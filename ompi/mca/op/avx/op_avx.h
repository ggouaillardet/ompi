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

#ifndef MCA_OP_AVX_EXPORT_H
#define MCA_OP_AVX_EXPORT_H

#include "ompi_config.h"

#include "ompi/mca/mca.h"
#include "opal/class/opal_object.h"

#include "ompi/mca/op/op.h"

BEGIN_C_DECLS

/**
 * Derive a struct from the base op component struct, allowing us to
 * cache some component-specific information on our well-known
 * component struct.
 */
typedef struct {
    /** The base op component struct */
    ompi_op_base_component_1_0_0_t super;

    /* What follows is avx-component-specific cached information.  We
       tend to use this scheme (caching information on the avx
       component itself) instead of lots of individual global
       variables for the component.  The following data fields are
       avxs; replace them with whatever is relevant for your
       component. */

    /** A simple boolean indicating whether double precision is
        supported. */
    bool double_supported;
} ompi_op_avx_component_t;

/**
 * Globally exported variable.  Note that it is a *avx* component
 * (defined above), which has the ompi_op_base_component_t as its
 * first member.  Hence, the MCA/op framework will find the data that
 * it expects in the first memory locations, but then the component
 * itself can cache additional information after that that can be used
 * by both the component and modules.
 */
OMPI_DECLSPEC extern ompi_op_avx_component_t
    mca_op_avx_component;

END_C_DECLS

#endif /* MCA_OP_AVX_EXPORT_H */
