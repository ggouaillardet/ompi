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
    op_avx2_support=0
    op_avx512_support=0
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
               [op_avx512_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])

           AS_IF([test $op_avx512_support -eq 0],
                 [AC_MSG_CHECKING([for AVX512 support (with -march=skylake-avx512)])
                  op_avx_cflags_save="$CFLAGS"
                  CFLAGS="$CFLAGS -march=skylake-avx512"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                       [[
    __m512 vA, vB;
    _mm512_add_ps(vA, vB)
                                       ]])],
                      [op_avx512_support=1
                       op_avx_CPPFLAGS="-march=skylake-avx512"
                       AC_MSG_RESULT([yes])],
                      [AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           #
           # No support for the AVX512 instruction set. Let's see if we can fall back
           # to an earlier instruction set (AVX2).
           #
           AS_IF([test $op_avx512_support -eq 0],
                 [AC_MSG_CHECKING([for AVX2 support (no additional flags)])
                  op_avx_cflags_save="$CFLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                       [[
    __m256 vA, vB;
    _mm256_add_ps(vA, vB)
                                       ]])],
                      [op_avx2_support=1
                       AC_MSG_RESULT([yes])],
                      [AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                  AS_IF([test $op_avx2_support -eq 0],
                        [AC_MSG_CHECKING([for AVX2 support (with -mavx2)])
                         op_avx_cflags_save="$CFLAGS"
                         CFLAGS="$CFLAGS -mavx2"
                         AC_LINK_IFELSE(
                            [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                             [[
    __m256 vA, vB;
    _mm256_add_ps(vA, vB)
                                             ]])],
                            [op_avx2_support=1
                             op_avx_CPPFLAGS="-mavx2"
                             AC_MSG_RESULT([yes])],
                            [AC_MSG_RESULT([no])])
                        CFLAGS="$op_avx_cflags_save"
                    ])
                 ],
                 [AC_MSG_NOTICE([Assume support for AVX2 (implied by support for AVX512)])
                  op_avx2_support=1])
           #
           # No support for the AVX512 nor AVX2 instruction sets. Fall back
           # to an even earlier instruction set (AVX).
           #
           AS_IF([test $op_avx2_support -eq 0],
                 [AC_MSG_CHECKING([for AVX support (no additional flags)])
                  op_avx_cflags_save="$CFLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                       [[
    __m128 vA, vB;
    _mm128_add_ps(vA, vB)
                                       ]])],
                      [op_avx_support=1
                       AC_MSG_RESULT([yes])],
                      [AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                  AS_IF([test $op_avx_support -eq 0],
                        [AC_MSG_CHECKING([for AVX support (with -mavx)])
                         op_avx_cflags_save="$CFLAGS"
                         CFLAGS="$CFLAGS -mavx"
                         AC_LINK_IFELSE(
                            [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                             [[
    __m128 vA, vB;
    _mm128_add_ps(vA, vB)
                                             ]])],
                            [op_avx_support=1
                             op_avx_CPPFLAGS="-mavx"
                             AC_MSG_RESULT([yes])],
                            [AC_MSG_RESULT([no])])
                        CFLAGS="$op_avx_cflags_save"
                    ])
                 ],
                 [AC_MSG_NOTICE([Assume support for AVX (implied by support for AVX2)])
                  op_avx_support=1])

           AC_LANG_POP([C])
          ])

    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX512],
                       [$op_avx512_support],
                       [Whetever AVX512 is supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX2],
                       [$op_avx2_support],
                       [Whetever AVX2 is supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX],
                       [$op_avx_support],
                       [Whetever AVX is supported in the current build])
    AC_SUBST([op_avx_CPPFLAGS])
    OPAL_VAR_SCOPE_POP
    AS_IF([test $op_avx_support -eq 1],
          [$1],
          [$2])

])dnl
