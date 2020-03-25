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

#include "ompi_config.h"

#ifdef HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif
#include "opal/util/output.h"

#include "ompi/op/op.h"
#include "ompi/mca/op/op.h"
#include "ompi/mca/op/base/base.h"
#include "ompi/mca/op/neon/op_neon.h"
#include "ompi/mca/op/neon/op_neon_functions.h"

#include <arm_neon.h>
/*
 * Since all the functions in this file are essentially identical, we
 * use a macro to substitute in names and types.  The core operation
 * in all functions that use this macro is the same.
 *
 * This macro is for (out op in).
 *
 * Support ops: max, min, for signed/unsigned 8,16,32,64
 *              sum, for integer 8,16,32,64
 *
 */

#define OP_NEON_FUNC(name, type_sign, type_size, types_per_step , type, op)                            \
static void ompi_op_neon_2buff_##name##_##type##type_size##_t(const void *_in, void *_out, int *count, \
                                              struct ompi_datatype_t **dtype,                          \
                                              struct ompi_op_base_module_1_0_0_t *module)              \
{                                                                                                      \
    int left_over = *count;                                                                            \
    type##type_size##_t *in = (type##type_size##_t*)_in, *out = (type##type_size##_t*)_out;            \
        assert(types_per_step == (128 / 8) / sizeof(type##type_size##_t));                             \
        for( ; left_over >= types_per_step; left_over -= types_per_step ) {                            \
            type##type_size##x##types_per_step##_t vecA = vld1q_##type_sign##type_size(in);            \
            in += types_per_step;                                                                      \
            type##type_size##x##types_per_step##_t vecB = vld1q_##type_sign##type_size(out);           \
            type##type_size##x##types_per_step##_t res =  v##op##q_##type_sign##type_size(vecA, vecB); \
            vst1q_##type_sign##type_size(out, res);                                                    \
            out += types_per_step;                                                                     \
        }                                                                                              \
    while( left_over > 0 ) {                                                                           \
        int how_much = (left_over > 8) ? 8 : left_over;                                                \
        switch(how_much) {                                                                             \
        case 8: out[7] = current_func(out[7], in[7]);                                                  \
        case 7: out[6] = current_func(out[6], in[6]);                                                  \
        case 6: out[5] = current_func(out[5], in[5]);                                                  \
        case 5: out[4] = current_func(out[4], in[4]);                                                  \
        case 4: out[3] = current_func(out[3], in[3]);                                                  \
        case 3: out[2] = current_func(out[2], in[2]);                                                  \
        case 2: out[1] = current_func(out[1], in[1]);                                                  \
        case 1: out[0] = current_func(out[0], in[0]);                                                  \
        }                                                                                              \
        left_over -= how_much;                                                                         \
        out += how_much;                                                                               \
        in += how_much;                                                                                \
    }                                                                                                  \
}

#define OP_NEON_FUNC_3(name, type_sign, type_size, types_per_step , type, op)                          \
static void ompi_op_neon_3buff_##name##_##type##type_size##_t(const void * restrict _in1,              \
                                                              const void * restrict _in2,              \
                                                              void * restrict _out, int *count,        \
                                              struct ompi_datatype_t **dtype,                          \
                                              struct ompi_op_base_module_1_0_0_t *module)              \
{                                                                                                      \
    int left_over = *count;                                                                            \
    type##type_size##_t *in1 = (type##type_size##_t*)_in1,                                             \
                        *in2 = (type##type_size##_t*)_in2,                                             \
                        *out = (type##type_size##_t*)_out;                                             \
        assert(types_per_step == (128 / 8) / sizeof(type##type_size##_t));                             \
        for( ; left_over >= types_per_step; left_over -= types_per_step ) {                            \
            type##type_size##x##types_per_step##_t vecA = vld1q_##type_sign##type_size(in1);           \
            type##type_size##x##types_per_step##_t vecB = vld1q_##type_sign##type_size(in2);           \
            in1 += types_per_step;                                                                     \
            in2 += types_per_step;                                                                     \
            type##type_size##x##types_per_step##_t res =  v##op##q_##type_sign##type_size(vecA, vecB); \
            vst1q_##type_sign##type_size(out, res);                                                    \
            out += types_per_step;                                                                     \
        }                                                                                              \
    while( left_over > 0 ) {                                                                           \
        int how_much = (left_over > 8) ? 8 : left_over;                                                \
        switch(how_much) {                                                                             \
        case 8: out[7] = current_func(in1[7], in2[7]);                                                 \
        case 7: out[6] = current_func(in1[6], in2[6]);                                                 \
        case 6: out[5] = current_func(in1[5], in2[5]);                                                 \
        case 5: out[4] = current_func(in1[4], in2[4]);                                                 \
        case 4: out[3] = current_func(in1[3], in2[3]);                                                 \
        case 3: out[2] = current_func(in1[2], in2[2]);                                                 \
        case 2: out[1] = current_func(in1[1], in2[1]);                                                 \
        case 1: out[0] = current_func(in1[0], in2[0]);                                                 \
        }                                                                                              \
        left_over -= how_much;                                                                         \
        out += how_much;                                                                               \
        in1 += how_much;                                                                               \
        in2 += how_much;                                                                               \
    }                                                                                                  \
}

/*************************************************************************
 * Max
 *************************************************************************/
#undef current_func
#define current_func(a, b) ((a) > (b) ? (a) : (b))
    OP_NEON_FUNC(max, s,  8, 16,   int, max)
    OP_NEON_FUNC(max, u,  8, 16,  uint, max)
    OP_NEON_FUNC(max, s, 16,  8,   int, max)
    OP_NEON_FUNC(max, u, 16,  8,  uint, max)
    OP_NEON_FUNC(max, s, 32,  4,   int, max)
    OP_NEON_FUNC(max, u, 32,  4,  uint, max)
    OP_NEON_FUNC(max, f, 32,  4, float, max)
    OP_NEON_FUNC(max, f, 64,  2, float, max)

/*************************************************************************
 * Min
 *************************************************************************/
#undef current_func
#define current_func(a, b) ((a) < (b) ? (a) : (b))
    OP_NEON_FUNC(min, s,  8, 16,   int, min)
    OP_NEON_FUNC(min, u,  8, 16,  uint, min)
    OP_NEON_FUNC(min, s, 16,  8,   int, min)
    OP_NEON_FUNC(min, u, 16,  8,  uint, min)
    OP_NEON_FUNC(min, s, 32,  4,   int, min)
    OP_NEON_FUNC(min, u, 32,  4,  uint, min)
    OP_NEON_FUNC(min, f, 32,  4, float, min)
    OP_NEON_FUNC(min, f, 64,  2, float, min)

/*************************************************************************
 * Sum 
 *************************************************************************/
#undef current_func
#define current_func(a, b) ((a) + (b))
    OP_NEON_FUNC(sum, s,  8, 16,   int, add)
    OP_NEON_FUNC(sum, u,  8, 16,  uint, add)
    OP_NEON_FUNC(sum, s, 16,  8,   int, add)
    OP_NEON_FUNC(sum, u, 16,  8,  uint, add)
    OP_NEON_FUNC(sum, s, 32,  4,   int, add)
    OP_NEON_FUNC(sum, u, 32,  4,  uint, add)
    OP_NEON_FUNC(sum, f, 32,  4, float, add)
    OP_NEON_FUNC(sum, f, 64,  2, float, add)

/*************************************************************************
 * Product
 *************************************************************************/
#undef current_func
#define current_func(a, b) ((a) * (b))
    OP_NEON_FUNC(prod, s,  8, 16,   int, mul)
    OP_NEON_FUNC(prod, u,  8, 16,  uint, mul)
    OP_NEON_FUNC(prod, s, 16,  8,   int, mul)
    OP_NEON_FUNC(prod, u, 16,  8,  uint, mul)
    OP_NEON_FUNC(prod, s, 32,  4,   int, mul)
    OP_NEON_FUNC(prod, u, 32,  4,  uint, mul)
    OP_NEON_FUNC(prod, f, 32,  4, float, mul)
    OP_NEON_FUNC(prod, f, 64,  2, float, mul)

/** C functions ***********************************************************/
#define C_FUNCTIONS(name, ftype)                                              \
    [OMPI_OP_BASE_TYPE_INT8_T]   = ompi_op_neon_##ftype##_##name##_int8_t,    \
    [OMPI_OP_BASE_TYPE_UINT8_T]  = ompi_op_neon_##ftype##_##name##_uint8_t,   \
    [OMPI_OP_BASE_TYPE_INT16_T]  = ompi_op_neon_##ftype##_##name##_int16_t,   \
    [OMPI_OP_BASE_TYPE_UINT16_T] = ompi_op_neon_##ftype##_##name##_uint16_t,  \
    [OMPI_OP_BASE_TYPE_INT32_T]  = ompi_op_neon_##ftype##_##name##_int32_t,   \
    [OMPI_OP_BASE_TYPE_UINT32_T] = ompi_op_neon_##ftype##_##name##_uint32_t,  \
    [OMPI_OP_BASE_TYPE_FLOAT]    = ompi_op_neon_##ftype##_##name##_float32_t, \
    [OMPI_OP_BASE_TYPE_DOUBLE]   = ompi_op_neon_##ftype##_##name##_float64_t


/*
 * MPI_OP_NULL
 * All types
 */
#define FLAGS_NO_FLOAT \
        (OMPI_OP_FLAGS_INTRINSIC | OMPI_OP_FLAGS_ASSOC | OMPI_OP_FLAGS_COMMUTE)
#define FLAGS \
        (OMPI_OP_FLAGS_INTRINSIC | OMPI_OP_FLAGS_ASSOC | \
         OMPI_OP_FLAGS_FLOAT_ASSOC | OMPI_OP_FLAGS_COMMUTE)

ompi_op_base_handler_fn_t ompi_op_neon_functions[OMPI_OP_BASE_FORTRAN_OP_MAX][OMPI_OP_BASE_TYPE_MAX] =
{
    /* Corresponds to MPI_OP_NULL */
    [OMPI_OP_BASE_FORTRAN_NULL] = {
        /* Leaving this empty puts in NULL for all entries */
        NULL,
    },
    /* Corresponds to MPI_MAX */
    [OMPI_OP_BASE_FORTRAN_MAX] = {
        C_FUNCTIONS(max, 2buff)
    },
    /* Corresponds to MPI_MIN */
    [OMPI_OP_BASE_FORTRAN_MIN] = {
        C_FUNCTIONS(min, 2buff)
    },
    /* Corresponds to MPI_SUM */
    [OMPI_OP_BASE_FORTRAN_SUM] = {
        C_FUNCTIONS(sum, 2buff)
    },
    /* Corresponds to MPI_PROD */
    [OMPI_OP_BASE_FORTRAN_PROD] = {
        C_FUNCTIONS(prod, 2buff)
    },
};

/*************************************************************************
 * Max
 *************************************************************************/
#undef current_func
#define current_func(a, b) ((a) > (b) ? (a) : (b))
    OP_NEON_FUNC_3(max, s,  8, 16,   int, max)
    OP_NEON_FUNC_3(max, u,  8, 16,  uint, max)
    OP_NEON_FUNC_3(max, s, 16,  8,   int, max)
    OP_NEON_FUNC_3(max, u, 16,  8,  uint, max)
    OP_NEON_FUNC_3(max, s, 32,  4,   int, max)
    OP_NEON_FUNC_3(max, u, 32,  4,  uint, max)
    OP_NEON_FUNC_3(max, f, 32,  4, float, max)
    OP_NEON_FUNC_3(max, f, 64,  2, float, max)

ompi_op_base_3buff_handler_fn_t ompi_op_neon_3buff_functions[OMPI_OP_BASE_FORTRAN_OP_MAX][OMPI_OP_BASE_TYPE_MAX] =
{
    /* Corresponds to MPI_OP_NULL */
    [OMPI_OP_BASE_FORTRAN_NULL] = {
        /* Leaving this empty puts in NULL for all entries */
        NULL,
    },
    /* Corresponds to MPI_MAX */
    [OMPI_OP_BASE_FORTRAN_MAX] = {
        C_FUNCTIONS(max, 3buff)
    },
};
