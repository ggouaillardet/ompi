#!/bin/sh
#
# Copyright (c) 2015      Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# Copyright (c) 2015 Cisco Systems, Inc.  All rights reserved.
# $COPYRIGHT$
#

if [ $# -ne 5 ]; then
    echo "usage: $0 <OMPI_FORTRAN_CAPS> <OMPI_FORTRAN_PLAIN> <OMPI_FORTRAN_SINGLE_UNDERSCORE> <OMPI_FORTRAN_DOUBLE_UNDERSCORE> <PROJECT>"
    exit 1
fi

OMPI_FORTRAN_CAPS=$1
OMPI_FORTRAN_PLAIN=$2
OMPI_FORTRAN_SINGLE_UNDERSCORE=$3
OMPI_FORTRAN_DOUBLE_UNDERSCORE=$4
project=$5

if test "$project" != "ompi" && test "$project" != "oshmem"; then
    echo "ERROR: Unknown project ($project)";
    exit 1
fi

file_mpi_constants=mpif-constants-decl.h
file_mpi_symbols=mpif-ompi-symbols.h
file_mpi_f08_types=mpif-f08-types.h
file_oshmem_symbols=mpif-oshmem-symbols.h

if [ "X$OMPI_FORTRAN_CAPS" = X0 ] && [ "X$OMPI_FORTRAN_PLAIN" = X0 ] && [ "X$OMPI_FORTRAN_SINGLE_UNDERSCORE" = X0 ] && [ "X$OMPI_FORTRAN_DOUBLE_UNDERSCORE" = X0 ]; then
    # no fortran ...
    if test "$project" = "ompi"; then
        touch $file_mpi_constants
        touch $file_mpi_symbols
        touch $file_mpi_f08_types
    elif test "$project" = "oshmem"; then
        touch $file_oshmem_symbols
    fi
    exit 0
fi

mangle() {
    if [ "X$OMPI_FORTRAN_CAPS" = X1 ]; then
        echo $1 | tr [a-z] [A-Z]
    elif [ "X$OMPI_FORTRAN_PLAIN" = X1 ]; then
        echo $1 | tr [A-Z] [a-z]
    elif [ "X$OMPI_FORTRAN_SINGLE_UNDERSCORE" = X1 ]; then
        echo ${1}_ | tr [A-Z] [a-z]
    elif [ "X$OMPI_FORTRAN_DOUBLE_UNDERSCORE" = X1 ]; then
        echo ${1}__ | tr [A-Z] [a-z]
    fi
}

make_constant() {
    echo "extern $1 $(mangle $2);" >> $3
    echo "#define $(echo $2 | sed -e s/^mpi_/OMPI_IS_/g | tr [a-z] [A-Z])(addr) \\" >> $3
    echo "        (addr == (void *) &$(mangle $2))" >> $3
    echo >> $3
}

gen_mpi_constants() {
    file=$file_mpi_constants
    cat > $file << EOF
/* WARNING: This is a generated file!  Edits will be lost! */
/*
 * Copyright (c) 2015      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * \$COPYRIGHT\$
 *
 * This file was generated by gen-mpi-mangling.sh
 */

/* Note that the rationale for the types of each of these variables is
   discussed in ompi/include/mpif-common.h.  Do not change the types
   without also changing ompi/runtime/ompi_mpi_init.c and
   ompi/include/mpif-common.h. */

EOF

    cat $tmp | while read type symbol; do
        make_constant $type $symbol $file
    done
}

make_ompi_symbols() {
    echo "$1 $(mangle $2);" >> $3
}

gen_mpi_symbols() {
    file=$file_mpi_symbols
    cat > $file << EOF
/* WARNING: This is a generated file!  Edits will be lost! */
/*
 * Copyright (c) 2015      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * \$COPYRIGHT\$
 *
 * This file was generated by gen-mpi-mangling.sh
 */

EOF

    cat $tmp | while read type symbol; do
        make_ompi_symbols $type $symbol $file
    done

    cat > $tmp << EOF
    int mpi_fortran_bottom
    int mpi_fortran_in_place
    char* mpi_fortran_argv_null
    char* mpi_fortran_argvs_null
    int* mpi_fortran_errcodes_ignore
    int* mpi_fortran_status_ignore
    int* mpi_fortran_statuses_ignore
EOF
}

make_oshmem_symbols() {
    echo "$1 $(mangle $2);" >> $3
}

gen_oshmem_symbols() {
    file=$file_oshmem_symbols
    cat > $file << EOF
/* WARNING: This is a generated file!  Edits will be lost! */
/*
 * Copyright (c) 2015      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * \$COPYRIGHT\$
 *
 * This file was generated by gen-mpi-mangling.sh
 */

EOF

    cat $tmp | while read type symbol; do
        make_oshmem_symbols $type $symbol $file
    done

    cat > $tmp << EOF
  type(MPI_STATUS) MPI_STATUS_IGNORE
  type(MPI_STATUS) MPI_STATUSES_IGNORE(1)
  integer MPI_BOTTOM
  integer MPI_IN_PLACE
  integer MPI_ARGV_NULL
  integer MPI_ARGVS_NULL
  integer MPI_ERRCODES_IGNORE
  integer MPI_UNWEIGHTED
  integer MPI_WEIGHTS_EMPTY
EOF
}

make_f08() {
    echo "$1, bind(C, name=\"$(mangle $(echo $2 | sed -e s/^MPI_/MPI_FORTRAN_/g))\") :: $2" >> $3
}

gen_mpi_f08_types() {
    file=$file_mpi_f08_types
    cat > $file << EOF
! WARNING: This is a generated file!  Edits will be lost! */
!
! Copyright (c) 2015      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! \$COPYRIGHT\$
!
! This file was generated by gen-mpi-mangling.sh
!

EOF

    cat $tmp | while read type symbol; do
        make_f08 integer $symbol $file
    done

}

tmp=$(mktemp /tmp/ompi_symbols_XXXXXX)
cat > $tmp << EOF
    int mpi_fortran_bottom
    int mpi_fortran_in_place
    int mpi_fortran_unweighted
    int mpi_fortran_weights_empty
    char* mpi_fortran_argv_null
    char* mpi_fortran_argvs_null
    int* mpi_fortran_errcodes_ignore
    int* mpi_fortran_status_ignore
    int* mpi_fortran_statuses_ignore
EOF

if test "$project" = "ompi"; then
    gen_mpi_constants
    gen_mpi_symbols
    gen_mpi_f08_types
elif test "$project" = "oshmem"; then
    gen_oshmem_symbols
fi

rm -f $tmp

exit 0
