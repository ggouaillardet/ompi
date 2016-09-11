/*
 * Copyright (c) 2006-2007 Los Alamos National Security, LLC.  All rights
 *                         reserved.
 * Copyright (c) 2007      Cisco Systems, Inc.  All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include "opal_config.h"

#include <stdlib.h>
#include <string.h>

#include "opal/constants.h"
#include "opal/mca/installxdirs/installxdirs.h"

static int installxdirs_env_open(void);


opal_installxdirs_base_component_t mca_installxdirs_env_component = {
    /* First, the mca_component_t struct containing meta information
       about the component itself */
    {
        OPAL_INSTALLXDIRS_BASE_VERSION_2_0_0,

        /* Component name and version */
        "env",
        OPAL_MAJOR_VERSION,
        OPAL_MINOR_VERSION,
        OPAL_RELEASE_VERSION,

        /* Component open and close functions */
        installxdirs_env_open,
        NULL
    },
    {
        /* This component is checkpointable */
        MCA_BASE_METADATA_PARAM_CHECKPOINT
    },

    /* Next the opal_install_dirs_t install_dirs_data information */
    {
        NULL,
    },
};


#define SET_FIELD(field, envname)                                         \
    do {                                                                  \
        char *tmp = getenv("OPAL_X" envname);                             \
         if (NULL != tmp && 0 == strlen(tmp)) {                           \
             tmp = NULL;                                                  \
         }                                                                \
         mca_installxdirs_env_component.install_dirs_data.field = tmp;     \
    } while (0)


static int
installxdirs_env_open(void)
{
    SET_FIELD(prefix, "PREFIX");
    SET_FIELD(exec_prefix, "EXEC_PREFIX");
    SET_FIELD(bindir, "BINDIR");
    SET_FIELD(sbindir, "SBINDIR");
    SET_FIELD(libexecdir, "LIBEXECDIR");
    SET_FIELD(datarootdir, "DATAROOTDIR");
    SET_FIELD(datadir, "DATADIR");
    SET_FIELD(sysconfdir, "SYSCONFDIR");
    SET_FIELD(sharedstatedir, "SHAREDSTATEDIR");
    SET_FIELD(localstatedir, "LOCALSTATEDIR");
    SET_FIELD(libdir, "LIBDIR");
    SET_FIELD(includedir, "INCLUDEDIR");
    SET_FIELD(infodir, "INFODIR");
    SET_FIELD(mandir, "MANDIR");
    SET_FIELD(opaldatadir, "PKGDATADIR");
    SET_FIELD(opallibdir, "PKGLIBDIR");
    SET_FIELD(opalincludedir, "PKGINCLUDEDIR");

    return OPAL_SUCCESS;
}
