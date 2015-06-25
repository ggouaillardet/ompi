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

package OMPI::Utils;

use strict;

use vars qw(@EXPORT);
use base qw(Exporter);
@EXPORT = qw(safe_write_file);


# Subroutine to write an output file only if a) the output file does
# not already exist, or b) it exists, but its contents are different
# than $str.

sub safe_write_file {
    my ($filename_out, $str) = @_;

    my $need_write = 0;
    my $need_create = 0;
    if (! -f $filename_out) {
        $need_write = 1;
        $need_create = 1;
    } else {
        open(FILE_IN, $filename_out) || die "Couldn't open $filename_out";
        my $tmp;
        $tmp .= $_
            while (<FILE_IN>);
        close(FILE_IN);

        # Remove the generated string because it contains a timestamp
        my $copy = $str;
        $copy =~ s/Generated: .*$//m;
        $tmp =~ s/Generated: .*$//m;

        if ($copy ne $tmp) {
            $need_write = 1;
            $need_create = 0;
        }
    }
    
    if ($need_write) {
        open(FILE_OUT, ">$filename_out") || die "Couldn't open $filename_out";
        print FILE_OUT $str;
        close(FILE_OUT);
        if ($need_create) {
            print "created $filename_out\n";
        } else {
            print "re-wrote $filename_out\n";
        }
    } else {
        print "$filename_out unchanged; not written\n";
    }
}

