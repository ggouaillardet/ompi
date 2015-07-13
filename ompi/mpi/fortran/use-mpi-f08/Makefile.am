# -*- makefile -*-
#
# Copyright (c) 2006-2015 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2012-2013 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2012-2013 Inria.  All rights reserved.
# Copyright (c) 2013      Los Alamos National Security, LLC. All rights
#                         reserved.
# Copyright (c) 2015      Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
#
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

include $(top_srcdir)/Makefile.ompi-rules

# This Makefile is only relevant if we're building the "use mpi_f08"
# MPI bindings.
if OMPI_BUILD_FORTRAN_USEMPIF08_BINDINGS

AM_FCFLAGS = -I$(top_builddir)/ompi/include \
             -I$(top_srcdir)/ompi/include \
             $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/$(OMPI_FORTRAN_USEMPI_DIR) \
             $(OMPI_FC_MODULE_FLAG). \
             -I$(top_srcdir) $(FCFLAGS_f90)

MOSTLYCLEANFILES = *.mod

CLEANFILES += *.i90

lib_LTLIBRARIES = libmpi_usempif08.la

module_sentinel_file = \
        libforce_usempif08_internal_modules_to_be_built.la

noinst_LTLIBRARIES = $(module_sentinel_file)

mpi-f08.lo: $(module_sentinel_file)
mpi-f08.lo: mpi-f08.F90
mpi-f08.lo: mpi-f-interfaces-bind.h pmpi-f-interfaces-bind.h
mpi-f08.lo: attr-fn-f08-callback-interfaces.h
mpi-f08.lo: conversion-fn-null-f08-interface.h
mpi-f08.lo: sizeof_f08.h

#
# *sizeof_f08.* are generated based on some results from
# configure tests.
#

sizeof_pl=$(top_srcdir)/ompi/mpi/fortran/base/gen-mpi-sizeof.pl

sizeof_f08.h: $(top_builddir)/config.status
sizeof_f08.h: $(sizeof_pl)
sizeof_f08.h:
	$(OMPI_V_GEN) $(sizeof_pl) \
	    --header=$@ --ierror=optional \
	    --maxrank=$(OMPI_FORTRAN_MAX_ARRAY_RANK) \
	    --generate=$(OMPI_FORTRAN_BUILD_SIZEOF) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

sizeof_f08.f90: $(top_builddir)/config.status
sizeof_f08.f90: $(sizeof_pl)
sizeof_f08.f90:
	$(OMPI_V_GEN) $(sizeof_pl) \
	    --impl=$@ --ierror=optional --mpi \
	    --maxrank=$(OMPI_FORTRAN_MAX_ARRAY_RANK) \
	    --generate=$(OMPI_FORTRAN_BUILD_SIZEOF) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

profile/psizeof_f08.f90: $(top_builddir)/config.status
profile/psizeof_f08.f90: $(sizeof_pl)
profile/psizeof_f08.f90:
	$(OMPI_V_GEN) $(sizeof_pl) \
	    --impl=$@ --ierror=optional --pmpi \
	    --maxrank=$(OMPI_FORTRAN_MAX_ARRAY_RANK) \
	    --generate=$(OMPI_FORTRAN_BUILD_SIZEOF) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

CLEANFILES += sizeof_f08.h sizeof_f08.f90 profile/psizeof_f08.f90

mpi_api_files = \
        aint_add_f08.F90 \
        aint_diff_f08.F90 \
        alltoallw_f08.F90 \
        buffer_detach.c \
        comm_create_errhandler_f08.F90 \
        comm_create_keyval_f08.F90 \
        f_sync_reg_f08.F90 \
        grequest_start_f08.F90 \
        ialltoallw_f08.F90 \
        improbe_f08.F90 \
        ineighbor_alltoallw_f08.F90 \
        info_get_f08.F90 \
        info_get_valuelen_f08.F90 \
        iprobe_f08.F90 \
        mprobe_f08.F90 \
        mrecv_f08.F90 \
        neighbor_alltoallw_f08.F90 \
        pcontrol_f08.F90 \
        request_get_status_f08.F90 \
        startall_f08.F90 \
        start_f08.F90 \
        status_set_cancelled_f08.F90 \
        testall_f08.F90 \
        testany_f08.F90 \
        test_cancelled_f08.F90 \
        test_f08.F90 \
        testsome_f08.F90 \
        type_create_keyval_f08.F90 \
        win_create_errhandler_f08.F90 \
        win_create_keyval_f08.F90 \
        mpi-f08-module-bodies.F90

if OMPI_PROVIDE_MPI_FILE_INTERFACE
mpi_api_files += \
        file_create_errhandler_f08.F90 \
        register_datarep_f08.F90
endif

# JMS Somehow this variable substitution isn't quite working, and I
# don't have time to figure it out.  So just wholesale copy the file
# list.  :-(
#pmpi_api_files = $(mpi_api_files:%=profile/p%)

pmpi_api_files = \
        profile/paint_add_f08.F90 \
        profile/paint_diff_f08.F90 \
        profile/palltoallw_f08.F90 \
        profile/pcomm_create_errhandler_f08.F90 \
        profile/pcomm_create_keyval_f08.F90 \
        profile/pf_sync_reg_f08.F90 \
        profile/pgrequest_start_f08.F90 \
        profile/pialltoallw_f08.F90 \
        profile/pimprobe_f08.F90 \
        profile/pineighbor_alltoallw_f08.F90 \
        profile/pinfo_get_f08.F90 \
        profile/pinfo_get_valuelen_f08.F90 \
        profile/piprobe_f08.F90 \
        profile/pmprobe_f08.F90 \
        profile/pmrecv_f08.F90 \
        profile/pneighbor_alltoallw_f08.F90 \
        profile/ppcontrol_f08.F90 \
        profile/prequest_get_status_f08.F90 \
        profile/pstartall_f08.F90 \
        profile/pstart_f08.F90 \
        profile/pstatus_set_cancelled_f08.F90 \
        profile/ptestall_f08.F90 \
        profile/ptestany_f08.F90 \
        profile/ptest_cancelled_f08.F90 \
        profile/ptest_f08.F90 \
        profile/ptestsome_f08.F90 \
        profile/ptype_create_keyval_f08.F90 \
        profile/pwin_create_errhandler_f08.F90 \
        profile/pwin_create_keyval_f08.F90 \
        profile/pmpi-f08-module-bodies.F90

if OMPI_PROVIDE_MPI_FILE_INTERFACE
pmpi_api_files += \
        profile/pfile_create_errhandler_f08.F90 \
        profile/pregister_datarep_f08.F90
endif

libmpi_usempif08_la_SOURCES = \
        $(mpi_api_files) \
        $(pmpi_api_files) \
        mpi-f-interfaces-bind.h \
        pmpi-f-interfaces-bind.h \
        attr-fn-f08-callback-interfaces.h \
        conversion-fn-null-f08-interface.h \
        mpi-f08.F90 \
        mpi-f-interfaces-bind.h pmpi-f-interfaces-bind.h \
        attr-fn-f08-callback-interfaces.h \
        conversion-fn-null-f08-interface.h \
        constants.h \
        mpi-f08-module-interfaces.h \
        pmpi-f08-module-interfaces.h \
        constants.c

# These are generated; do not ship them
nodist_libmpi_usempif08_la_SOURCES =

if BUILD_FORTRAN_SIZEOF
SIZEOF_H = sizeof_f08.h
nodist_libmpi_usempif08_la_SOURCES += \
        sizeof_f08.h \
        sizeof_f08.f90 \
        profile/psizeof_f08.f90
endif

#
# Include the mpi_f08-based MPI extensions in libmpi_usempif08, too.
#

libmpi_usempif08_la_LIBADD = \
        $(module_sentinel_file) \
        $(OMPI_MPIEXT_USEMPIF08_LIBS) \
        $(top_builddir)/ompi/mpi/fortran/mpif-h/libmpi_mpifh.la \
        $(top_builddir)/ompi/libmpi.la
libmpi_usempif08_la_DEPENDENCIES = $(module_sentinel_file)
libmpi_usempif08_la_LDFLAGS = -version-info $(libmpi_usempif08_so_version)

#
# Automake doesn't do Fortran dependency analysis, so must list them
# manually here.  Bummer!
#

mpi_api_lo_files = $(mpi_api_files:.F90=.lo)
pmpi_api_lo_files = $(pmpi_api_files:.F90=.lo)

$(mpi_api_lo_files): mpi-f08.lo
$(pmpi_api_lo_files): mpi-f08.lo

mpi-f08.lo: $(module_sentinel_file) $(SIZEOF_H)
mpi-f08.lo: mpi-f-interfaces-bind.h pmpi-f-interfaces-bind.h
mpi-f08.lo: attr-fn-f08-callback-interfaces.h
mpi-f08.lo: conversion-fn-null-f08-interface.h

###########################################################################

# f08 support modules

libforce_usempif08_internal_modules_to_be_built_la_SOURCES = \
        mpi-f08-types.F90 \
        mpi-f08-interfaces.F90 \
        mpi-f08-interfaces-callbacks.F90 \
        pmpi-f08-interfaces.F90

config_h = \
    $(top_builddir)/ompi/mpi/fortran/configure-fortran-output.h \
    $(top_srcdir)/ompi/mpi/fortran/configure-fortran-output-bottom.h

#
# Automake doesn't do Fortran dependency analysis, so must list them
# manually here.  Bummer!
#

mpi-f08-types.lo: $(config_h)
mpi-f08-types.lo: mpi-f08-types.F90
mpi-f08-interfaces.lo: $(config_h)
mpi-f08-interfaces.lo: mpi-f08-interfaces.F90
mpi-f08-interfaces.lo: mpi-f08-interfaces-callbacks.lo
mpi-f08-interfaces.lo: mpi-f08-module-interfaces.h
mpi-f08-interfaces-callbacks.lo: $(config_h)
mpi-f08-interfaces-callbacks.lo: mpi-f08-interfaces-callbacks.F90
mpi-f08-interfaces-callbacks.lo: mpi-f08-types.lo
pmpi-f08-interfaces.lo: $(config_h)
pmpi-f08-interfaces.lo: pmpi-f08-interfaces.F90
pmpi-f08-interfaces.lo: mpi-f08-interfaces-callbacks.lo
pmpi-f08-interfaces.lo: pmpi-f08-module-interfaces.h

###########################################################################

# Install the generated .mod files.  Unfortunately, each F90 compiler
# may generate different filenames, so we have to use a glob.  :-(

install-exec-hook:
	@ for file in `ls *.mod`; do \
	  echo $(INSTALL) $$file $(DESTDIR)$(libdir); \
	  $(INSTALL) $$file $(DESTDIR)$(libdir); \
	done

uninstall-local:
	@ for file in `ls *.mod`; do \
	  echo rm -f $(DESTDIR)$(libdir)/$$file; \
	  rm -f $(DESTDIR)$(libdir)/$$file; \
	done
else

# Need to have empty targets because AM can't handle having an
# AM_CONDITIONAL was targets in the "if" statement but not in the
# "else".  :-(

install-exec-hook:
uninstall-local:

endif
