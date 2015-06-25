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
# Values for all of Open MPI's Fortran handles
#

package OMPI::Handles;

use strict;

our $handles;

$handles->{MPI_COMM_WORLD} = 0;
$handles->{MPI_COMM_SELF} = 1;
$handles->{MPI_GROUP_EMPTY} = 1;
$handles->{MPI_ERRORS_ARE_FATAL} = 1;
$handles->{MPI_ERRORS_RETURN} = 2;

$handles->{MPI_MAX} =  1;
$handles->{MPI_MIN} =  2;
$handles->{MPI_SUM} =  3;
$handles->{MPI_PROD} =  4;
$handles->{MPI_LAND} =  5;
$handles->{MPI_BAND} =  6;
$handles->{MPI_LOR} =  7;
$handles->{MPI_BOR} =  8;
$handles->{MPI_LXOR} =  9;
$handles->{MPI_BXOR} = 10;
$handles->{MPI_MAXLOC} = 11;
$handles->{MPI_MINLOC} = 12;
$handles->{MPI_REPLACE} = 13;

$handles->{MPI_COMM_NULL} = 2;
$handles->{MPI_DATATYPE_NULL} = 0;
$handles->{MPI_ERRHANDLER_NULL} = 0;
$handles->{MPI_GROUP_NULL} = 0;
$handles->{MPI_INFO_NULL} = 0;
$handles->{MPI_MESSAGE_NULL} = 0;
$handles->{MPI_OP_NULL} = 0;
$handles->{MPI_REQUEST_NULL} = 0;
$handles->{MPI_WIN_NULL} = 0;
$handles->{MPI_MESSAGE_NULL} = 0;

$handles->{MPI_BYTE} =  1;
$handles->{MPI_PACKED} =  2;
$handles->{MPI_UB} =  3;
$handles->{MPI_LB} =  4;
$handles->{MPI_CHARACTER} =  5;
$handles->{MPI_LOGICAL} =  6;
$handles->{MPI_INTEGER} =  7;
$handles->{MPI_INTEGER1} =  8;
$handles->{MPI_INTEGER2} =  9;
$handles->{MPI_INTEGER4} = 10;
$handles->{MPI_INTEGER8} = 11;
$handles->{MPI_INTEGER16} = 12;
$handles->{MPI_REAL} = 13;
$handles->{MPI_REAL4} = 14;
$handles->{MPI_REAL8} = 15;
$handles->{MPI_REAL16} = 16;
$handles->{MPI_DOUBLE_PRECISION} = 17;
$handles->{MPI_COMPLEX} = 18;
$handles->{MPI_COMPLEX8} = 19;
$handles->{MPI_COMPLEX16} = 20;
$handles->{MPI_COMPLEX32} = 21;
$handles->{MPI_DOUBLE_COMPLEX} = 22;
$handles->{MPI_2REAL} = 23;
$handles->{MPI_2DOUBLE_PRECISION} = 24;
$handles->{MPI_2INTEGER} = 25;
$handles->{MPI_2COMPLEX} = 26;
$handles->{MPI_2DOUBLE_COMPLEX} = 27;
$handles->{MPI_REAL2} = 28;
$handles->{MPI_LOGICAL1} = 29;
$handles->{MPI_LOGICAL2} = 30;
$handles->{MPI_LOGICAL4} = 31;
$handles->{MPI_LOGICAL8} = 32;
$handles->{MPI_WCHAR} = 33;
$handles->{MPI_CHAR} = 34;
$handles->{MPI_UNSIGNED_CHAR} = 35;
$handles->{MPI_SIGNED_CHAR} = 36;
$handles->{MPI_SHORT} = 37;
$handles->{MPI_UNSIGNED_SHORT} = 38;
$handles->{MPI_INT} = 39;
$handles->{MPI_UNSIGNED} = 40;
$handles->{MPI_LONG} = 41;
$handles->{MPI_UNSIGNED_LONG} = 42;
$handles->{MPI_LONG_LONG_INT} = 43;
$handles->{MPI_UNSIGNED_LONG_LONG} = 44;
$handles->{MPI_FLOAT} = 45;
$handles->{MPI_DOUBLE} = 46;
$handles->{MPI_LONG_DOUBLE} = 47;
$handles->{MPI_FLOAT_INT} = 48;
$handles->{MPI_DOUBLE_INT} = 49;
$handles->{MPI_LONGDBL_INT} = 50;
$handles->{MPI_LONG_INT} = 51;
$handles->{MPI_2INT} = 52;
$handles->{MPI_SHORT_INT} = 53;
$handles->{MPI_CXX_BOOL} = 54;
$handles->{MPI_CXX_CPLEX} = 55;
$handles->{MPI_CXX_DBLCPLEX} = 56;
$handles->{MPI_CXX_LDBLCPLEX} = 57;
$handles->{MPI_INT8_T} = 58;
$handles->{MPI_UINT8_T} = 59;
$handles->{MPI_INT16_T} = 60;
$handles->{MPI_UINT16_T} = 61;
$handles->{MPI_INT32_T} = 62;
$handles->{MPI_UINT32_T} = 63;
$handles->{MPI_INT64_T} = 64;
$handles->{MPI_UINT64_T} = 65;
$handles->{MPI_AINT} = 66;
$handles->{MPI_OFFSET} = 67;
$handles->{MPI_C_COMPLEX} = 68;
$handles->{MPI_C_FLOAT_COMPLEX} = 69;
$handles->{MPI_C_DOUBLE_COMPLEX} = 70;
$handles->{MPI_C_LONG_DOUBLE_COMPLEX} = 71;
$handles->{MPI_COUNT} = 72;

$handles->{MPI_MESSAGE_NO_PROC} = 1;

$handles->{MPI_INFO_ENV} = 1;

#----------------------------------------------------------------------------

our $io_handles;

$io_handles->{MPI_FILE_NULL} = 0;

1;
