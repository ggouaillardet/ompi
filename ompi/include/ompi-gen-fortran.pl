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
# OMPI's Fortran implementation is broken up into several parts:
#
# TOP LEVEL FILES:
# 1. mpif.h - just includes other files of constants, etc. (generated
#    by configure, not this script)
# 2. mpi module - includes files of constants and interfaces
# 3. mpi_f08 module - includes files of constants and interfaces
#
# INCLUDED FILES:
# 4. mpif-constants.h
# 5. mpif-io-constants.h
# 6. mpif-handles.h
# 7. mpif-io-handles.h
# 8. mpi-module-interfaces.F90
# 9. mpi-f08-module-interfaces.F90
#
# We break the IO constants and handles out into separate files
# because Open MPI can be built with and without the MPI IO
# interfaces.
#

use strict;
use lib 'ompi/include';

use Data::Dumper;
use Getopt::Long;
use Cwd;

use OMPI::Constants;
use OMPI::Handles;
use OMPI::Utils;
use OMPI::Headers;
use OMPI::Interfaces;
use OMPI::Bodies;

#----------------------------------------------------------------------------

my $mpif_arg = 1;
my $mpi_module_arg = 0;
my $mpi_f08_module_arg = 1;
my $async_arg = 0;
my $optional_arg = 1;
my $choice_pragma_arg = '    !GCC$ ATTRIBUTES NO_ARG_CHECK';
my $choice_type_arg = 'OMPI_FORTRAN_IGNORE_TKR_TYPE';
my $choice_rank_arg;
my $ompi_arg;
my $help_arg;

&Getopt::Long::Configure("bundling");
my $ok = Getopt::Long::GetOptions("mpif!" => \$mpif_arg,
                                  "mpi-module!" => \$mpi_module_arg,
                                  "mpi-f08-module!" => \$mpi_f08_module_arg,
                                  "asynchronous!" => \$async_arg,
                                  "optional!" => \$optional_arg,
                                  "choice-pragma=s" => \$choice_pragma_arg,
                                  "choice-type=s" => \$choice_type_arg,
                                  "choice-rank=s" => \$choice_rank_arg,
                                  "ompi=s" => \$ompi_arg,
                                  "help|h" => \$help_arg,
    );

if (defined($ompi_arg) && ! -d $ompi_arg) {
    print "Directory $ompi_arg does not exist\n";
    $ok = 0;
}

if ($help_arg || !defined($ok) || !$ok) {
    print "$0 [options]

Valid options:
  --[no-]mpif 
  --[no-]mpi-module 
  --[no-]mpi-f08-module
  --[no-]asynchronous
  --choice-pragma PRAGMA
  --choice-type TYPE
  --choice-rank RANK
  --ompi OMPI_DIR
  --help\n";

    exit($ok ? 0 : 1);
}

if ($mpi_module_arg || $mpi_f08_module_arg) {
    if (!defined($choice_type_arg)) {
        print "Cannot generate mpi or mpi_f08 modules without 
--choice-type\n";
        exit(1);
    }
}

#----------------------------------------------------------------------------

chdir($ompi_arg)
    if (defined($ompi_arg));

# Find the OMPI topdir.  It is likely the pwd.
my $topdir;
if (-r "ompi/include/mpi.h.in") {
    $topdir = ".";
} elsif (-r "include/mpi.h.in") {
    $topdir = "..";
} elsif (-r "mpi.h.in") {
    $topdir = "../..";
} else {
    print "Please run this script from the Open MPI topdir or topdir/include/mpi\n";
    print "Aborting.\n";
# JMS
#    exit(1);
}
chdir($topdir);
print "working in " . cwd() . "\n";

#----------------------------------------------------------------------------

my $hostname = `hostname`;
chomp($hostname);
my $user = `whoami`;
chomp($user);
my $date = localtime;

my $gen_str = "Generated: $user\@$hostname on $date";

#============================================================================
# HEADER FILES
#============================================================================

# First, creates header files to be compiled with the various Fortran
# bindings.  In some cases, we need Fortran PARAMETER values; in other
# cases, we need #define preprocessor macros.
#
# This script generates both cases, and ensures that the values are
# the same between both (e.g., that MPI_COMM_WORLD is both a fortran
# INTEGER PARAMETER of value 0 and is #define'd to be 0).
#
# Additionally, since Open MPI provides the configure ability to
# compile out the entire MPI IO interface, all the IO
# handles/constants are generated in separate .h files in the
# non-preprocessor case, and included in relevant #if's in the
# preprocessor case.
#
# Files are generated in the following directories:
#
#   ompi/include
#   ompi/mpi/fortran/use-mpi-f08
#

#----------------------------------------------------------------------------
# Header files

# These handles+constants files are included by mpif.h and the mpi
# module.
if ($mpif_arg || $mpi_module_arg) {
    OMPI::Headers::EmitMPI($gen_str);
}

# This handles+constants file is included by the mpi_f08 module.
if ($mpi_f08_module_arg) {
    OMPI::Headers::EmitMPI_F08($gen_str);
}

#----------------------------------------------------------------------------
# Interfaces for the mpi and mpi_f08 modules

my $args;
$args->{gen_str} = $gen_str;
$args->{optional} = $optional_arg;
$args->{async} = $async_arg;
$args->{choice_pragma} = $choice_pragma_arg
    if (defined($choice_pragma_arg));
$args->{choice_type} = $choice_type_arg
    if (defined($choice_type_arg));
$args->{choice_rank} = $choice_rank_arg
    if (defined($choice_rank_arg));

# This interfaces file is included by the mpi module
$mpi_module_arg = 1;
if ($mpi_module_arg) {
    # Copy $args so that any changes are local
    my $args_copy;
    %{$args_copy} = %{$args};
    OMPI::Interfaces::EmitMPI($args_copy);
}

# This interfaces file is included by the mpi_f08 module
if ($mpi_f08_module_arg) {
    # Copy $args so that any changes are local
    my $args_copy;
    %{$args_copy} = %{$args};
    OMPI::Interfaces::EmitMPI_F08($args_copy);
    OMPI::Bodies::EmitMPI_F08($args_copy);
}

#============================================================================
# IMPLEMENTATION FILES
#============================================================================

# JMS Write me...
