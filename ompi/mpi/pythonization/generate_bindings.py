#!/usr/bin/python3

# Copyright (c) 2020      Research Organization for Information Science
#                         and Technology (RIST).  All rights reserved.
#
# $COPYRIGHT$
#
# Additional copyrights may follow
#
import json
import sys
import textwrap
import filecmp
from shutil import copyfile
import tempfile
import os

with open('ompi/mpi/pythonization/apis.json') as f:
  bindings = json.load(f)

class Kind:
    def __init__(self, name, ftype):
        self.name = name
        self.ftype = ftype

    def get_fhtype(self, param):
        return "MPI_Fint *"

    def get_fhtrail(self, param):
        return None

    def get_ftype(self, param):
        return self.ftype

    def get_f08type(self, param):
        return self.get_ftype(self, param)

    def get_fusing(self, param):
        return None

    def get_using(self, param):
        return None

    def get_used(self, param):
        return None

    def get_intent(self, param):
        if "f08_intent" in param["suppress"].split():
            return ""
        elif param["param_direction"] == "in":
            return ", INTENT(IN)"
        elif param["param_direction"] == "out":
            return ", INTENT(OUT)"
        elif param["param_direction"] == "inout":
            return ", INTENT(INOUT)"
        else:
            return ""

    def get_asynchronous(self, param):
        if param["asynchronous"]:
            return ", ASYNCHRONOUS"
        else:
            return ""

    def get_optional(self, param):
        if param["optional"]:
            return ", OPTIONAL"
        else:
            return ""

    def get_array(self, param):
      if param["length"] is not None:
        if isinstance(param["length"], list) :
          return "(%s)" % (', '.join(list(reversed(param["length"]))))
        elif param["length"] == "":
          return "(*)"
        else:
           return "(%s)" % (param["length"])
      else:
        return ""

    def fheader(self, param):
        return "%s %s%s:: %s%s" % (self.get_ftype(param), self.get_intent(param), self.get_asynchronous(param), param["name"], self.get_array(param))

    def f08header(self, param):
        return "%s %s%s%s:: %s%s" % (self.get_ftype(param), self.get_intent(param), self.get_asynchronous(param), self.get_optional(param), param["name"], self.get_array(param))
        
    def fdefine(self, param):
        return self.fheader(param)
        
    def f08define(self, param):
        return self.f08header(param)

    def fparam(self, param):
        return param["name"]

    def f08param(self, param):
        return self.fparam(param)
        
class KindF08Noval(Kind):
    def __init__(self, name, f08type):
        Kind.__init__(self, name, 'INTEGER')
        self.f08type = f08type

    def get_f08type(self, param):
        return self.f08type

    def get_using(self, param):
        return "mpi_f08_types"

    def get_used(self, param):
        return self.get_f08type(param)

    def f08header(self, param):
        return "TYPE(%s) %s%s%s:: %s%s" % (self.get_f08type(param), self.get_intent(param), self.get_asynchronous(param), self.get_optional(param), param["name"], self.get_array(param))

class KindF08(KindF08Noval):
    def __init__(self, name, f08type):
        KindF08Noval.__init__(self, name, f08type)

    def f08param(self, param):
        return "%s%%MPI_VAL" % (param["name"])

class KindProcedure(KindF08):
    def __init__(self, name):
        KindF08.__init__(self, name, "")

    def get_using(self, param):
        return "mpi_f08_interfaces_callbacks"

    def get_used(self, param):
        return param["func_type"]

    def get_ftype(self, param):
        return param["func_type"]

    def get_f08_type(self, pame, param):
        return "PROCEDURE(%s)" % (param["func_type"])

    def f08header(self, param):
        return "PROCEDURE(%s) %s%s%s:: %s%s" % (param["func_type"], self.get_intent(param), self.get_asynchronous(param), self.get_optional(param), param["name"], self.get_array(param))

    def get_intent(self, param):
        return ""

class KindLogical(Kind):
    def __init__(self):
        Kind.__init__(self, 'LOGICAL', 'LOGICAL')

    def get_fhtype(self, param):
        return "ompi_fortran_logical_t *"

class KindCBuffer(KindF08Noval):
    def __init__(self, name, f08type):
        KindF08Noval.__init__(self, name, f08type)
        self.ftype = f08type

    def get_using(self, param):
        return "ISO_C_BINDING"

    def get_fusing(self, param):
        return self.get_using(param)

    def fheader(self, param):
        return self.f08header(param)

class KindBuffer(Kind):
    def __init__(self):
        Kind.__init__(self, 'BUFFER', 'OMPI_FORTRAN_IGNORE_TKR_TYPE')

    def get_intent(self, param):
        if "f08_intent" not in param["suppress"].split() and param["param_direction"] == "in":
            return ", INTENT(IN)"
        else:
            return ""

    def f08header(self, param):
        return "@OMPI_FORTRAN_IGNORE_TKR_PREDECL@ %s\n   " % (param["name"]) + self.f08define(param)

    def f08define(self, param):
        return "OMPI_FORTRAN_IGNORE_TKR_TYPE %s%s%s:: %s" % (self.get_intent(param), self.get_asynchronous(param), self.get_optional(param), param["name"])

    def get_fhtype(self, param):
        return "char *"

class KindAddress(KindF08Noval):
    def __init__(self, name):
        KindF08Noval.__init__(self, name, 'INTEGER(KIND=MPI_ADDRESS_KIND)')
        self.ftype = 'INTEGER(KIND=MPI_ADDRESS_KIND)'

    def get_using(self, param):
        return "mpi_f08_types"

    def get_fusing(self, param):
        return self.get_using(param)

    def get_used(self, param):
        return "MPI_ADDRESS_KIND"

    def get_fhtype(self, param):
        return "MPI_Aint *"

class KindF08Status(KindF08Noval):
    def __init__(self):
        KindF08Noval.__init__(self, "F08_STATUS", "MPI_Status")

    def get_fusing(self, param):
        return self.get_using(param)

    def fheader(self, param):
        return self.f08header(param)

class KindOffset(KindAddress):
    def __init__(self):
        KindAddress.__init__(self, "OFFSET")

    def get_fhtype(self, param):
        return "MPI_Offset *"

class KindStatus(KindF08Status):
    def __init__(self):
        KindF08Noval.__init__(self, "STATUS", "MPI_Status")
 
    def get_intent(self, param):
        if "f08_intent" in param["suppress"].split():
            return ""
        elif param["param_direction"] == "in":
            return ", INTENT(IN)"
        elif param["param_direction"] == "inout":
            return ", INTENT(INOUT)"
        else:
            return ""

    def get_fusing(self, param):
        return self.get_using(param)

    def fheader(self, param):
        return self.f08header(param)

class KindF90Status(KindF08Noval):
    def __init__(self):
        KindF08Noval.__init__(self, "F90_STATUS", "INTEGER")

    def get_used(self, param):
        return "MPI_STATUS_SIZE"

    def get_fusing(self, param):
        return self.get_using(param)

    def get_array(self, param):
        return "(MPI_STATUS_SIZE)"

class KindString(Kind):
    def __init__(self):
        Kind.__init__(self, "STRING", "")

    def get_using(self, param): 
        #print("KindString %s\n" % (param["name"]))
        if param["length"] is not None and param["length"][0:4] == "MPI_":
            return "mpi_f08_types"
        else:
            return None

    def get_array(self, param):
        return ""

    def get_used(self, param):
        return param["length"]

    def get_ftype(self, param):
        if param["length"] is None:
            return "CHARACTER(LEN=*)"
        else:
            return "CHARACTER(LEN=%s)" % (param["length"])

    def get_fhtype(self, param):
        return "char *"

    def get_fhtrail(self, param):
        return "int %s_len" % (param["name"])

class KindStringArray(Kind):
    def __init__(self):
        Kind.__init__(self, "STRING_ARRAY", "")

    def get_ftype(self, param):
        if param["length"] is None:
            return "CHARACTER(LEN=*)"
        else:
            return "CHARACTER(LEN=%s)" % (param["length"])

    def get_array(self, param):
        return ("(*)")

_kinds = [
    Kind('ACCESS_MODE', 'INTEGER'),
    KindAddress('ALLOC_MEM_NUM_BYTES'),
    Kind('ARGUMENT_COUNT', 'INTEGER'),
    Kind('ARGUMENT_LIST', 'INTEGER'),
    Kind('ARRAY_LENGTH', 'INTEGER'),
    Kind('ARRAY_LENGTH_NNI', 'INTEGER'),
    Kind('ARRAY_LENGTH_PI', 'INTEGER'),
    Kind('ASSERT', 'INTEGER'),
    KindAddress('ATTRIBUTE_VAL'),
    KindBuffer(),
    KindCBuffer('C_BUFFER', 'C_PTR'),
    KindCBuffer('C_BUFFER2', 'C_PTR'),
    Kind('COLOR', 'INTEGER'),
    Kind('COMBINER', 'INTEGER'),
    Kind('COMM_COMPARISON', 'INTEGER'),
    Kind('COMM_SIZE', 'INTEGER'),
    Kind('COMM_SIZE_PI', 'INTEGER'),
    KindF08('COMMUNICATOR', 'MPI_Comm'),
    Kind('COORDINATE', 'INTEGER'),
    KindF08('DATATYPE', 'MPI_Datatype'),
    Kind('DEGREE', 'INTEGER'),
    Kind('DIMENSION', 'INTEGER'),
    KindAddress('DISPLACEMENT'),
    KindAddress('DISPLACEMENT_AINT_COUNT_SMALL'),
    Kind('DISPLACEMENT_COUNT_SMALL', 'INTEGER'),
    Kind('DISPLACEMENT_SMALL', 'INTEGER'),
    KindAddress('DISPOFFSET_SMALL'),
    Kind('DISTRIB_ENUM', 'INTEGER'),
    Kind('DTYPE_DISTRIBUTION', 'INTEGER'),
    Kind('DTYPE_NUM_ELEM_NNI_SMALL', 'INTEGER'),
    Kind('DTYPE_NUM_ELEM_PI_SMALL', 'INTEGER'),
    Kind('DTYPE_NUM_ELEM_SMALL', 'INTEGER'),
    KindAddress('DTYPE_PACK_SIZE_SMALL'),
    KindAddress('DTYPE_STRIDE_BYTES_SMALL'),
    KindF08('ERRHANDLER', 'MPI_Errhandler'),
    Kind('ERROR_CLASS', 'INTEGER'),
    Kind('ERROR_CODE', 'INTEGER'),
    KindAddress('EXTRA_STATE'),
    KindF08Status(),
    KindF90Status(),
    KindF08('FILE', 'MPI_File'),
    Kind('FILE_DESCRIPTOR', 'INTEGER'),
    KindProcedure('FUNCTION'), # 'MPI_User_Function'
    KindProcedure('FUNCTION_SMALL'), # 'MPI_Comm_errhandler_function'
    Kind('GENERIC_DTYPE_INT', 'INTEGER'),
    KindF08('GROUP', 'MPI_Group'),
    Kind('GROUP_COMPARISON', 'INTEGER'),
    Kind('INDEX', 'INTEGER'),
    KindF08('INFO', 'MPI_Info'),
    Kind('INFO_VALUE_LENGTH', 'INTEGER'),
    Kind('KEY', 'INTEGER'),
    Kind('KEY_INDEX', 'INTEGER'),
    Kind('KEYVAL', 'INTEGER'),
    KindAddress('LOCATION_SMALL'),
    Kind('LOCK_TYPE', 'INTEGER'),
    KindLogical(),
    Kind('LOGICAL_BOOLEAN', 'LOGICAL'),
    Kind('MATH', 'INTEGER'),
    KindF08('MESSAGE', 'MPI_Message'),
    Kind('NUM_BYTES_NNI_SMALL', 'INTEGER'),
    Kind('NUM_DIMS', 'INTEGER'),
    KindOffset(),
    KindF08('OPERATION', 'MPI_Op'),
    Kind('ORDER', 'INTEGER'),
    Kind('PROCESS_GRID_SIZE', 'INTEGER'),
    Kind('PROFILE_LEVEL', 'INTEGER'),
    Kind('RANK', 'INTEGER'),
    Kind('RANK_NNI', 'INTEGER'),
    KindAddress('RMA_DISPLACEMENT_NNI'),
    Kind('RMA_DISPLACEMENT_SMALL', 'INTEGER'),
    KindF08('REQUEST', 'MPI_Request'),
    Kind('SPLIT_TYPE', 'INTEGER'),
    KindStatus(),
    KindString(),
    Kind('STRING_LENGTH', 'INTEGER'),
    KindStringArray(),
    Kind('TAG', 'INTEGER'),
    Kind('THREAD_LEVEL', 'INTEGER'),
    Kind('TOPOLOGY_TYPE', 'INTEGER'),
    Kind('TYPECLASS', 'INTEGER'),
    Kind('TYPECLASS_SIZE', 'INTEGER'),
    Kind('UPDATE_MODE', 'INTEGER'),
    Kind('VERSION', 'INTEGER'),
    Kind('WEIGHT', 'INTEGER'),
    KindF08('WINDOW', 'MPI_Win'),
    KindAddress('WINDOW_SIZE'),
    KindAddress('WIN_ATTACH_SIZE'),
    KindAddress('XFER_NUM_ELEM'),
    Kind('XFER_NUM_ELEM_SMALL', 'INTEGER'),
    Kind('XFER_NUM_ELEM_NNI_SMALL', 'INTEGER'),
]

kinds = {}
for kind in _kinds:
    kinds[kind.name] = kind

def generate_header(binding, file):
  using = {}
  params = []
  body = "   implicit none\n"
  for param in binding["parameters"]:
    if param["kind"] == "VARARGS" or "f08_parameter" in param["suppress"].split():
        continue

    body = body + "   "
    params.append(param["name"])

    kind = kinds[param["kind"]]
    m = kind.get_using(param)
    if m is not None:
        if not m in using:
            using[m] = {}
        using[m][kind.get_used(param)] = True

    body = body + kind.f08header(param) + "\n"

  if "mpi_f08_interfaces_callbacks" in using:
    body = "   use :: mpi_f08_interfaces_callbacks, only : %s\n" % (', '.join(sorted(using["mpi_f08_interfaces_callbacks"].keys()))) + body
  if "mpi_f08_types" in using:
    body = "   use :: mpi_f08_types, only : %s\n" % (', '.join(sorted(using["mpi_f08_types"].keys()))) + body
  if "ISO_C_BINDING" in using:
    body = "   use, intrinsic :: ISO_C_BINDING, only : %s\n" % (', '.join(sorted(using["ISO_C_BINDING"].keys()))) + body

  wrap = textwrap.TextWrapper(width=80,subsequent_indent="%%-%ds" % (len(binding["name"])+16) % " ",placeholder='&')
  wrapped_params= '&\n'.join(wrap.wrap(text=', '.join(params)))

  if binding["return_kind"] == "ERROR_CODE":
      file.write("\ninterface %s\nsubroutine %s_f08(%s)\n%send subroutine %s_f08\nend interface %s\n" %(binding["name"], binding["name"], wrapped_params, body, binding["name"], binding["name"]))
  else:
      file.write("\ninterface %s\nfunction %s_f08(%s)\n%s   %s :: %s_f08\nend function %s_f08\nend interface %s\n" %(binding["name"], binding["name"], wrapped_params, body, kinds[binding["return_kind"]].get_f08type(None), binding["name"], binding["name"], binding["name"]))

def generate_header2(binding, file):
  using = {}
  params = []
  body = "    implicit none\n"
  for param in binding["parameters"]:
    if param["kind"] == "VARARGS" or "f08_parameter" in param["suppress"].split():
        continue

    body = body + "    "
    params.append(param["name"])

    kind = kinds[param["kind"]]
    m = kind.get_fusing(param)
    if m is not None:
        if not m in using:
            using[m] = {}
        using[m][kind.get_used(param)] = True

    body = body + kind.fheader(param) + "\n"

  if "mpi_f08_interfaces_callbacks" in using:
    body = "   use :: mpi_f08_interfaces_callbacks, only : %s\n" % (', '.join(sorted(using["mpi_f08_interfaces_callbacks"].keys()))) + body
  if "mpi_f08_types" in using:
    body = "   use :: mpi_f08_types, only : %s\n" % (', '.join(sorted(using["mpi_f08_types"].keys()))) + body
  if "ISO_C_BINDING" in using:
    body = "   use, intrinsic :: ISO_C_BINDING, only : %s\n" % (', '.join(sorted(using["ISO_C_BINDING"].keys()))) + body


  wrap = textwrap.TextWrapper(width=80,subsequent_indent="%%-%ds" % (len(binding["name"])+16) % " ",placeholder='&')
  wrapped_params= '&\n'.join(wrap.wrap(text=', '.join(params)))

  if binding["return_kind"] == "ERROR_CODE":
      file.write("subroutine o%s_f(%s) &\n    BIND(C,name=\"o%s_f\")\n%send subroutine o%s_f\n\n" %(name, wrapped_params, name, body, name))
    
def generate_header3(binding, file):
  using = {}
  params = []
  params2 = []
  name = binding["name"]
  body = "PN2(void, %s, %s, %s, \\\n    (" % ( name, name.lower(), name.upper())
  for param in binding["parameters"]:
    if param["kind"] == "VARARGS" or "f08_parameter" in param["suppress"].split():
        continue

    kind = kinds[param["kind"]]
    params.append(kind.get_fhtype(name) + param["name"])
    trail = kind.get_fhtrail(param)
    if trail is not None:
        params2.append(trail)

  wrap = textwrap.TextWrapper(width=80,subsequent_indent="%%-%ds" % (5) % " ",placeholder=' \\')
  wrapped_params= ' \\\n'.join(wrap.wrap(text=', '.join(params + params2)))

  file.write(body + wrapped_params + "));\n")

def generate_binding(name, binding):
  header = False
  using = {}
  params = []
  body = "   implicit none\n"
  for param in binding["parameters"]:
    if param["kind"] == "VARARGS" or "f08_parameter" in param["suppress"].split():
        continue

    body = body + "   "
    params.append(param["name"])

    kind = kinds[param["kind"]]
    m = kind.get_using(param)
    if m is not None:
        if not m in using:
            using[m] = {}
        using[m][kind.get_used(param)] = True

    body = body + kind.f08define(param) + "\n"

  if "mpi_f08_interfaces_callbacks" in using:
    body = "   use :: mpi_f08_interfaces_callbacks, only : %s\n" % (', '.join(sorted(using["mpi_f08_interfaces_callbacks"].keys()))) + body
  if "mpi_f08_types" in using:
    body = "   use :: mpi_f08_types, only : %s\n" % (', '.join(sorted(using["mpi_f08_types"].keys()))) + body
  if "ISO_C_BINDING" in using:
    body = "   use, intrinsic :: ISO_C_BINDING, only : %s\n" % (', '.join(sorted(using["ISO_C_BINDING"].keys()))) + body

  f = open("ompi/mpi/fortran/use-mpi-f08/%s_f08.F90" % (name[4:]), "w")
  f.write("!do not edit\n\n")
  f.write("#include \"ompi/mpi/fortran/configure-fortran-output.h\"\n")
  f.write("#include \"mpi-f08-rename.h\"\n\n")
  wrap = textwrap.TextWrapper(width=80,subsequent_indent="%%-%ds" % (len(binding["name"])+16) % " ",placeholder='&')
  wrapped_params= '&\n'.join(wrap.wrap(text=', '.join(params)))
  f.write("subroutine %s_f08(%s)\n   use :: ompi_mpifh_bindings, only : o%s_f\n%s\n   integer :: c_ierror\n\n" % (binding["name"], wrapped_params, name, body))
  params = []
  for param in binding["parameters"]:
    if param["kind"] == "VARARGS" or "f08_parameter" in param["suppress"].split():
        continue
    params.append(kinds[param["kind"]].f08param(param))
  wrap = textwrap.TextWrapper(width=80,subsequent_indent="%%-%ds" % (len(name)+12) % " ",placeholder='&')
  wrapped_params= '&\n'.join(wrap.wrap(text=', '.join(params[:-1] + ["c_ierror"])))
  f.write("   call o%s_f(%s)\n   if (present(ierror)) ierror = c_ierror\nend subroutine %s_f08\n" % (name, wrapped_params, binding["name"]))
  f.close()
  
manual_prototypes = [
# OMPI: we had to remove ASYNCHRONOUS
    "mpi_free_mem",
# dimensions
    "mpi_dist_graph_create_adjacent",
    "mpi_dist_graph_neighbors",
    "mpi_comm_spawn_multiple",
# removed
    "mpi_get_elements",
    "mpi_get_elements_x",
# new
    "mpi_comm_idup_with_info",
    "mpi_intercomm_create_from_groups",
    "mpi_type_get_elements_x",
    "mpi_type_get_elements",
    "mpi_isendrecv",
    "mpi_isendrecv_replace",
    "mpi_info_create_env",
    "mpi_info_get_string",
    "mpi_comm_create_from_group",
# MPI_Sizeof
    "mpi_sizeof",
# Sessions
    "mpi_group_from_session_pset",
    "mpi_session_call_errhandler",
    "mpi_session_create_errhandler",
    "mpi_session_finalize",
    "mpi_session_get_errhandler",
    "mpi_session_get_info",
    "mpi_session_get_nth_pset",
    "mpi_session_get_num_psets",
    "mpi_session_get_pset_info",
    "mpi_session_init",
    "mpi_session_set_errhandler",
# bind(C) functions
    "mpi_wtime",
    "mpi_wtick",
# Non blocking collectives
    "mpi_allgather_init",
    "mpi_allgatherv_init",
    "mpi_allreduce_init",
    "mpi_alltoall_init",
    "mpi_alltoallv_init",
    "mpi_alltoallw_init",
    "mpi_barrier_init",
    "mpi_bcast_init",
    "mpi_exscan_init",
    "mpi_gather_init",
    "mpi_gatherv_init",
    "mpi_neighbor_allgather_init",
    "mpi_neighbor_allgatherv_init",
    "mpi_neighbor_alltoall_init",
    "mpi_neighbor_alltoallv_init",
    "mpi_neighbor_alltoallw_init",
    "mpi_reduce_init",
    "mpi_reduce_scatter_block_init",
    "mpi_reduce_scatter_init",
    "mpi_scan_init",
    "mpi_scatter_init",
    "mpi_scatterv_init",
]

manual_bindings = [
    "mpi_add_error_string",
    "mpi_aint_add",
    "mpi_aint_diff",
    "mpi_alloc_mem",
    "mpi_alltoallw",
    "mpi_cart_create",
    "mpi_cart_get",
    "mpi_comm_get_attr",
    "mpi_cart_map",
    "mpi_cart_sub",
    "mpi_close_port",
    "mpi_comm_accept",
    "mpi_comm_connect",
    "mpi_comm_create",
    "mpi_comm_create_errhandler",
    "mpi_comm_create_group",
    "mpi_comm_create_keyval",
    "mpi_comm_dup_with_info",
    "mpi_comm_get_attr",
    "mpi_comm_get_errhandler",
    "mpi_comm_get_info",
    "mpi_comm_get_name",
    "mpi_comm_set_errhandler",
    "mpi_comm_set_info",
    "mpi_comm_set_name",
    "mpi_comm_spawn",
    "mpi_comm_test_inter",
    "mpi_dist_graph_create",
    "mpi_dist_graph_neighbors_count",
    "mpi_error_string",
    "mpi_f_sync_reg",
    "mpi_file_create_errhandler",
    "mpi_file_delete",
    "mpi_file_get_atomicity",
    "mpi_file_get_view",
    "mpi_file_open",
    "mpi_file_set_atomicity",
    "mpi_file_set_view",
    "mpi_finalized",
    "mpi_get_library_version",
    "mpi_get_processor_name",
    "mpi_graph_create",
    "mpi_grequest_start",
    "mpi_ialltoallw",
    "mpi_improbe",
    "mpi_imrecv",
    "mpi_ineighbor_alltoallw",
    "mpi_info_delete",
    "mpi_info_get",
    "mpi_info_get_nthkey",
    "mpi_info_get_valuelen",
    "mpi_info_set",
    "mpi_initialized",
    "mpi_intercomm_merge",
    "mpi_iprobe",
    "mpi_is_thread_main",
    "mpi_lookup_name",
    "mpi_mprobe",
    "mpi_mrecv",
    "mpi_neighbor_alltoallw",
    "mpi_op_commutative",
    "mpi_op_create",
    "mpi_open_port",
    "mpi_pack_external",
    "mpi_pack_external_size",
    "mpi_pcontrol",
    "mpi_publish_name",
    "mpi_register_datarep",
    "mpi_request_get_status",
    "mpi_status_set_cancelled",
    "mpi_testall",
    "mpi_testany",
    "mpi_test_cancelled",
    "mpi_test",
    "mpi_testsome",
    "mpi_type_create_keyval",
    "mpi_type_get_attr",
    "mpi_type_get_name",
    "mpi_type_set_name",
    "mpi_unpack_external",
    "mpi_unpublish_name",
    "mpi_win_create_errhandler",
    "mpi_win_create_keyval",
    "mpi_win_get_attr",
    "mpi_win_get_name",
    "mpi_win_set_name",
    "mpi_win_test",
]

manual_mpifh_bindings = [
    "mpi_buffer_detach",
    "mpi_cart_create",
    "mpi_cart_get",
    "mpi_cart_map",
    "mpi_cart_sub",
    "mpi_close_port",
    "mpi_comm_accept",
    "mpi_comm_connect",
    "mpi_comm_create_errhandler",
    "mpi_comm_create_keyval",
    "mpi_comm_get_attr",
    "mpi_comm_get_name",
    "mpi_comm_set_name",
]

manual_pn2_bindings = [
    "mpi_buffer_detach",
    "mpi_add_error_string",
    "mpi_aint_add",
    "mpi_aint_diff",
    "mpi_alloc_mem",
    "mpi_comm_create_errhandler",
    "mpi_comm_create_keyval",
    "mpi_comm_spawn",
    "mpi_comm_spawn_multiple",
    "mpi_comm_test_inter",
    "mpi_dist_graph_neighbors_count",
    "mpi_errhandler_create",
    "mpi_file_create_errhandler",
    "mpi_file_get_atomicity",
    "mpi_get_elements_x",
    "mpi_grequest_start",
    "mpi_group_range_excl",
    "mpi_group_range_incl",
    "mpi_alltoallw",
    "mpi_ialltoallw",
    "mpi_neighbor_alltoallw",
    "mpi_ineighbor_alltoallw",
    "mpi_keyval_create",
    "mpi_op_create",
    "mpi_pcontrol",
    "mpi_register_datarep",
    "mpi_status_f082f",
    "mpi_status_f2f08",
    "mpi_status_set_cancelled",
    "mpi_status_set_elements_x",
    "mpi_type_create_keyval",
    "mpi_type_get_extent_x",
    "mpi_type_get_true_extent_x",
    "mpi_type_size_x",
    "mpi_win_allocate",
    "mpi_win_allocate_cptr",
    "mpi_win_allocate_shared",
    "mpi_win_allocate_shared_cptr",
    "mpi_win_create_errhandler",
    "mpi_win_create_keyval",
    "mpi_win_shared_query",
    "mpi_win_shared_query_cptr",
    "mpi_wtick",
    "mpi_wtime"
]


files = []
file = open("ompi/mpi/fortran/use-mpi-f08/mod/mpi-f08-py-interfaces.h.in", "w")
file.write("!do not edit\n\n")
f = open("ompi/mpi/fortran/use-mpi-f08/bindings/mpi-f-py-interfaces-bind.h", "w")
f.write("!do not edit\n\n")
f2 = open("ompi/mpi/fortran/mpif-h/prototypes_mpi-py.h", "w")
f2.write("/* do not edit */\n\n")
for name,binding in bindings.items():
  if name not in manual_prototypes:
    if binding["attributes"]["f08_expressible"] and binding["attributes"]["predefined_function"] is None and not binding["attributes"]["callback"]:
      generate_header(binding, file)
      if name not in manual_bindings:
        generate_binding(name, binding)
        files.append("%s_f08.F90" % (name[4:]))
        if name not in manual_mpifh_bindings:
          generate_header2(binding, f)
      if name not in manual_pn2_bindings:
        generate_header3(binding, f2)

file.close()
f.close()
f2.close()

file = open("ompi/mpi/fortran/use-mpi-f08/mpi-f08-interfaces.mk", "w")
file.write("# do not edit\nmpi_py_api_files = \\\n        ")
file.write("\\\n        ".join(files))
file.close()

file = open("ompi/mpi/fortran/use-mpi-f08/profile/pmpi-f08-interfaces.mk", "w")
file.write("# do not edit\npmpi_py_api_files = \\\n        p")
file.write("\\\n        p".join(files))
file.close()
