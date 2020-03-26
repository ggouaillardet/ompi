# -*- shell-script -*-
#
# Copyright (c) 2019-2020 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2020      Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2020      Research Organization for Information Science
#                         and Technology (RIST).  All rights reserved.
#
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

# MCA_ompi_op_sve_CONFIG([action-if-can-compile],
#                        [action-if-cant-compile])
# ------------------------------------------------
# We can always build, unless we were explicitly disabled.
AC_DEFUN([MCA_ompi_op_sve_CONFIG],[
    AC_CONFIG_FILES([ompi/mca/op/sve/Makefile])

    op_sve_support=0

    AS_IF([test "$opal_cv_asm_arch" = "ARM64"],
          [AC_LANG_PUSH([C])

           # Check for SVE support with default flags
           AC_MSG_CHECKING([for SVE support (no additional flags)])
           AC_LINK_IFELSE(
               [AC_LANG_PROGRAM([[#include <arm_sve.h>]],
                                [[
    svfloat32_t vA, vB, vC;
    svbool_t pg;
    pg = svptrue_b32();
    vC = svadd_f32(pg, vA, vB);
                                ]])],
               [op_sve_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])

           AC_LANG_POP([C])
          ])

    op_sve_CFLAGS="-march=armv8.2a+sve"

    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_SVE],
                       [$op_sve_support],
                       [Whetever SVE is supported in the current build])

    AC_SUBST([op_sve_CFLAGS])

    AS_IF([test $op_sve_support -eq 1],
          [$1],
          [$2])

])dnl
