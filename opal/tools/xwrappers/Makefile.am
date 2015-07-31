#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2006 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2009 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2008      Sun Microsystems, Inc.  All rights reserved.
# Copyright (c) 2014-2016 Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

DEFS="-DEXEEXT=\"$(EXEEXT)\""

include $(top_srcdir)/Makefile.ompi-rules

if !OPAL_WANT_SCRIPT_WRAPPER_COMPILERS
if OPAL_INSTALL_BINARIES

bin_PROGRAMS = xopal_wrapper

dist_opaldata_DATA = help-xopal-wrapper.txt

# Only install the following for developer-level installs
if WANT_INSTALL_HEADERS

nodist_opaldata_DATA = \
	xopalcc-wrapper-data.txt \
	xopalc++-wrapper-data.txt

install-exec-hook:
	(cd $(DESTDIR)$(bindir); rm -f xopalcc$(EXEEXT); $(LN_S) xopal_wrapper$(EXEECT) xopalcc$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xopalc++$(EXEEXT); $(LN_S) xopal_wrapper$(EXEECT) xopalc++$(EXEEXT))

uninstall-local:
	rm -f $(DESTDIR)$(bindir)/xopalcc$(EXEEXT) \
	$(DESTDIR)$(bindir)/xopalc++$(EXEEXT)

endif # WANT_INSTALL_HEADERS

endif # OPAL_INSTALL_BINARIES
endif # OPAL_WANT_SCRIPT_WRAPPER_COMPILERS

xopal_wrapper_SOURCES = xopal_wrapper.c
xopal_wrapper_LDADD = $(top_builddir)/opal/lib@OPAL_LIB_PREFIX@open-pal.la
