#!/usr/bin/env perl
#
# Copyright (c) 2013 Cisco Systems, Inc.  All rights reserved.
#
# $COPYRIGHT$
# 
# Additional copyrights may follow
# 
# $HEADER$
#

#
# Values for all of Open MPI's Fortran constants
#

package OMPI::Constants;

use strict;

our $constants;

$constants->{MPI_VERSION} = 3;
$constants->{MPI_SUBVERSION} = 0;

$constants->{MPI_ANY_SOURCE} = -1;
$constants->{MPI_ANY_TAG} = -1;
$constants->{MPI_PROC_NULL} = -2;
$constants->{MPI_ROOT} = -4;
$constants->{MPI_UNDEFINED} = -32766;
$constants->{MPI_CART} = 1;
$constants->{MPI_GRAPH} = 2;
$constants->{MPI_DIST_GRAPH} = 3;
$constants->{MPI_KEYVAL_INVALID} = -1;
$constants->{MPI_SOURCE} = 1;
$constants->{MPI_TAG} = 2;
$constants->{MPI_ERROR} = 3;
$constants->{MPI_TAG_UB} = 0;
$constants->{MPI_HOST} = 1;
$constants->{MPI_IO} = 2;
$constants->{MPI_WTIME_IS_GLOBAL} = 3;
$constants->{MPI_APPNUM} = 4;
$constants->{MPI_LASTUSEDCODE} = 5;
$constants->{MPI_UNIVERSE_SIZE} = 6;
$constants->{MPI_WIN_BASE} = 7;
$constants->{MPI_WIN_SIZE} = 8;
$constants->{MPI_WIN_DISP_UNIT} = 9;

$constants->{MPI_BSEND_OVERHEAD} = 128;
$constants->{MPI_ORDER_C} = 0;
$constants->{MPI_ORDER_FORTRAN} = 1;
$constants->{MPI_DISTRIBUTE_BLOCK} = 0;
$constants->{MPI_DISTRIBUTE_CYCLIC} = 1;
$constants->{MPI_DISTRIBUTE_NONE} = 2;
$constants->{MPI_DISTRIBUTE_DFLT_DARG} = -1;
$constants->{MPI_TYPECLASS_INTEGER} = 1;
$constants->{MPI_TYPECLASS_REAL} = 2;
$constants->{MPI_TYPECLASS_COMPLEX} = 3;
$constants->{MPI_MODE_NOCHECK} = 1;
$constants->{MPI_MODE_NOPRECEDE} = 2;
$constants->{MPI_MODE_NOPUT} = 4;
$constants->{MPI_MODE_NOSTORE} = 8;
$constants->{MPI_MODE_NOSUCCEED} = 16;
$constants->{MPI_LOCK_EXCLUSIVE} = 1;
$constants->{MPI_LOCK_SHARED} = 2;

$constants->{MPI_THREAD_SINGLE} = 0;
$constants->{MPI_THREAD_FUNNELED} = 1;
$constants->{MPI_THREAD_SERIALIZED} = 2;
$constants->{MPI_THREAD_MULTIPLE} = 3;

$constants->{MPI_SUCCESS} = 0;
$constants->{MPI_ERR_BUFFER} = 1;
$constants->{MPI_ERR_COUNT} = 2;
$constants->{MPI_ERR_TYPE} = 3;
$constants->{MPI_ERR_TAG} = 4;
$constants->{MPI_ERR_COMM} = 5;
$constants->{MPI_ERR_RANK} = 6;
$constants->{MPI_ERR_REQUEST} = 7;
$constants->{MPI_ERR_ROOT} = 8;
$constants->{MPI_ERR_GROUP} = 9;
$constants->{MPI_ERR_OP} = 10;
$constants->{MPI_ERR_TOPOLOGY} = 11;
$constants->{MPI_ERR_DIMS} = 12;
$constants->{MPI_ERR_ARG} = 13;
$constants->{MPI_ERR_UNKNOWN} = 14;
$constants->{MPI_ERR_TRUNCATE} = 15;
$constants->{MPI_ERR_OTHER} = 16;
$constants->{MPI_ERR_INTERN} = 17;
$constants->{MPI_ERR_IN_STATUS} = 18;
$constants->{MPI_ERR_PENDING} = 19;
$constants->{MPI_ERR_ACCESS} = 20;
$constants->{MPI_ERR_AMODE} = 21;
$constants->{MPI_ERR_ASSERT} = 22;
$constants->{MPI_ERR_BAD_FILE} = 23;
$constants->{MPI_ERR_BASE} = 24;
$constants->{MPI_ERR_CONVERSION} = 25;
$constants->{MPI_ERR_DISP} = 26;
$constants->{MPI_ERR_DUP_DATAREP} = 27;
$constants->{MPI_ERR_FILE_EXISTS} = 28;
$constants->{MPI_ERR_FILE_IN_USE} = 29;
$constants->{MPI_ERR_FILE} = 30;
$constants->{MPI_ERR_INFO_KEY} = 31;
$constants->{MPI_ERR_INFO_NOKEY} = 32;
$constants->{MPI_ERR_INFO_VALUE} = 33;
$constants->{MPI_ERR_INFO} = 34;
$constants->{MPI_ERR_IO} = 35;
$constants->{MPI_ERR_KEYVAL} = 36;
$constants->{MPI_ERR_LOCKTYPE} = 37;
$constants->{MPI_ERR_NAME} = 38;
$constants->{MPI_ERR_NO_MEM} = 39;
$constants->{MPI_ERR_NOT_SAME} = 40;
$constants->{MPI_ERR_NO_SPACE} = 41;
$constants->{MPI_ERR_NO_SUCH_FILE} = 42;
$constants->{MPI_ERR_PORT} = 43;
$constants->{MPI_ERR_QUOTA} = 44;
$constants->{MPI_ERR_READ_ONLY} = 45;
$constants->{MPI_ERR_RMA_CONFLICT} = 46;
$constants->{MPI_ERR_RMA_SYNC} = 47;
$constants->{MPI_ERR_SERVICE} = 48;
$constants->{MPI_ERR_SIZE} = 49;
$constants->{MPI_ERR_SPAWN} = 50;
$constants->{MPI_ERR_UNSUPPORTED_DATAREP} = 51;
$constants->{MPI_ERR_UNSUPPORTED_OPERATION} = 52;
$constants->{MPI_ERR_WIN} = 53;
# these error codes will never be returned by a fortran function
# since there are no fortran bindings for MPI_T
$constants->{MPI_T_ERR_MEMORY} = 54;
$constants->{MPI_T_ERR_NOT_INITIALIZED} = 55;
$constants->{MPI_T_ERR_CANNOT_INIT} = 56;
$constants->{MPI_T_ERR_INVALID_INDEX} = 57;
$constants->{MPI_T_ERR_INVALID_ITEM} = 58;
$constants->{MPI_T_ERR_INVALID_HANDLE} = 59;
$constants->{MPI_T_ERR_OUT_OF_HANDLES} = 60;
$constants->{MPI_T_ERR_OUT_OF_SESSIONS} = 61;
$constants->{MPI_T_ERR_INVALID_SESSION} = 62;
$constants->{MPI_T_ERR_CVAR_SET_NOT_NOW} = 63;
$constants->{MPI_T_ERR_CVAR_SET_NEVER} = 64;
$constants->{MPI_T_ERR_PVAR_NO_STARTSTOP} = 65;
$constants->{MPI_T_ERR_PVAR_NO_WRITE} = 66;
$constants->{MPI_T_ERR_PVAR_NO_ATOMIC} = 67;
$constants->{MPI_ERR_RMA_RANGE} = 68;
$constants->{MPI_ERR_RMA_ATTACH} = 69;
$constants->{MPI_ERR_RMA_FLAVOR} = 70;
$constants->{MPI_ERR_RMA_SHARED} = 71;
$constants->{MPI_T_ERR_INVALID} = 72;
$constants->{MPI_ERR_LASTCODE} = 92;

$constants->{MPI_IDENT} = 0;
$constants->{MPI_CONGRUENT} = 1;
$constants->{MPI_SIMILAR} = 2;
$constants->{MPI_UNEQUAL} = 3;

$constants->{MPI_COMBINER_NAMED} = 0;
$constants->{MPI_COMBINER_DUP} = 1;
$constants->{MPI_COMBINER_CONTIGUOUS} = 2;
$constants->{MPI_COMBINER_VECTOR} = 3;
$constants->{MPI_COMBINER_HVECTOR_INTEGER} = 4;
$constants->{MPI_COMBINER_HVECTOR} = 5;
$constants->{MPI_COMBINER_INDEXED} = 6;
$constants->{MPI_COMBINER_HINDEXED_INTEGER} = 7;
$constants->{MPI_COMBINER_HINDEXED} = 8;
$constants->{MPI_COMBINER_INDEXED_BLOCK} = 9;
$constants->{MPI_COMBINER_STRUCT_INTEGER} = 10;
$constants->{MPI_COMBINER_STRUCT} = 11;
$constants->{MPI_COMBINER_SUBARRAY} = 12;
$constants->{MPI_COMBINER_DARRAY} = 13;
$constants->{MPI_COMBINER_F90_REAL} = 14;
$constants->{MPI_COMBINER_F90_COMPLEX} = 15;
$constants->{MPI_COMBINER_F90_INTEGER} = 16;
$constants->{MPI_COMBINER_RESIZED} = 17;
$constants->{MPI_COMBINER_HINDEXED_BLOCK} = 18;

$constants->{MPI_COMM_TYPE_SHARED} = 0;
$constants->{OMPI_COMM_TYPE_HWTHREAD} = 1;
$constants->{OMPI_COMM_TYPE_CORE} = 2;
$constants->{OMPI_COMM_TYPE_L1CACHE} = 3;
$constants->{OMPI_COMM_TYPE_L2CACHE} = 4;
$constants->{OMPI_COMM_TYPE_L3CACHE} = 5;
$constants->{OMPI_COMM_TYPE_SOCKET} = 6;
$constants->{OMPI_COMM_TYPE_NUMA} = 7;
$constants->{OMPI_COMM_TYPE_NODE} = 0;
$constants->{OMPI_COMM_TYPE_BOARD} = 8;
$constants->{OMPI_COMM_TYPE_HOST} = 9;
$constants->{OMPI_COMM_TYPE_CU} = 10;
$constants->{OMPI_COMM_TYPE_CLUSTER} = 11;

#----------------------------------------------------------------------------

our $io_constants;

$io_constants->{MPI_SEEK_SET} = 600;
$io_constants->{MPI_SEEK_CUR} = 602;
$io_constants->{MPI_SEEK_END} = 604;
$io_constants->{MPI_MODE_CREATE} = 1;
$io_constants->{MPI_MODE_RDONLY} = 2;
$io_constants->{MPI_MODE_WRONLY} = 4;
$io_constants->{MPI_MODE_RDWR} = 8;
$io_constants->{MPI_MODE_DELETE_ON_CLOSE} = 16;
$io_constants->{MPI_MODE_UNIQUE_OPEN} = 32;
$io_constants->{MPI_MODE_EXCL} = 64;
$io_constants->{MPI_MODE_APPEND} = 128;
$io_constants->{MPI_MODE_SEQUENTIAL} = 256;
$io_constants->{MPI_DISPLACEMENT_CURRENT} = -54278278;

# If we get here, then this script has values for all the constants in
# FortranMPI.

1;
