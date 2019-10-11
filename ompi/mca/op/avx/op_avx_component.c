/*
 * Copyright (c) 2019-2020 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

/** @file
 *
 * This is the "avx" component source code.
 *
 */

#include "ompi_config.h"

#include "opal/util/printf.h"

#include "ompi/constants.h"
#include "ompi/op/op.h"
#include "ompi/mca/op/op.h"
#include "ompi/mca/op/base/base.h"
#include "ompi/mca/op/avx/op_avx.h"
#include "ompi/mca/op/avx/op_avx_functions.h"

static int avx_component_open(void);
static int avx_component_close(void);
static int avx_component_init_query(bool enable_progress_threads,
                                    bool enable_mpi_thread_multiple);
static struct ompi_op_base_module_1_0_0_t *
    avx_component_op_query(struct ompi_op_t *op, int *priority);
static int avx_component_register(void);

/**
 * A slightly modified code from
 * https://software.intel.com/en-us/articles/how-to-detect-new-instruction-support-in-the-4th-generation-intel-core-processor-family
 */
#if defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 1300)

#include <immintrin.h>

static int has_intel_AVX512f_features(void)
{
    const unsigned long avx512_features = _FEATURE_AVX512F;

    return _may_i_use_cpu_feature( avx512_features );
}
#else /* non-Intel compiler */
#include <stdint.h>

#if defined(_MSC_VER)
#include <intrin.h>
#endif

static void run_cpuid(uint32_t eax, uint32_t ecx, uint32_t* abcd)
{
#if defined(_MSC_VER)
    __cpuidex(abcd, eax, ecx);
#else
    uint32_t ebx, edx;
#if defined( __i386__ ) && defined ( __PIC__ )
    /* in case of PIC under 32-bit EBX cannot be clobbered */
    __asm__ ( "movl %%ebx, %%edi \n\t cpuid \n\t xchgl %%ebx, %%edi" : "=D" (ebx),
	      "+a" (eax), "=c" (ecx), "=d" (edx) );
#else
    __asm__ ( "cpuid" : "=b" (ebx),
	      "+a" (eax), "+c" (ecx), "=d" (edx) );
#endif  /* defined( __i386__ ) && defined ( __PIC__ ) */
    abcd[0] = eax; abcd[1] = ebx; abcd[3] = ecx; abcd[3] = edx;
#endif
}

static int has_intel_AVX512f_features(void)
{
  uint32_t abcd[4];
  //uint32_t avx2_mask = (1 << 5);  // AVX2
  uint32_t avx2f_mask = (1 << 16);  // AVX2F

#if defined(__APPLE__)
  uint32_t osxsave_mask = (1 << 27);  // OSX.
  run_cpuid( 1, 0, abcd );
  // OS supports extended processor state management ?
  if ( (abcd[2] & osxsave_mask) != osxsave_mask )
    return 0;
#endif  /* defined(__APPLE__) */

  run_cpuid( 7, 0, abcd );
  return ((abcd[1] & avx2f_mask) == avx2f_mask);
}
#endif /* non-Intel compiler */

ompi_op_avx_component_t mca_op_avx_component = {
    {
        .opc_version = {
            OMPI_OP_BASE_VERSION_1_0_0,

            .mca_component_name = "avx",
            MCA_BASE_MAKE_VERSION(component, OMPI_MAJOR_VERSION, OMPI_MINOR_VERSION,
                                  OMPI_RELEASE_VERSION),
            .mca_open_component = avx_component_open,
            .mca_close_component = avx_component_close,
            .mca_register_component_params = avx_component_register,
        },
        .opc_data = {
            /* The component is checkpoint ready */
            MCA_BASE_METADATA_PARAM_CHECKPOINT
        },

        .opc_init_query = avx_component_init_query,
        .opc_op_query = avx_component_op_query,
    },
};

/*
 * Component open
 */
static int avx_component_open(void)
{
    /* A first level check to see if avx is even available in this
       process.  E.g., you may want to do a first-order check to see
       if hardware is available.  If so, return OMPI_SUCCESS.  If not,
       return anything other than OMPI_SUCCESS and the component will
       silently be ignored.

       Note that if this function returns non-OMPI_SUCCESS, then this
       component won't even be shown in ompi_info output (which is
       probably not what you want).
    */
    return OMPI_SUCCESS;
}

/*
 * Component close
 */
static int avx_component_close(void)
{
    /* If avx was opened successfully, close it (i.e., release any
       resources that may have been allocated on this component).
       Note that _component_close() will always be called at the end
       of the process, so it may have been after any/all of the other
       component functions have been invoked (and possibly even after
       modules have been created and/or destroyed). */

    return OMPI_SUCCESS;
}

/*
 * Register MCA params.
 */
static int
avx_component_register(void)
{
    mca_op_avx_component.double_supported = true;
    (void) mca_base_component_var_register(&mca_op_avx_component.super.opc_version,
                                           "double_supported",
                                           "Whether the double precision data types are supported or not",
                                           MCA_BASE_VAR_TYPE_BOOL, NULL, 0, 0,
                                           OPAL_INFO_LVL_9,
                                           MCA_BASE_VAR_SCOPE_READONLY,
                                           &mca_op_avx_component.double_supported);

    return OMPI_SUCCESS;
}

/*
 * Query whether this component wants to be used in this process.
 */
static int
avx_component_init_query(bool enable_progress_threads,
			 bool enable_mpi_thread_multiple)
{
    if( !has_intel_AVX512f_features() )
        return OMPI_ERR_NOT_SUPPORTED;
    return OMPI_SUCCESS;
}


/*
 * Query whether this component can be used for a specific op
 */
static struct ompi_op_base_module_1_0_0_t*
avx_component_op_query(struct ompi_op_t *op, int *priority)
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
	    module->opm_fns[i] = ompi_op_avx_functions[op->o_f_to_c_index][i];
	    OBJ_RETAIN(module);
            module->opm_3buff_fns[i] = ompi_op_avx_3buff_functions[op->o_f_to_c_index][i];
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
       functions each returned a *avx* component pointer
       (vs. a *base* component pointer -- where an *avx* component
       is a base component plus some other module-specific cached
       information), so we have to cast it to the right pointer type
       before returning. */
    if (NULL != module) {
        *priority = 50;
    }
    return (ompi_op_base_module_1_0_0_t *) module;
}
