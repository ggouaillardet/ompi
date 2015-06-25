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
# Generated interfaces
#

package FortranMPI::Interfaces;

use strict;

use FortranMPI::Utils;
use FortranMPI::Types;

#============================================================================
# MPI interfaces

our $interfaces;
my $api;

#----------------------------------------------------------------------------
# MPI_Send
$api = newAPI("MPI_Send");
# No need to specify the "use" statement types -- they can be inferred
# from the dummy argument types, below.
APIArg($api, "buf",      IntentIN,  TypeChoice);
APIArg($api, "count",    IntentIN,  TypeInteger);
APIArg($api, "datatype", IntentIN,  TypeDatatype);
APIArg($api, "dest",     IntentIN,  TypeInteger);
APIArg($api, "tags",     IntentIN,  TypeInteger);
APIArg($api, "comm",     IntentIN,  TypeComm);
APIArg($api, "ierror",   IntentOUT, TypeInteger);

#----------------------------------------------------------------------------
# MPI_Isend
$api = newAPI("MPI_Isend");
APIArg($api, "buf",      IntentIN,  TypeChoice);
APIArgAsync($api, "buf");
APIArg($api, "count",    IntentIN,  TypeInteger);
APIArg($api, "datatype", IntentIN,  TypeDatatype);
APIArg($api, "dest",     IntentIN,  TypeInteger);
APIArg($api, "tags",     IntentIN,  TypeInteger);
APIArg($api, "comm",     IntentIN,  TypeComm);
APIArg($api, "request",  IntentOUT, TypeRequest);
APIArg($api, "ierror",   IntentOUT, TypeInteger);

#----------------------------------------------------------------------------
# MPI_Wtick
$api = newAPI("MPI_Wtick");
# MPI_Wtick is actually a Fortran function, not a subroutine
APIReturnDouble($api);

#----------------------------------------------------------------------------
# MPI_Comm_spawn_multiple
$api = newAPI("MPI_Comm_spawn_multiple");
APIArg     ($api, "count",             IntentIN,  TypeInteger);
APIArgArray($api, "array_of_maxprocs", IntentIN,  TypeInteger,   "count");
APIArgArray($api, "array_of_commands", IntentIN,  TypeCharacter, "*");
APIArgModify($api, "array_of_commands", "LEN=*");
APIArgArray($api, "array_of_argv",     IntentIN,  TypeCharacter, "count,*");
APIArgModify($api, "array_of_argv", "LEN=*");
APIArgArray($api, "array_of_info",     IntentIN,  TypeInfo,      "count");
APIArg     ($api, "root",              IntentIN,  TypeInteger);
APIArg     ($api, "comm",              IntentIN,  TypeComm);
APIArg     ($api, "intercomm",         IntentOUT, TypeComm);
APIArgArray($api, "array_of_errcodes", IntentOUT, TypeInteger,   "*");
APIArg     ($api, "ierror",            IntentOUT, TypeInteger);

#----------------------------------------------------------------------------
# MPI_Address
$api = newAPI("MPI_Get_address");
APIArg($api, "location", 0,      TypeChoice);
APIArg($api, "address",  IntentOUT, TypeAint);
APIArg($api, "ierror",   IntentOUT, TypeInteger);

# All done
1;
