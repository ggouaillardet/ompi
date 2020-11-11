/*
 * Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2013 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2006-2015 Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2011-2013 Inria.  All rights reserved.
 * Copyright (c) 2011-2013 Universite Bordeaux 1
 * Copyright (c) 2013-2015 Los Alamos National Security, LLC. All rights
 *                         reserved.
 * Copyright (c) 2016-2020 Research Organization for Information Science
 *                         and Technology (RIST).  All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 *
 * This file prototypes all MPI fortran functions in all four fortran
 * symbol conventions as well as all the internal real OMPI wrapper
 * functions (different from any of the four fortran symbol
 * conventions for clarity, at the cost of more typing for me...).
 * This file is included in the top-level build ONLY. The prototyping
 * is done ONLY for MPI_* bindings
 *
 * Zeroth, the OMPI wrapper functions, with a ompi_ prefix and _f
 * suffix.
 *
 * This is needed ONLY if the lower-level prototypes_pmpi.h has not
 * already been included.
 *
 * Note about function pointers: all function pointers are prototyped
 * here as (void*) rather than including the .h file that defines the
 * proper type (e.g., "op/op.h" defines ompi_op_fortran_handler_fn_t,
 * which is the function pointer type for fortran op callback
 * functions).  This is because there is no type checking coming in
 * from fortran, so why bother?  Also, including "op/op.h" (and
 * friends) makes the all the f77 bindings files dependant on these
 * files -- any change to any one of them will cause the recompilation
 * of the entire set of f77 bindings (ugh!).
 */

#ifndef OMPI_F77_PROTOTYPES_MPI_H
#define OMPI_F77_PROTOTYPES_MPI_H

#include "ompi_config.h"
#include "ompi/errhandler/errhandler.h"
#include "ompi/attribute/attribute.h"
#include "ompi/op/op.h"
#include "ompi/request/grequest.h"
#include "ompi/mpi/fortran/base/datarep.h"

BEGIN_C_DECLS

/* These are the prototypes for the "real" back-end fortran functions. */
#define PN2(ret, mixed_name, lower_name, upper_name, args) \
    /* Prototype the actual OMPI function */               \
    OMPI_DECLSPEC ret o##lower_name##_f args;              \
    /* Prototype the 4 versions of the MPI mpif.h name */  \
    OMPI_DECLSPEC ret lower_name args;                     \
    OMPI_DECLSPEC ret lower_name##_ args;                  \
    OMPI_DECLSPEC ret lower_name##__ args;                 \
    OMPI_DECLSPEC ret upper_name args;                     \
    /* Prototype the use mpi/use mpi_f08 names  */         \
    OMPI_DECLSPEC ret mixed_name##_f08 args;               \
    OMPI_DECLSPEC ret mixed_name##_f args;                 \
    /* Prototype the actual POMPI function */              \
    OMPI_DECLSPEC ret po##lower_name##_f args;             \
    /* Prototype the 4 versions of the PMPI mpif.h name */ \
    OMPI_DECLSPEC ret p##lower_name args;                  \
    OMPI_DECLSPEC ret p##lower_name##_ args;               \
    OMPI_DECLSPEC ret p##lower_name##__ args;              \
    OMPI_DECLSPEC ret P##upper_name args;                  \
    /* Prototype the use mpi/use mpi_f08 PMPI names  */    \
    OMPI_DECLSPEC ret P##mixed_name##_f08 args;            \
    OMPI_DECLSPEC ret P##mixed_name##_f args

PN2(void, MPI_Add_error_string, mpi_add_error_string, MPI_ADD_ERROR_STRING, (MPI_Fint *errorcode, char *string, MPI_Fint *ierr, int l));
PN2(MPI_Aint, MPI_Aint_add, mpi_aint_add, MPI_AINT_ADD, (MPI_Aint *base, MPI_Aint *diff));
PN2(MPI_Aint, MPI_Aint_diff, mpi_aint_diff, MPI_AINT_DIFF, (MPI_Aint *addr1, MPI_Aint *addr2));
PN2(void, MPI_Alloc_mem, mpi_alloc_mem, MPI_ALLOC_MEM, (MPI_Aint *size, MPI_Fint *info, char *baseptr, MPI_Fint *ierr));
/* Extra Alloc_mem prototype for the _cptr variant added in MPI-3.0 errata */
PN2(void, MPI_Alloc_mem_cptr, mpi_alloc_mem_cptr, MPI_ALLOC_MEM_CPTR, (MPI_Aint *size, MPI_Fint *info, char *baseptr, MPI_Fint *ierr));
PN2(void, MPI_Alltoallw, mpi_alltoallw, MPI_ALLTOALLW, (char *sendbuf, MPI_Fint *sendcounts, MPI_Fint *sdispls, MPI_Fint *sendtypes, char *recvbuf, MPI_Fint *recvcounts, MPI_Fint *rdispls, MPI_Fint *recvtypes, MPI_Fint *comm, MPI_Fint *ierr));
PN2(void, MPI_Attr_delete, mpi_attr_delete, MPI_ATTR_DELETE, (MPI_Fint *comm, MPI_Fint *keyval, MPI_Fint *ierr));
PN2(void, MPI_Attr_get, mpi_attr_get, MPI_ATTR_GET, (MPI_Fint *comm, MPI_Fint *keyval, MPI_Fint *attribute_val, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Attr_put, mpi_attr_put, MPI_ATTR_PUT, (MPI_Fint *comm, MPI_Fint *keyval, MPI_Fint *attribute_val, MPI_Fint *ierr));
PN2(void, MPI_Buffer_detach, mpi_buffer_detach, MPI_BUFFER_DETACH, (char *buffer, MPI_Fint *size, MPI_Fint *ierr));
PN2(void, MPI_Cart_create, mpi_cart_create, MPI_CART_CREATE, (MPI_Fint *old_comm, MPI_Fint *ndims, MPI_Fint *dims, ompi_fortran_logical_t *periods, ompi_fortran_logical_t *reorder, MPI_Fint *comm_cart, MPI_Fint *ierr));
PN2(void, MPI_Cart_get, mpi_cart_get, MPI_CART_GET, (MPI_Fint *comm, MPI_Fint *maxdims, MPI_Fint *dims, ompi_fortran_logical_t *periods, MPI_Fint *coords, MPI_Fint *ierr));
PN2(void, MPI_Cart_map, mpi_cart_map, MPI_CART_MAP, (MPI_Fint *comm, MPI_Fint *ndims, MPI_Fint *dims, ompi_fortran_logical_t *periods, MPI_Fint *newrank, MPI_Fint *ierr));
PN2(void, MPI_Cart_sub, mpi_cart_sub, MPI_CART_SUB, (MPI_Fint *comm, ompi_fortran_logical_t *remain_dims, MPI_Fint *new_comm, MPI_Fint *ierr));
PN2(void, MPI_Comm_create_errhandler, mpi_comm_create_errhandler, MPI_COMM_CREATE_ERRHANDLER, (ompi_errhandler_fortran_handler_fn_t* function, MPI_Fint *errhandler, MPI_Fint *ierr));
PN2(void, MPI_Comm_create_keyval, mpi_comm_create_keyval, MPI_COMM_CREATE_KEYVAL, (ompi_aint_copy_attr_function* comm_copy_attr_fn, ompi_aint_delete_attr_function* comm_delete_attr_fn, MPI_Fint *comm_keyval, MPI_Aint *extra_state, MPI_Fint *ierr));
PN2(void, MPI_Comm_get_attr, mpi_comm_get_attr, MPI_COMM_GET_ATTR, (MPI_Fint *comm, MPI_Fint *comm_keyval, MPI_Aint *attribute_val, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Comm_spawn, mpi_comm_spawn, MPI_COMM_SPAWN, (char *command, char *argv, MPI_Fint *maxprocs, MPI_Fint *info, MPI_Fint *root, MPI_Fint *comm, MPI_Fint *intercomm, MPI_Fint *array_of_errcodes, MPI_Fint *ierr, int command_len, int argv_len));
PN2(void, MPI_Comm_spawn_multiple, mpi_comm_spawn_multiple, MPI_COMM_SPAWN_MULTIPLE, (MPI_Fint *count, char *array_of_commands, char *array_of_argv, MPI_Fint *array_of_maxprocs, MPI_Fint *array_of_info, MPI_Fint *root, MPI_Fint *comm, MPI_Fint *intercomm, MPI_Fint *array_of_errcodes, MPI_Fint *ierr, int cmd_len, int argv_len));
PN2(void, MPI_Comm_test_inter, mpi_comm_test_inter, MPI_COMM_TEST_INTER, (MPI_Fint *comm, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Dist_graph_create_adjacent, mpi_dist_graph_create_adjacent, MPI_DIST_GRAPH_CREATE_ADJACENT, (MPI_Fint *comm_old, MPI_Fint *indegree,  MPI_Fint *sources, MPI_Fint *sourceweights, MPI_Fint *outdegree,  MPI_Fint *destinations, MPI_Fint *destweights, MPI_Fint *info, ompi_fortran_logical_t *reorder, MPI_Fint *comm_graph, MPI_Fint *ierr));
PN2(void, MPI_Dist_graph_neighbors, mpi_dist_graph_neighbors, MPI_DIST_GRAPH_NEIGHBORS, (MPI_Fint* comm, MPI_Fint* maxindegree, MPI_Fint* sources, MPI_Fint* sourceweights, MPI_Fint* maxoutdegree, MPI_Fint* destinations, MPI_Fint* destweights, MPI_Fint *ierr));
PN2(void, MPI_Dist_graph_neighbors_count, mpi_dist_graph_neighbors_count, MPI_DIST_GRAPH_NEIGHBORS_COUNT, (MPI_Fint *comm, MPI_Fint *inneighbors, MPI_Fint *outneighbors, ompi_fortran_logical_t *weighted, MPI_Fint *ierr));
PN2(void, MPI_Errhandler_create, mpi_errhandler_create, MPI_ERRHANDLER_CREATE, (ompi_errhandler_fortran_handler_fn_t* function, MPI_Fint *errhandler, MPI_Fint *ierr));
PN2(void, MPI_File_create_errhandler, mpi_file_create_errhandler, MPI_FILE_CREATE_ERRHANDLER, (ompi_errhandler_fortran_handler_fn_t* function, MPI_Fint *errhandler, MPI_Fint *ierr));
PN2(void, MPI_File_get_atomicity, mpi_file_get_atomicity, MPI_FILE_GET_ATOMICITY, (MPI_Fint *fh, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Free_mem, mpi_free_mem, MPI_FREE_MEM, (char *base, MPI_Fint *ierr));
PN2(void, MPI_Get_elements, mpi_get_elements, MPI_GET_ELEMENTS, (MPI_Fint *status, MPI_Fint *datatype, MPI_Fint *count, MPI_Fint *ierr));
PN2(void, MPI_Get_elements_x, mpi_get_elements_x, MPI_GET_ELEMENTS_X, (MPI_Fint *status, MPI_Fint *datatype, MPI_Count *count, MPI_Fint *ierr));
PN2(void, MPI_Grequest_start, mpi_grequest_start, MPI_GREQUEST_START, (MPI_F_Grequest_query_function* query_fn, MPI_F_Grequest_free_function* free_fn, MPI_F_Grequest_cancel_function* cancel_fn, MPI_Aint *extra_state, MPI_Fint *request, MPI_Fint *ierr));
PN2(void, MPI_Group_range_excl, mpi_group_range_excl, MPI_GROUP_RANGE_EXCL, (MPI_Fint *group, MPI_Fint *n, MPI_Fint ranges[][3], MPI_Fint *newgroup, MPI_Fint *ierr));
PN2(void, MPI_Group_range_incl, mpi_group_range_incl, MPI_GROUP_RANGE_INCL, (MPI_Fint *group, MPI_Fint *n, MPI_Fint ranges[][3], MPI_Fint *newgroup, MPI_Fint *ierr));
PN2(void, MPI_Ialltoallw, mpi_ialltoallw, MPI_IALLTOALLW, (char *sendbuf, MPI_Fint *sendcounts, MPI_Fint *sdispls, MPI_Fint *sendtypes, char *recvbuf, MPI_Fint *recvcounts, MPI_Fint *rdispls, MPI_Fint *recvtypes, MPI_Fint *comm, MPI_Fint *request, MPI_Fint *ierr));
PN2(void, MPI_Ineighbor_alltoallw, mpi_ineighbor_alltoallw, MPI_INEIGHBOR_ALLTOALLW, (char *sendbuf, MPI_Fint *sendcounts, MPI_Aint *sdispls, MPI_Fint *sendtypes, char *recvbuf, MPI_Fint *recvcounts, MPI_Aint *rdispls, MPI_Fint *recvtypes, MPI_Fint *comm, MPI_Fint *request, MPI_Fint *ierr));
PN2(void, MPI_Initialized, mpi_initialized, MPI_INITIALIZED, (ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Keyval_create, mpi_keyval_create, MPI_KEYVAL_CREATE, (ompi_fint_copy_attr_function* copy_fn, ompi_fint_delete_attr_function* delete_fn, MPI_Fint *keyval, MPI_Fint *extra_state, MPI_Fint *ierr));
PN2(void, MPI_Keyval_free, mpi_keyval_free, MPI_KEYVAL_FREE, (MPI_Fint *keyval, MPI_Fint *ierr));
PN2(void, MPI_Neighbor_alltoallw, mpi_neighbor_alltoallw, MPI_NEIGHBOR_ALLTOALLW, (char *sendbuf, MPI_Fint *sendcounts, MPI_Aint *sdispls, MPI_Fint *sendtypes, char *recvbuf, MPI_Fint *recvcounts, MPI_Aint *rdispls, MPI_Fint *recvtypes, MPI_Fint *comm, MPI_Fint *ierr));
PN2(void, MPI_Op_create, mpi_op_create, MPI_OP_CREATE, (ompi_op_fortran_handler_fn_t* function, ompi_fortran_logical_t *commute, MPI_Fint *op, MPI_Fint *ierr));
PN2(void, MPI_Pcontrol, mpi_pcontrol, MPI_PCONTROL, (MPI_Fint *level));
PN2(void, MPI_Register_datarep, mpi_register_datarep, MPI_REGISTER_DATAREP, (char *datarep, ompi_mpi2_fortran_datarep_conversion_fn_t *read_conversion_fn, ompi_mpi2_fortran_datarep_conversion_fn_t *write_conversion_fn, ompi_mpi2_fortran_datarep_extent_fn_t *dtype_file_extent_fn, MPI_Aint *extra_state, MPI_Fint *ierr, int datarep_len));
PN2(void, MPI_Status_f082f, mpi_status_f082f, MPI_STATUS_F082F, (const MPI_F08_status *f08_status, MPI_Fint *f_status, MPI_Fint *ierr));
PN2(void, MPI_Status_f2f08, mpi_status_f2f08, MPI_STATUS_F2F08, (const MPI_Fint *f_status, MPI_F08_status *f08_status, MPI_Fint *ierr));
PN2(void, MPI_Status_set_cancelled, mpi_status_set_cancelled, MPI_STATUS_SET_CANCELLED, (MPI_Fint *status, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Status_set_elements_x, mpi_status_set_elements_x, MPI_STATUS_SET_ELEMENTS_X, (MPI_Fint *status, MPI_Fint *datatype, MPI_Count *count, MPI_Fint *ierr));
PN2(void, MPI_Test_cancelled, mpi_test_cancelled, MPI_TEST_CANCELLED, (MPI_Fint *status, ompi_fortran_logical_t *flag, MPI_Fint *ierr));
PN2(void, MPI_Type_create_keyval, mpi_type_create_keyval, MPI_TYPE_CREATE_KEYVAL, (ompi_aint_copy_attr_function* type_copy_attr_fn, ompi_aint_delete_attr_function* type_delete_attr_fn, MPI_Fint *type_keyval, MPI_Aint *extra_state, MPI_Fint *ierr));
PN2(void, MPI_Type_get_extent_x, mpi_type_get_extent_x, MPI_TYPE_GET_EXTENT_X, (MPI_Fint *type, MPI_Count *lb, MPI_Count *extent, MPI_Fint *ierr));
PN2(void, MPI_Type_get_true_extent_x, mpi_type_get_true_extent_x, MPI_TYPE_GET_TRUE_EXTENT_X, (MPI_Fint *datatype, MPI_Count *true_lb, MPI_Count *true_extent, MPI_Fint *ierr));
PN2(void, MPI_Type_size_x, mpi_type_size_x, MPI_TYPE_SIZE_X, (MPI_Fint *type, MPI_Count *size, MPI_Fint *ierr));
PN2(void, MPI_Win_allocate, mpi_win_allocate, MPI_WIN_ALLOCATE, (MPI_Aint *size, MPI_Fint *disp_unit, MPI_Fint *info, MPI_Fint *comm, char *baseptr, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_allocate_cptr, mpi_win_allocate_cptr, MPI_WIN_ALLOCATE_CPTR, (MPI_Aint *size, MPI_Fint *disp_unit, MPI_Fint *info, MPI_Fint *comm, char *baseptr, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_allocate_shared, mpi_win_allocate_shared, MPI_WIN_ALLOCATE_SHARED, (MPI_Aint *size, MPI_Fint *disp_unit, MPI_Fint *info, MPI_Fint *comm, char *baseptr, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_allocate_shared_cptr, mpi_win_allocate_shared_cptr, MPI_WIN_ALLOCATE_SHARED_CPTR, (MPI_Aint *size, MPI_Fint *disp_unit, MPI_Fint *info, MPI_Fint *comm, char *baseptr, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_call_errhandler, mpi_win_call_errhandler, MPI_WIN_CALL_ERRHANDLER, (MPI_Fint *win, MPI_Fint *errorcode, MPI_Fint *ierr));
PN2(void, MPI_Win_complete, mpi_win_complete, MPI_WIN_COMPLETE, (MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_create, mpi_win_create, MPI_WIN_CREATE, (char *base, MPI_Aint *size, MPI_Fint *disp_unit, MPI_Fint *info, MPI_Fint *comm, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_create_dynamic, mpi_win_create_dynamic, MPI_WIN_CREATE_DYNAMIC, (MPI_Fint *info, MPI_Fint *comm, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_create_errhandler, mpi_win_create_errhandler, MPI_WIN_CREATE_ERRHANDLER, (ompi_errhandler_fortran_handler_fn_t* function, MPI_Fint *errhandler, MPI_Fint *ierr));
PN2(void, MPI_Win_create_keyval, mpi_win_create_keyval, MPI_WIN_CREATE_KEYVAL, (ompi_aint_copy_attr_function* win_copy_attr_fn, ompi_aint_delete_attr_function* win_delete_attr_fn, MPI_Fint *win_keyval, MPI_Aint *extra_state, MPI_Fint *ierr));
PN2(void, MPI_Win_flush, mpi_win_flush, MPI_WIN_FLUSH, (MPI_Fint *rank, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_flush_all, mpi_win_flush_all, MPI_WIN_FLUSH_ALL, (MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_flush_local, mpi_win_flush_local, MPI_WIN_FLUSH_LOCAL, (MPI_Fint *rank, MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_flush_local_all, mpi_win_flush_local_all, MPI_WIN_FLUSH_LOCAL_ALL, (MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_free, mpi_win_free, MPI_WIN_FREE, (MPI_Fint *win, MPI_Fint *ierr));
PN2(void, MPI_Win_free_keyval, mpi_win_free_keyval, MPI_WIN_FREE_KEYVAL, (MPI_Fint *win_keyval, MPI_Fint *ierr));
PN2(void, MPI_Win_shared_query, mpi_win_shared_query, MPI_WIN_SHARED_QUERY, (MPI_Fint *win, MPI_Fint *rank, MPI_Aint *size, MPI_Fint *disp_unit, char *baseptr, MPI_Fint *ierr));
PN2(void, MPI_Win_shared_query_cptr, mpi_win_shared_query_cptr, MPI_WIN_SHARED_QUERY_CPTR, (MPI_Fint *win, MPI_Fint *rank, MPI_Aint *size, MPI_Fint *disp_unit, char *baseptr, MPI_Fint *ierr));
PN2(double, MPI_Wtick, mpi_wtick, MPI_WTICK, (void));
PN2(double, MPI_Wtime, mpi_wtime, MPI_WTIME, (void));

PN2(void, MPI_Type_null_delete_fn, mpi_type_null_delete_fn, MPI_TYPE_NULL_DELETE_FN, (MPI_Fint* type, MPI_Fint* type_keyval, MPI_Aint* attribute_val_out, MPI_Aint* extra_state, MPI_Fint* ierr));
PN2(void, MPI_Type_null_copy_fn, mpi_type_null_copy_fn, MPI_TYPE_NULL_COPY_FN, (MPI_Fint* type, MPI_Fint* type_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Type_dup_fn, mpi_type_dup_fn, MPI_TYPE_DUP_FN, (MPI_Fint* type, MPI_Fint* type_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Win_dup_fn, mpi_win_dup_fn, MPI_WIN_DUP_FN, (MPI_Fint* window, MPI_Fint* win_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Win_null_copy_fn, mpi_win_null_copy_fn, MPI_WIN_NULL_COPY_FN, (MPI_Fint* window, MPI_Fint* win_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Win_null_delete_fn, mpi_win_null_delete_fn, MPI_WIN_NULL_DELETE_FN, (MPI_Fint* window, MPI_Fint* win_keyval, MPI_Aint* attribute_val_out, MPI_Aint* extra_state, MPI_Fint* ierr));
PN2(void, MPI_Null_delete_fn, mpi_null_delete_fn, MPI_NULL_DELETE_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Fint* attribute_val_out, MPI_Fint* extra_state, MPI_Fint* ierr));
PN2(void, MPI_Null_copy_fn, mpi_null_copy_fn, MPI_NULL_COPY_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Fint* extra_state, MPI_Fint* attribute_val_in, MPI_Fint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Dup_fn, mpi_dup_fn, MPI_DUP_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Fint* extra_state, MPI_Fint* attribute_val_in, MPI_Fint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Comm_null_delete_fn, mpi_comm_null_delete_fn, MPI_COMM_NULL_DELETE_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Aint* attribute_val_out, MPI_Aint* extra_state, MPI_Fint* ierr));
PN2(void, MPI_Comm_null_copy_fn, mpi_comm_null_copy_fn, MPI_COMM_NULL_COPY_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));
PN2(void, MPI_Comm_dup_fn, mpi_comm_dup_fn, MPI_COMM_DUP_FN, (MPI_Fint* comm, MPI_Fint* comm_keyval, MPI_Aint* extra_state, MPI_Aint* attribute_val_in, MPI_Aint* attribute_val_out, ompi_fortran_logical_t * flag, MPI_Fint* ierr));

#include "prototypes_mpi-py.h"

END_C_DECLS

#endif
