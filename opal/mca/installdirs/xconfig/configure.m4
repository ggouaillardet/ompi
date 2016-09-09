# -*- shell-script -*-
#
# Copyright (c) 2006      Los Alamos National Security, LLC.  All rights
#                         reserved.
# Copyright (c) 2010      Cisco Systems, Inc.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

AC_DEFUN([MCA_opal_installdirs_xconfig_PRIORITY], [0])

AC_DEFUN([MCA_opal_installdirs_xconfig_COMPILE_MODE], [
    AC_MSG_CHECKING([for MCA component $2:$3 compile mode])
    $4="static"
    AC_MSG_RESULT([$$4])
])


# MCA_installdirs_xconfig_CONFIG(action-if-can-compile,
#                        [action-if-cant-compile])
# ------------------------------------------------
AC_DEFUN([MCA_opal_installdirs_xconfig_CONFIG],[
    AC_CONFIG_FILES([opal/mca/installdirs/xconfig/Makefile
                     opal/mca/installdirs/xconfig/install_xdirs.h])
])

