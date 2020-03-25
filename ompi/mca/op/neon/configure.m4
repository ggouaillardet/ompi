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

# MCA_ompi_op_neon_CONFIG([action-if-can-compile],
#                         [action-if-cant-compile])
# ------------------------------------------------
# We can always build, unless we were explicitly disabled.
AC_DEFUN([MCA_ompi_op_neon_CONFIG],[
    AC_CONFIG_FILES([ompi/mca/op/neon/Makefile])

    op_neon_support=0

    AS_IF([test "$opal_cv_asm_arch" = "ARM64"],
          [AC_LANG_PUSH([C])

           # Check for NEON support with default flags
           AC_MSG_CHECKING([for NEON support (no additional flags)])
           AC_LINK_IFELSE(
               [AC_LANG_PROGRAM([[#include <arm_neon.h>]],
                                [[
    float32x4_t vA, vB, vC;
    vC = vaddq_f32(vA, vB);
                                ]])],
               [op_neon_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])

           AC_LANG_POP([C])
          ])

    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_NEON],
                       [$op_neon_support],
                       [Whetever NEON is supported in the current build])

    AS_IF([test $op_neon_support -eq 1],
          [$1],
          [$2])

])dnl
