/*
 * Copyright (c) 2019-2020 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2020      Research Organization for Information Science
 *                         and Technology (RIST).  All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

/** @file
 *
 * This is the "neon" component source code.
 *
 */

#include "ompi_config.h"

#include "opal/util/printf.h"

#include "ompi/constants.h"
#include "ompi/op/op.h"
#include "ompi/mca/op/op.h"
#include "ompi/mca/op/base/base.h"
#include "ompi/mca/op/neon/op_neon.h"
#include "ompi/mca/op/neon/op_neon_functions.h"

static int neon_component_open(void);
static int neon_component_close(void);
static int neon_component_init_query(bool enable_progress_threads,
                                     bool enable_mpi_thread_multiple);
static struct ompi_op_base_module_1_0_0_t *
    neon_component_op_query(struct ompi_op_t *op, int *priority);
static int neon_component_register(void);

ompi_op_neon_component_t mca_op_neon_component = {
    {
        .opc_version = {
            OMPI_OP_BASE_VERSION_1_0_0,

            .mca_component_name = "neon",
            MCA_BASE_MAKE_VERSION(component, OMPI_MAJOR_VERSION, OMPI_MINOR_VERSION,
                                  OMPI_RELEASE_VERSION),
            .mca_open_component = neon_component_open,
            .mca_close_component = neon_component_close,
            .mca_register_component_params = neon_component_register,
        },
        .opc_data = {
            /* The component is checkpoint ready */
            MCA_BASE_METADATA_PARAM_CHECKPOINT
        },

        .opc_init_query = neon_component_init_query,
        .opc_op_query = neon_component_op_query,
    },
};

/*
 * Component open
 */
static int neon_component_open(void)
{
    return OMPI_SUCCESS;
}

/*
 * Component close
 */
static int neon_component_close(void)
{
    return OMPI_SUCCESS;
}

/*
 * Register MCA params.
 */
static int
neon_component_register(void)
{
    return OMPI_SUCCESS;
}

/*
 * Query whether this component wants to be used in this process.
 */
static int
neon_component_init_query(bool enable_progress_threads,
                          bool enable_mpi_thread_multiple)
{
    return OMPI_SUCCESS;
}


/*
 * Query whether this component can be used for a specific op
 */
static struct ompi_op_base_module_1_0_0_t*
neon_component_op_query(struct ompi_op_t *op, int *priority)
{
    ompi_op_base_module_t *module = NULL;
    /* Sanity check -- although the framework should never invoke the
       _component_op_query() on non-intrinsic MPI_Op's, we'll put a
       check here just to be sure. */
    if (0 == (OMPI_OP_FLAGS_INTRINSIC & op->o_flags)) {
        return NULL;
    }

    switch (op->o_f_to_c_index) {
    case OMPI_OP_BASE_FORTRAN_MAX:
    case OMPI_OP_BASE_FORTRAN_MIN:
    case OMPI_OP_BASE_FORTRAN_SUM:
    case OMPI_OP_BASE_FORTRAN_PROD:
    case OMPI_OP_BASE_FORTRAN_BOR:
    case OMPI_OP_BASE_FORTRAN_BAND:
    case OMPI_OP_BASE_FORTRAN_BXOR:
        module = OBJ_NEW(ompi_op_base_module_t);
        for (int i = 0; i < OMPI_OP_BASE_TYPE_MAX; ++i) {
            module->opm_fns[i] = ompi_op_neon_functions[op->o_f_to_c_index][i];
            OBJ_RETAIN(module);
            module->opm_3buff_fns[i] = ompi_op_neon_3buff_functions[op->o_f_to_c_index][i];
            OBJ_RETAIN(module);
        }
        break;
    case OMPI_OP_BASE_FORTRAN_LAND:
    case OMPI_OP_BASE_FORTRAN_LOR:
    case OMPI_OP_BASE_FORTRAN_LXOR:
    case OMPI_OP_BASE_FORTRAN_MAXLOC:
    case OMPI_OP_BASE_FORTRAN_MINLOC:
    case OMPI_OP_BASE_FORTRAN_REPLACE:
    default:
        break;
    }
    /* If we got a module from above, we'll return it.  Otherwise,
       we'll return NULL, indicating that this component does not want
       to be considered for selection for this MPI_Op.  Note that the
       functions each returned a *neon* component pointer
       (vs. a *base* component pointer -- where an *neon* component
       is a base component plus some other module-specific cached
       information), so we have to cast it to the right pointer type
       before returning. */
    if (NULL != module) {
        *priority = 50;
    }
    return (ompi_op_base_module_1_0_0_t *) module;
}
