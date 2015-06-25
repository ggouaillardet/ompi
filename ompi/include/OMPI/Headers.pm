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
# Generate Fortran interface strings
#

package OMPI::Headers;

use strict;

use Data::Dumper;

use FortranMPI::Constants;
use FortranMPI::Handles;
use FortranMPI::Emit::Declarations;

use OMPI::Constants;
use OMPI::Handles;
use OMPI::Utils;

#----------------------------------------------------------------------------

sub EmitMPI {
    my $gen_str = shift;

    # JMS Edit final script path
    my $header = '! -*- fortran -*-
! WARNING! THIS IS A GENERATED FILE!!
! ANY EDITS YOU PUT HERE WILL BE LOST!
! ' . $gen_str . '
! ==> Instead, edit top_srcdir/ompi/include/ompi-gen-fortran.pl.

! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2010 The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
!                         University of Stuttgart.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2013 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
! $COPYRIGHT$
!
! Additional copyrights may follow
!
! $HEADER$
!

';

    _write_fortran_header_file($header, $OMPI::Handles::handles, 
                               "ompi/include/mpif-handles.h");
    _write_fortran_header_file($header, $OMPI::Constants::constants, 
                               "ompi/include/mpif-constants.h");
    _write_fortran_header_file($header, $OMPI::Handles::io_handles, 
                               "ompi/include/mpif-io-handles.h");
    _write_fortran_header_file($header, $OMPI::Constants::io_constants, 
                               "ompi/include/mpif-io-constants.h");
}

sub _write_fortran_header_file {
    my ($output, $value_map, $filename) = @_;

    $output .= FortranMPI::Emit::Declarations::EmitParameter($value_map);

    safe_write_file($filename, $output);
}

#----------------------------------------------------------------------------

sub EmitMPI_F08 {
    my $gen_str = shift;

    # JMS Edit final script path
    my $output = '/* WARNING! THIS IS A GENERATED FILE!!
 * ANY EDITS YOU PUT HERE WILL BE LOST!
 * ' . $gen_str . '
 * Instead, edit top_srcdir/ompi/include/ompi-gen-fortran.pl.
 */

/*
 * Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2006 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2007 High Performance Computing Center Stuttgart,
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2007-2013 Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2008-2009 Sun Microsystems, Inc.  All rights reserved.
 * Copyright (c) 2009      Oak Ridge National Labs.  All rights reserved.
 * Copyright (c) 2009-2012 Los Alamos National Security, LLC.
 *                         All rights reserved.
 * Copyright (c) 2015      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#ifndef USE_MPI_F08_CONSTANTS_H
#define USE_MPI_F08_CONSTANTS_H

';

    $output .= 
        FortranMPI::Emit::Declarations::EmitDefine("OMPI_",
                                                   $OMPI::Constants::constants) .
        FortranMPI::Emit::Declarations::EmitDefine("OMPI_",
                                                   $OMPI::Handles::handles);

    $output .= "
#if OMPI_PROVIDE_MPI_FILE_INTERFACE\n";

    $output .= 
        FortranMPI::Emit::Declarations::EmitDefine("OMPI_",
                                                   $OMPI::Constants::io_constants) .
        FortranMPI::Emit::Declarations::EmitDefine("OMPI_", 
                                                   $OMPI::Handles::io_handles);

    $output .= "
#endif /* OMPI_PROVIDE_MPI_FILE_INTERFACE */

#endif /* USE_MPI_F08_CONSTANTS_H */ \n";

    # Done
    safe_write_file("ompi/mpi/fortran/use-mpi-f08/constants.h", $output);
}

#============================================================================

# Sanity check against FortranMPI handles to make sure that we have
# them all
sub _sanity_check_handles {
    # Simple test: go through all the FortranMPI handles and delete
    # them from a local copy of all the values that we have.  IF we
    # don't find a FortranMPI handle in the local copy, it's an error.
    my $hcopy;
    my $iohcopy;
    %{$hcopy} = %{$OMPI::Handles::handles};
    %{$iohcopy} = %{$OMPI::Handles::io_handles};

    my $error = 0;
    foreach my $key (keys(%{$FortranMPI::Handles::handles})) {
        foreach my $handle (@{$FortranMPI::Handles::handles->{$key}}) {
            if (exists($hcopy->{$handle})) {
                delete $hcopy->{$handle};
            } elsif (exists($iohcopy->{$handle})) {
                delete $iohcopy->{$handle};
            } else {
                print "WARNING: Found Fortran MPI handle $key / $handle that is not in script\n";
                $error = 1;
            }
        }
    }

    # If we have anything left in the local copy, then it's a value
    # that FortranMPI doesn't have (which is also an error).
    my @keys = keys(%{$hcopy});
    if ($#keys >= 0) {
        print "WARNING: have handles locally that are not in FortranMPI\n";
        print Dumper($hcopy);
        $error = 1;
    }
    my @keys = keys(%{$iohcopy});
    if ($#keys >= 0) {
        print "WARNING: have handles locally that are not in FortranMPI\n";
        print Dumper($iohcopy);
        $error = 1;
    }

    die "Cannot continue"
        if ($error > 0);
}

#----------------------------------------------------------------------------

# Sanity check against FortranMPI constants to make sure that we have
# them all
sub _sanity_check_constants {
    # Simple test: go through all the FortranMPI constants and delete them
    # from a local copy of all the values that we have.  IF we don't find
    # a FortranMPI constant in the local copy, it's an error.
    my $ccopy;
    my $ioccopy;
    %{$ccopy} = %{$OMPI::Constants::constants};
    %{$ioccopy} = %{$OMPI::Constants::io_constants};

    my $error = 0;
    foreach my $constant (@FortranMPI::Constants::constants) {
        if (exists($ccopy->{$constant})) {
            delete $ccopy->{$constant};
        } elsif (exists($ioccopy->{$constant})) {
            delete $ioccopy->{$constant};
        } else {
            print "WARNING: Found Fortran MPI constant $constant that is not in script\n";
            $error = 1;
        }
    }

    # If we have anything left in the local copy, then it's a value
    # that FortranMPI doesn't have (which is also an error).
    my @keys = keys(%{$ccopy});
    if ($#keys >= 0) {
        print "WARNING: have constants locally that are not in FortranMPI\n";
        print Dumper($ccopy);
        $error = 1;
    }
    my @keys = keys(%{$ioccopy});
    if ($#keys >= 0) {
        print "WARNING: have constants locally that are not in FortranMPI\n";
        print Dumper($ioccopy);
        $error = 1;
    }

    die "Cannot continue"
        if ($error > 0);
}

# Run the sanity checks when this file is loaded
_sanity_check_constants();
_sanity_check_handles();

# If we get here, then we're good in terms of a sanity check.
1; 
