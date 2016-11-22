/*
 * Copyright (c) 2013-2016 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2013-2016 Inria.  All rights reserved.
 * Copyright (c) 2015      Bull SAS.  All rights reserved.
 * Copyright (c) 2016      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include <ompi_config.h>
#include <common_monitoring.h>
#include <ompi/constants.h>
#include <ompi/communicator/communicator.h>
#include <opal/mca/base/mca_base_component_repository.h>
#include <opal/class/opal_hash_table.h>
#include <assert.h>

extern int mca_common_monitoring_filter( void );

/*** Monitoring specific variables ***/
struct mca_monitoring_coll_data_t {
    opal_list_item_t super;
    char*procs;
    char*comm_name;
    int world_rank;
    ompi_communicator_t*p_comm;
    uint64_t o2a_count;
    uint64_t o2a_size;
    uint64_t a2o_count;
    uint64_t a2o_size;
    uint64_t a2a_count;
    uint64_t a2a_size;
};

/* Collectives operation monitoring */
static opal_hash_table_t *comm_data = NULL;

static inline void mca_common_monitoring_coll_cache(mca_monitoring_coll_data_t*data)
{
    int world_rank;

    if( -1 == data->world_rank ) {
        /* Get current process world_rank */
        mca_common_monitoring_get_world_rank(ompi_comm_rank(data->p_comm), data->p_comm,
                                             &data->world_rank);
    }
    if( NULL == data->comm_name ) {
        data->comm_name = strdup(data->p_comm->c_name);
    }
    
    if( NULL == data->procs ) {
        /* FIX-ME: the algorithm is O(n^2) */
        int i, pos, size = ompi_comm_size(data->p_comm);
        char*tmp_procs;
        assert( 0 < size );
        /* Get first rank (there is at least one node if we reach this point) */
        mca_common_monitoring_get_world_rank(0, data->p_comm, &world_rank);
        pos = asprintf(&data->procs, "%d,", world_rank);
        for(i = 1; i < size; ++i) {
            /* WARNING : Keep the order of the next two instruction :
               it sometimes happened with gcc/4.9.2 that the return
               from opal_hash_table_get_value_uint_64() set tmp_procs
               to NULL (while returning OPAL_SUCCESS). */
            mca_common_monitoring_get_world_rank(i, data->p_comm, &world_rank);
            tmp_procs = data->procs;
            pos = asprintf(&data->procs, "%s%d,", tmp_procs, world_rank);
            free(tmp_procs);
        }
        data->procs[pos - 1] = '\0'; /* Remove final coma */
    }
    if( -1 == data->world_rank ) {
        /* Get current process world_rank */
        mca_common_monitoring_get_world_rank(ompi_comm_rank(data->p_comm), data->p_comm,
                                             &data->world_rank);
    }
    if( NULL == data->comm_name ) {
        data->comm_name = strdup(data->p_comm->c_name);
    }
}

mca_monitoring_coll_data_t*mca_common_monitoring_coll_new( ompi_communicator_t*comm )
{
    mca_monitoring_coll_data_t*data = OBJ_NEW(mca_monitoring_coll_data_t);
    if( NULL == data ) {
        OPAL_MONITORING_PRINT_ERR("coll: new: data structure cannot be allocated");
        return NULL;
    }

    data->p_comm = comm;
    
    /* Allocate hashtable */
    if( NULL == comm_data ) {
        comm_data = OBJ_NEW(opal_hash_table_t);
        if( NULL == comm_data ) {
            OPAL_MONITORING_PRINT_ERR("coll: new: failed to allocate hashtable");
            return data;
        }
        opal_hash_table_init(comm_data, 2048);
    }

    /* Insert in hashtable */
    uint64_t key = *((uint64_t*)&data);
    if( OPAL_SUCCESS != opal_hash_table_set_value_uint64(comm_data, key, (void*)data) ) {
        OPAL_MONITORING_PRINT_ERR("coll: new: failed to allocate memory or "
                                  "growing the hash table");
    }

    return data;
}

void mca_common_monitoring_coll_release(mca_monitoring_coll_data_t*data)
{
#if OPAL_ENABLE_DEBUG
    if( NULL == data ) {
        OPAL_MONITORING_PRINT_ERR("coll: release: data structure empty or already desallocated");
        return;
    }
#endif /* OPAL_ENABLE_DEBUG */
    
    if( NULL == data->p_comm ) { /* if the communicator is already released */
        opal_hash_table_remove_value_uint64(comm_data, *((uint64_t*)&data));
        free(data->comm_name);
        free(data->procs);
        OBJ_RELEASE(data);
    } else { /* not flushed yet */
        mca_common_monitoring_coll_cache(data);
        data->p_comm = NULL;
    }
}

void mca_common_monitoring_coll_flush(FILE *pf, mca_monitoring_coll_data_t*data)
{
    /* Set data->procs, data->world_rank and data->comm_name */
    mca_common_monitoring_coll_cache(data);
    /* Flush data */
    fprintf(pf,
            "C\t%s\tprocs: %s\n"
            "O2A\t%d\t%" PRIu64 " bytes\t%" PRIu64 " msgs sent\n"
            "A2O\t%d\t%" PRIu64 " bytes\t%" PRIu64 " msgs sent\n"
            "A2A\t%d\t%" PRIu64 " bytes\t%" PRIu64 " msgs sent\n",
            data->comm_name, data->procs,
            data->world_rank, data->o2a_size, data->o2a_count,
            data->world_rank, data->a2o_size, data->a2o_count,
            data->world_rank, data->a2a_size, data->a2a_count);
}

void mca_common_monitoring_coll_flush_all(FILE *pf)
{
    if( NULL == comm_data ) return; /* No hashtable */
        
    uint64_t key;
    void*data;
    mca_monitoring_coll_data_t*previous = NULL;

    fprintf(pf, "# COLLECTIVES\n");
    
    OPAL_HASH_TABLE_FOREACH(key, uint64, data, comm_data) {
        if( NULL != previous && NULL == previous->p_comm ) {
            /* Phase flushed -> free already released once coll_data_t */
            mca_common_monitoring_coll_release(previous);
        }
        mca_common_monitoring_coll_flush(pf, (mca_monitoring_coll_data_t*)data);
        previous = data;
    }
}

void mca_common_monitoring_coll_o2a(uint64_t size, mca_monitoring_coll_data_t*data)
{
    if( 0 == mca_common_monitoring_filter() ) return; /* right now the monitoring is not started */
#if OPAL_ENABLE_DEBUG
    if( NULL == data ) {
        OPAL_MONITORING_PRINT_ERR("coll: o2a: data structure empty");
        return;
    }
#endif /* OPAL_ENABLE_DEBUG */
    opal_atomic_add_64(&data->o2a_size, size);
    opal_atomic_add_64(&data->o2a_count, 1);
}

void mca_common_monitoring_coll_a2o(uint64_t size, mca_monitoring_coll_data_t*data)
{
    if( 0 == mca_common_monitoring_filter() ) return; /* right now the monitoring is not started */
#if OPAL_ENABLE_DEBUG
    if( NULL == data ) {
        OPAL_MONITORING_PRINT_ERR("coll: a2o: data structure empty");
        return;
    }
#endif /* OPAL_ENABLE_DEBUG */
    opal_atomic_add_64(&data->a2o_size, size);
    opal_atomic_add_64(&data->a2o_count, 1);
}

void mca_common_monitoring_coll_a2a(uint64_t size, mca_monitoring_coll_data_t*data)
{
    if( 0 == mca_common_monitoring_filter() ) return; /* right now the monitoring is not started */
#if OPAL_ENABLE_DEBUG
    if( NULL == data ) {
        OPAL_MONITORING_PRINT_ERR("coll: a2a: data structure empty");
        return;
    }
#endif /* OPAL_ENABLE_DEBUG */
    opal_atomic_add_64(&data->a2a_size, size);
    opal_atomic_add_64(&data->a2a_count, 1);
}

static void mca_monitoring_coll_construct (mca_monitoring_coll_data_t*coll_data)
{
    coll_data->procs      = NULL;
    coll_data->comm_name  = NULL;
    coll_data->world_rank = -1;
    coll_data->p_comm     = NULL;
    coll_data->o2a_count  = 0;
    coll_data->o2a_size   = 0;
    coll_data->a2o_count  = 0;
    coll_data->a2o_size   = 0;
    coll_data->a2a_count  = 0;
    coll_data->a2a_size   = 0;
}

OBJ_CLASS_INSTANCE(mca_monitoring_coll_data_t, opal_list_item_t, mca_monitoring_coll_construct, NULL);
