#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2006-2014 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2012      Los Alamos National Security, LLC.  All rights reserved.
# Copyright (c) 2013      Intel, Inc. All rights reserved.
# Copyright (c) 2014-2016 Research Organization for Information Science
#                         and Technology (RIST). All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

include $(top_srcdir)/Makefile.ompi-rules

if OPAL_WANT_SCRIPT_WRAPPER_COMPILERS

bin_SCRIPTS = xompi_wrapper_script
CLEANFILES += $(bin_SCRIPTS)

install-exec-hook-always:
	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
	(cd $(DESTDIR)$(bindir); rm -f xmpicc; $(LN_S) xompi_wrapper_script mpicc)
	(cd $(DESTDIR)$(bindir); rm -f xmpic++; $(LN_S) xompi_wrapper_script mpic++)
	(cd $(DESTDIR)$(bindir); rm -f xmpicxx; $(LN_S) xompi_wrapper_script mpicxx)
	(cd $(DESTDIR)$(bindir); rm -f xmpifort; $(LN_S) xompi_wrapper_script mpifort)
	(cd $(DESTDIR)$(bindir); rm -f xmpif77; $(LN_S) xompi_wrapper_script mpif77)
	(cd $(DESTDIR)$(bindir); rm -f xmpif90; $(LN_S) xompi_wrapper_script mpif90)

uninstall-local-always:
	rm -f $(DESTDIR)$(bindir)/xmpicc \
	$(DESTDIR)$(bindir)/xmpic++ \
	$(DESTDIR)$(bindir)/xmpicxx \
	$(DESTDIR)$(bindir)/xmpifort \
	$(DESTDIR)$(bindir)/xmpif77 \
	$(DESTDIR)$(bindir)/xmpif90

if CASE_SENSITIVE_FS
install-exec-hook: install-exec-hook-always
	(cd $(DESTDIR)$(bindir); rm -f xmpiCC; $(LN_S) xompi_wrapper_script xmpiCC)
uninstall-local: uninstall-local-always
	rm -f $(DESTDIR)$(bindir)/xmpiCC
else # CASE_SENSITIVE_FS
install-exec-hook: install-exec-hook-always
uninstall-local: uninstall-local-always
endif # CASE_SENSITIVE_FS

else # OPAL_WANT_SCRIPT_WRAPPER_COMPILERS

if OPAL_INSTALL_BINARIES

install-exec-hook-always:
	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
	(cd $(DESTDIR)$(bindir); rm -f xmpicc$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpicc$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xmpic++$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpic++$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xmpicxx$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpicxx$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xmpifort$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpifort$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xmpif77$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpif77$(EXEEXT))
	(cd $(DESTDIR)$(bindir); rm -f xmpif90$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpif90$(EXEEXT))

install-data-hook-always:
	(cd $(DESTDIR)$(pkgdatadir); rm -f xmpicxx-wrapper-data.txt; $(LN_S) xmpic++-wrapper-data.txt xmpicxx-wrapper-data.txt)
	(cd $(DESTDIR)$(pkgdatadir); rm -f xmpif77-wrapper-data.txt; $(LN_S) xmpifort-wrapper-data.txt xmpif77-wrapper-data.txt)
	(cd $(DESTDIR)$(pkgdatadir); rm -f xmpif90-wrapper-data.txt; $(LN_S) xmpifort-wrapper-data.txt xmpif90-wrapper-data.txt)

uninstall-local-always:
	rm -f $(DESTDIR)$(bindir)/xmpicc$(EXEEXT) \
	$(DESTDIR)$(bindir)/xmpic++$(EXEEXT) \
	$(DESTDIR)$(bindir)/xmpicxx$(EXEEXT) \
	$(DESTDIR)$(bindir)/xmpif77$(EXEEXT) \
	$(DESTDIR)$(bindir)/xmpif90$(EXEEXT) \
	$(DESTDIR)$(bindir)/xmpifort$(EXEEXT) \
	$(DESTDIR)$(pkgdatadir)/xmpicxx-wrapper-data.txt \
	$(DESTDIR)$(pkgdatadir)/xmpif77-wrapper-data.txt \
	$(DESTDIR)$(pkgdatadir)/xmpif90-wrapper-data.txt

if CASE_SENSITIVE_FS
install-exec-hook: install-exec-hook-always
	(cd $(DESTDIR)$(bindir); rm -f xmpiCC$(EXEEXT); $(LN_S) xopal_wrapper$(EXEEXT) xmpiCC$(EXEEXT))

install-data-hook: install-data-hook-always
	(cd $(DESTDIR)$(pkgdatadir); rm -f xmpiCC-wrapper-data.txt; $(LN_S) xmpic++-wrapper-data.txt xmpiCC-wrapper-data.txt)

uninstall-local: uninstall-local-always
	rm -f $(DESTDIR)$(bindir)/xmpiCC$(EXEEXT) \
	$(DESTDIR)$(pkgdatadir)/xmpiCC-wrapper-data.txt

else # CASE_SENSITIVE_FS
install-exec-hook: install-exec-hook-always
install-data-hook: install-data-hook-always
uninstall-local: uninstall-local-always

endif # CASE_SENSITIVE_FS

endif # OPAL_INSTALL_BINARIES

endif # OPAL_WANT_SCRIPT_WRAPPER_COMPILERS

