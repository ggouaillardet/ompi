/*
 * Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2005 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2011-2013 Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2015-2019 Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include "ompi_config.h"

#include "ompi/communicator/communicator.h"
#include "ompi/errhandler/errhandler.h"
#include "ompi/mpi/fortran/use-mpi-f08/ts/bindings.h"
#include "ompi/mpi/fortran/base/constants.h"

static const char FUNC_NAME[] = "MPI_Scatterv";

void ompi_scatterv_ts(CFI_cdesc_t *x1, MPI_Fint *sendcounts,
                      MPI_Fint *displs, MPI_Fint *sendtype,
                      CFI_cdesc_t *x2, MPI_Fint *recvcount,
                      MPI_Fint *recvtype, MPI_Fint *root,
                      MPI_Fint *comm, MPI_Fint *ierr)
{
    int c_ierr;
    MPI_Comm c_comm = PMPI_Comm_f2c(*comm);
    int c_root = OMPI_FINT_2_INT(*root);
    MPI_Datatype c_sendtype = NULL, c_recvtype = NULL, c_recvdatatype = NULL;
    void *sendbuf = x1->base_addr, *recvbuf = x2->base_addr;
    int c_recvcount = 0;
    OMPI_ARRAY_NAME_DECL(sendcounts);
    OMPI_ARRAY_NAME_DECL(displs);

    if (OMPI_COMM_IS_INTER(c_comm)) {
        if (MPI_ROOT == c_root) {
            OMPI_COND_STATEMENT(int size = ompi_comm_size(c_comm));
            c_sendtype = PMPI_Type_f2c(*sendtype);
            OMPI_ARRAY_FINT_2_INT(sendcounts, size);
            OMPI_ARRAY_FINT_2_INT(displs, size);
            OMPI_CFI_CHECK_CONTIGUOUS(x1, c_ierr);
            if (MPI_SUCCESS != c_ierr) {
                if (NULL != ierr) *ierr = OMPI_INT_2_FINT(c_ierr);
                OMPI_ERRHANDLER_INVOKE(c_comm, c_ierr, FUNC_NAME)
                return;
            }
        } else if (MPI_PROC_NULL != c_root) {
            c_recvtype = PMPI_Type_f2c(*recvtype);
            c_recvcount = OMPI_FINT_2_INT(*recvcount);
            OMPI_CFI_2_C(x2, c_recvcount, c_recvtype, c_recvdatatype, c_ierr);
            if (MPI_SUCCESS != c_ierr) {
                if (NULL != ierr) *ierr = OMPI_INT_2_FINT(c_ierr);
                OMPI_ERRHANDLER_INVOKE(c_comm, c_ierr, FUNC_NAME)
                return;
            }
        }
    } else {
        if (ompi_comm_rank(c_comm) == c_root) {
            OMPI_COND_STATEMENT(int size = ompi_comm_size(c_comm));
            c_sendtype = PMPI_Type_f2c(*sendtype);
            OMPI_CFI_CHECK_CONTIGUOUS(x1, c_ierr);
            if (MPI_SUCCESS != c_ierr) {
                if (NULL != ierr) *ierr = OMPI_INT_2_FINT(c_ierr);
                OMPI_ERRHANDLER_INVOKE(c_comm, c_ierr, FUNC_NAME)
                return;
            }
            OMPI_ARRAY_FINT_2_INT(sendcounts, size);
            OMPI_ARRAY_FINT_2_INT(displs, size);
        }
        if (OMPI_IS_FORTRAN_IN_PLACE(recvbuf)) {
            recvbuf = MPI_IN_PLACE;
        } else {
            c_recvtype = PMPI_Type_f2c(*recvtype);
            c_recvcount = OMPI_FINT_2_INT(*recvcount);
            OMPI_CFI_2_C(x2, c_recvcount, c_recvtype, c_recvdatatype, c_ierr);
            if (MPI_SUCCESS != c_ierr) {
                if (NULL != ierr) *ierr = OMPI_INT_2_FINT(c_ierr);
                OMPI_ERRHANDLER_INVOKE(c_comm, c_ierr, FUNC_NAME)
                return;
            }
        }
    }

    c_ierr = PMPI_Scatterv(sendbuf,
                           OMPI_ARRAY_NAME_CONVERT(sendcounts),
                           OMPI_ARRAY_NAME_CONVERT(displs),
                           c_sendtype,
                           recvbuf, c_recvcount, c_recvdatatype,
                           c_root, c_comm);

    if (c_recvdatatype != c_recvtype) {
        ompi_datatype_destroy(&c_recvdatatype);
    }
    if (NULL != ierr) *ierr = OMPI_INT_2_FINT(c_ierr);

    OMPI_ARRAY_FINT_2_INT_CLEANUP(sendcounts);
    OMPI_ARRAY_FINT_2_INT_CLEANUP(displs);
}
