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
# Generate Fortran header file strings
#

package FortranMPI::Emit::Declarations;

use strict;

use Data::Dumper;

use FortranMPI::Types;
use FortranMPI::Interfaces;

#============================================================================

sub EmitParameter {
    my ($value_map) = @_;

    my $output;
    foreach my $key (sort(keys(%{$value_map}))) {
        $output .= "        integer $key\n";
    }
    $output .= "\n";
    foreach my $key (sort(keys(%{$value_map}))) {
        $output .= "        parameter ($key=$value_map->{$key})\n";
    }

    return $output;
}

#============================================================================

sub EmitDefine {
    my ($define_prefix, $value_map) = @_;

    my $output;
    foreach my $key (sort(keys(%{$value_map}))) {
        $output .= "#define $define_prefix$key $value_map->{$key}\n";
    }
    $output .= "\n";

    return $output;
}

1;
