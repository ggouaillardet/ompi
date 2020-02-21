/* -*- Mode: C; c-basic-offset:4 ; indent-tabs-mode:nil -*- */
/*
 * Copyright (c) 2019-2020 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#ifdef __ARM_FEATURE_SVE
#include <arm_sve.h>
#endif /* __ARM_FEATURE_SVE */

#include "mpi.h"
#include "ompi/communicator/communicator.h"
#include "ompi/runtime/mpiruntime.h"
#include "ompi/datatype/ompi_datatype.h"

static void print_status(char* op, char* type, int correctness)
{
    if(correctness)
        printf("%s %s [\033[1;32msuccess\033[0m]", op, type);
    else
        printf("%s %s [\033[1;31mfail\033[0m]", op, type);
}

int main(int argc, char **argv)
{
    static void *in_buf = NULL, *inout_buf = NULL, *inout_check_buf = NULL;
    int count, elem_size, rank, size, len, provided, correctness = 1, i;
    double tstart, tend;
    char *type, *op;

    if(argc < 4 ) {
        fprintf(stderr,
                "Less arguments than expected (we need at least 3): <count> <type> <element size> <op>\n"
                "  <type> : [i, u, f, d]\n"
                "  <op> ; [sum, max, min, bor, bxor, mul, band]\n");
        exit(-1);
    }
    count = atoi(argv[1]);
    type = argv[2];
    elem_size = atoi(argv[3]);
    op = argv[4];

    if( count <= 0 ) {
        printf("The number of elements should be positive\n");
        exit(-1);
    }
    if( (0 != (elem_size%8)) || (elem_size <= 0) || (elem_size > 64) ) {
        printf("The element type should be 8, 16, 32 or 64\n");
        exit(-2);
    }

    in_buf          = malloc(count * sizeof(double));
    inout_buf       = malloc(count * sizeof(double));
    inout_check_buf = malloc(count * sizeof(double));

    ompi_mpi_init(argc, argv, MPI_THREAD_SERIALIZED, &provided, false);

    rank = ompi_comm_rank(MPI_COMM_WORLD);
    size = ompi_comm_size(MPI_COMM_WORLD);

    if(*type=='i') {
        if( 8 == elem_size ) {
            int8_t *in_int8 = (int8_t*)in_buf,
                *inout_int8 = (int8_t*)inout_buf,
                *inout_int8_for_check = (int8_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_int8[i] = 5;
                inout_int8[i] = inout_int8_for_check[i] = -3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8, inout_int8, count, MPI_INT8_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != (int8_t)(in_int8[i] + inout_int8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8, inout_int8, count, MPI_INT8_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != in_int8[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {  //intentionly reversed in and out
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_int8, in_int8, count, MPI_INT8_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != in_int8[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8, inout_int8, count, MPI_INT8_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != (in_int8[i] | inout_int8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8, inout_int8, count, MPI_INT8_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != (in_int8[i] ^ inout_int8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8,inout_int8,count, MPI_INT8_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != (int8_t)(in_int8[i] * inout_int8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_INT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int8, inout_int8, count, MPI_INT8_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int8[i] != (in_int8[i] & inout_int8_for_check[i]) ) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT8_T", correctness);
            }
        }
        if( 16 == elem_size ) {
            int16_t *in_int16 = (int16_t*)in_buf,
                *inout_int16 = (int16_t*)inout_buf,
                *inout_int16_for_check = (int16_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_int16[i] = 5;
                inout_int16[i] = inout_int16_for_check[i] = -3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_SUM);
                tend = MPI_Wtime();
                for( i = 0; i < count; i++ ) {
                    if(inout_int16[i] != (int16_t)(in_int16[i] + inout_int16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ )  {
                    if(inout_int16[i] != in_int16[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_int16, in_int16, count, MPI_INT16_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int16[i] != in_int16[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int16[i] != (in_int16[i] | inout_int16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int16[i] != (in_int16[i] ^ inout_int16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int16[i] != (int16_t)(in_int16[i] * inout_int16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_INT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int16, inout_int16, count, MPI_INT16_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int16[i] != (in_int16[i] & inout_int16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT16_T", correctness);
            }
        }
        if( 32 == elem_size ) {
            int32_t *in_int32 = (int32_t*)in_buf,
                *inout_int32 = (int32_t*)inout_buf,
                *inout_int32_for_check = (int32_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_int32[i] = 5;
                inout_int32[i] = inout_int32_for_check[i] = 3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != (int32_t)(in_int32[i] + inout_int32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != in_int32[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_int32, in_int32, count, MPI_INT32_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != in_int32[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != (in_int32[i] | inout_int32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != (int32_t)(in_int32[i] * inout_int32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != (in_int32[i] & inout_int32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_INT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int32, inout_int32, count, MPI_INT32_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int32[i] != (in_int32[i] ^ inout_int32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT32_T", correctness);
            }
        }
        if( 64 == elem_size ) {
            int64_t *in_int64 = (int64_t*)in_buf,
                *inout_int64 = (int64_t*)inout_buf,
                *inout_int64_for_check = (int64_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_int64[i] = 5;
                inout_int64[i] = inout_int64_for_check[i] = 3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64, inout_int64, count, MPI_INT64_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != (int64_t)(in_int64[i] + inout_int64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64, inout_int64, count, MPI_INT64_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != in_int64[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_int64, in_int64, count, MPI_INT64_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != in_int64[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64, inout_int64, count, MPI_INT64_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != (in_int64[i] | inout_int64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64, inout_int64, count, MPI_INT64_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != (in_int64[i] ^ inout_int64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64,inout_int64,count, MPI_INT64_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != (int64_t)(in_int64[i] * inout_int64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_INT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_int64, inout_int64, count, MPI_INT64_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_int64[i] != (in_int64[i] & inout_int64_for_check[i]) ) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT64_T", correctness);
            }
        }
    }
    if(*type=='u') {
        if( 8 == elem_size ) {
            uint8_t *in_uint8 = (uint8_t*)in_buf,
                *inout_uint8 = (uint8_t*)inout_buf,
                *inout_uint8_for_check = (uint8_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_uint8[i] = 5;
                inout_uint8[i] = inout_uint8_for_check[i] = -3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != (uint8_t)(in_uint8[i] + inout_uint8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != inout_uint8_for_check[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {  //intentionly reversed in and out
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != in_uint8[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != (in_uint8[i] | inout_uint8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != (in_uint8[i] ^ inout_uint8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != (uint8_t)(in_uint8[i] * inout_uint8_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT8_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_UINT8_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint8, inout_uint8, count, MPI_UINT8_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint8[i] != (in_uint8[i] & inout_uint8_for_check[i]) ) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT8_T", correctness);
            }
        }
        if( 16 == elem_size ) {
            uint16_t *in_uint16 = (uint16_t*)in_buf,
                *inout_uint16 = (uint16_t*)inout_buf,
                *inout_uint16_for_check = (uint16_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_uint16[i] = 5;
                inout_uint16[i] = inout_uint16_for_check[i] = -3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_SUM);
                tend = MPI_Wtime();
                for( i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != (uint16_t)(in_uint16[i] + inout_uint16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ )  {
                    if(inout_uint16[i] != inout_uint16_for_check[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != in_uint16[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != (in_uint16[i] | inout_uint16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != (in_uint16[i] ^ inout_uint16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != (uint16_t)(in_uint16[i] * inout_uint16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT16_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_UINT16_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint16, inout_uint16, count, MPI_UINT16_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint16[i] != (in_uint16[i] & inout_uint16_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT16_T", correctness);
            }
        }
        if( 32 == elem_size ) {
            uint32_t *in_uint32 = (uint32_t*)in_buf,
                *inout_uint32 = (uint32_t*)inout_buf,
                *inout_uint32_for_check = (uint32_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_uint32[i] = 5;
                inout_uint32[i] = inout_uint32_for_check[i] = 3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32, inout_uint32, count, MPI_UINT32_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != (uint32_t)(in_uint32[i] + inout_uint32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32, inout_uint32, count, MPI_UINT32_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != in_uint32[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {  // we reverse the send and recv buffers
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_uint32, in_uint32, count, MPI_UINT32_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != in_uint32[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32,inout_uint32,count, MPI_UINT32_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != (in_uint32[i] | inout_uint32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32, inout_uint32, count, MPI_UINT32_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != (uint32_t)(in_uint32[i] * inout_uint32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32, inout_uint32, count, MPI_UINT32_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != (in_uint32[i] & inout_uint32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT32_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_UINT32_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint32, inout_uint32, count, MPI_UINT32_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint32[i] != (in_uint32[i] ^ inout_uint32_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT32_T", correctness);
            }
        }
        if( 64 == elem_size ) {
            int64_t *in_uint64 = (int64_t*)in_buf,
                *inout_uint64 = (int64_t*)inout_buf,
                *inout_uint64_for_check = (int64_t*)inout_check_buf;
            for( i = 0; i < count; i++ ) {
                in_uint64[i] = 5;
                inout_uint64[i] = inout_uint64_for_check[i] = 3;
            }
            if( 0 == strcmp(op, "sum") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64, inout_uint64, count, MPI_UINT64_T, MPI_SUM);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != (int64_t)(in_uint64[i] + inout_uint64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_SUM", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "max") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64, inout_uint64, count, MPI_UINT64_T, MPI_MAX);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != in_uint64[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MAX", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "min") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(inout_uint64, in_uint64, count, MPI_UINT64_T, MPI_MIN);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != in_uint64[i]) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_MIN", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "bor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BOR", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64, inout_uint64, count, MPI_UINT64_T, MPI_BOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != (in_uint64[i] | inout_uint64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BOR", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "bxor") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BXOR", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64, inout_uint64, count, MPI_UINT64_T, MPI_BXOR);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != (in_uint64[i] ^ inout_uint64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BXOR", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "mul") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64,inout_uint64,count, MPI_UINT64_T, MPI_PROD);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != (int64_t)(in_uint64[i] * inout_uint64_for_check[i])) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_PROD", "MPI_INT64_T", correctness);
            }
            if( 0 == strcmp(op, "band") ) {
                printf("#Local Reduce %s for %s: %d \n", "MPI_BAND", "MPI_UINT64_T", count);
                tstart = MPI_Wtime();
                MPI_Reduce_local(in_uint64, inout_uint64, count, MPI_UINT64_T, MPI_BAND);
                tend = MPI_Wtime();
                for( correctness = 1, i = 0; i < count; i++ ) {
                    if(inout_uint64[i] != (in_uint64[i] & inout_uint64_for_check[i]) ) {
                        if( correctness )
                            printf("First error at position %d\n", i);
                        correctness = 0;
                        break;
                    }
                }
                print_status("MPI_BAND", "MPI_INT64_T", correctness);
            }
        }
    }

    if(*type=='f') {
        float *in_float = (float*)in_buf,
            *inout_float = (float*)inout_buf,
            *inout_float_for_check = (float*)inout_check_buf;
        for( i = 0; i < count; i++ ) {
            in_float[i] = 1000.0+1;
            inout_float[i] = inout_float_for_check[i] = 100.0+2;
        }
        if( 0 == strcmp(op, "sum") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_FLOAT", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_float, inout_float, count, MPI_FLOAT, MPI_SUM);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_float[i] != inout_float_for_check[i]+in_float[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_SUM", "MPI_FLOAT", correctness);
        }

        if( 0 == strcmp(op, "max") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_FLOAT", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_float, inout_float, count, MPI_FLOAT, MPI_MAX);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_float[i] != in_float[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_MAX", "MPI_FLOAT", correctness);
        }

        if( 0 == strcmp(op, "min") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_FLOAT", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(inout_float,in_float,count, MPI_FLOAT, MPI_MIN);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_float[i] != in_float[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_MIN", "MPI_FLOAT", correctness);
        }

        if( 0 == strcmp(op, "mul") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_FLOAT", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_float, inout_float, count, MPI_FLOAT, MPI_PROD);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_float[i] != in_float[i] * inout_float_for_check[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_PROD", "MPI_FLOAT", correctness);
        }
    }

    if(*type=='d') {
        double *in_double = (double*)in_buf,
            *inout_double = (double*)inout_buf,
            *inout_double_for_check = (double*)inout_check_buf;
        for( i = 0; i < count; i++ ) {
            in_double[i] = 10.0+1;
            inout_double[i] = inout_double_for_check[i] = 1.0+2;
        }

        if( 0 == strcmp(op, "sum") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_SUM", "MPI_DOUBLE", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_double, inout_double, count, MPI_DOUBLE, MPI_SUM);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_double[i] != inout_double_for_check[i]+in_double[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_SUM", "MPI_DOUBLE", correctness);
        }

        if( 0 == strcmp(op, "max") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_MAX", "MPI_DOUBLE", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_double, inout_double, count, MPI_DOUBLE, MPI_MAX);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_double[i] != in_double[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_MAX", "MPI_DOUBLE", correctness);
        }

        if( 0 == strcmp(op, "min") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_MIN", "MPI_DOUBLE", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(inout_double, in_double, count, MPI_DOUBLE, MPI_MIN);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_double[i] != in_double[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_MIN", "MPI_DOUBLE", correctness);
        }
        if( 0 == strcmp(op, "mul") ) {
            printf("#Local Reduce %s for %s: %d \n", "MPI_PROD", "MPI_DOUBLE", count);
            tstart = MPI_Wtime();
            MPI_Reduce_local(in_double, inout_double, count, MPI_DOUBLE, MPI_PROD);
            tend = MPI_Wtime();
            for( correctness = 1, i = 0; i < count; i++ ) {
                if(inout_double[i] != inout_double_for_check[i]*in_double[i]) {
                    if( correctness )
                        printf("First error at position %d\n", i);
                    correctness = 0;
                    break;
                }
            }
            print_status("MPI_PROD", "MPI_DOUBLE", correctness);
        }
    }
    //tstart = MPI_Wtime(); 
    //memcpy(in_uint8,inout_uint8, count);
    //memcpy(in_float, inout_float, count);
    //memcpy(in_double, inout_double, count);
    printf(" count  %d  time %.6f seconds\n",count, tend-tstart);
    ompi_mpi_finalize();

    free(in_buf);
    free(inout_buf);
    free(inout_check_buf);

    return correctness ? 0 : -1;
}

