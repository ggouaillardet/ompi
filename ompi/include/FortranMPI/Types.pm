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

package FortranMPI::Types;

use strict;

use constant ReturnVoid => 0;
use constant ReturnDouble => 1;
use constant ReturnAint => 2;

# JMS Add rest of the types
use constant TypeChoice => 0;
use constant TypeCharacter => 1;
use constant TypeCharacterString => 2;
use constant TypeInteger => 3;
use constant TypeDouble => 4;
use constant TypeComm => 5;
use constant TypeDatatype => 6;
use constant TypeRequest => 7;
use constant TypeInfo => 8;
use constant TypeAint => 9;
use constant TypeC => 10;
use constant TypeErrhandler => 11;
use constant TypeFile => 12;
use constant TypeGroup => 14;
use constant TypeLogical => 15;
use constant TypeMessage => 16;
use constant TypeOp => 17;
use constant TypeStatus => 32;
use constant TypeWin => 33;
use constant TypeCount => 34;
use constant TypeOffset => 35;
use constant TypeProcedure => 36;


use constant HandleInteger => 0;
use constant HandleDerived => 1;

use constant IntentNONE => 0;
use constant IntentIN => 1;
use constant IntentOUT => 2;
use constant IntentINOUT => 3;

use constant ArgScalar => 0;
use constant ArgArray => 1;

use vars qw/@EXPORT/;
use base qw/Exporter/;

@EXPORT = qw/ReturnVoid ReturnDouble ReturnAint TypeChoice TypeCharacter TypeCharacterString TypeInteger TypeDouble TypeComm TypeDatatype TypeRequest TypeInfo TypeAint TypeC TypeErrhandler TypeFile TypeGroup TypeLogical TypeMessage TypeOp TypeProcedure TypeStatus TypeWin TypeCount TypeOffset HandleInteger HandleDerived IntentNONE IntentIN IntentOUT IntentINOUT ArgScalar ArgArray/;

1;
