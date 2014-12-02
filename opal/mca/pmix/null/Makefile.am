#
# Copyright (c) 2014      Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# $COPYRIGHT$
# 
# Additional copyrights may follow
# 
# $HEADER$
#

sources = \
        pmix_null.h \
        pmix_null_component.c \
        pmix_null.c

# Make the output library in this directory, and name it either
# mca_<type>_<name>.la (for DSO builds) or libmca_<type>_<name>.la
# (for static builds).

if MCA_BUILD_opal_pmix_null_DSO
component_noinst =
component_install = mca_pmix_null.la
else
component_noinst = libmca_pmix_null.la
component_install =
endif

mcacomponentdir = $(opallibdir)
mcacomponent_LTLIBRARIES = $(component_install)
mca_pmix_null_la_SOURCES = $(sources)
mca_pmix_null_la_LDFLAGS = -module -avoid-version

noinst_LTLIBRARIES = $(component_noinst)
libmca_pmix_null_la_SOURCES =$(sources)
libmca_pmix_null_la_LDFLAGS = -module -avoid-version
