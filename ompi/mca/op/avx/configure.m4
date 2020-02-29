# -*- shell-script -*-
#
# Copyright (c) 2019-2020 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2020      Cisco Systems, Inc.  All rights reserved.
#
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

# MCA_ompi_op_avx_CONFIG([action-if-can-compile],
#                         [action-if-cant-compile])
# ------------------------------------------------
# We can always build, unless we were explicitly disabled.
AC_DEFUN([MCA_ompi_op_avx_CONFIG],[
    AC_CONFIG_FILES([ompi/mca/op/avx/Makefile])

    op_avx_support=0
    OPAL_VAR_SCOPE_PUSH([op_avx_cflags_save])

    AS_IF([test "$opal_cv_asm_arch" = "X86_64"],
          [AC_LANG_PUSH([C])

           # Check for AVX512 support with default flags
           op_avx_CPPFLAGS=""
           AC_MSG_CHECKING([for AVX512 support (no additional flags)])
           AC_LINK_IFELSE(
               [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                [[
    __m512 vA, vB;
    _mm512_add_ps(vA, vB)
                                ]])],
               [op_avx_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])

           AS_IF([test $op_avx_support -eq 0],
                 [AC_MSG_CHECKING([for AVX512 support (with -march=skylake-avx512)])
                  op_avx_cflags_save="$CFLAGS"
                  CFLAGS="$CFLAGS -march=skylake-avx512"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                       [[
    __m512 vA, vB;
    _mm512_add_ps(vA, vB)
                                       ]])],
                      [op_avx_support=1
                       op_avx_CPPFLAGS="-march=skylake-avx512"
                       AC_MSG_RESULT([yes])],
                      [AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           AC_LANG_POP([C])
          ])

    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX512],
                       [$op_avx_support],
                       [Whetever AVX512 is supported in the current compilation context])
    AC_SUBST([op_avx_CPPFLAGS])
    OPAL_VAR_SCOPE_POP
    AS_IF([test $op_avx_support -eq 1],
          [$1],
          [$2])

])dnl
