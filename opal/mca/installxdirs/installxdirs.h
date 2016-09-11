/* -*- Mode: C; c-basic-offset:4 ; indent-tabs-mode:nil -*- */
/*
 * Copyright (c) 2006-2015 Los Alamos National Security, LLC.  All rights
 *                         reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#ifndef OPAL_MCA_INSTALLDIRS_INSTALLXDIRS_H
#define OPAL_MCA_INSTALLDIRS_INSTALLXDIRS_H

#include "opal_config.h"

#include "opal/mca/mca.h"
#include "opal/mca/base/base.h"

#include "opal/mca/installdirs/installdirs.h"

BEGIN_C_DECLS

/* Install directories.  Only available after opal_init() */
OPAL_DECLSPEC extern opal_install_dirs_t opal_install_xdirs;

/**
 * Expand out path variables (such as ${prefix}) in the input string
 * using the current opal_install_dirs structure */
OPAL_DECLSPEC char * opal_install_xdirs_expand(const char* input);


/**
 * Structure for installxdirs components.
 */
struct opal_installxdirs_base_component_2_0_0_t {
    /** MCA base component */
    mca_base_component_t component;
    /** MCA base data */
    mca_base_component_data_t component_data;
    /** install directories provided by the given component */
    opal_install_dirs_t install_dirs_data;
};
/**
 * Convenience typedef
 */
typedef struct opal_installxdirs_base_component_2_0_0_t opal_installxdirs_base_component_t;

/*
 * Macro for use in components that are of type installdirs
 */
#define OPAL_INSTALLXDIRS_BASE_VERSION_2_0_0 \
    OPAL_MCA_BASE_VERSION_2_1_0("installxdirs", 2, 0, 0)

END_C_DECLS

#endif /* OPAL_MCA_INSTALLDIRS_INSTALLXDIRS_H */
