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

# MCA_ompi_op_avx_CONFIG([action-if-can-compile],
#                         [action-if-cant-compile])
# ------------------------------------------------
# We can always build, unless we were explicitly disabled.
AC_DEFUN([MCA_ompi_op_avx_CONFIG],[
    AC_CONFIG_FILES([ompi/mca/op/avx/Makefile])

    MCA_BUILD_OP_AVX_FLAGS=""
    MCA_BUILD_OP_AVX2_FLAGS=""
    MCA_BUILD_OP_AVX512_FLAGS=""
    op_sse3_support=0
    op_sse41_support=0
    op_avx_support=0
    op_avx2_support=0
    op_avx512_support=0
    OPAL_VAR_SCOPE_PUSH([op_avx_cflags_save])

    AS_IF([test "$opal_cv_asm_arch" = "X86_64"],
          [AC_LANG_PUSH([C])

           #
           # Check for AVX512 support
           #
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
                  CFLAGS="-march=skylake-avx512 $CFLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                       [[
    __m512 vA, vB;
    _mm512_add_ps(vA, vB)
                                       ]])],
                      [op_avx512_support=1
                       MCA_BUILD_OP_AVX512_FLAGS="-march=skylake-avx512"
                       AC_MSG_RESULT([yes])],
                      [AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           #
           # Some combination of gcc and older as would not correctly build the code generated by
           # _mm256_loadu_si256. Screen them out.
           #
           AS_IF([test $op_avx512_support -eq 1],
                 [AC_MSG_CHECKING([if _mm512_loadu_si512 generates code that can be compiled])
                  op_avx_cflags_save="$CFLAGS"
                  CFLAGS="$CFLAGS_WITHOUT_OPTFLAGS -O0 $MCA_BUILD_OP_AVX512_FLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                               [[
    int A[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    __m512i vA = _mm512_loadu_si512((__m512i*)&(A[1]))
                               ]])],
                      [AC_MSG_RESULT([yes])],
                      [op_avx512_support=0
                       MCA_BUILD_OP_AVX512_FLAGS=""
                       AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           #
           # Some PGI compilers do not define _mm512_mullo_epi64. Screen them out.
           #
           AS_IF([test $op_avx512_support -eq 1],
                 [AC_MSG_CHECKING([if _mm512_mullo_epi64 generates code that can be compiled])
                  op_avx_cflags_save="$CFLAGS"
                  CFLAGS="$CFLAGS_WITHOUT_OPTFLAGS -O0 $MCA_BUILD_OP_AVX512_FLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                               [[
    __m512i vA, vB;
    _mm512_mullo_epi64(vA, vB)
                               ]])],
                      [AC_MSG_RESULT([yes])],
                      [op_avx512_support=0
                       MCA_BUILD_OP_AVX512_FLAGS=""
                       AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           #
           # Check support for AVX2
           #
           AC_MSG_CHECKING([for AVX2 support (no additional flags)])
           AC_LINK_IFELSE(
               [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                       [[
    __m256 vA, vB;
    _mm256_add_ps(vA, vB)
                       ]])],
               [op_avx2_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])
           AS_IF([test $op_avx2_support -eq 0],
               [AC_MSG_CHECKING([for AVX2 support (with -mavx2)])
                op_avx_cflags_save="$CFLAGS"
                CFLAGS="-mavx2 $CFLAGS"
                AC_LINK_IFELSE(
                    [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                            [[
    __m256 vA, vB;
    _mm256_add_ps(vA, vB)
                            ]])],
                    [op_avx2_support=1
                     MCA_BUILD_OP_AVX2_FLAGS="-mavx2"
                     AC_MSG_RESULT([yes])],
                    [AC_MSG_RESULT([no])])
                CFLAGS="$op_avx_cflags_save"
                ])
           #
           # Some combination of gcc and older as would not correctly build the code generated by
           # _mm256_loadu_si256. Screen them out.
           #
           AS_IF([test $op_avx2_support -eq 1],
                 [AC_MSG_CHECKING([if _mm256_loadu_si256 generates code that can be compiled])
                  op_avx_cflags_save="$CFLAGS"
                  CFLAGS="$CFLAGS_WITHOUT_OPTFLAGS -O0 $MCA_BUILD_OP_AVX2_FLAGS"
                  AC_LINK_IFELSE(
                      [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                               [[
    int A[8] = {0, 1, 2, 3, 4, 5, 6, 7};
    __m256i vA = _mm256_loadu_si256((__m256i*)&A)
                               ]])],
                      [AC_MSG_RESULT([yes])],
                      [op_avx2_support=0
                       MCA_BUILD_OP_AVX2_FLAGS=""
                       AC_MSG_RESULT([no])])
                  CFLAGS="$op_avx_cflags_save"
                 ])
           #
           # What about early AVX support. The rest of the logic is slightly different as
           # we need to include some of the SSE4.1 and SSE3 instructions. So, we first check
           # if we can compile AVX code without a flag, then we validate that we have support
           # for the SSE4.1 and SSE3 instructions we need. If not, we check for the usage of
           # the AVX flag, and then recheck if we have support for the SSE4.1 and SSE3
           # instructions.
           #
           AC_MSG_CHECKING([for AVX support (no additional flags)])
           AC_LINK_IFELSE(
               [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                       [[
    __m128 vA, vB;
    _mm_add_ps(vA, vB)
                       ]])],
               [op_avx_support=1
                AC_MSG_RESULT([yes])],
               [AC_MSG_RESULT([no])])
           #
           # Check for SSE4.1 support
           #
           AS_IF([test $op_avx_support -eq 1],
               [AC_MSG_CHECKING([for SSE4.1 support])
                AC_LINK_IFELSE(
                    [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                            [[
    __m128i vA, vB;
    (void)_mm_max_epi8(vA, vB)
                            ]])],
                    [op_sse41_support=1
                     AC_MSG_RESULT([yes])],
                    [AC_MSG_RESULT([no])])
                ])
           #
           # Check for SSE3 support
           #
           AS_IF([test $op_avx_support -eq 1],
               [AC_MSG_CHECKING([for SSE3 support])
                AC_LINK_IFELSE(
                    [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                            [[
    int A[4] = {0, 1, 2, 3};
    __m128i vA = _mm_lddqu_si128((__m128i*)&A)
                            ]])],
                    [op_sse3_support=1
                     AC_MSG_RESULT([yes])],
                    [AC_MSG_RESULT([no])])
                ])
           # Second pass, do we need to add the AVX flag ?
           AS_IF([test $op_avx_support -eq 0 || test $op_sse41_support -eq 0 || test $op_sse3_support -eq 0],
               [AC_MSG_CHECKING([for AVX support (with -mavx)])
                op_avx_cflags_save="$CFLAGS"
                CFLAGS="-mavx $CFLAGS"
                AC_LINK_IFELSE(
                    [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                            [[
    __m128 vA, vB;
    _mm_add_ps(vA, vB)
                            ]])],
                    [op_avx_support=1
                     MCA_BUILD_OP_AVX_FLAGS="-mavx"
                     op_sse41_support=0
                     op_sse3_support=0
                     AC_MSG_RESULT([yes])],
                    [AC_MSG_RESULT([no])])

                AS_IF([test $op_sse41_support -eq 0],
                    [AC_MSG_CHECKING([for SSE4.1 support])
                     AC_LINK_IFELSE(
                         [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                 [[
    __m128i vA, vB;
    (void)_mm_max_epi8(vA, vB)
                                 ]])],
                         [op_sse41_support=1
                          AC_MSG_RESULT([yes])],
                         [AC_MSG_RESULT([no])])
                     ])
                AS_IF([test $op_sse3_support -eq 0],
                    [AC_MSG_CHECKING([for SSE3 support])
                     AC_LINK_IFELSE(
                         [AC_LANG_PROGRAM([[#include <immintrin.h>]],
                                 [[
    int A[4] = {0, 1, 2, 3};
    __m128i vA = _mm_lddqu_si128((__m128i*)&A)
                                 ]])],
                         [op_sse3_support=1
                          AC_MSG_RESULT([yes])],
                         [AC_MSG_RESULT([no])])
                     ])
                CFLAGS="$op_avx_cflags_save"
               ])

           AC_LANG_POP([C])
          ])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX512],
                       [$op_avx512_support],
                       [AVX512 supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX2],
                       [$op_avx2_support],
                       [AVX2 supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_AVX],
                       [$op_avx_support],
                       [AVX supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_SSE41],
                       [$op_sse41_support],
                       [SSE4.1 supported in the current build])
    AC_DEFINE_UNQUOTED([OMPI_MCA_OP_HAVE_SSE3],
                       [$op_sse3_support],
                       [SSE3 supported in the current build])
    AM_CONDITIONAL([MCA_BUILD_ompi_op_has_avx512_support],
                   [test "$op_avx512_support" == "1"])
    AM_CONDITIONAL([MCA_BUILD_ompi_op_has_avx2_support],
                   [test "$op_avx2_support" == "1"])
    AM_CONDITIONAL([MCA_BUILD_ompi_op_has_avx_support],
                   [test "$op_avx_support" == "1"])
    AM_CONDITIONAL([MCA_BUILD_ompi_op_has_sse41_support],
                   [test "$op_sse41_support" == "1"])
    AM_CONDITIONAL([MCA_BUILD_ompi_op_has_sse3_support],
                   [test "$op_sse3_support" == "1"])
    AC_SUBST(MCA_BUILD_OP_AVX512_FLAGS)
    AC_SUBST(MCA_BUILD_OP_AVX2_FLAGS)
    AC_SUBST(MCA_BUILD_OP_AVX_FLAGS)

    OPAL_VAR_SCOPE_POP
    # Enable this component iff we have at least the most basic form of support
    # for vectorial ISA
    AS_IF([test $op_avx_support -eq 1 || test $op_avx2_support -eq 1 || test $op_avx512_support -eq 1],
          [$1],
          [$2])

])dnl
