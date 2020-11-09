
# -*- makefile.am	 -*-
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2013 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2009-2014 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2011      Sandia National Laboratories. All rights reserved.
# Copyright (c) 2012      Oak Ridge National Laboratory. All rights reserved.
# Copyright (c) 2012-2013 Inria.  All rights reserved.
# Copyright (c) 2013      Los Alamos National Security, LLC. All rights
#                         reserved.
# Copyright (c) 2015-2020 Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

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
             $(OMPI_FC_MODULE_FLAG)../mod \
             $(OMPI_FC_MODULE_FLAG)../bindings \
             -I$(top_srcdir) -I$(top_builddir) $(FCFLAGS_f90) \
             -DOMPI_BUILD_MPI_PROFILING=1

CLEANFILES += *.i90

noinst_LTLIBRARIES = libmpi_usempif08_pmpi.la

# get the list of automatically generated bindings from an automatically generated file
include pmpi-f08-interfaces.mk

pmpi_api_files = \
        padd_error_string_f08.F90 \
        paint_add_f08.F90 \
        paint_diff_f08.F90 \
        palloc_mem_f08.F90 \
        palltoallw_f08.F90 \
        pcart_create_f08.F90 \
        pcart_get_f08.F90 \
        pcart_map_f08.F90 \
        pcart_sub_f08.F90 \
        pclose_port_f08.F90 \
        pcomm_accept_f08.F90 \
        pcomm_connect_f08.F90 \
        pcomm_create_errhandler_f08.F90 \
        pcomm_create_f08.F90 \
        pcomm_create_group_f08.F90 \
        pcomm_create_keyval_f08.F90 \
        pcomm_dup_with_info_f08.F90 \
        pcomm_get_attr_f08.F90 \
        pcomm_get_errhandler_f08.F90 \
        pcomm_get_info_f08.F90 \
        pcomm_get_name_f08.F90 \
        pcomm_set_errhandler_f08.F90 \
        pcomm_set_info_f08.F90 \
        pcomm_set_name_f08.F90 \
        pcomm_spawn_f08.F90 \
        pcomm_spawn_multiple_f08.F90 \
        pcomm_test_inter_f08.F90 \
        pdist_graph_create_adjacent_f08.F90 \
        pdist_graph_create_f08.F90 \
        pdist_graph_neighbors_count_f08.F90 \
        pdist_graph_neighbors_f08.F90 \
        perror_string_f08.F90 \
        pf_sync_reg_f08.F90 \
        pfile_create_errhandler_f08.F90 \
        pfile_delete_f08.F90 \
        pfile_get_atomicity_f08.F90 \
        pfile_get_view_f08.F90 \
        pfile_open_f08.F90 \
        pfile_set_atomicity_f08.F90 \
        pfile_set_view_f08.F90 \
        pfinalized_f08.F90 \
        pfree_mem_f08.F90 \
        pget_elements_f08.F90 \
        pget_elements_x_f08.F90 \
        pget_library_version_f08.F90 \
        pget_processor_name_f08.F90 \
        pgraph_create_f08.F90 \
        pgrequest_start_f08.F90 \
        pialltoallw_f08.F90 \
        pimprobe_f08.F90 \
        pimrecv_f08.F90 \
        pineighbor_alltoallw_f08.F90 \
        pinfo_delete_f08.F90 \
        pinfo_get_f08.F90 \
        pinfo_get_nthkey_f08.F90 \
        pinfo_get_valuelen_f08.F90 \
        pinfo_set_f08.F90 \
        pinitialized_f08.F90 \
        pintercomm_merge_f08.F90 \
        piprobe_f08.F90 \
        pis_thread_main_f08.F90 \
        plookup_name_f08.F90 \
        pmprobe_f08.F90 \
        pmrecv_f08.F90 \
        pneighbor_alltoallw_f08.F90 \
        pop_commutative_f08.F90 \
        pop_create_f08.F90 \
        popen_port_f08.F90 \
        ppack_external_f08.F90 \
        ppack_external_size_f08.F90 \
        ppcontrol_f08.F90 \
        ppublish_name_f08.F90 \
        pregister_datarep_f08.F90 \
        prequest_get_status_f08.F90 \
        pstatus_set_cancelled_f08.F90 \
        ptestall_f08.F90 \
        ptestany_f08.F90 \
        ptest_cancelled_f08.F90 \
        ptest_f08.F90 \
        ptestsome_f08.F90 \
        ptype_create_keyval_f08.F90 \
        ptype_get_attr_f08.F90 \
        ptype_get_name_f08.F90 \
        ptype_set_name_f08.F90 \
        punpack_external_f08.F90 \
        punpublish_name_f08.F90 \
        pwin_create_errhandler_f08.F90 \
        pwin_create_keyval_f08.F90 \
        pwin_get_attr_f08.F90 \
        pwin_get_name_f08.F90 \
        pwin_set_name_f08.F90 \
        pwin_test_f08.F90 \
        pwin_wait_f08.F90 \
        \
        $(pmpi_py_api_files)

#
# Automake doesn't do Fortran dependency analysis, so must list them
# manually here.  Bummer!
#

pmpi_api_lo_files = $(pmpi_api_files:.F90=.lo)

$(pmpi_api_lo_files): ../bindings/libforce_usempif08_internal_bindings_to_be_built.la

nodist_libmpi_usempif08_pmpi_la_SOURCES = \
        $(pmpi_api_files)

#
# Sym link in the sources from the real MPI directory
#
$(nodist_libmpi_usempif08_pmpi_la_SOURCES):
	$(OMPI_V_LN_S) if test ! -r $@ ; then \
		pname=`echo $@ | cut -b '2-'` ; \
		$(LN_S) $(top_srcdir)/ompi/mpi/fortran/use-mpi-f08/$$pname $@ ; \
	fi

# These files were created by targets above

MAINTAINERCLEANFILES = $(nodist_libmpi_usempif08_pmpi_la_SOURCES)

endif

# Don't want these targets in here

tags-recursive:
tags:
TAGS:
GTAGS:
ID:
