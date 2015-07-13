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

package FortranMPI::Emit::Bodies;

use strict;

use Data::Dumper;

use FortranMPI::Types;
use FortranMPI::Interfaces;
use FortranMPI::Emit::Interfaces;
use FortranMPI::Utils;

#============================================================================
# These interfaces files are included by the mpi and mpi_f08 modules.

# Expecting in args:
# - types_module_name
# - optional: undef or 1
# - async: undef or 1
# - choice_pragma: undef or string for the choice argument pragma
# - choice_type: string for the choice argument type
# - choice_rank: string for the choice argument rank

sub EmitMPI_F08 {
    my $args = shift;

    $args->{define} = "OMPI_MPI_F08_MODULE_INTERFACES_H";
    $args->{filepath} = "ompi/mpi/fortran/use-mpi-f08";
    $args->{module_name} = "mpi";
    $args->{suffix} = "_f08";
    $args->{handle_type} = HandleDerived;

    return _emit_bodies($args, "");
}

sub EmitPMPI_F08 {
    my $args = shift;

    $args->{define} = "OMPI_MPI_F08_MODULE_INTERFACES_H";
    $args->{filepath} = "ompi/mpi/fortran/use-mpi-f08";
    $args->{module_name} = "mpi";
    $args->{suffix} = "_f08";
    $args->{handle_type} = HandleDerived;

    return _emit_bodies($args, "P");
}

#----------------------------------------------------------------------------

my $choice_pragma;
my $choice_type;
my $choice_rank;
my $async;
my $optional;
my $filepath;

sub _emit_bodies {
    my ($args, $prefix) = @_;

    $filepath = $args->{filepath};
    my $module_name = $args->{module_name};
    my $suffix = $args->{suffix};
    my $types_module_name = $args->{types_module_name};
    my $callbacks_module_name = $args->{callbacks_module_name};

    $choice_pragma = $args->{choice_pragma};
    $choice_type = $args->{choice_type};
    $choice_rank = $args->{choice_rank}
        if (defined($args->{choice_rank})) ;
    $async = $args->{async};
    $optional = $args->{optional};

    SetHandleType($args->{handle_type});

    my $output = "\n#include \"ompi/mpi/fortran/configure-fortran-output.h\"\n";

    foreach my $name (sort(keys(%{$FortranMPI::Interfaces::interfaces}))) {
        $output .= _emit_procedure($name, $prefix, $suffix, $types_module_name, $callbacks_module_name, 1);
    }

    return $output;
}

sub _emit_body {
    my ($name, $prefix, $suffix, $types_module_name) = @_;

    # Print function/subroutine
    my $api = $FortranMPI::Interfaces::interfaces->{$name};

    return unless $api->{autobody};

    my $proc_type = "subroutine";
    if (ReturnDouble == $api->{return}) {
        $proc_type = "function";
    }
    my $output = "\n$proc_type $prefix$name$suffix(&\n";

    # Print each of the args
    my $sep = "";
    foreach my $arg (@{$api->{dummy_args}}) {
        $output .= "$sep$arg->{name}&\n";
        $sep = ",";
    }
    $output .= ")\n";

    # If we have a types module, print the Use statements
    my $h;
    my $found = 0;
    # See if there are any MPI handles or KIND constants in the dummy
    # arguments
    foreach my $arg (@{$api->{dummy_args}}) {
        my $t = $arg->{type};
        if (ArgIsHandle($arg) ||
            ArgIsKind($arg)) {
            $h->{$t} = $FortranMPI::Utils::type_map->{$t};
            $found = 1;
        }
    }

# JMS Need to handle MPI constants, too -- might need those in the "use" statement

    if ($found) {
        $output .= "    use :: $types_module_name, only : ";
        my $sep = "";
        foreach my $k (sort(keys(%{$h}))) {
            $output .= "$sep$h->{$k}";
            $sep = ", ";
        }
        $output .= "\n";
    }
    $output .= "    use :: mpi_f08, only : ompi_" . lc(substr($name, 4)) . "_f\n";

    # Do we ever wany anything other than "implicit none"?
    $output .= "    implicit none\n";

    # Declare type of each dummy arg
    foreach my $arg (@{$api->{dummy_args}}) {
        $output .= _emit_arg($arg);
    }

    # If this is a function, set the return type
    if (ReturnDouble == $api->{return}) {
        $output .= "    double precision $name$suffix\n";
    }

    # Done parameters
    
    $output .= "    integer :: c_ierror\n";
    $output .= "\n";
    $output .= "    call ompi_" . lc(substr($name, 4)) . "_f(";
    $sep = "";
    foreach my $arg (@{$api->{dummy_args}}) {
        if ($arg->{name} eq "ierror") {
            $output .= "$sep"."c_ierror";
        } elsif (ArgIsHandle($arg)) {
            $output .= "$sep$arg->{name}%MPI_VAL";
        } else {
            $output .= "$sep$arg->{name}";
        }
        $sep = ",";
    }
    $output .= ");\n";
    $output .= "    if (present(ierror)) ierror = c_ierror\n";
    $output .= "\n";

    $output .= "end $proc_type $prefix$name$suffix\n";

    return $output;
}

sub _emit_arg {
    my ($arg) = @_;

    my $output;

    # Print the type
    if ($arg->{type} == TypeChoice) {
        $output .= "$choice_pragma :: $arg->{name}\n"
            if (defined($choice_pragma));
        if (defined($choice_rank)) {
            $output .= "    $choice_type, dimension($choice_rank)";
        } else {
            $output .= "    $choice_type";
        }
    } elsif (&ArgIsHandle($arg)) {
        $output .= "    type($FortranMPI::Utils::type_map->{$arg->{type}})";
    } elsif (&ArgIsKind($arg)) {
        $output .= "    integer(kind=$FortranMPI::Utils::type_map->{$arg->{type}})";
    } else {
        $output .= "    $FortranMPI::Utils::type_map->{$arg->{type}}";
    }

    # Need a type modifier?
    $output .= "($arg->{type_modifier})"
        if (exists($arg->{type_modifier}));

    # Need dimension?  We do *not* need dimension if the argument is a
    # choice buffer (because it [potentially] already has a dimension).
    if ($arg->{ordinality} == ArgArray) {
        die "Error: Array of Choice buffers? That shouldn't be..."
            if ($arg->{type} == TypeChoice);
        $output .= ", DIMENSION($arg->{rank})";
    }

    # Need async? 
    $output .= ", ASYNCHRONOUS"
        if ($arg->{async} && defined($async) && $async);

    # Need optional?
    $output .= ", OPTIONAL"
        if ($arg->{optional} && defined($optional) && $optional);

    # Intent
    if ($arg->{intent} > 0) {
        $output .= ", INTENT(";
        if ($arg->{intent} == IntentIN) {
            $output .= "IN";
        } elsif ($arg->{intent} == IntentOUT) {
            $output .= "OUT";
        } elsif ($arg->{intent} == IntentINOUT) {
            $output .= "INOUT";
        } else {
            die "Unknown intent: $arg->{intent}";
        }
        $output .= ")";
    }

    # Print the argument name
    $output .= " :: $arg->{name}\n";

    # Done
    return $output;
}

1;
