/* -*- Mode: C; c-basic-offset:4 ; -*- */
/*
 * Copyright (c) 2014      The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2014-2016 Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 * 
 * Additional copyrights may follow
 * 
 * $HEADER$
 */

#include "ompi_config.h"
#include "ompi/datatype/ompi_datatype.h"
#include "opal/runtime/opal.h"
#include "opal/datatype/opal_convertor.h"
#include "opal/datatype/opal_datatype_internal.h"
// #include <mpi.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


static int test_predefined_ddt()
{
    ompi_datatype_t * t;

    t = MPI_INT;
    if (t->super.flags & OPAL_DATATYPE_FLAG_HETEROGENEOUS) {
        fprintf(stderr, "%s is not an heterogeneous datatype\n", t->super.name);
        return 1;
    }

    t = MPI_DOUBLE;
    if (t->super.flags & OPAL_DATATYPE_FLAG_HETEROGENEOUS) {
        fprintf(stderr, "%s is not an heterogeneous datatype\n", t->super.name);
        return 1;
    }

    t = MPI_DOUBLE_INT;
    if (!(t->super.flags & OPAL_DATATYPE_FLAG_HETEROGENEOUS)) {
        fprintf(stderr, "%s is an heterogeneous datatype\n", t->super.name);
        return 1;
    }

    return 0;
}

int main( int argc, char* argv[] )
{
    int rc;

    opal_init_util(&argc, &argv);
    ompi_datatype_init();
    /**
     * By default simulate homogeneous architectures.
     */
    printf( "\n\n#\n * TEST PREDEFINED DATATYPES\n #\n\n" );
    rc = test_predefined_ddt();
    if( 0 != rc ) {
        printf( "predefined datatypes [NOT PASSED]\n" );
        return -1;
    }
    printf( "predefined datatypes [PASSED]\n" );
    return 0;
}
