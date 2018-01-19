/* -*- Mode: C; c-basic-offset:4 ; -*- */
/*
 * Copyright (c) 2004-2010 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2007 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2012      Los Alamos National Security, LLC.  All rights
 *                         reserved.
 * Copyright (c) 2013-2014 Intel, Inc. All rights reserved
 * Copyright (c) 2015 Cisco Systems, Inc.  All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include "ompi_config.h"

#include <string.h>

#include "opal/class/opal_list.h"
#include "opal/util/output.h"
#include "opal/util/show_help.h"
#include "opal/runtime/opal_progress.h"
#include "ompi/mca/mca.h"
#include "opal/mca/base/base.h"
#include "opal/runtime/opal.h"

#include "ompi/constants.h"
#include "ompi/mca/cid/cid.h"
#include "ompi/mca/cid/base/base.h"

/**
 * Function for selecting one component from all those that are
 * available.
 */
int ompi_cid_base_select(void)
{
    ompi_cid_base_component_t *best_component = NULL;
    ompi_cid_base_module_t *best_module = NULL;
    int rc = ORTE_SUCCESS;

    /*
     * Select the best component
     */
    if (OPAL_SUCCESS != mca_base_select("cid", ompi_cid_base_framework.framework_output,
                                        &ompi_cid_base_framework.framework_components,
                                        (mca_base_module_t **) &best_module,
                                        (mca_base_component_t **) &best_component, NULL)) {
        /* This will only happen if no component was selected */
        return ORTE_ERR_NOT_FOUND;
    }

    /* Save the winner */
    ompi_cid = *best_module;
    /* give it a chance to init */
    if (NULL != ompi_cid.init) {
        rc = ompi_cid.init();
    }
    return rc;
}
