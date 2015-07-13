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

use vars qw/@EXPORT/;
use base qw/Exporter/;

@EXPORT = qw/_emit_procedure/;



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

    return _emit_interfaces($args, "");
}

# Expecting same values in args as EmitMPI
sub EmitPMPI_F08 {
    my $args = shift;

    $args->{define} = "OMPI_PMPI_F08_MODULE_INTERFACES_H";
    $args->{filename} = "ompi/mpi/fortran/use-mpi-f08/pmpi-f08-module-interfaces.h";
    $args->{module_name} = "mpi";
    $args->{suffix} = "_f08";
    $args->{handle_type} = HandleDerived;

    return _emit_interfaces($args, "P");
}

#----------------------------------------------------------------------------

my $choice_pragma;
my $choice_type;
my $choice_rank;
my $async;
my $optional;

sub _emit_interfaces {
    my ($args, $prefix) = @_;

    my $filename = $args->{filename};
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

    my $output;
    foreach my $name (sort(keys(%{$FortranMPI::Interfaces::interfaces}))) {
        if (defined($prefix)) {
            $output .= _emit_one_interface($name, $prefix, $suffix, $types_module_name, $callbacks_module_name);
        } else {
            $output .= _emit_interface($name, $suffix, $types_module_name, $callbacks_module_name);
        }
    }

    return $output;
}

sub _emit_interface {
    my ($name, $suffix, $types_module_name, $callbacks_module_name) = @_;

    my $output;
    $output = _emit_one_interface($name, "", $suffix, $types_module_name, $callbacks_module_name) .
        _emit_one_interface($name, "P", $suffix, $types_module_name, $callbacks_module_name);

    return $output;
}

sub _emit_one_interface {
    my ($name, $prefix, $suffix, $types_module_name, $callbacks_module_name) = @_;

    my $output = "";
    if ($name =~ "^MPI_File_") {
        $output = "#if OMPI_PROVIDE_MPI_FILE_INTERFACE\n";
    }
    $output .= "interface $prefix$name\n" .
        _emit_procedure($name, $prefix, $suffix, $types_module_name, $callbacks_module_name, 0) .
        "end interface $prefix$name\n\n";
    if ($name =~ "^MPI_File_") {
        $output .= "#endif /* OMPI_PROVIDE_MPI_FILE_INTERFACE */\n";
    }

    return $output;
}

sub _emit_procedure {
    my ($name, $prefix, $suffix, $types_module_name, $callbacks_module_name, $body) = @_;

    # Print function/subroutine
    my $api = $FortranMPI::Interfaces::interfaces->{$name};
    if ( $body && !$api->{autobody} ) {
        return "";
    }
    my $proc_type = "subroutine";
    if (APIIsFunction($api)) {
        $proc_type = "function";
    }
    my $output = "$proc_type $prefix$name$suffix(&\n";

    # Print each of the args
    my $sep = "";
    foreach my $arg (@{$api->{dummy_args}}) {
        $output .= "$sep$arg->{name}&\n";
        $sep = ",";
    }
    $output .= ")\n";

    # If we have a types module, print the Use statements
    my $htypes; my $hmodifiers; my $hcallbacks;
    my $typefound = 0; my $modifierfound; my $callbackfound = 0;
    # See if there are any MPI handles or KIND constants in the dummy
    # arguments
    foreach my $arg (@{$api->{dummy_args}}) {
        my $t = $arg->{type};
        if (exists($arg->{type_modifier})) {
            if ($arg->{type_modifier} =~ "^LEN=MPI_") {
                $hmodifiers->{$t} = $arg->{type_modifier};
                $modifierfound = 1;
            }
        }
        if (ArgIsHandle($arg) ||
            ArgIsKind($arg)) {
                $htypes->{$t} = $FortranMPI::Utils::type_map->{$t};
                $typefound = 1;
        } elsif (ArgIsProcedure($arg)) {
                $hcallbacks->{$arg->{type_modifier}} = $arg->{type_modifier};
                $callbackfound = 1;
        }
    }

# JMS Need to handle MPI constants, too -- might need those in the "use" statement

    if ($typefound) {
        foreach my $k (sort(keys(%{$htypes}))) {
            $output .= "    use :: $types_module_name, only : $htypes->{$k}\n";
        }
    }
    if ($modifierfound) {
        foreach my $k (sort(keys(%{$hmodifiers}))) {
            $output .= "    use :: $types_module_name, only : " . substr($hmodifiers->{$k}, 4) . "\n";
        }
    }
    if ($callbackfound) {
        foreach my $k (sort(keys(%{$hcallbacks}))) {
            $output .= "    use :: $callbacks_module_name, only : $hcallbacks->{$k}\n";
        }
        $output .= "\n";
    }

    if ( $body ) {
        if ( $api->{pmpi} ) {
            $output .= "    use :: mpi, only : P" . $name . "\n";
        } else {
            $output .= "    use :: mpi_f08, only : ompi_" . lc(substr($name, 4)) . "_f\n";
        }
    }

    # Do we ever wany anything other than "implicit none"?
    $output .= "    implicit none\n";

    # Declare type of each dummy arg
    foreach my $arg (@{$api->{dummy_args}}) {
        $output .= _emit_arg($arg);
    }

    # If this is a function, set the return type
    if (ReturnDouble == $api->{return}) {
        $output .= "    double precision $prefix$name$suffix\n";
    } elsif (ReturnAint == $api->{return}) {
        $output .= "    integer(KIND=MPI_ADDRESS_KIND) $prefix$name$suffix\n";
    }

    # Done

    if ($body) {
        $output .= "    integer :: c_ierror\n";
        $output .= "\n";
        if ( $api->{pmpi} ) {
            $output .= "    call P" . $name . "(&\n";
        } else {
            $output .= "    call ompi_" . lc(substr($name, 4)) . "_f(&\n";
        }
        $sep = "        ";
        foreach my $arg (@{$api->{dummy_args}}) {
            if ($arg->{name} eq "ierror") {
                $output .= "$sep"."c_ierror&\n";
            } elsif (ArgUsesVal($arg)) {
                #if (ArgIsArray($arg)) {
                    ## GG FIXME
                    #$output .= "$sep$arg->{name}(1)%MPI_VAL&\n";
                #} else {
                    $output .= "$sep$arg->{name}%MPI_VAL&\n";
                #}
            } else {
                $output .= "$sep$arg->{name}&\n";
            }
            $sep = "        ,";
        }
        foreach my $arg (@{$api->{dummy_args}}) {
            if (ArgIsString($arg)) {
                $output .= "$sep" . "len(" . $arg->{name} . ")&\n";
                $sep = "        ,";
            }
        }
        $output .= "    );\n";
        $output .= "    if (present(ierror)) ierror = c_ierror\n";
    }

    $output .= "end $proc_type $prefix$name$suffix\n\n";
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
    } elsif (&ArgIsProcedure($arg)) {
        $output .= "    procedure";
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
