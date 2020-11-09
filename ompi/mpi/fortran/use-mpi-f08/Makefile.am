# -*- makefile.am -*-
#
# Copyright (c) 2006-2019 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2012-2013 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2012-2013 Inria.  All rights reserved.
# Copyright (c) 2013-2018 Los Alamos National Security, LLC. All rights
#                         reserved.
# Copyright (c) 2015-2020 Research Organization for Information Science
#                         and Technology (RIST).  All rights reserved.
# Copyright (c) 2016      IBM Corporation.  All rights reserved.
# Copyright (c) 2017-2018 FUJITSU LIMITED.  All rights reserved.
# Copyright (c) 2019      Triad National Security, LLC. All rights
#                         reserved.
#
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

SUBDIRS = profile

include $(top_srcdir)/Makefile.ompi-rules

# Note that Automake's Fortran-buidling rules uses CPPFLAGS and
# AM_CPPFLAGS.  This can cause weirdness (e.g.,
# https://github.com/open-mpi/ompi/issues/7253).  Let's just zero
# those out and rely on AM_FCFLAGS.
CPPFLAGS =
AM_CPPFLAGS =

# This Makefile is only relevant if we're building the "use mpi_f08"
# MPI bindings.
if OMPI_BUILD_FORTRAN_USEMPIF08_BINDINGS

AM_FCFLAGS = -I$(top_srcdir)/ompi/mpi/fortran/use-mpi-f08/mod \
             -I$(top_builddir)/ompi/include \
             -I$(top_srcdir)/ompi/include \
             $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/mpi/fortran/use-mpi \
             $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/$(OMPI_FORTRAN_USEMPI_DIR) \
             $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/mpi/fortran/use-mpi-f08/mod \
             $(OMPI_FC_MODULE_FLAG)$(top_builddir)/ompi/mpi/fortran/use-mpi-f08/bindings \
             -I$(top_srcdir) -I$(top_builddir) $(FCFLAGS_f90) \
             -DOMPI_BUILD_MPI_PROFILING=0

MOSTLYCLEANFILES = *.mod

CLEANFILES += *.i90

lib_LTLIBRARIES = lib@OMPI_LIBMPI_NAME@_usempif08.la

module_sentinel_files = \
        mod/libforce_usempif08_internal_modules_to_be_built.la \
        bindings/libforce_usempif08_internal_bindings_to_be_built.la

mpi-f08.lo: $(module_sentinel_files)
mpi-f08.lo: mpi-f08.F90
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
	    --real2=$(OMPI_HAVE_FORTRAN_REAL2) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex4=$(OMPI_HAVE_FORTRAN_COMPLEX4) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

sizeof_f08.f90: $(top_builddir)/config.status
sizeof_f08.f90: $(sizeof_pl)
sizeof_f08.f90:
	$(OMPI_V_GEN) $(sizeof_pl) \
	    --impl=$@ --ierror=optional --mpi \
	    --maxrank=$(OMPI_FORTRAN_MAX_ARRAY_RANK) \
	    --generate=$(OMPI_FORTRAN_BUILD_SIZEOF) \
	    --real2=$(OMPI_HAVE_FORTRAN_REAL2) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex4=$(OMPI_HAVE_FORTRAN_COMPLEX4) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

profile/psizeof_f08.f90: $(top_builddir)/config.status
profile/psizeof_f08.f90: $(sizeof_pl)
profile/psizeof_f08.f90:
	$(OMPI_V_GEN) $(sizeof_pl) \
	    --impl=$@ --ierror=optional --pmpi \
	    --maxrank=$(OMPI_FORTRAN_MAX_ARRAY_RANK) \
	    --generate=$(OMPI_FORTRAN_BUILD_SIZEOF) \
	    --real2=$(OMPI_HAVE_FORTRAN_REAL2) \
	    --real16=$(OMPI_HAVE_FORTRAN_REAL16) \
	    --complex4=$(OMPI_HAVE_FORTRAN_COMPLEX4) \
	    --complex32=$(OMPI_HAVE_FORTRAN_COMPLEX32)

CLEANFILES += sizeof_f08.h sizeof_f08.f90 profile/psizeof_f08.f90

# get the list of automatically generated bindings from an automatically generated file
include mpi-f08-interfaces.mk

mpi_api_files = \
        add_error_string_f08.F90 \
        aint_add_f08.F90 \
        aint_diff_f08.F90 \
        alloc_mem_f08.F90 \
        alltoallw_f08.F90 \
        cart_create_f08.F90 \
        cart_get_f08.F90 \
        cart_map_f08.F90 \
        cart_sub_f08.F90 \
        close_port_f08.F90 \
        comm_accept_f08.F90 \
        comm_connect_f08.F90 \
        comm_create_errhandler_f08.F90 \
        comm_create_f08.F90 \
        comm_create_group_f08.F90 \
        comm_create_keyval_f08.F90 \
        comm_dup_with_info_f08.F90 \
        comm_get_attr_f08.F90 \
        comm_get_errhandler_f08.F90 \
        comm_get_info_f08.F90 \
        comm_get_name_f08.F90 \
        comm_set_errhandler_f08.F90 \
        comm_set_info_f08.F90 \
        comm_set_name_f08.F90 \
        comm_spawn_f08.F90 \
        comm_spawn_multiple_f08.F90 \
        comm_test_inter_f08.F90 \
        dist_graph_create_adjacent_f08.F90 \
        dist_graph_create_f08.F90 \
        dist_graph_neighbors_count_f08.F90 \
        dist_graph_neighbors_f08.F90 \
        error_string_f08.F90 \
        f_sync_reg_f08.F90 \
        file_create_errhandler_f08.F90 \
        file_delete_f08.F90 \
        file_get_atomicity_f08.F90 \
        file_get_view_f08.F90 \
        file_open_f08.F90 \
        file_set_atomicity_f08.F90 \
        file_set_view_f08.F90 \
        finalized_f08.F90 \
        free_mem_f08.F90 \
        get_elements_f08.F90 \
        get_elements_x_f08.F90 \
        get_library_version_f08.F90 \
        get_processor_name_f08.F90 \
        graph_create_f08.F90 \
        grequest_start_f08.F90 \
        ialltoallw_f08.F90 \
        improbe_f08.F90 \
        imrecv_f08.F90 \
        ineighbor_alltoallw_f08.F90 \
        info_delete_f08.F90 \
        info_get_f08.F90 \
        info_get_nthkey_f08.F90 \
        info_get_valuelen_f08.F90 \
        info_set_f08.F90 \
        initialized_f08.F90 \
        intercomm_merge_f08.F90 \
        iprobe_f08.F90 \
        is_thread_main_f08.F90 \
        lookup_name_f08.F90 \
        mprobe_f08.F90 \
        mrecv_f08.F90 \
        neighbor_alltoallw_f08.F90 \
        op_commutative_f08.F90 \
        op_create_f08.F90 \
        open_port_f08.F90 \
        pack_external_f08.F90 \
        pack_external_size_f08.F90 \
        pcontrol_f08.F90 \
        publish_name_f08.F90 \
        register_datarep_f08.F90 \
        request_get_status_f08.F90 \
        status_set_cancelled_f08.F90 \
        testall_f08.F90 \
        testany_f08.F90 \
        test_cancelled_f08.F90 \
        test_f08.F90 \
        testsome_f08.F90 \
        type_create_keyval_f08.F90 \
        type_get_attr_f08.F90 \
        type_get_name_f08.F90 \
        type_set_name_f08.F90 \
        unpack_external_f08.F90 \
        unpublish_name_f08.F90 \
        win_create_errhandler_f08.F90 \
        win_create_keyval_f08.F90 \
        win_get_attr_f08.F90 \
        win_get_name_f08.F90 \
        win_set_name_f08.F90 \
        win_test_f08.F90 \
        \
        $(mpi_py_apy_files)

# JMS Somehow this variable substitution isn't quite working, and I
# don't have time to figure it out.  So just wholesale copy the file
# list.  :-(
#pmpi_api_files = $(mpi_api_files:%=profile/p%)

lib@OMPI_LIBMPI_NAME@_usempif08_la_SOURCES = \
        $(mpi_api_files) \
        mpi-f08.F90

# These are generated; do not ship them
nodist_lib@OMPI_LIBMPI_NAME@_usempif08_la_SOURCES =

if BUILD_FORTRAN_SIZEOF
SIZEOF_H = sizeof_f08.h
nodist_lib@OMPI_LIBMPI_NAME@_usempif08_la_SOURCES += \
        sizeof_f08.h \
        sizeof_f08.f90 \
        profile/psizeof_f08.f90
endif

#
# Include the mpi_f08-based MPI extensions in libmpi_usempif08, too.
#
# Also include the one .c file that we need in this library -- because
# we zero out CPPFLAGS and AM_CPPFLAGS in this Makefile.am, we have to
# compile that .c file in a separate directory / Makefile.
#

lib@OMPI_LIBMPI_NAME@_usempif08_la_LIBADD = \
        profile/libmpi_usempif08_pmpi.la \
        $(OMPI_MPIEXT_USEMPIF08_LIBS) \
        $(top_builddir)/ompi/mpi/fortran/mpif-h/lib@OMPI_LIBMPI_NAME@_mpifh.la \
        $(top_builddir)/ompi/lib@OMPI_LIBMPI_NAME@.la \
        mod/libusempif08_internal_modules.la \
        base/libusempif08_ccode.la
lib@OMPI_LIBMPI_NAME@_usempif08_la_DEPENDENCIES = $(module_sentinel_files)
lib@OMPI_LIBMPI_NAME@_usempif08_la_LDFLAGS = -version-info $(libmpi_usempif08_so_version)

#
# Automake doesn't do Fortran dependency analysis, so must list them
# manually here.  Bummer!
#

mpi_api_lo_files = $(mpi_api_files:.F90=.lo)

$(mpi_api_lo_files): bindings/libforce_usempif08_internal_bindings_to_be_built.la

mpi-f08.lo: $(module_sentinel_files) $(SIZEOF_H)

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

endif
