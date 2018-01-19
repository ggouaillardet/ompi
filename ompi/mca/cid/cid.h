/* -*- Mode: C; c-basic-offset:4 ; indent-tabs-mode:nil -*- */
/*
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#ifndef MCA_CID_H
#define MCA_CID_H

#include "ompi_config.h"

#include "opal/class/opal_object.h"
#include "ompi/mca/mca.h"

#include "ompi/types.h"
#include "ompi/communicator/communicator.h"
#include "ompi/request/request.h"

BEGIN_C_DECLS

/**
 * Pre-declare this so that we can pass it as an argument to the
 * typedef'ed functions.
 */
struct ompi_cid_base_module_1_0_0_t;

typedef struct ompi_cid_base_module_1_0_0_t ompi_cid_base_module_t;

/**
 * allocate new communicator ID (non-blocking)
 * @param newcomm:    pointer to the new communicator
 * @param oldcomm:    original comm
 * @param bridgecomm: bridge comm for intercomm_create
 * @param mode: combination of input
 *              OMPI_COMM_CID_INTRA:        intra-comm
 *              OMPI_COMM_CID_INTER:        inter-comm
 * This routine has to be thread safe in the final version.
 */
typedef int (*ompi_cid_base_module_nextcid_nb_fn_t) (ompi_communicator_t *newcomm, ompi_communicator_t *comm,
                                                    ompi_communicator_t *bridgecomm, const void *arg0, const void *arg1,
                                                    bool send_first, int mode, ompi_request_t **req);

/**
 * allocate new communicator ID
 * @param newcomm:    pointer to the new communicator
 * @param oldcomm:    original comm
 * @param bridgecomm: bridge comm for intercomm_create
 * @param mode: combination of input
 *              OMPI_COMM_CID_INTRA:        intra-comm
 *              OMPI_COMM_CID_INTER:        inter-comm
 *              OMPI_COMM_CID_GROUP:        only decide CID within the ompi_group_t
 *                                          associated with the communicator. arg0
 *                                          must point to an int which will be used
 *                                          as the pml tag for communication.
 *              OMPI_COMM_CID_INTRA_BRIDGE: 2 intracomms connected by
 *                                          a bridge comm. arg0 and arg1 must point
 *                                          to integers representing the local and
 *                                          remote leader ranks. the remote leader rank
 *                                          is a rank in the bridgecomm.
 *              OMPI_COMM_CID_INTRA_PMIX:   2 intracomms, leaders talk
 *                                          through PMIx. arg0 must point to an integer
 *                                          representing the local leader rank. arg1
 *                                          must point to a string representing the
 *                                          port of the remote leader.
 * @param send_first: to avoid a potential deadlock for
 *                    the OOB version.
 * This routine has to be thread safe in the final version.
 */
typedef int (*ompi_cid_base_module_nextcid_fn_t) (ompi_communicator_t *newcomm, ompi_communicator_t *comm,
                                                 ompi_communicator_t *bridgecomm, const void *arg0, const void *arg1,
                                                 bool send_first, int mode);

/* This routine serves two purposes:
 * - the allreduce acts as a kind of Barrier,
 *   which avoids, that we have incoming fragments
 *   on the new communicator before everybody has set
 *   up the comm structure.
 * - some components (e.g. the collective MagPIe component
 *   might want to generate new communicators and communicate
 *   using the new comm. Thus, it can just be called after
 *   the 'barrier'.
 *
 * The reason that this routine is in comm_cid and not in
 * comm.c is, that this file contains the allreduce implementations
 * which are required, and thus we avoid having duplicate code...
 */
typedef int (*ompi_cid_base_module_activate_nb_fn_t) (ompi_communicator_t **newcomm, ompi_communicator_t *comm,
                                                      ompi_communicator_t *bridgecomm, const void *arg0,
                                                      const void *arg1, bool send_first, int mode, ompi_request_t **req);

typedef int (*ompi_cid_base_module_activate_fn_t) (ompi_communicator_t **newcomm, ompi_communicator_t *comm,
                                                   ompi_communicator_t *bridgecomm, const void *arg0,
                                                   const void *arg1, bool send_first, int mode);

typedef int (*ompi_cid_base_module_release_nb_fn_t) (int cid, ompi_request_t **req);

typedef int (*ompi_cid_base_module_release_fn_t) (int cid);

/* initialize the module - allow it to do whatever one-time
 * things it requires */
typedef int (*ompi_cid_base_module_init_fn_t)(void);

/* give the component a chance to cleanup */
typedef void (*ompi_cid_base_module_finalize_fn_t)(void);

typedef struct ompi_cid_base_component_1_0_0_t {
    mca_base_component_t base_version;
    mca_base_component_data_t base_data;
} ompi_cid_base_component_1_0_0_t;


/** Per guidence in mca.h, use the unversioned struct name if you just
    want to always keep up with the most recent version of the
    interace. */
typedef struct ompi_cid_base_component_1_0_0_t ompi_cid_base_component_t;

/**
 * Module initialization function.  Should return OPAL_SUCCESS if
 * everything goes ok.  This function can be NULL in the module struct
 * if the module doesn't need to do anything between the component
 * query function and being invoked for MPI_Op operations.
 */
typedef int (*ompi_cid_base_module_enable_1_0_0_fn_t)
    (struct ompi_cid_base_module_1_0_0_t *module);

/**
 * Module struct
 */
typedef struct ompi_cid_base_module_1_0_0_t {
    ompi_cid_base_module_nextcid_nb_fn_t  nextcid_nb;
    ompi_cid_base_module_nextcid_fn_t     nextcid;
    ompi_cid_base_module_activate_nb_fn_t activate_nb;
    ompi_cid_base_module_activate_fn_t    activate;
    ompi_cid_base_module_release_nb_fn_t  release_nb;
    ompi_cid_base_module_release_fn_t     release;
    ompi_cid_base_module_init_fn_t        init;
    ompi_cid_base_module_finalize_fn_t    finalize;
} ompi_cid_base_module_1_0_0_t;

OMPI_DECLSPEC extern ompi_cid_base_module_t ompi_cid;

/**
 * Struct that is used in op.h to hold all the function pointers and
 * pointers to the corresopnding modules (so that we can properly
 * RETAIN/RELEASE them)
 */
#define OMPI_CID_BASE_VERSION_1_0_0 \
    OMPI_MCA_BASE_VERSION_2_1_0("cid", 1, 0, 0)

END_C_DECLS

#endif /* OMPI_MCA_CID_H */
