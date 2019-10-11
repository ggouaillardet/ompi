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

#include "ompi/mca/op/op.h"
#include "ompi/mca/op/avx/op_avx.h"

BEGIN_C_DECLS

OMPI_DECLSPEC extern ompi_op_base_handler_fn_t
ompi_op_avx_functions[OMPI_OP_BASE_FORTRAN_OP_MAX][OMPI_OP_BASE_TYPE_MAX];
OMPI_DECLSPEC extern ompi_op_base_3buff_handler_fn_t
ompi_op_avx_3buff_functions[OMPI_OP_BASE_FORTRAN_OP_MAX][OMPI_OP_BASE_TYPE_MAX];

END_C_DECLS

