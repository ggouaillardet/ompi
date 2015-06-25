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

package FortranMPI::Emit::Interfaces;

use strict;

use Data::Dumper;

use FortranMPI::Types;
use FortranMPI::Interfaces;
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
sub EmitMPI {
    my $args = shift;

    $args->{define} = "OMPI_MPI_MODULE_INTERFACES_H";
    $args->{filename} = "ompi/mpi/fortran/use-mpi/mpi-module-interfaces.h";
    $args->{module_name} = "mpi";
    $args->{suffix} = "";
    $args->{handle_type} = HandleInteger;

    return _emit_interfaces($args);
}
    
#============================================================================
# These interfaces files are included by the mpi and mpi_f08 modules.

# Expecting same values in args as EmitMPI
sub EmitMPI_F08 {
    my $args = shift;

    $args->{define} = "OMPI_MPI_F08_MODULE_INTERFACES_H";
    $args->{filename} = "ompi/mpi/fortran/use-mpi-f08/mpi-f08-module-interfaces.h";
    $args->{module_name} = "mpi";
    $args->{suffix} = "_f08";
    $args->{handle_type} = HandleDerived;

    return _emit_interfaces($args);
}

#----------------------------------------------------------------------------

my $choice_pragma;
my $choice_type;
my $choice_rank;
my $async;
my $optional;

sub _emit_interfaces {
    my $args = shift;

    my $filename = $args->{filename};
    my $module_name = $args->{module_name};
    my $suffix = $args->{suffix};
    my $types_module_name = $args->{types_module_name};

    $choice_pragma = $args->{choice_pragma};
    $choice_type = $args->{choice_type};
    $choice_rank = $args->{choice_rank};
    $async = $args->{async};
    $optional = $args->{optional};

    SetHandleType($args->{handle_type});

    my $output;
    foreach my $name (sort(keys(%{$FortranMPI::Interfaces::interfaces}))) {
        $output .= _emit_interface($name, $suffix, $types_module_name);
    }

    return $output;
}

sub _emit_interface {
    my ($name, $suffix, $types_module_name) = @_;

    my $output;
    $output = _emit_one_interface($name, $suffix, $types_module_name, 0) .
        _emit_one_interface($name, $suffix, $types_module_name, 1);

    return $output;
}

sub _emit_one_interface {
    my ($name, $suffix, $types_module_name, $which) = @_;

    # Select MPI or PMPI
    my $key = $name;
    $name = "P$name"
        if (1 == $which);

    my $output;
    $output = "interface $name\n" .
        _emit_procedure($key, $suffix, $types_module_name) .
        "end interface $name\n\n";

    return $output;
}

sub _emit_procedure {
    my ($name, $suffix, $types_module_name) = @_;

    # Print function/subroutine
    my $api = $FortranMPI::Interfaces::interfaces->{$name};
    my $proc_type = "subroutine";
    if (ReturnDouble == $api->{return}) {
        $proc_type = "function";
    }
    my $output = "$proc_type $name$suffix(";

    # Print each of the args
    my $sep = "";
    foreach my $arg (@{$api->{dummy_args}}) {
        $output .= "$sep$arg->{name}";
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

    # Done
    $output .= "end $proc_type $name$suffix\n";

    return $output;
}

sub _emit_arg {
    my ($arg) = @_;

    my $output;

    # Print the type
    if ($arg->{type} == TypeChoice) {
        $output .= "$choice_pragma :: $arg->{name}\n"
            if (defined($choice_pragma));
        $output .= "    $choice_type, dimension($choice_rank)";
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
