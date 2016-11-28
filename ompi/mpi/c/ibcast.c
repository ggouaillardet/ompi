/*
 * Copyright (c) 2012      Oak Rigde National Laboratory. All rights reserved.
 * Copyright (c) 2015-2017 Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */
#include "ompi_config.h"
#include <stdio.h>

#include "ompi/mpi/c/bindings.h"
#include "ompi/runtime/params.h"
#include "ompi/communicator/communicator.h"
#include "ompi/errhandler/errhandler.h"
#include "ompi/datatype/ompi_datatype.h"
#include "ompi/memchecker.h"

#if OMPI_BUILD_MPI_PROFILING
#if OPAL_HAVE_WEAK_SYMBOLS
#pragma weak MPI_Ibcast = PMPI_Ibcast
#endif
#define MPI_Ibcast PMPI_Ibcast
#endif

static const char FUNC_NAME[] = "MPI_Ibcast";


int MPI_Ibcast(void *buffer, int count, MPI_Datatype datatype,
              int root, MPI_Comm comm,  MPI_Request *request)
{
    int err;

    MEMCHECKER(
        memchecker_datatype(datatype);
        memchecker_comm(comm);
        if (OMPI_COMM_IS_INTRA(comm)) {
            if (ompi_comm_rank(comm) == root) {
                /* check whether root's send buffer is defined. */
                memchecker_call(&opal_memchecker_base_isdefined, buffer, count, datatype);
            } else {
                /* check whether receive buffer is addressable. */
                memchecker_call(&opal_memchecker_base_isaddressable, buffer, count, datatype);
            }
        } else {
            if (MPI_ROOT == root) {
                /* check whether root's send buffer is defined. */
                memchecker_call(&opal_memchecker_base_isdefined, buffer, count, datatype);
            } else if (MPI_PROC_NULL != root) {
                /* check whether receive buffer is addressable. */
                memchecker_call(&opal_memchecker_base_isaddressable, buffer, count, datatype);
            }
        }
    );

    if (MPI_PARAM_CHECK) {
      err = MPI_SUCCESS;
      OMPI_ERR_INIT_FINALIZE(FUNC_NAME);
      if (ompi_comm_invalid(comm)) {
          return OMPI_ERRHANDLER_INVOKE(MPI_COMM_WORLD, MPI_ERR_COMM,
                                     FUNC_NAME);
      }

      /* Errors for all ranks */

      OMPI_CHECK_DATATYPE_FOR_SEND(err, datatype, count);
      OMPI_ERRHANDLER_CHECK(err, comm, err, FUNC_NAME);
      if (MPI_IN_PLACE == buffer) {
          return OMPI_ERRHANDLER_INVOKE(comm, MPI_ERR_ARG, FUNC_NAME);
      }

      /* Errors for intracommunicators */

      if (OMPI_COMM_IS_INTRA(comm)) {
        if ((root >= ompi_comm_size(comm)) || (root < 0)) {
          return OMPI_ERRHANDLER_INVOKE(comm, MPI_ERR_ROOT, FUNC_NAME);
        }
      }

      /* Errors for intercommunicators */

      else {
        if (! ((root >= 0 && root < ompi_comm_remote_size(comm)) ||
               MPI_ROOT == root || MPI_PROC_NULL == root)) {
            return OMPI_ERRHANDLER_INVOKE(comm, MPI_ERR_ROOT, FUNC_NAME);
        }
      }
    }

    OPAL_CR_ENTER_LIBRARY();

    /* Invoke the coll component to perform the back-end operation */

    err = comm->c_coll.coll_ibcast(buffer, count, datatype, root, comm,
                                  request,
                                  comm->c_coll.coll_ibcast_module);
    OMPI_ERRHANDLER_RETURN(err, comm, err, FUNC_NAME);
}
