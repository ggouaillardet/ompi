! -*- f90 -*-
!
! Copyright (c) 2009-2015 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009-2015 Los Alamos National Security, LLC.
!                         All rights reserved.
! Copyright (c) 2012      The University of Tennessee and The University
!                         of Tennessee Research Foundation.  All rights
!                         reserved.
! Copyright (c) 2012      Inria.  All rights reserved.
! Copyright (c) 2015      Research Organization for Information Science
!                         and Technology (RIST). All rights reserved.
! $COPYRIGHT$
!
! This file provides the interface specifications for the MPI Fortran
! API bindings.  It effectively maps between public names ("MPI_Init")
! and the name for tools ("MPI_Init_f08") and the back-end implementation
! name (e.g., "MPI_Init_f08").

#include "ompi/mpi/fortran/configure-fortran-output.h"

module mpi_f08_interfaces

#include "ompi/mpi/fortran/use-mpi-f08/mpi-f08-module-interfaces.h"

end module mpi_f08_interfaces
