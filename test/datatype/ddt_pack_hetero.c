/* -*- Mode: C; c-basic-offset:4 ; -*- */
/*
 * Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2006 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2006 High Performance Computing Center Stuttgart, 
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2006 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2006      Sun Microsystems Inc. All rights reserved.
 * Copyright (c) 2015-2016 Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 * 
 * Additional copyrights may follow
 * 
 * $HEADER$
 */

#include "ompi_config.h"
#include "ompi/datatype/ompi_datatype.h"
#include "opal/datatype/opal_datatype_internal.h"
#include "opal/datatype/opal_datatype_checksum.h"
#include "opal/datatype/opal_convertor.h"
#include "opal/datatype/opal_convertor_internal.h"
#include "opal/include/opal_config_bottom.h"
#include "ompi/proc/proc.h"

#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif
#ifdef HAVE_STRING_H
#include <string.h>
#endif

#include <assert.h>

#ifndef OPAL_PTRDIFF_TYPE
#define OPAL_PTRDIFF_TYPE long
#endif

#define IOVEC_MEM_LIMIT 8192

static inline
int convertor_create_stack_at_begining( opal_convertor_t* convertor,
                                             const size_t* sizes )
{
    dt_stack_t* pStack = convertor->pStack;
    dt_elem_desc_t* pElems;

    /**
     * The prepare function already make the selection on which data representation
     * we have to use: normal one or the optimized version ?
     */
    pElems = convertor->use_desc->desc;

    convertor->stack_pos      = 1;
    convertor->partial_length = 0;
    convertor->bConverted     = 0;
    /**
     * Fill the first position on the stack. This one correspond to the
     * last fake OPAL_DATATYPE_END_LOOP that we add to the data representation and
     * allow us to move quickly inside the datatype when we have a count.
     */
    pStack[0].index = -1;
    pStack[0].count = convertor->count;
    pStack[0].disp  = 0;
    pStack[0].type  = OPAL_DATATYPE_LOOP;

    pStack[1].index = 0;
    pStack[1].disp = 0;
    if( pElems[0].elem.common.type == OPAL_DATATYPE_LOOP ) {
        pStack[1].count = pElems[0].loop.loops;
        pStack[1].type  = OPAL_DATATYPE_LOOP;
    } else {
        pStack[1].count = pElems[0].elem.count;
        pStack[1].type  = pElems[0].elem.common.type;
    }
    return OPAL_SUCCESS;
}

int32_t
pack_homogeneous_contig_with_gaps( opal_convertor_t* pConv,
                                        struct iovec* iov,
                                        uint32_t* out_size,
                                        size_t* max_data );
int32_t
pack_homogeneous_contig_with_gaps( opal_convertor_t* pConv,
                                        struct iovec* iov,
                                        uint32_t* out_size,
                                        size_t* max_data )
{
    const opal_datatype_t* pData = pConv->pDesc;
    dt_stack_t* stack = pConv->pStack;
    unsigned char *user_memory, *packed_buffer;
    uint32_t i, index, iov_count;
    size_t bConverted, remaining, length, initial_bytes_converted = pConv->bConverted;
    OPAL_PTRDIFF_TYPE extent= pData->ub - pData->lb;
    OPAL_PTRDIFF_TYPE initial_displ = pConv->use_desc->desc[pConv->use_desc->used].end_loop.first_elem_disp;

    assert( (pData->flags & OPAL_DATATYPE_FLAG_CONTIGUOUS) && ((OPAL_PTRDIFF_TYPE)pData->size != extent) );
    if( stack[1].type != opal_datatype_uint1.id ) {
        stack[1].count *= opal_datatype_basicDatatypes[stack[1].type]->size;
        stack[1].type = opal_datatype_uint1.id;
    }

    /* There are some optimizations that can be done if the upper level
     * does not provide a buffer.
     */
    for( iov_count = 0; iov_count < (*out_size); iov_count++ ) {
        /* Limit the amount of packed data to the data left over on this convertor */
        remaining = pConv->local_size - pConv->bConverted;
        if( 0 == remaining ) break;  /* we're done this time */
        if( remaining > (uint32_t)iov[iov_count].iov_len )
            remaining = iov[iov_count].iov_len;
        packed_buffer = (unsigned char *)iov[iov_count].iov_base;
        bConverted = remaining; /* how much will get unpacked this time */
        user_memory = pConv->pBaseBuf + initial_displ + stack[0].disp + stack[1].disp;
        i = pConv->count - stack[0].count;  /* how many we already packed */
        assert(i == ((uint32_t)(pConv->bConverted / pData->size)));

        if( packed_buffer == NULL ) {
            /* special case for small data. We avoid allocating memory if we
             * can fill the iovec directly with the address of the remaining
             * data.
             */
            if( (uint32_t)stack->count < ((*out_size) - iov_count) ) {
                stack[1].count = pData->size - (pConv->bConverted % pData->size);
                for( index = iov_count; i < pConv->count; i++, index++ ) {
                    iov[index].iov_base = (IOVBASE_TYPE *) user_memory;
                    iov[index].iov_len = stack[1].count;
                    stack[0].disp += extent;
                    pConv->bConverted += stack[1].count;
                    stack[1].disp  = 0;  /* reset it for the next round */
                    stack[1].count = pData->size;
                    user_memory = pConv->pBaseBuf + initial_displ + stack[0].disp;
                    COMPUTE_CSUM( iov[index].iov_base, iov[index].iov_len, pConv );
                }
                *out_size = iov_count + index;
                *max_data = (pConv->bConverted - initial_bytes_converted);
                pConv->flags |= CONVERTOR_COMPLETED;
                return 1;  /* we're done */
            }
            /* now special case for big contiguous data with gaps around */
            if( pData->size >= IOVEC_MEM_LIMIT ) {
                /* as we dont have to copy any data, we can simply fill the iovecs
                 * with data from the user data description.
                 */
                for( index = iov_count; (i < pConv->count) && (index < (*out_size));
                     i++, index++ ) {
                    if( remaining < pData->size ) {
                        iov[index].iov_base = (IOVBASE_TYPE *) user_memory;
                        iov[index].iov_len = remaining;
                        remaining = 0;
                        COMPUTE_CSUM( iov[index].iov_base, iov[index].iov_len, pConv );
                        break;
                    } else {
                        iov[index].iov_base = (IOVBASE_TYPE *) user_memory;
                        iov[index].iov_len = pData->size;
                        user_memory += extent;
                        COMPUTE_CSUM( iov[index].iov_base, (size_t)iov[index].iov_len, pConv );
                    }
                    remaining -= iov[index].iov_len;
                    pConv->bConverted += iov[index].iov_len;
                }
                *out_size = index;
                *max_data = (pConv->bConverted - initial_bytes_converted);
                if( pConv->bConverted == pConv->local_size ) {
                    pConv->flags |= CONVERTOR_COMPLETED;
                    return 1;
                }
                return 0;
            }
        }

        {

            length = (0 == pConv->stack_pos ? 0 : stack[1].count);  /* left over from the last pack */
            /* data left from last round and enough space in the buffer */
            if( (0 != length) && (length <= remaining)) {
                /* copy the partial left-over from the previous round */
                OPAL_DATATYPE_SAFEGUARD_POINTER( user_memory, length, pConv->pBaseBuf,
                                                 pData, pConv->count );
                MEMCPY_CSUM( packed_buffer, user_memory, length, pConv );
                packed_buffer  += length;
                user_memory    += (extent - pData->size + length);
                remaining      -= length;
                stack[1].count -= length;
                if( 0 == stack[1].count) { /* one completed element */
                    stack[0].count--;
                    stack[0].disp += extent;
                    if( 0 != stack[0].count ) {  /* not yet done */
                        stack[1].count = pData->size;
                        stack[1].disp = 0;
                    }
                }
            }
            for( i = 0;  pData->size <= remaining; i++ ) {
                OPAL_DATATYPE_SAFEGUARD_POINTER( user_memory, pData->size, pConv->pBaseBuf,
                                                 pData, pConv->count );
                MEMCPY_CSUM( packed_buffer, user_memory, pData->size, pConv );
                packed_buffer += pData->size;
                user_memory   += extent;
                remaining   -= pData->size;
            }
            stack[0].count -= i;  /* the filled up and the entire types */
            stack[0].disp  += (i * extent);
            stack[1].disp  += remaining;
            /* Copy the last bits */
            if( 0 != remaining ) {
                OPAL_DATATYPE_SAFEGUARD_POINTER( user_memory, remaining, pConv->pBaseBuf,
                                                 pData, pConv->count );
                MEMCPY_CSUM( packed_buffer, user_memory, remaining, pConv );
                user_memory += remaining;
                stack[1].count -= remaining;
            }
            if( 0 == stack[1].count ) {  /* prepare for the next element */
                stack[1].count = pData->size;
                stack[1].disp  = 0;
            }
        }
        pConv->bConverted += bConverted;
    }
    *out_size = iov_count;
    *max_data = (pConv->bConverted - initial_bytes_converted);
    if( pConv->bConverted == pConv->local_size ) {
        pConv->flags |= CONVERTOR_COMPLETED;
        return 1;
    }
    return 0;
}
int32_t convertor_prepare_for_send( opal_convertor_t* convertor,
                                    const struct opal_datatype_t* datatype,
                                    int32_t count,
                                    const void* pUserBuf );

int32_t convertor_prepare_for_send( opal_convertor_t* convertor,
                                    const struct opal_datatype_t* datatype,
                                    int32_t count,
                                    const void* pUserBuf )
{
    convertor->flags |= CONVERTOR_SEND;

    {
#if 0
        uint32_t bdt_mask;
#endif

        /* If the data is empty we just mark the convertor as
         * completed. With this flag set the pack and unpack functions
         * will not do anything.
         */                                                             \
        if( OPAL_UNLIKELY((0 == count) || (0 == datatype->size)) ) {
            convertor->flags |= OPAL_DATATYPE_FLAG_NO_GAPS | CONVERTOR_COMPLETED;
            convertor->local_size = convertor->remote_size = 0;
            return OPAL_SUCCESS;
        }
        /* Compute the local in advance */
        convertor->local_size = count * datatype->size;
        convertor->pBaseBuf   = (unsigned char*)pUserBuf;
        convertor->count      = count;

        /* Grab the datatype part of the flags */
        convertor->flags     &= CONVERTOR_TYPE_MASK;
        convertor->flags     |= (CONVERTOR_DATATYPE_MASK & datatype->flags);
        convertor->flags     |= (CONVERTOR_NO_OP | CONVERTOR_HOMOGENEOUS);
        convertor->pDesc      = (opal_datatype_t*)datatype;
        convertor->bConverted = 0;
        /* By default consider the optimized description */
        convertor->use_desc = &(datatype->opt_desc);

        convertor->remote_size = convertor->local_size;
        if( OPAL_LIKELY(convertor->remoteArch == opal_local_arch) ) {
            if( (convertor->flags & (CONVERTOR_WITH_CHECKSUM | OPAL_DATATYPE_FLAG_NO_GAPS)) == OPAL_DATATYPE_FLAG_NO_GAPS ) {
                return OPAL_SUCCESS;
            }
            if( ((convertor->flags & (CONVERTOR_WITH_CHECKSUM | OPAL_DATATYPE_FLAG_CONTIGUOUS))
                 == OPAL_DATATYPE_FLAG_CONTIGUOUS) && (1 == count) ) {
                return OPAL_SUCCESS;
            }
        }

#if 0
        bdt_mask = datatype->bdt_used & convertor->master->hetero_mask;
        OPAL_CONVERTOR_COMPUTE_REMOTE_SIZE( convertor, datatype,
                                            bdt_mask );
#elif 1
        // FIXME
        convertor->use_desc = &(datatype->desc);
#endif
        assert( NULL != convertor->use_desc->desc );
        /* For predefined datatypes (contiguous) do nothing more */
        /* if checksum is enabled then always continue */
        if( ((convertor->flags & (CONVERTOR_WITH_CHECKSUM | OPAL_DATATYPE_FLAG_NO_GAPS))
             == OPAL_DATATYPE_FLAG_NO_GAPS) &&
            (convertor->flags & (CONVERTOR_SEND | CONVERTOR_HOMOGENEOUS)) ) {
            return OPAL_SUCCESS;
        }
        convertor->flags &= ~CONVERTOR_NO_OP;
        {
            uint32_t required_stack_length = datatype->btypes[OPAL_DATATYPE_LOOP] + 1;

            if( required_stack_length > convertor->stack_size ) {
                assert(convertor->pStack == convertor->static_stack);
                convertor->stack_size = required_stack_length;
                convertor->pStack     = (dt_stack_t*)malloc(sizeof(dt_stack_t) *
                                                            convertor->stack_size );
            }
        }
        convertor_create_stack_at_begining( convertor, opal_datatype_local_sizes );
    }

    convertor->fAdvance = pack_homogeneous_contig_with_gaps;
    return OPAL_SUCCESS;
}

static void opal_convertor_construct( opal_convertor_t* convertor );

static void opal_convertor_construct( opal_convertor_t* convertor )
{
    convertor->pStack         = convertor->static_stack;
    convertor->stack_size     = DT_STATIC_STACK_SIZE;
    convertor->partial_length = 0;
    convertor->remoteArch     = opal_local_arch;
    convertor->flags          = OPAL_DATATYPE_FLAG_NO_GAPS | CONVERTOR_COMPLETED;
#if OPAL_CUDA_SUPPORT
    convertor->cbmemcpy       = &opal_cuda_memcpy;
#endif
}

int
main(int argc, char* argv[])
{
    int ret;
    typedef struct {
        long l;
        int i;
        int p;
    } li_t;
    li_t li[2] = { { 1, 2, -1}, {3, 4, -1} };
    char buf[32];
    char *p;

    ompi_datatype_t *type;
    int blens[2] = { 1, 1};
    MPI_Aint displs[2] = {0, 8};
    ompi_datatype_t *types[2] = { &ompi_mpi_long.dt, &ompi_mpi_int.dt };

    opal_convertor_t convertor;
    struct iovec iov = { buf, 24 };
    uint32_t out_size = 1;
    size_t max_data = 24;

    ret = ompi_datatype_init();
    if (0 != ret) return ret;
   
    ret = ompi_datatype_create_struct( 2, blens, displs, types, &type );
    if (0 != ret) goto cleanup;
    ret = ompi_datatype_commit( &type );
    if (0 != ret) goto cleanup;

    memset(&convertor, 0, sizeof(opal_convertor_t));
    opal_convertor_construct( &convertor );

    ret = convertor_prepare_for_send( &convertor,
                                      &type->super,
                                      2,
                                      li );

    ret = opal_convertor_pack ( &convertor, &iov, &out_size, &max_data );

    p = buf;
    assert(1 == *(long *)p);
    p += sizeof(long);
    assert(2 == *(int *)p);
    p += sizeof(int);
    assert(3 == *(long *)p);
    p += sizeof(long);
    assert(4 == *(int *)p);

 cleanup:
    ompi_datatype_finalize();

    return ret;
}
