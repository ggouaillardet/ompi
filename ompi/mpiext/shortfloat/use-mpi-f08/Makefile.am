#
# Copyright (c) 2018      FUJITSU LIMITED.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

# This file builds the use_mpi_f08-based bindings for MPI extensions.  It
# is optional in MPI extensions.

# We must set these #defines and include paths so that the inner OMPI
# MPI prototype header files do the Right Thing.
AM_FCFLAGS = $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/mpi/fortran/use-mpi-f08/mod \
             -I$(top_srcdir) $(FCFLAGS_f90)

# Note that the mpi_f08-based bindings are optional -- they can only
# be built if OMPI is also building the Fortran-based bindings.  So we
# initially set some Makefile macros to empty, and then conditionally
# add to them later.
noinst_LTLIBRARIES =

# Use the Automake conditional to know if we're building the "use mpi_f08"
# bindings.
if OMPI_BUILD_FORTRAN_USEMPIF08_BINDINGS

# If we are, build the convenience libtool library that will be
# slurped up into libmpi_usempif08.la.
noinst_LTLIBRARIES += libmpiext_shortfloat_usempif08.la

# Note that no header files are installed; instead,
# mpiext_shortfloat_usempif08.h is automatically slurped up into the
# mpi_f08_ext module.  It must be listed so that it is included in
# dist tarballs.
noinst_HEADERS = mpiext_shortfloat_usempif08.h

# Sources for the convenience libtool library.
libmpiext_shortfloat_usempif08_la_SOURCES = $(ompi_HEADERS)
libmpiext_shortfloat_usempif08_la_LDFLAGS = -module -avoid-version

endif
