! -*- f90 -*-
!
! Copyright (c) 2009-2015 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009-2012 Los Alamos National Security, LLC.
!                         All rights reserved.
! Copyright (c) 2012      The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2012      Inria.  All rights reserved.
! Copyright (c) 2015-2020 Research Organization for Information Science
!                         and Technology (RIST).  All rights reserved.
! $COPYRIGHT$
!
! This file provides the interface specifications for the MPI Fortran
! API bindings.  It effectively maps between public names ("MPI_Init")
! and the back-end OMPI implementation subroutine name (e.g.,
! "ompi_init_f").
!

#include "ompi/mpi/fortran/configure-fortran-output.h"

!
! Most of the "wrapper" subroutines in the mpi_f08 module (i.e., all
! the ones prototyped in this file) are simple routines that simply
! invoke a back-end ompi_*_f() subroutine, which is BIND(C)-bound to a
! back-end C function.  Easy-peasy.
!
! However, a bunch of MPI Fortran subroutines use LOGICAL dummy
! parameters, and Fortran disallows passing LOGICAL parameters to
! BIND(C) routines (because the .TRUE. and .FALSE. values are not
! standardized (!)).  Hence, for these
! subroutines-with-LOGICAL-params, we have to be creative on how to
! invoke the back-end ompi_*_f() C function.  There are 2 cases:

! 1. If the Fortran interface has a LOGICAL parameter and no
! TYPE(MPI_Status) parameter, the individual wrapper implementation
! files (e.g., finalized_f08.F90) use the "mpi" module to get a
! interface for the subroutine and call the PMPI_* name of the
! function, which then invokes the corresponding function in the
! ompi/mpi/fortran/mpif-h directory.
!
! This is a bit of a hack: the "mpi" module will provide the right
! Fortran interface so that the compiler can verify that we're passing
! the right types (e.g., convert MPI handles from comm to
! comm%MPI_VAL).  But here's the hack part: when we pass *unbounded
! arrays* of handles (e.g., the sendtypes and recvtypes arrays
! MPI_Alltoallw), we declare that the corresponding ompi_*_f()
! subroutine takes a *scalar*, and then we pass sendtypes(0)%MPI_VAL.
!
! >>>THIS IS A LIE!<<< We're passing a scalar to something that
! expects an array.
!
! However, remember that Fortran passes by reference.  So the compiler
! will pass a pointer to sendtypes(0)%MPI_VAL (i.e., the first integer
! in the array).  And since the mpi_f08 handles were cleverly designed
! to be exactly equivalent to a single INTEGER, an array of mpi_f08
! handles is exactly equivalent to an array of INTEGERS.  So passing
! an address to the first MPI_VAL is exactly the same as passing an
! array of INTEGERS.
!
! Specifically: the back-end C function (in *.c files in
! ompi/mpi/fortran/mpif-h) gets an (MPI_Fint*), and it's all good.
!
! The key here is that there is a disconnect between Fortran and C:
! we're telling the Fortran compiler what the C interface is, and
! we're lying.  But just a little bit.  No one gets hurt.
!
! Yes, this is a total hack.  But Craig Rasumussen tells me that this
! is actually quite a common hack in the Fortran developer world, so
! we shouldn't feel bad about using it.  Shrug.
!
! 2. If the Fortran interface has both LOGICAL and TYPE(MPI_Status)
! parameters, then we have to do even more tricks than we described
! above. :-(
!
! The problem occurs because in the mpi_f08 module, an MPI_Status is
! TYPE(MPI_Status), but in the mpi module, it's INTEGER,
! DIMENSION(MPI_STATUS_SIZE).  Just like MPI handles, TYPE(MPI_Status)
! was cleverly designed so that it can be identical (in terms of a
! memory map) to INTEGER, DIMENSION(MPI_STATUS_SIZE).  So we just have
! to fool the compiler into accepting it (it's the same C<-->Fortran
! disconnect from #1).
!
! So in this case, we actually don't "use mpi" at all -- we just add
! an "interface" block for the PMPI_* subroutine that we want to call.
! And we lie in that interface block, saying that the status argument
! is TYPE(MPI_Status) (rather than an INTEGER,
! DIMENSION(MPI_STATUS_SIZE), which is what it *really* is) -- i.e.,
! the same type that we already have.
!
! For the C programmers reading this, this is very much analogous to
! something like this:
!
! $ cat header.h
! void foo(int *param);
! $ cat source.c
! #include "header.h"
! // Pretend that we *know* somehow that param will point to exactly
! // sizeof(int) bytes.
! void bar(char *param) {
!     foo(param); // <-- This generates a compiler warning
! }
!
! To fix the compiler warning, instead of including "header.h", we
! just put a byte-equivalent prototype in source.c:
!
! $ cat source.c
! void foo(char *param);
! void bar(char *param) {
!     foo(param);
! }
!
! And now it compiles without warning.
!
! The main difference here is that in Fortran, it is an error -- not a
! warning.
!
! Again, we're making the Fortran compiler happy, but we're lying
! because we know the back-end memory representation of the two types
! is the same.
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Wasn't that simple?  Here's the list of subroutines that are not
! prototyped in this file because they fall into case #1 or #2, above.
!
! Case #1:
! MPI_Cart_create
! MPI_Cart_get
! MPI_Cart_map
! MPI_Cart_sub
! MPI_Comm_get_attr
! MPI_Comm_test_inter
! MPI_Dist_graph_create
! MPI_Dist_graph_create_adjacent
! MPI_Dist_graph_neighbors_count
! MPI_File_get_atomicity
! MPI_File_set_atomicity
! MPI_Finalized
! MPI_Graph_create
! MPI_Info_get
! MPI_Info_get_valuelen
! MPI_Initialized
! MPI_Intercomm_merge
! MPI_Is_thread_main
! MPI_Op_commutative
! MPI_Op_create
! MPI_Type_get_attr
! MPI_Win_get_attr
! MPI_Win_test
!
! Case #2:
! MPI_Iprobe
! MPI_Improbe
! MPI_Request_get_status
! MPI_Status_set_cancelled
! MPI_Test
! MPI_Testall
! MPI_Testany
! MPI_Testsome
! MPI_Test_cancelled
!

interface

! Note that we have an F08-specific C implementation function for
! MPI_BUFFER_DETACH (i.e., it is different than the mpif.h / mpi
! module C implementation function).
subroutine ompi_buffer_detach_f(buffer_addr,size,ierror) &
   BIND(C, name="ompi_buffer_detach_f08")
   USE, INTRINSIC ::  ISO_C_BINDING, ONLY : C_PTR
   implicit none
   TYPE(C_PTR), INTENT(OUT) ::  buffer_addr
   INTEGER, INTENT(OUT) :: size
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_buffer_detach_f

subroutine ompi_get_elements_f(status,datatype,count,ierror) &
   BIND(C, name="ompi_get_elements_f")
   use :: mpi_f08_types, only : MPI_Status
   implicit none
   TYPE(MPI_Status), INTENT(IN) :: status
   INTEGER, INTENT(IN) :: datatype
   INTEGER, INTENT(OUT) :: count
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_get_elements_f

subroutine ompi_get_elements_x_f(status,datatype,count,ierror) &
   BIND(C, name="ompi_get_elements_x_f")
   use :: mpi_f08_types, only : MPI_Status, MPI_COUNT_KIND
   implicit none
   TYPE(MPI_Status), INTENT(IN) :: status
   INTEGER, INTENT(IN) :: datatype
   INTEGER(MPI_COUNT_KIND), INTENT(OUT) :: count
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_get_elements_x_f

subroutine ompi_pack_external_f(datarep,inbuf,incount,datatype, &
                                outbuf,outsize,position,ierror,datarep_len) &
   BIND(C, name="ompi_pack_external_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: datarep
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: inbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: outbuf
   INTEGER, INTENT(IN) :: incount
   INTEGER, INTENT(IN) :: datatype
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: outsize
   INTEGER(MPI_ADDRESS_KIND), INTENT(INOUT) :: position
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_pack_external_f

subroutine ompi_pack_external_size_f(datarep,incount,datatype,size,ierror,datarep_len) &
   BIND(C, name="ompi_pack_external_size_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   INTEGER, INTENT(IN) :: datatype
   INTEGER, INTENT(IN) :: incount
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: datarep
   INTEGER(MPI_ADDRESS_KIND), INTENT(OUT) :: size
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_pack_external_size_f

subroutine ompi_unpack_external_f(datarep,inbuf,insize,position, &
                                  outbuf,outcount,datatype,ierror,datarep_len) &
   BIND(C, name="ompi_unpack_external_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: datarep
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: inbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: outbuf
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: insize
   INTEGER(MPI_ADDRESS_KIND), INTENT(INOUT) :: position
   INTEGER, INTENT(IN) :: outcount
   INTEGER, INTENT(IN) :: datatype
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_unpack_external_f

subroutine ompi_alltoallw_f(sendbuf,sendcounts,sdispls,sendtypes, &
                            recvbuf,recvcounts,rdispls,recvtypes,comm,ierror) &
   BIND(C, name="ompi_alltoallw_f")
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: sendbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: recvbuf
   INTEGER, INTENT(IN) :: sendcounts(*), sdispls(*), recvcounts(*), rdispls(*)
   INTEGER, INTENT(IN) :: sendtypes
   INTEGER, INTENT(IN) :: recvtypes
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_alltoallw_f

subroutine ompi_ialltoallw_f(sendbuf,sendcounts,sdispls,sendtypes, &
                            recvbuf,recvcounts,rdispls,recvtypes,comm,request,ierror) &
   BIND(C, name="ompi_ialltoallw_f")
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN), ASYNCHRONOUS :: sendbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE, ASYNCHRONOUS :: recvbuf
   INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts(*), sdispls(*), recvcounts(*), rdispls(*)
   INTEGER, INTENT(IN), ASYNCHRONOUS :: sendtypes
   INTEGER, INTENT(IN), ASYNCHRONOUS :: recvtypes
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: request
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_ialltoallw_f

subroutine ompi_comm_create_f(comm,group,newcomm,ierror) &
   BIND(C, name="ompi_comm_create_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(IN) :: group
   INTEGER, INTENT(OUT) :: newcomm
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_create_f

subroutine ompi_comm_create_group_f(comm, group, tag, newcomm, ierror) &
   BIND(C, name="ompi_comm_create_group_f")
   implicit none
  integer, intent(in) :: comm
  integer, intent(in) :: group
  integer, intent(in) :: tag
  integer, intent(out) :: newcomm
  integer, intent(out) :: ierror
end subroutine ompi_comm_create_group_f

subroutine ompi_comm_create_keyval_f(comm_copy_attr_fn,comm_delete_attr_fn, &
                                     comm_keyval,extra_state,ierror) &
   BIND(C, name="ompi_comm_create_keyval_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: comm_copy_attr_fn
   type(c_funptr), value :: comm_delete_attr_fn
   INTEGER, INTENT(OUT) :: comm_keyval
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_create_keyval_f

subroutine ompi_comm_dup_with_info_f(comm, info, newcomm, ierror) &
   BIND(C, name="ompi_comm_dup_with_info_f")
   implicit none
  integer, intent(in) :: comm
  integer, intent(in) :: info
  integer, intent(out) :: newcomm
  integer, intent(out) :: ierror
end subroutine ompi_comm_dup_with_info_f

subroutine ompi_comm_get_info_f(comm,info_used,ierror) &
   BIND(C, name="ompi_comm_get_info_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: info_used
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_get_info_f

subroutine ompi_comm_get_name_f(comm,comm_name,resultlen,ierror,comm_name_len) &
   BIND(C, name="ompi_comm_get_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: comm
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: comm_name
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: comm_name_len
end subroutine ompi_comm_get_name_f

subroutine ompi_comm_set_info_f(comm,info,ierror) &
   BIND(C, name="ompi_comm_set_info_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_set_info_f

subroutine ompi_comm_set_name_f(comm,comm_name,ierror,comm_name_len) &
   BIND(C, name="ompi_comm_set_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: comm
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: comm_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: comm_name_len
end subroutine ompi_comm_set_name_f

subroutine ompi_type_create_keyval_f(type_copy_attr_fn,type_delete_attr_fn, &
                                     type_keyval,extra_state,ierror) &
   BIND(C, name="ompi_type_create_keyval_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: type_copy_attr_fn
   type(c_funptr), value :: type_delete_attr_fn
   INTEGER, INTENT(OUT) :: type_keyval
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_type_create_keyval_f

subroutine ompi_type_get_name_f(datatype,type_name,resultlen,ierror,type_name_len) &
   BIND(C, name="ompi_type_get_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: datatype
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: type_name
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: type_name_len
end subroutine ompi_type_get_name_f

subroutine ompi_type_set_name_f(datatype,type_name,ierror,type_name_len) &
   BIND(C, name="ompi_type_set_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: datatype
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: type_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: type_name_len
end subroutine ompi_type_set_name_f

subroutine ompi_win_create_keyval_f(win_copy_attr_fn,win_delete_attr_fn, &
                                    win_keyval,extra_state,ierror) &
   BIND(C, name="ompi_win_create_keyval_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: win_copy_attr_fn
   type(c_funptr), value :: win_delete_attr_fn
   INTEGER, INTENT(OUT) :: win_keyval
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_win_create_keyval_f

subroutine ompi_win_get_name_f(win,win_name,resultlen,ierror,win_name_len) &
   BIND(C, name="ompi_win_get_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: win
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: win_name
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: win_name_len
end subroutine ompi_win_get_name_f

subroutine ompi_win_set_name_f(win,win_name,ierror,win_name_len) &
   BIND(C, name="ompi_win_set_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: win
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: win_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: win_name_len
end subroutine ompi_win_set_name_f

subroutine ompi_dist_graph_neighbors_f(comm,maxindegree,sources,sourceweights, &
                                       maxoutdegree,destinations,destweights,ierror) &
   BIND(C, name="ompi_dist_graph_neighbors_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(IN) :: maxindegree, maxoutdegree
   INTEGER, INTENT(OUT) :: sources(maxindegree), destinations(maxoutdegree)
   INTEGER, INTENT(OUT) :: sourceweights(maxindegree), destweights(maxoutdegree)
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_dist_graph_neighbors_f

function  ompi_wtick_f() &
   BIND(C, name="ompi_wtick_f")
   implicit none
   DOUBLE PRECISION :: ompi_wtick_f
end function  ompi_wtick_f

function  ompi_wtime_f() &
   BIND(C, name="ompi_wtime_f")
   implicit none
   DOUBLE PRECISION :: ompi_wtime_f
end function  ompi_wtime_f

function ompi_aint_add_f(base,diff) &
   BIND(C, name="ompi_aint_add_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: base
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: diff
   INTEGER(MPI_ADDRESS_KIND) :: ompi_aint_add_f
end function ompi_aint_add_f

function ompi_aint_diff_f(addr1,addr2) &
   BIND(C, name="ompi_aint_diff_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: addr1
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: addr2
   INTEGER(MPI_ADDRESS_KIND) :: ompi_aint_diff_f
end function ompi_aint_diff_f

subroutine ompi_add_error_string_f(errorcode,string,ierror,str_len) &
   BIND(C, name="ompi_add_error_string_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: errorcode
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: string
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: str_len
end subroutine ompi_add_error_string_f

subroutine ompi_alloc_mem_f(size,info,baseptr,ierror) &
   BIND(C, name="ompi_alloc_mem_f")
   use, intrinsic :: ISO_C_BINDING, only : C_PTR
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   implicit none
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: size
   INTEGER, INTENT(IN) :: info
   TYPE(C_PTR), INTENT(OUT) :: baseptr
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_alloc_mem_f

subroutine ompi_comm_create_errhandler_f(comm_errhandler_fn,errhandler,ierror) &
   BIND(C, name="ompi_comm_create_errhandler_f")
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: comm_errhandler_fn
   INTEGER, INTENT(OUT) :: errhandler
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_create_errhandler_f

subroutine ompi_comm_get_errhandler_f(comm,errhandler,ierror) &
   BIND(C, name="ompi_comm_get_errhandler_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: errhandler
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_get_errhandler_f

subroutine ompi_comm_set_errhandler_f(comm,errhandler,ierror) &
   BIND(C, name="ompi_comm_set_errhandler_f")
   implicit none
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(IN) :: errhandler
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_comm_set_errhandler_f

subroutine ompi_error_string_f(errorcode,string,resultlen,ierror,str_len) &
   BIND(C, name="ompi_error_string_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: errorcode
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: string
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: str_len
end subroutine ompi_error_string_f

subroutine ompi_file_create_errhandler_f(file_errhandler_fn,errhandler,ierror) &
   BIND(C, name="ompi_file_create_errhandler_f")
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: file_errhandler_fn
   INTEGER, INTENT(OUT) :: errhandler
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_file_create_errhandler_f

subroutine ompi_free_mem_f(base,ierror) &
   BIND(C, name="ompi_free_mem_f")
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: base
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_free_mem_f

subroutine ompi_get_processor_name_f(name,resultlen,ierror,name_len) &
   BIND(C, name="ompi_get_processor_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: name
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: name_len
end subroutine ompi_get_processor_name_f

subroutine ompi_info_delete_f(info,key,ierror,key_len) &
   BIND(C, name="ompi_info_delete_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: info
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: key
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: key_len
end subroutine ompi_info_delete_f

subroutine ompi_info_set_f(info,key,value,ierror,key_len,value_len) &
   BIND(C, name="ompi_info_set_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: info
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: key, value
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: key_len, value_len
end subroutine ompi_info_set_f

subroutine ompi_close_port_f(port_name,ierror,port_name_len) &
   BIND(C, name="ompi_close_port_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: port_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: port_name_len
end subroutine ompi_close_port_f

subroutine ompi_win_create_errhandler_f(win_errhandler_fn,errhandler,ierror) &
   BIND(C, name="ompi_win_create_errhandler_f")
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: win_errhandler_fn
   INTEGER, INTENT(OUT) :: errhandler
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_win_create_errhandler_f

subroutine ompi_info_get_nthkey_f(info,n,key,ierror,key_len) &
   BIND(C, name="ompi_info_get_nthkey_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(IN) :: n
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: key
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: key_len
end subroutine ompi_info_get_nthkey_f

subroutine ompi_comm_accept_f(port_name,info,root,comm,newcomm,ierror,port_name_len) &
   BIND(C, name="ompi_comm_accept_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: port_name
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(IN) :: root
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: newcomm
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: port_name_len
end subroutine ompi_comm_accept_f

subroutine ompi_comm_connect_f(port_name,info,root,comm,newcomm,ierror,port_name_len) &
   BIND(C, name="ompi_comm_connect_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: port_name
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(IN) :: root
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: newcomm
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: port_name_len
end subroutine ompi_comm_connect_f

subroutine ompi_comm_spawn_f(command,argv,maxprocs,info,root,comm, &
                             intercomm, array_of_errcodes,ierror,cmd_len,argv_len) &
   BIND(C, name="ompi_comm_spawn_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: command, argv
   INTEGER, INTENT(IN) :: maxprocs, root
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: intercomm
   INTEGER, INTENT(OUT) :: array_of_errcodes(*)
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: cmd_len, argv_len
end subroutine ompi_comm_spawn_f


! TODO - FIXME to use arrays of strings and pass strlen
subroutine ompi_comm_spawn_multiple_f(count,array_of_commands, &
                                      array_of_argv, array_of_maxprocs,array_of_info,root, &
                                      comm,intercomm,array_of_errcodes,ierror, &
                                      cmd_len, argv_len) &
   BIND(C, name="ompi_comm_spawn_multiple_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: count, root
   INTEGER, INTENT(IN) :: array_of_maxprocs(count)
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: array_of_commands(*), array_of_argv(*)
   INTEGER, INTENT(IN) :: array_of_info(count)
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: intercomm
   INTEGER, INTENT(OUT) :: array_of_errcodes(*)
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: cmd_len, argv_len
end subroutine ompi_comm_spawn_multiple_f

subroutine ompi_lookup_name_f(service_name,info,port_name,ierror, &
                              service_name_len,port_name_len) &
   BIND(C, name="ompi_lookup_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: service_name
   INTEGER, INTENT(IN) :: info
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: port_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: service_name_len, port_name_len
end subroutine ompi_lookup_name_f

subroutine ompi_open_port_f(info,port_name,ierror,port_name_len) &
   BIND(C, name="ompi_open_port_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: info
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: port_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: port_name_len
end subroutine ompi_open_port_f

subroutine ompi_publish_name_f(service_name,info,port_name,ierror, &
                               service_name_len,port_name_len) &
   BIND(C, name="ompi_publish_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: info
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: service_name, port_name
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: service_name_len, port_name_len
end subroutine ompi_publish_name_f

subroutine ompi_unpublish_name_f(service_name,info,port_name, &
                                 ierror,service_name_len,port_name_len) &
   BIND(C, name="ompi_unpublish_name_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: service_name, port_name
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: service_name_len, port_name_len
end subroutine ompi_unpublish_name_f

subroutine ompi_grequest_start_f(query_fn,free_fn,cancel_fn, &
                                 extra_state,request,ierror) &
   BIND(C, name="ompi_grequest_start_f")
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: query_fn
   type(c_funptr), value :: free_fn
   type(c_funptr), value :: cancel_fn
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
   INTEGER, INTENT(OUT) :: request
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_grequest_start_f

subroutine ompi_file_delete_f(filename,info,ierror,filename_len) &
   BIND(C, name="ompi_file_delete_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: filename
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: filename_len
end subroutine ompi_file_delete_f

subroutine ompi_file_get_view_f(fh,disp,etype,filetype,datarep,ierror,datarep_len) &
   BIND(C, name="ompi_file_get_view_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_OFFSET_KIND
   implicit none
   INTEGER, INTENT(IN) :: fh
   INTEGER(MPI_OFFSET_KIND), INTENT(OUT) :: disp
   INTEGER, INTENT(OUT) :: etype
   INTEGER, INTENT(OUT) :: filetype
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: datarep
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_file_get_view_f

subroutine ompi_file_open_f(comm,filename,amode,info,fh,ierror,filename_len) &
   BIND(C, name="ompi_file_open_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   INTEGER, INTENT(IN) :: comm
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: filename
   INTEGER, INTENT(IN) :: amode
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(OUT) :: fh
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: filename_len
end subroutine ompi_file_open_f

subroutine ompi_file_set_view_f(fh,disp,etype,filetype,datarep,info,ierror,datarep_len) &
   BIND(C, name="ompi_file_set_view_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_OFFSET_KIND
   implicit none
   INTEGER, INTENT(IN) :: fh
   INTEGER(MPI_OFFSET_KIND), INTENT(IN) :: disp
   INTEGER, INTENT(IN) :: etype
   INTEGER, INTENT(IN) :: filetype
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: datarep
   INTEGER, INTENT(IN) :: info
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_file_set_view_f

subroutine ompi_register_datarep_f(datarep,read_conversion_fn, &
                                   write_conversion_fn,dtype_file_extent_fn, &
                                   extra_state,ierror,datarep_len) &
   BIND(C, name="ompi_register_datarep_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   use :: mpi_f08_types, only : MPI_ADDRESS_KIND
   use, intrinsic :: iso_c_binding, only: c_funptr
   implicit none
   type(c_funptr), value :: read_conversion_fn
   type(c_funptr), value :: write_conversion_fn
   type(c_funptr), value :: dtype_file_extent_fn
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(IN) :: datarep
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: datarep_len
end subroutine ompi_register_datarep_f

!
! MPI_Sizeof is generic for numeric types.  This ignore TKR interface
! is replaced by the specific generics.
!
!subroutine ompi_sizeof(x,size,ierror) &
!   BIND(C, name="ompi_sizeof_f")
!   implicit none
!   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: x
!   INTEGER, INTENT(OUT) :: size
!   INTEGER, INTENT(OUT) :: ierror
!end subroutine ompi_sizeof

subroutine ompi_pcontrol_f(level) &
   BIND(C, name="ompi_pcontrol_f")
   implicit none
   INTEGER, INTENT(IN) :: level
end subroutine ompi_pcontrol_f


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! New routines to MPI-3
!

subroutine ompi_f_sync_reg_f(buf) &
   BIND(C, name="ompi_f_sync_reg_f")
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: buf
end subroutine ompi_f_sync_reg_f

subroutine ompi_get_library_version_f(name,resultlen,ierror,name_len) &
   BIND(C, name="ompi_get_library_version_f")
   use, intrinsic :: ISO_C_BINDING, only : C_CHAR
   implicit none
   CHARACTER(KIND=C_CHAR), DIMENSION(*), INTENT(OUT) :: name
   INTEGER, INTENT(OUT) :: resultlen
   INTEGER, INTENT(OUT) :: ierror
   INTEGER, VALUE, INTENT(IN) :: name_len
end subroutine ompi_get_library_version_f

subroutine ompi_mprobe_f(source,tag,comm,message,status,ierror) &
   BIND(C, name="ompi_mprobe_f")
   use :: mpi_f08_types, only : MPI_Status
   implicit none
   INTEGER, INTENT(IN) :: source, tag
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: message
   TYPE(MPI_Status) :: status
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_mprobe_f

subroutine ompi_imrecv_f(buf,count,datatype,message,request,ierror) &
   BIND(C, name="ompi_imrecv_f")
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE OMPI_ASYNCHRONOUS :: buf
   INTEGER, INTENT(IN) :: count
   INTEGER, INTENT(IN) :: datatype
   INTEGER, INTENT(INOUT) :: message
   INTEGER, INTENT(OUT) :: request
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_imrecv_f

subroutine ompi_mrecv_f(buf,count,datatype,message,status,ierror) &
   BIND(C, name="ompi_mrecv_f")
   use :: mpi_f08_types, only : MPI_Status
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: buf
   INTEGER, INTENT(IN) :: count
   INTEGER, INTENT(IN) :: datatype
   INTEGER, INTENT(INOUT) :: message
   TYPE(MPI_Status) :: status
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_mrecv_f

subroutine ompi_neighbor_alltoallw_f(sendbuf,sendcounts,sdispls,sendtypes,recvbuf,recvcounts, &
                             rdispls,recvtypes,comm,ierror) &
                             BIND(C, name="ompi_neighbor_alltoallw_f")
   use :: mpi_f08_types, only : MPI_Datatype, MPI_Comm, MPI_ADDRESS_KIND
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) :: sendbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE :: recvbuf
   INTEGER, INTENT(IN) :: sendcounts(*), recvcounts(*)
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) :: sdispls(*), rdispls(*)
   INTEGER, INTENT(IN) :: sendtypes, recvtypes
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_neighbor_alltoallw_f

subroutine ompi_ineighbor_alltoallw_f(sendbuf,sendcounts,sdispls,sendtypes,recvbuf,recvcounts, &
                             rdispls,recvtypes,comm,request,ierror) &
                             BIND(C, name="ompi_ineighbor_alltoallw_f")
   use :: mpi_f08_types, only : MPI_Datatype, MPI_Comm, MPI_Request, MPI_ADDRESS_KIND
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) OMPI_ASYNCHRONOUS :: sendbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE OMPI_ASYNCHRONOUS :: recvbuf
   INTEGER, INTENT(IN) OMPI_ASYNCHRONOUS :: sendcounts(*), recvcounts(*)
   INTEGER(MPI_ADDRESS_KIND), INTENT(IN) OMPI_ASYNCHRONOUS :: sdispls(*), rdispls(*)
   INTEGER, INTENT(IN) :: sendtypes, recvtypes
   INTEGER, INTENT(IN) :: comm
   INTEGER, INTENT(OUT) :: request
   INTEGER, INTENT(OUT) :: ierror
end subroutine ompi_ineighbor_alltoallw_f

#include "mpi-f-py-interfaces-bind.h"

end interface
