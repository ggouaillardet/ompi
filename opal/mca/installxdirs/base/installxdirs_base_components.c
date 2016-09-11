/*
 * Copyright (c) 2006-2012 Los Alamos National Security, LLC.  All rights
 *                         reserved.
 * Copyright (c) 2007      Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2010      Sandia National Laboratories. All rights reserved.
 * Copyright (c) 2015      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 *
 */

#include "opal_config.h"

#include "opal/constants.h"
#include "opal/mca/mca.h"
#include "opal/mca/installxdirs/installxdirs.h"
#include "opal/mca/installxdirs/base/base.h"
#include "opal/mca/installxdirs/base/static-components.h"

opal_install_dirs_t opal_install_xdirs = {0};

#define CONDITIONAL_COPY(target, origin, field)                 \
    do {                                                        \
        if (origin.field != NULL && target.field == NULL) {     \
            target.field = origin.field;                        \
        }                                                       \
    } while (0)

static int
opal_installxdirs_base_open(mca_base_open_flag_t flags)
{
    mca_base_component_list_item_t *component_item;
    int ret;

    ret = mca_base_framework_components_open (&opal_installxdirs_base_framework,
                                              flags);
    if (OPAL_SUCCESS != ret) {
        return ret;
    }

    OPAL_LIST_FOREACH(component_item, &opal_installxdirs_base_framework.framework_components, mca_base_component_list_item_t) {
        const opal_installdirs_base_component_t *component =
            (const opal_installdirs_base_component_t *) component_item->cli_component;

        /* copy over the data, if something isn't already there */
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         prefix);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         exec_prefix);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         bindir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         sbindir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         libexecdir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         datarootdir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         datadir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         sysconfdir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         sharedstatedir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         localstatedir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         libdir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         includedir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         infodir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         mandir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         opaldatadir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         opallibdir);
        CONDITIONAL_COPY(opal_install_xdirs, component->install_dirs_data,
                         opalincludedir);
    }

    /* expand out all the fields */
    opal_install_xdirs.prefix =
        opal_install_xdirs_expand_setup(opal_install_xdirs.prefix);
    opal_install_xdirs.exec_prefix =
        opal_install_xdirs_expand_setup(opal_install_xdirs.exec_prefix);
    opal_install_xdirs.bindir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.bindir);
    opal_install_xdirs.sbindir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.sbindir);
    opal_install_xdirs.libexecdir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.libexecdir);
    opal_install_xdirs.datarootdir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.datarootdir);
    opal_install_xdirs.datadir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.datadir);
    opal_install_xdirs.sysconfdir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.sysconfdir);
    opal_install_xdirs.sharedstatedir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.sharedstatedir);
    opal_install_xdirs.localstatedir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.localstatedir);
    opal_install_xdirs.libdir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.libdir);
    opal_install_xdirs.includedir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.includedir);
    opal_install_xdirs.infodir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.infodir);
    opal_install_xdirs.mandir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.mandir);
    opal_install_xdirs.opaldatadir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.opaldatadir);
    opal_install_xdirs.opallibdir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.opallibdir);
    opal_install_xdirs.opalincludedir =
        opal_install_xdirs_expand_setup(opal_install_xdirs.opalincludedir);

#if 0
    fprintf(stderr, "prefix:         %s\n", opal_install_xdirs.prefix);
    fprintf(stderr, "exec_prefix:    %s\n", opal_install_xdirs.exec_prefix);
    fprintf(stderr, "bindir:         %s\n", opal_install_xdirs.bindir);
    fprintf(stderr, "sbindir:        %s\n", opal_install_xdirs.sbindir);
    fprintf(stderr, "libexecdir:     %s\n", opal_install_xdirs.libexecdir);
    fprintf(stderr, "datarootdir:    %s\n", opal_install_xdirs.datarootdir);
    fprintf(stderr, "datadir:        %s\n", opal_install_xdirs.datadir);
    fprintf(stderr, "sysconfdir:     %s\n", opal_install_xdirs.sysconfdir);
    fprintf(stderr, "sharedstatedir: %s\n", opal_install_xdirs.sharedstatedir);
    fprintf(stderr, "localstatedir:  %s\n", opal_install_xdirs.localstatedir);
    fprintf(stderr, "libdir:         %s\n", opal_install_xdirs.libdir);
    fprintf(stderr, "includedir:     %s\n", opal_install_xdirs.includedir);
    fprintf(stderr, "infodir:        %s\n", opal_install_xdirs.infodir);
    fprintf(stderr, "mandir:         %s\n", opal_install_xdirs.mandir);
    fprintf(stderr, "pkgdatadir:     %s\n", opal_install_xdirs.pkgdatadir);
    fprintf(stderr, "pkglibdir:      %s\n", opal_install_xdirs.pkglibdir);
    fprintf(stderr, "pkgincludedir:  %s\n", opal_install_xdirs.pkgincludedir);
#endif

    /* NTH: Is it ok not to close the components? If not we can add a flag
       to mca_base_framework_components_close to indicate not to deregister
       variable groups */
    return OPAL_SUCCESS;
}


static int
opal_installxdirs_base_close(void)
{
    free(opal_install_xdirs.prefix);
    free(opal_install_xdirs.exec_prefix);
    free(opal_install_xdirs.bindir);
    free(opal_install_xdirs.sbindir);
    free(opal_install_xdirs.libexecdir);
    free(opal_install_xdirs.datarootdir);
    free(opal_install_xdirs.datadir);
    free(opal_install_xdirs.sysconfdir);
    free(opal_install_xdirs.sharedstatedir);
    free(opal_install_xdirs.localstatedir);
    free(opal_install_xdirs.libdir);
    free(opal_install_xdirs.includedir);
    free(opal_install_xdirs.infodir);
    free(opal_install_xdirs.mandir);
    free(opal_install_xdirs.opaldatadir);
    free(opal_install_xdirs.opallibdir);
    free(opal_install_xdirs.opalincludedir);
    memset (&opal_install_xdirs, 0, sizeof (opal_install_xdirs));

    return mca_base_framework_components_close (&opal_installxdirs_base_framework, NULL);
}

/* Declare the installxdirs framework */
MCA_BASE_FRAMEWORK_DECLARE(opal, installxdirs, NULL, NULL, opal_installxdirs_base_open,
                           opal_installxdirs_base_close, mca_installxdirs_base_static_components,
                           MCA_BASE_FRAMEWORK_FLAG_NOREGISTER | MCA_BASE_FRAMEWORK_FLAG_NO_DSO);
