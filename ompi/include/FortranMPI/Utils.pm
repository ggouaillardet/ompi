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
# Helper functions for generated interfaces
#

package FortranMPI::Utils;

use strict;

use FortranMPI::Types;

use vars qw/@EXPORT/;
use base qw/Exporter/;

@EXPORT = qw/newAPI APIReturnDouble APIReturnAint APIArgAsync APIArg APIArgArray APIArgModify APIContainsChoice APIAuto APIPMPI APIIsFunction ArgIsHandle ArgIsKind ArgIsProcedure ArgUsesVal ArgIsString ArgIsArray SetHandleType safe_write_file/;


my $handle_type;

our $type_map;

sub SetHandleType {
    my $type = shift;

    my $i;
    $handle_type = $type;
    if (FortranMPI::Types::HandleInteger == $type) {
        $i = FortranMPI::Types::TypeComm;     $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeDatatype; $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeRequest;  $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeInfo;     $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeFile;     $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeGroup;    $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeOp;       $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeMessage;  $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeStatus;   $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeWin;      $type_map->{$i} = "integer";
        $i = FortranMPI::Types::TypeC;        $type_map->{$i} = "integer";
    } elsif (FortranMPI::Types::HandleDerived == $type) {
        $i = FortranMPI::Types::TypeComm;     $type_map->{$i} = "MPI_Comm";
        $i = FortranMPI::Types::TypeDatatype; $type_map->{$i} = "MPI_Datatype";
        $i = FortranMPI::Types::TypeRequest;  $type_map->{$i} = "MPI_Request";
        $i = FortranMPI::Types::TypeInfo;     $type_map->{$i} = "MPI_Info";
        $i = FortranMPI::Types::TypeFile;     $type_map->{$i} = "MPI_File";
        $i = FortranMPI::Types::TypeGroup;    $type_map->{$i} = "MPI_Group";
        $i = FortranMPI::Types::TypeOp;       $type_map->{$i} = "MPI_Op";
        $i = FortranMPI::Types::TypeMessage;  $type_map->{$i} = "MPI_Message";
        $i = FortranMPI::Types::TypeStatus;   $type_map->{$i} = "MPI_Status";
        $i = FortranMPI::Types::TypeWin;      $type_map->{$i} = "MPI_Win";
        $i = FortranMPI::Types::TypeC;        $type_map->{$i} = "C_PTR";
        $i = FortranMPI::Types::TypeErrhandler;                 $type_map->{$i} = "MPI_Errhandler";
    } else {
        die "Unknown handle type: $type";
    }
}

sub newAPI {
    my $name = shift;

    $FortranMPI::Interfaces::interfaces->{$name} = {
        # Default to returning void (i.e., subroutine)
        name => $name,
        return => FortranMPI::Types::ReturnVoid,
        autobody => 0,
        dummy_args => qw//,
    };

    # Return a pointer to this interface
    return \$FortranMPI::Interfaces::interfaces->{$name};
}

sub APIReturnDouble {
    my $api = shift;

    ${$api}->{return} = FortranMPI::Types::ReturnDouble;
}

sub APIReturnAint {
    my $api = shift;

    ${$api}->{return} = FortranMPI::Types::ReturnAint;
}

sub APIArgAsync {
    my $api = shift;

    ${$api}->{async} = 1;
}

sub APIArg {
    my $api = shift;
    my $arg_name = shift;
    my $intent = shift;
    my $type = shift;

    my $arg = {
        name => $arg_name,
        ordinality => FortranMPI::Types::ArgScalar,
        intent => $intent,
        type => $type,
        async => 0,
        optional => 0,
    };

    # Automatically make "ierror" be optional
    $arg->{optional} = 1
        if ($arg_name eq "ierror");

    push(@{${$api}->{dummy_args}}, $arg);
}

sub APIArgArray {
    my $api = shift;
    my $arg_name = shift;
    my $intent = shift;
    my $type = shift;
    my $rank = shift;

    my $arg = {
        name => $arg_name,
        ordinality => FortranMPI::Types::ArgArray,
        intent => $intent,
        type => $type,
        rank => $rank,
        async => 0,
        optional => 0,
    };
    push(@{${$api}->{dummy_args}}, $arg);
}

sub APIArgModify {
    my $api = shift;
    my $arg_name = shift;
    my $type_modifier = shift;

    foreach my $arg (@{${$api}->{dummy_args}}) {
        if ($arg->{name} eq $arg_name) {
            $arg->{type_modifier} = $type_modifier;
            return;
        }
    }

    die "Could not find argument $arg_name on API ${$api}->{name}";
}

sub APIContainsChoice {
    my $api = shift;

    foreach my $arg (@{${$api}->{dummy_args}}) {
        return 1
            if ($arg->{type} == FortranMPI::Types::TypeChoice);
    }
    return 0;
}

sub APIAuto {
    my $api = shift;

    ${$api}->{autobody} = 1;
}

sub APIPMPI {
    my $api = shift;

    ${$api}->{pmpi} = 1;
}

sub APIIsFunction {
    my $api = shift;

    my $r = $api->{return};
    if ($r == FortranMPI::Types::ReturnDouble ||
        $r == FortranMPI::Types::ReturnAint) {
        return 1;
    }
    return 0;
}

sub ArgIsHandle {
    my $arg = shift;

    # If handles are integers, then just return 0
    if ($handle_type == FortranMPI::Types::HandleInteger) {
        return 0;
    }

    my $t = $arg->{type};
    # JMS Add other handle types
    if ($t == FortranMPI::Types::TypeComm ||
        $t == FortranMPI::Types::TypeDatatype ||
        $t == FortranMPI::Types::TypeRequest ||
        $t == FortranMPI::Types::TypeInfo ||
        $t == FortranMPI::Types::TypeFile ||
        $t == FortranMPI::Types::TypeGroup ||
        $t == FortranMPI::Types::TypeOp ||
        $t == FortranMPI::Types::TypeMessage ||
        $t == FortranMPI::Types::TypeStatus ||
        $t == FortranMPI::Types::TypeWin ||
        $t == FortranMPI::Types::TypeC ||
        $t == FortranMPI::Types::TypeErrhandler) {

        return 1;
    }
    return 0;
}

sub ArgIsKind {
    my $arg = shift;

    my $t = $arg->{type};
    # JMS Add other kind types
    if ($t == FortranMPI::Types::TypeAint ||
        $t == FortranMPI::Types::TypeCount ||
        $t == FortranMPI::Types::TypeOffset) {
        return 1;
    }
    return 0;
}

sub ArgIsProcedure {
    my $arg = shift;

    # If handles are integers, then just return 0
    if ($handle_type == FortranMPI::Types::HandleInteger) {
        return 0;
    }

    my $t = $arg->{type};
    # JMS Add other handle types
    if ($t == FortranMPI::Types::TypeProcedure) {
        return 1;
    }
    return 0;
}

sub ArgUsesVal {
    my $arg = shift;

    # If handles are integers, then just return 0
    if ($handle_type == FortranMPI::Types::HandleInteger) {
        return 0;
    }

    my $t = $arg->{type};
    # JMS Add other handle types
    if ($t == FortranMPI::Types::TypeComm ||
        $t == FortranMPI::Types::TypeDatatype ||
        $t == FortranMPI::Types::TypeRequest ||
        $t == FortranMPI::Types::TypeInfo ||
        $t == FortranMPI::Types::TypeFile ||
        $t == FortranMPI::Types::TypeGroup ||
        $t == FortranMPI::Types::TypeOp ||
        $t == FortranMPI::Types::TypeMessage ||
        $t == FortranMPI::Types::TypeWin ||
        $t == FortranMPI::Types::TypeErrhandler) {

        return 1;
    }
    return 0;
}

sub ArgIsString {
    my $arg = shift;

    # If handles are integers, then just return 0
    if ($handle_type == FortranMPI::Types::HandleInteger) {
        return 0;
    }

    my $t = $arg->{type};
    my $o = $arg->{ordinality};
    # JMS Add other handle types
    if ($t == FortranMPI::Types::TypeCharacter &&
        exists($arg->{type_modifier}) &&
        $arg->{type_modifier} =~ 'LEN=') {
            return 1;
    }
    return 0;
}

sub ArgIsArray {
    my $arg = shift;

    my $o = $arg->{ordinality};
    # JMS Add other handle types
    if ($o == FortranMPI::Types::ArgArray) {
        return 1;
    }
    return 0;
}

# JMS Add rest of the types
my $i;
$i = TypeCharacter;
$type_map->{$i} = "character";
$i = TypeCharacterString;
$type_map->{$i} = "character(len=*)";
$i = TypeInteger;
$type_map->{$i} = "integer";
$i = TypeDouble;
$type_map->{$i} = "double precision";
$i = TypeAint;
$type_map->{$i} = "MPI_ADDRESS_KIND";
$i = TypeCount;
$type_map->{$i} = "MPI_COUNT_KIND";
$i = TypeOffset;
$type_map->{$i} = "MPI_OFFSET_KIND";
$i = TypeLogical;
$type_map->{$i} = "LOGICAL";

# Default to derived types
SetHandleType(FortranMPI::Types::HandleDerived);

# All done
1;
