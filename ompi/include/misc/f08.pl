#----------------------------------------------------------------------------
# MPI_Bsend
$api = newAPI("MPI_Bsend");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Bsend_init
$api = newAPI("MPI_Bsend_init");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Buffer_attach
$api = newAPI("MPI_Buffer_attach");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buffer
APIArg      ($api, "buffer", IntentNONE, TypeChoice);
APIArgAsync ($api, "buffer");
# INTEGER, INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Buffer_detach
$api = newAPI("MPI_Buffer_detach");
APIAuto     ($api);
# TYPE(C_PTR), INTENT(OUT) :: buffer_addr
APIArg      ($api, "buffer_addr", IntentOUT, TypeC);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cancel
$api = newAPI("MPI_Cancel");
APIAuto     ($api);
# TYPE(MPI_Request), INTENT(IN) :: request
APIArg      ($api, "request", IntentIN, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_count
$api = newAPI("MPI_Get_count");
# TYPE(MPI_Status), INTENT(IN) :: status
APIArg      ($api, "status", IntentIN, TypeStatus);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(OUT) :: count
APIArg      ($api, "count", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ibsend
$api = newAPI("MPI_Ibsend");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Improbe
$api = newAPI("MPI_Improbe");
APIPMPI     ($api);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeInteger);
# TYPE(MPI_Message), INTENT(OUT) :: message
APIArg      ($api, "message", IntentOUT, TypeMessage);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Imrecv
$api = newAPI("MPI_Imrecv");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Message), INTENT(INOUT) :: message
APIArg      ($api, "message", IntentINOUT, TypeMessage);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iprobe
$api = newAPI("MPI_Iprobe");
APIPMPI     ($api);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Irecv
$api = newAPI("MPI_Irecv");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Irsend
$api = newAPI("MPI_Irsend");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Isend
$api = newAPI("MPI_Isend");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Issend
$api = newAPI("MPI_Issend");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Mprobe
$api = newAPI("MPI_Mprobe");
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Message), INTENT(OUT) :: message
APIArg      ($api, "message", IntentOUT, TypeMessage);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Mrecv
$api = newAPI("MPI_Mrecv");
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Message), INTENT(INOUT) :: message
APIArg      ($api, "message", IntentINOUT, TypeMessage);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Probe
$api = newAPI("MPI_Probe");
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Recv
$api = newAPI("MPI_Recv");
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Recv_init
$api = newAPI("MPI_Recv_init");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Request_free
$api = newAPI("MPI_Request_free");
# TYPE(MPI_Request), INTENT(INOUT) :: request
APIArg      ($api, "request", IntentINOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Request_get_status
$api = newAPI("MPI_Request_get_status");
APIPMPI     ($api);
# TYPE(MPI_Request), INTENT(IN) :: request
APIArg      ($api, "request", IntentIN, TypeRequest);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Rsend
$api = newAPI("MPI_Rsend");
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Rsend_init
$api = newAPI("MPI_Rsend_init");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Send
$api = newAPI("MPI_Send");
grep: ../../mpi/fortran/use-mpi-f08/send_f08.F90: No such file or directory
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Send_init
$api = newAPI("MPI_Send_init");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Sendrecv
$api = newAPI("MPI_Sendrecv");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: sendtag
APIArg      ($api, "sendtag", IntentIN, TypeInteger);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: recvtag
APIArg      ($api, "recvtag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Sendrecv_replace
$api = newAPI("MPI_Sendrecv_replace");
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: sendtag
APIArg      ($api, "sendtag", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: source
APIArg      ($api, "source", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: recvtag
APIArg      ($api, "recvtag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ssend
$api = newAPI("MPI_Ssend");
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ssend_init
$api = newAPI("MPI_Ssend_init");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: dest
APIArg      ($api, "dest", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Start
$api = newAPI("MPI_Start");
# TYPE(MPI_Request), INTENT(INOUT) :: request
APIArg      ($api, "request", IntentINOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Startall
$api = newAPI("MPI_Startall");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "count");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Test
$api = newAPI("MPI_Test");
APIPMPI     ($api);
# TYPE(MPI_Request), INTENT(INOUT) :: request
APIArg      ($api, "request", IntentINOUT, TypeRequest);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Test_cancelled
$api = newAPI("MPI_Test_cancelled");
APIPMPI     ($api);
# TYPE(MPI_Status), INTENT(IN) :: status
APIArg      ($api, "status", IntentIN, TypeStatus);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Testall
$api = newAPI("MPI_Testall");
APIPMPI     ($api);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "count");
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# TYPE(MPI_Status) :: array_of_statuses
APIArgArray ($api, "array_of_statuses", IntentNONE, TypeStatus, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Testany
$api = newAPI("MPI_Testany");
APIPMPI     ($api);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "count");
# INTEGER, INTENT(OUT) :: index
APIArg      ($api, "index", IntentOUT, TypeInteger);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Testsome
$api = newAPI("MPI_Testsome");
APIPMPI     ($api);
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "incount");
# INTEGER, INTENT(OUT) :: outcount
APIArg      ($api, "outcount", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: array_of_indices
APIArgArray ($api, "array_of_indices", IntentOUT, TypeInteger, "*");
# TYPE(MPI_Status) :: array_of_statuses
APIArgArray ($api, "array_of_statuses", IntentNONE, TypeStatus, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Wait
$api = newAPI("MPI_Wait");
# TYPE(MPI_Request), INTENT(INOUT) :: request
APIArg      ($api, "request", IntentINOUT, TypeRequest);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Waitall
$api = newAPI("MPI_Waitall");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "count");
# TYPE(MPI_Status) :: array_of_statuses
APIArgArray ($api, "array_of_statuses", IntentNONE, TypeStatus, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Waitany
$api = newAPI("MPI_Waitany");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "count");
# INTEGER, INTENT(OUT) :: index
APIArg      ($api, "index", IntentOUT, TypeInteger);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Waitsome
$api = newAPI("MPI_Waitsome");
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Request), INTENT(INOUT) :: array_of_requests
APIArgArray ($api, "array_of_requests", IntentINOUT, TypeRequest, "incount");
# INTEGER, INTENT(OUT) :: outcount
APIArg      ($api, "outcount", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: array_of_indices
APIArgArray ($api, "array_of_indices", IntentOUT, TypeInteger, "*");
# TYPE(MPI_Status) :: array_of_statuses
APIArgArray ($api, "array_of_statuses", IntentNONE, TypeStatus, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_address
$api = newAPI("MPI_Get_address");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: location
APIArg      ($api, "location", IntentNONE, TypeChoice);
APIArgAsync ($api, "location");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: address
APIArg      ($api, "address", IntentOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_elements
$api = newAPI("MPI_Get_elements");
# TYPE(MPI_Status), INTENT(IN) :: status
APIArg      ($api, "status", IntentIN, TypeStatus);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(OUT) :: count
APIArg      ($api, "count", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_elements_x
$api = newAPI("MPI_Get_elements_x");
# TYPE(MPI_Status), INTENT(IN) :: status
APIArg      ($api, "status", IntentIN, TypeStatus);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: count
APIArg      ($api, "count", IntentOUT, TypeCount);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Pack
$api = newAPI("MPI_Pack");
# TYPE(*), DIMENSION(..), INTENT(IN) :: inbuf
APIArg      ($api, "inbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: outbuf
APIArg      ($api, "outbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: outsize
APIArg      ($api, "outsize", IntentIN, TypeInteger);
# INTEGER, INTENT(INOUT) :: position
APIArg      ($api, "position", IntentINOUT, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Pack_external
$api = newAPI("MPI_Pack_external");
# CHARACTER(LEN=*), INTENT(IN) :: datarep
APIArg      ($api, "datarep", IntentIN, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# TYPE(*), DIMENSION(..), INTENT(IN) :: inbuf
APIArg      ($api, "inbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: outbuf
APIArg      ($api, "outbuf", IntentNONE, TypeChoice);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: outsize
APIArg      ($api, "outsize", IntentIN, TypeAint);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(INOUT) :: position
APIArg      ($api, "position", IntentINOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Pack_external_size
$api = newAPI("MPI_Pack_external_size");
# CHARACTER(LEN=*), INTENT(IN) :: datarep
APIArg      ($api, "datarep", IntentIN, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Pack_size
$api = newAPI("MPI_Pack_size");
# INTEGER, INTENT(IN) :: incount
APIArg      ($api, "incount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_commit
$api = newAPI("MPI_Type_commit");
# TYPE(MPI_Datatype), INTENT(INOUT) :: datatype
APIArg      ($api, "datatype", IntentINOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_contiguous
$api = newAPI("MPI_Type_contiguous");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_darray
$api = newAPI("MPI_Type_create_darray");
# INTEGER, INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ndims
APIArg      ($api, "ndims", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_gsizes
APIArgArray ($api, "array_of_gsizes", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: array_of_distribs
APIArgArray ($api, "array_of_distribs", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: array_of_dargs
APIArgArray ($api, "array_of_dargs", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: array_of_psizes
APIArgArray ($api, "array_of_psizes", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: order
APIArg      ($api, "order", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_hindexed
$api = newAPI("MPI_Type_create_hindexed");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_blocklengths
APIArgArray ($api, "array_of_blocklengths", IntentIN, TypeInteger, "count");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: array_of_displacements
APIArgArray ($api, "array_of_displacements", IntentIN, TypeAint, "count");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_hindexed_block
$api = newAPI("MPI_Type_create_hindexed_block");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: blocklength
APIArg      ($api, "blocklength", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: array_of_displacements
APIArgArray ($api, "array_of_displacements", IntentIN, TypeAint, "count");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_hvector
$api = newAPI("MPI_Type_create_hvector");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: blocklength
APIArg      ($api, "blocklength", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: stride
APIArg      ($api, "stride", IntentIN, TypeAint);
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_indexed_block
$api = newAPI("MPI_Type_create_indexed_block");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: blocklength
APIArg      ($api, "blocklength", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_displacements
APIArgArray ($api, "array_of_displacements", IntentIN, TypeInteger, "count");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_resized
$api = newAPI("MPI_Type_create_resized");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: lb
APIArg      ($api, "lb", IntentIN, TypeAint);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extent
APIArg      ($api, "extent", IntentIN, TypeAint);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_struct
$api = newAPI("MPI_Type_create_struct");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_blocklengths
APIArgArray ($api, "array_of_blocklengths", IntentIN, TypeInteger, "count");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: array_of_displacements
APIArgArray ($api, "array_of_displacements", IntentIN, TypeAint, "count");
# TYPE(MPI_Datatype), INTENT(IN) :: array_of_types
APIArgArray ($api, "array_of_types", IntentIN, TypeDatatype, "count");
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_subarray
$api = newAPI("MPI_Type_create_subarray");
# INTEGER, INTENT(IN) :: ndims
APIArg      ($api, "ndims", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_sizes
APIArgArray ($api, "array_of_sizes", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: array_of_subsizes
APIArgArray ($api, "array_of_subsizes", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: array_of_starts
APIArgArray ($api, "array_of_starts", IntentIN, TypeInteger, "ndims");
# INTEGER, INTENT(IN) :: order
APIArg      ($api, "order", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_dup
$api = newAPI("MPI_Type_dup");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_free
$api = newAPI("MPI_Type_free");
# TYPE(MPI_Datatype), INTENT(INOUT) :: datatype
APIArg      ($api, "datatype", IntentINOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_contents
$api = newAPI("MPI_Type_get_contents");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: max_integers
APIArg      ($api, "max_integers", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: max_addresses
APIArg      ($api, "max_addresses", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: max_datatypes
APIArg      ($api, "max_datatypes", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: array_of_integers
APIArgArray ($api, "array_of_integers", IntentOUT, TypeInteger, "max_integers");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: array_of_addresses
APIArgArray ($api, "array_of_addresses", IntentOUT, TypeAint, "max_addresses");
# TYPE(MPI_Datatype), INTENT(OUT) :: array_of_datatypes
APIArgArray ($api, "array_of_datatypes", IntentOUT, TypeDatatype, "max_datatypes");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_envelope
$api = newAPI("MPI_Type_get_envelope");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(OUT) :: num_integers
APIArg      ($api, "num_integers", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: num_addresses
APIArg      ($api, "num_addresses", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: num_datatypes
APIArg      ($api, "num_datatypes", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: combiner
APIArg      ($api, "combiner", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_extent
$api = newAPI("MPI_Type_get_extent");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: lb
APIArg      ($api, "lb", IntentOUT, TypeAint);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: extent
APIArg      ($api, "extent", IntentOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_extent_x
$api = newAPI("MPI_Type_get_extent_x");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: lb
APIArg      ($api, "lb", IntentOUT, TypeCount);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: extent
APIArg      ($api, "extent", IntentOUT, TypeCount);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_true_extent
$api = newAPI("MPI_Type_get_true_extent");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: true_lb
APIArg      ($api, "true_lb", IntentOUT, TypeAint);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: true_extent
APIArg      ($api, "true_extent", IntentOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_true_extent_x
$api = newAPI("MPI_Type_get_true_extent_x");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: true_lb
APIArg      ($api, "true_lb", IntentOUT, TypeCount);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: true_extent
APIArg      ($api, "true_extent", IntentOUT, TypeCount);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_indexed
$api = newAPI("MPI_Type_indexed");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: array_of_blocklengths
APIArgArray ($api, "array_of_blocklengths", IntentIN, TypeInteger, "count");
# INTEGER, INTENT(IN) :: array_of_displacements
APIArgArray ($api, "array_of_displacements", IntentIN, TypeInteger, "count");
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_size
$api = newAPI("MPI_Type_size");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_size_x
$api = newAPI("MPI_Type_size_x");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeCount);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_vector
$api = newAPI("MPI_Type_vector");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: blocklength
APIArg      ($api, "blocklength", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: stride
APIArg      ($api, "stride", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: oldtype
APIArg      ($api, "oldtype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Unpack
$api = newAPI("MPI_Unpack");
# TYPE(*), DIMENSION(..), INTENT(IN) :: inbuf
APIArg      ($api, "inbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: insize
APIArg      ($api, "insize", IntentIN, TypeInteger);
# INTEGER, INTENT(INOUT) :: position
APIArg      ($api, "position", IntentINOUT, TypeInteger);
# TYPE(*), DIMENSION(..) :: outbuf
APIArg      ($api, "outbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: outcount
APIArg      ($api, "outcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Unpack_external
$api = newAPI("MPI_Unpack_external");
# CHARACTER(LEN=*), INTENT(IN) :: datarep
APIArg      ($api, "datarep", IntentIN, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# TYPE(*), DIMENSION(..), INTENT(IN) :: inbuf
APIArg      ($api, "inbuf", IntentIN, TypeChoice);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: insize
APIArg      ($api, "insize", IntentIN, TypeAint);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(INOUT) :: position
APIArg      ($api, "position", IntentINOUT, TypeAint);
# TYPE(*), DIMENSION(..) :: outbuf
APIArg      ($api, "outbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: outcount
APIArg      ($api, "outcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Allgather
$api = newAPI("MPI_Allgather");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Allgatherv
$api = newAPI("MPI_Allgatherv");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Allreduce
$api = newAPI("MPI_Allreduce");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Alltoall
$api = newAPI("MPI_Alltoall");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Alltoallv
$api = newAPI("MPI_Alltoallv");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Alltoallw
$api = newAPI("MPI_Alltoallw");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtypes
APIArgArray ($api, "sendtypes", IntentIN, TypeDatatype, "*");
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtypes
APIArgArray ($api, "recvtypes", IntentIN, TypeDatatype, "*");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Barrier
$api = newAPI("MPI_Barrier");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Bcast
$api = newAPI("MPI_Bcast");
APIAuto     ($api);
# TYPE(*), DIMENSION(..) :: buffer
APIArg      ($api, "buffer", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Exscan
$api = newAPI("MPI_Exscan");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Gather
$api = newAPI("MPI_Gather");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Gatherv
$api = newAPI("MPI_Gatherv");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iallgather
$api = newAPI("MPI_Iallgather");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iallgatherv
$api = newAPI("MPI_Iallgatherv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "displs");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iallreduce
$api = newAPI("MPI_Iallreduce");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ialltoall
$api = newAPI("MPI_Ialltoall");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ialltoallv
$api = newAPI("MPI_Ialltoallv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sendcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sdispls");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "rdispls");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ialltoallw
$api = newAPI("MPI_Ialltoallw");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sendcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sdispls");
# TYPE(MPI_Datatype), INTENT(IN), ASYNCHRONOUS :: sendtypes
APIArgArray ($api, "sendtypes", IntentIN, TypeDatatype, "*");
APIArgAsync ($api, "sendtypes");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "rdispls");
# TYPE(MPI_Datatype), INTENT(IN), ASYNCHRONOUS :: recvtypes
APIArgArray ($api, "recvtypes", IntentIN, TypeDatatype, "*");
APIArgAsync ($api, "recvtypes");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ibarrier
$api = newAPI("MPI_Ibarrier");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ibcast
$api = newAPI("MPI_Ibcast");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buffer
APIArg      ($api, "buffer", IntentNONE, TypeChoice);
APIArgAsync ($api, "buffer");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iexscan
$api = newAPI("MPI_Iexscan");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Igather
$api = newAPI("MPI_Igather");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Igatherv
$api = newAPI("MPI_Igatherv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "displs");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ireduce
$api = newAPI("MPI_Ireduce");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ireduce_scatter
$api = newAPI("MPI_Ireduce_scatter");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ireduce_scatter_block
$api = newAPI("MPI_Ireduce_scatter_block");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iscan
$api = newAPI("MPI_Iscan");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iscatter
$api = newAPI("MPI_Iscatter");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Iscatterv
$api = newAPI("MPI_Iscatterv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sendcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "displs");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Op_commutative
$api = newAPI("MPI_Op_commutative");
APIPMPI     ($api);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# LOGICAL, INTENT(OUT) :: commute
APIArg      ($api, "commute", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Op_create
$api = newAPI("MPI_Op_create");
APIPMPI     ($api);
# PROCEDURE(MPI_User_function) :: user_fn
APIArg      ($api, "user_fn", IntentNONE, TypeProcedureUserFunction);
# LOGICAL, INTENT(IN) :: commute
APIArg      ($api, "commute", IntentIN, TypeLogical);
# TYPE(MPI_Op), INTENT(OUT) :: op
APIArg      ($api, "op", IntentOUT, TypeOp);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Op_free
$api = newAPI("MPI_Op_free");
# TYPE(MPI_Op), INTENT(INOUT) :: op
APIArg      ($api, "op", IntentINOUT, TypeOp);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Reduce
$api = newAPI("MPI_Reduce");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Reduce_local
$api = newAPI("MPI_Reduce_local");
# TYPE(*), DIMENSION(..), INTENT(IN) :: inbuf
APIArg      ($api, "inbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: inoutbuf
APIArg      ($api, "inoutbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Reduce_scatter
$api = newAPI("MPI_Reduce_scatter");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Reduce_scatter_block
$api = newAPI("MPI_Reduce_scatter_block");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Scan
$api = newAPI("MPI_Scan");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Scatter
$api = newAPI("MPI_Scatter");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Scatterv
$api = newAPI("MPI_Scatterv");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_compare
$api = newAPI("MPI_Comm_compare");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm1
APIArg      ($api, "comm1", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(IN) :: comm2
APIArg      ($api, "comm2", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: result
APIArg      ($api, "result", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_create
$api = newAPI("MPI_Comm_create");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_create_group
$api = newAPI("MPI_Comm_create_group");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_create_keyval
$api = newAPI("MPI_Comm_create_keyval");
# PROCEDURE(MPI_Comm_copy_attr_function) :: comm_copy_attr_fn
APIArg      ($api, "comm_copy_attr_fn", IntentNONE, TypeProcedureCommCopyAttr);
# PROCEDURE(MPI_Comm_delete_attr_function) :: comm_delete_attr_fn
APIArg      ($api, "comm_delete_attr_fn", IntentNONE, TypeProcedureCommDeleteAttr);
# INTEGER, INTENT(OUT) :: comm_keyval
APIArg      ($api, "comm_keyval", IntentOUT, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
APIArg      ($api, "extra_state", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_delete_attr
$api = newAPI("MPI_Comm_delete_attr");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: comm_keyval
APIArg      ($api, "comm_keyval", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_dup
$api = newAPI("MPI_Comm_dup");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_dup_with_info
$api = newAPI("MPI_Comm_dup_with_info");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_free
$api = newAPI("MPI_Comm_free");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(INOUT) :: comm
APIArg      ($api, "comm", IntentINOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_free_keyval
$api = newAPI("MPI_Comm_free_keyval");
APIAuto     ($api);
# INTEGER, INTENT(INOUT) :: comm_keyval
APIArg      ($api, "comm_keyval", IntentINOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_get_attr
$api = newAPI("MPI_Comm_get_attr");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: comm_keyval
APIArg      ($api, "comm_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: attribute_val
APIArg      ($api, "attribute_val", IntentOUT, TypeAint);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_get_info
$api = newAPI("MPI_Comm_get_info");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Info), INTENT(OUT) :: info_used
APIArg      ($api, "info_used", IntentOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_get_name
$api = newAPI("MPI_Comm_get_name");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# CHARACTER(LEN=MPI_MAX_OBJECT_NAME), INTENT(OUT) :: comm_name
APIArg      ($api, "comm_name", IntentOUT, TypeCharacter);
APIArgModify($api, "comm_name", "LEN=MPI_MAX_OBJECT_NAME");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_group
$api = newAPI("MPI_Comm_group");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Group), INTENT(OUT) :: group
APIArg      ($api, "group", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_idup
$api = newAPI("MPI_Comm_idup");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_rank
$api = newAPI("MPI_Comm_rank");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: rank
APIArg      ($api, "rank", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_remote_group
$api = newAPI("MPI_Comm_remote_group");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Group), INTENT(OUT) :: group
APIArg      ($api, "group", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_remote_size
$api = newAPI("MPI_Comm_remote_size");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_set_attr
$api = newAPI("MPI_Comm_set_attr");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: comm_keyval
APIArg      ($api, "comm_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: attribute_val
APIArg      ($api, "attribute_val", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_set_info
$api = newAPI("MPI_Comm_set_info");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(INOUT) :: comm
APIArg      ($api, "comm", IntentINOUT, TypeComm);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_set_name
$api = newAPI("MPI_Comm_set_name");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# CHARACTER(LEN=*), INTENT(IN) :: comm_name
APIArg      ($api, "comm_name", IntentIN, TypeCharacter);
APIArgModify($api, "comm_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_size
$api = newAPI("MPI_Comm_size");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_split
$api = newAPI("MPI_Comm_split");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: color
APIArg      ($api, "color", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_split_type
$api = newAPI("MPI_Comm_split_type");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: split_type
APIArg      ($api, "split_type", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_test_inter
$api = newAPI("MPI_Comm_test_inter");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_compare
$api = newAPI("MPI_Group_compare");
# TYPE(MPI_Group), INTENT(IN) :: group1
APIArg      ($api, "group1", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(IN) :: group2
APIArg      ($api, "group2", IntentIN, TypeGroup);
# INTEGER, INTENT(OUT) :: result
APIArg      ($api, "result", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_difference
$api = newAPI("MPI_Group_difference");
# TYPE(MPI_Group), INTENT(IN) :: group1
APIArg      ($api, "group1", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(IN) :: group2
APIArg      ($api, "group2", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_excl
$api = newAPI("MPI_Group_excl");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ranks
APIArgArray ($api, "ranks", IntentIN, TypeInteger, "n");
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_free
$api = newAPI("MPI_Group_free");
# TYPE(MPI_Group), INTENT(INOUT) :: group
APIArg      ($api, "group", IntentINOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_incl
$api = newAPI("MPI_Group_incl");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ranks
APIArgArray ($api, "ranks", IntentIN, TypeInteger, "n");
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_intersection
$api = newAPI("MPI_Group_intersection");
# TYPE(MPI_Group), INTENT(IN) :: group1
APIArg      ($api, "group1", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(IN) :: group2
APIArg      ($api, "group2", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_range_excl
$api = newAPI("MPI_Group_range_excl");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ranges
APIArgArray ($api, "ranges", IntentIN, TypeInteger, "3,n");
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_range_incl
$api = newAPI("MPI_Group_range_incl");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ranges
APIArgArray ($api, "ranges", IntentIN, TypeInteger, "3,n");
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_rank
$api = newAPI("MPI_Group_rank");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(OUT) :: rank
APIArg      ($api, "rank", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_size
$api = newAPI("MPI_Group_size");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_translate_ranks
$api = newAPI("MPI_Group_translate_ranks");
# TYPE(MPI_Group), INTENT(IN) :: group1
APIArg      ($api, "group1", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ranks1
APIArgArray ($api, "ranks1", IntentIN, TypeInteger, "n");
# TYPE(MPI_Group), INTENT(IN) :: group2
APIArg      ($api, "group2", IntentIN, TypeGroup);
# INTEGER, INTENT(OUT) :: ranks2
APIArgArray ($api, "ranks2", IntentOUT, TypeInteger, "n");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Group_union
$api = newAPI("MPI_Group_union");
# TYPE(MPI_Group), INTENT(IN) :: group1
APIArg      ($api, "group1", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(IN) :: group2
APIArg      ($api, "group2", IntentIN, TypeGroup);
# TYPE(MPI_Group), INTENT(OUT) :: newgroup
APIArg      ($api, "newgroup", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Intercomm_create
$api = newAPI("MPI_Intercomm_create");
# TYPE(MPI_Comm), INTENT(IN) :: local_comm
APIArg      ($api, "local_comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: local_leader
APIArg      ($api, "local_leader", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: peer_comm
APIArg      ($api, "peer_comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: remote_leader
APIArg      ($api, "remote_leader", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: tag
APIArg      ($api, "tag", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(OUT) :: newintercomm
APIArg      ($api, "newintercomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Intercomm_merge
$api = newAPI("MPI_Intercomm_merge");
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: intercomm
APIArg      ($api, "intercomm", IntentIN, TypeComm);
# LOGICAL, INTENT(IN) :: high
APIArg      ($api, "high", IntentIN, TypeLogical);
# TYPE(MPI_Comm), INTENT(OUT) :: newintracomm
APIArg      ($api, "newintracomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_keyval
$api = newAPI("MPI_Type_create_keyval");
# PROCEDURE(MPI_Type_copy_attr_function) :: type_copy_attr_fn
APIArg      ($api, "type_copy_attr_fn", IntentNONE, TypeProcedureCopyAttr);
# PROCEDURE(MPI_Type_delete_attr_function) :: type_delete_attr_fn
APIArg      ($api, "type_delete_attr_fn", IntentNONE, TypeProcedureDeleteAttr);
# INTEGER, INTENT(OUT) :: type_keyval
APIArg      ($api, "type_keyval", IntentOUT, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
APIArg      ($api, "extra_state", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_delete_attr
$api = newAPI("MPI_Type_delete_attr");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: type_keyval
APIArg      ($api, "type_keyval", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_free_keyval
$api = newAPI("MPI_Type_free_keyval");
# INTEGER, INTENT(INOUT) :: type_keyval
APIArg      ($api, "type_keyval", IntentINOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_attr
$api = newAPI("MPI_Type_get_attr");
APIPMPI     ($api);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: type_keyval
APIArg      ($api, "type_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: attribute_val
APIArg      ($api, "attribute_val", IntentOUT, TypeAint);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_get_name
$api = newAPI("MPI_Type_get_name");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# CHARACTER(LEN=MPI_MAX_OBJECT_NAME), INTENT(OUT) :: type_name
APIArg      ($api, "type_name", IntentOUT, TypeCharacter);
APIArgModify($api, "type_name", "LEN=MPI_MAX_OBJECT_NAME");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_set_attr
$api = newAPI("MPI_Type_set_attr");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: type_keyval
APIArg      ($api, "type_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: attribute_val
APIArg      ($api, "attribute_val", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_set_name
$api = newAPI("MPI_Type_set_name");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# CHARACTER(LEN=*), INTENT(IN) :: type_name
APIArg      ($api, "type_name", IntentIN, TypeCharacter);
APIArgModify($api, "type_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_create_keyval
$api = newAPI("MPI_Win_create_keyval");
# PROCEDURE(MPI_Win_copy_attr_function) :: win_copy_attr_fn
APIArg      ($api, "win_copy_attr_fn", IntentNONE, TypeProcedureWinCopyAttr);
# PROCEDURE(MPI_Win_delete_attr_function) :: win_delete_attr_fn
APIArg      ($api, "win_delete_attr_fn", IntentNONE, TypeProcedureWinDeleteAttr);
# INTEGER, INTENT(OUT) :: win_keyval
APIArg      ($api, "win_keyval", IntentOUT, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
APIArg      ($api, "extra_state", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_delete_attr
$api = newAPI("MPI_Win_delete_attr");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, INTENT(IN) :: win_keyval
APIArg      ($api, "win_keyval", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_free_keyval
$api = newAPI("MPI_Win_free_keyval");
# INTEGER, INTENT(INOUT) :: win_keyval
APIArg      ($api, "win_keyval", IntentINOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_get_attr
$api = newAPI("MPI_Win_get_attr");
APIPMPI     ($api);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, INTENT(IN) :: win_keyval
APIArg      ($api, "win_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: attribute_val
APIArg      ($api, "attribute_val", IntentOUT, TypeAint);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_get_name
$api = newAPI("MPI_Win_get_name");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# CHARACTER(LEN=MPI_MAX_OBJECT_NAME), INTENT(OUT) :: win_name
APIArg      ($api, "win_name", IntentOUT, TypeCharacter);
APIArgModify($api, "win_name", "LEN=MPI_MAX_OBJECT_NAME");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_set_attr
$api = newAPI("MPI_Win_set_attr");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, INTENT(IN) :: win_keyval
APIArg      ($api, "win_keyval", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: attribute_val
APIArg      ($api, "attribute_val", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_set_name
$api = newAPI("MPI_Win_set_name");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# CHARACTER(LEN=*), INTENT(IN) :: win_name
APIArg      ($api, "win_name", IntentIN, TypeCharacter);
APIArgModify($api, "win_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_coords
$api = newAPI("MPI_Cart_coords");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: maxdims
APIArg      ($api, "maxdims", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: coords
APIArgArray ($api, "coords", IntentOUT, TypeInteger, "maxdims");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_create
$api = newAPI("MPI_Cart_create");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm_old
APIArg      ($api, "comm_old", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: ndims
APIArg      ($api, "ndims", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: dims
APIArgArray ($api, "dims", IntentIN, TypeInteger, "ndims");
# LOGICAL, INTENT(IN) :: periods
APIArgArray ($api, "periods", IntentIN, TypeLogical, "ndims");
# LOGICAL, INTENT(IN) :: reorder
APIArg      ($api, "reorder", IntentIN, TypeLogical);
# TYPE(MPI_Comm), INTENT(OUT) :: comm_cart
APIArg      ($api, "comm_cart", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_get
$api = newAPI("MPI_Cart_get");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: maxdims
APIArg      ($api, "maxdims", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: dims
APIArgArray ($api, "dims", IntentOUT, TypeInteger, "maxdims");
# LOGICAL, INTENT(OUT) :: periods
APIArgArray ($api, "periods", IntentOUT, TypeLogical, "maxdims");
# INTEGER, INTENT(OUT) :: coords
APIArgArray ($api, "coords", IntentOUT, TypeInteger, "maxdims");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_map
$api = newAPI("MPI_Cart_map");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: ndims
APIArg      ($api, "ndims", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: dims
APIArgArray ($api, "dims", IntentIN, TypeInteger, "ndims");
# LOGICAL, INTENT(IN) :: periods
APIArgArray ($api, "periods", IntentIN, TypeLogical, "ndims");
# INTEGER, INTENT(OUT) :: newrank
APIArg      ($api, "newrank", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_rank
$api = newAPI("MPI_Cart_rank");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: coords
APIArgArray ($api, "coords", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(OUT) :: rank
APIArg      ($api, "rank", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_shift
$api = newAPI("MPI_Cart_shift");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: direction
APIArg      ($api, "direction", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: disp
APIArg      ($api, "disp", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: rank_source
APIArg      ($api, "rank_source", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: rank_dest
APIArg      ($api, "rank_dest", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cart_sub
$api = newAPI("MPI_Cart_sub");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# LOGICAL, INTENT(IN) :: remain_dims
APIArgArray ($api, "remain_dims", IntentIN, TypeLogical, "*");
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Cartdim_get
$api = newAPI("MPI_Cartdim_get");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: ndims
APIArg      ($api, "ndims", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Dims_create
$api = newAPI("MPI_Dims_create");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: nnodes
APIArg      ($api, "nnodes", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: ndims
APIArg      ($api, "ndims", IntentIN, TypeInteger);
# INTEGER, INTENT(INOUT) :: dims
APIArgArray ($api, "dims", IntentINOUT, TypeInteger, "ndims");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Dist_graph_create
$api = newAPI("MPI_Dist_graph_create");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm_old
APIArg      ($api, "comm_old", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: sources
APIArgArray ($api, "sources", IntentIN, TypeInteger, "n");
# INTEGER, INTENT(IN) :: degrees
APIArgArray ($api, "degrees", IntentIN, TypeInteger, "n");
# INTEGER, INTENT(IN) :: destinations
APIArgArray ($api, "destinations", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: weights
APIArgArray ($api, "weights", IntentIN, TypeInteger, "*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# LOGICAL, INTENT(IN) :: reorder
APIArg      ($api, "reorder", IntentIN, TypeLogical);
# TYPE(MPI_Comm), INTENT(OUT) :: comm_dist_graph
APIArg      ($api, "comm_dist_graph", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Dist_graph_create_adjacent
$api = newAPI("MPI_Dist_graph_create_adjacent");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm_old
APIArg      ($api, "comm_old", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: indegree
APIArg      ($api, "indegree", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: sources
APIArgArray ($api, "sources", IntentIN, TypeInteger, "indegree");
# INTEGER, INTENT(IN) :: sourceweights
APIArgArray ($api, "sourceweights", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: outdegree
APIArg      ($api, "outdegree", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: destinations
APIArgArray ($api, "destinations", IntentIN, TypeInteger, "outdegree");
# INTEGER, INTENT(IN) :: destweights
APIArgArray ($api, "destweights", IntentIN, TypeInteger, "*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# LOGICAL, INTENT(IN) :: reorder
APIArg      ($api, "reorder", IntentIN, TypeLogical);
# TYPE(MPI_Comm), INTENT(OUT) :: comm_dist_graph
APIArg      ($api, "comm_dist_graph", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Dist_graph_neighbors
$api = newAPI("MPI_Dist_graph_neighbors");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: maxindegree
APIArg      ($api, "maxindegree", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: sources
APIArgArray ($api, "sources", IntentOUT, TypeInteger, "maxindegree");
# INTEGER :: sourceweights
APIArgArray ($api, "sourceweights", IntentNONE, TypeInteger, "*");
# INTEGER, INTENT(IN) :: maxoutdegree
APIArg      ($api, "maxoutdegree", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: destinations
APIArgArray ($api, "destinations", IntentOUT, TypeInteger, "maxoutdegree");
# INTEGER :: destweights
APIArgArray ($api, "destweights", IntentNONE, TypeInteger, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Dist_graph_neighbors_count
$api = newAPI("MPI_Dist_graph_neighbors_count");
APIAuto     ($api);
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: indegree
APIArg      ($api, "indegree", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: outdegree
APIArg      ($api, "outdegree", IntentOUT, TypeInteger);
# LOGICAL, INTENT(OUT) :: weighted
APIArg      ($api, "weighted", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graph_create
$api = newAPI("MPI_Graph_create");
APIPMPI     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm_old
APIArg      ($api, "comm_old", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: nnodes
APIArg      ($api, "nnodes", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: index
APIArgArray ($api, "index", IntentIN, TypeInteger, "nnodes");
# INTEGER, INTENT(IN) :: edges
APIArgArray ($api, "edges", IntentIN, TypeInteger, "*");
# LOGICAL, INTENT(IN) :: reorder
APIArg      ($api, "reorder", IntentIN, TypeLogical);
# TYPE(MPI_Comm), INTENT(OUT) :: comm_graph
APIArg      ($api, "comm_graph", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graph_get
$api = newAPI("MPI_Graph_get");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: maxindex
APIArg      ($api, "maxindex", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: maxedges
APIArg      ($api, "maxedges", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: index
APIArgArray ($api, "index", IntentOUT, TypeInteger, "maxindex");
# INTEGER, INTENT(OUT) :: edges
APIArgArray ($api, "edges", IntentOUT, TypeInteger, "maxedges");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graph_map
$api = newAPI("MPI_Graph_map");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: nnodes
APIArg      ($api, "nnodes", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: index
APIArgArray ($api, "index", IntentIN, TypeInteger, "nnodes");
# INTEGER, INTENT(IN) :: edges
APIArgArray ($api, "edges", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(OUT) :: newrank
APIArg      ($api, "newrank", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graph_neighbors
$api = newAPI("MPI_Graph_neighbors");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: maxneighbors
APIArg      ($api, "maxneighbors", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: neighbors
APIArgArray ($api, "neighbors", IntentOUT, TypeInteger, "maxneighbors");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graph_neighbors_count
$api = newAPI("MPI_Graph_neighbors_count");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: nneighbors
APIArg      ($api, "nneighbors", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Graphdims_get
$api = newAPI("MPI_Graphdims_get");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: nnodes
APIArg      ($api, "nnodes", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: nedges
APIArg      ($api, "nedges", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ineighbor_allgather
$api = newAPI("MPI_Ineighbor_allgather");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ineighbor_allgatherv
$api = newAPI("MPI_Ineighbor_allgatherv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "displs");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ineighbor_alltoall
$api = newAPI("MPI_Ineighbor_alltoall");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ineighbor_alltoallv
$api = newAPI("MPI_Ineighbor_alltoallv");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sendcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sdispls");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "rdispls");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Ineighbor_alltoallw
$api = newAPI("MPI_Ineighbor_alltoallw");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
APIArgAsync ($api, "sendbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "sendcounts");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN), ASYNCHRONOUS :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeAint, "*");
APIArgAsync ($api, "sdispls");
# TYPE(MPI_Datatype), INTENT(IN), ASYNCHRONOUS :: sendtypes
APIArgArray ($api, "sendtypes", IntentIN, TypeDatatype, "*");
APIArgAsync ($api, "sendtypes");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
APIArgAsync ($api, "recvbuf");
# INTEGER, INTENT(IN), ASYNCHRONOUS :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
APIArgAsync ($api, "recvcounts");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN), ASYNCHRONOUS :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeAint, "*");
APIArgAsync ($api, "rdispls");
# TYPE(MPI_Datatype), INTENT(IN), ASYNCHRONOUS :: recvtypes
APIArgArray ($api, "recvtypes", IntentIN, TypeDatatype, "*");
APIArgAsync ($api, "recvtypes");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Neighbor_allgather
$api = newAPI("MPI_Neighbor_allgather");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Neighbor_allgatherv
$api = newAPI("MPI_Neighbor_allgatherv");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: displs
APIArgArray ($api, "displs", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Neighbor_alltoall
$api = newAPI("MPI_Neighbor_alltoall");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcount
APIArg      ($api, "sendcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcount
APIArg      ($api, "recvcount", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Neighbor_alltoallv
$api = newAPI("MPI_Neighbor_alltoallv");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtype
APIArg      ($api, "sendtype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER, INTENT(IN) :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeInteger, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtype
APIArg      ($api, "recvtype", IntentIN, TypeDatatype);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Neighbor_alltoallw
$api = newAPI("MPI_Neighbor_alltoallw");
# TYPE(*), DIMENSION(..), INTENT(IN) :: sendbuf
APIArg      ($api, "sendbuf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: sendcounts
APIArgArray ($api, "sendcounts", IntentIN, TypeInteger, "*");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: sdispls
APIArgArray ($api, "sdispls", IntentIN, TypeAint, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: sendtypes
APIArgArray ($api, "sendtypes", IntentIN, TypeDatatype, "*");
# TYPE(*), DIMENSION(..) :: recvbuf
APIArg      ($api, "recvbuf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: recvcounts
APIArgArray ($api, "recvcounts", IntentIN, TypeInteger, "*");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: rdispls
APIArgArray ($api, "rdispls", IntentIN, TypeAint, "*");
# TYPE(MPI_Datatype), INTENT(IN) :: recvtypes
APIArgArray ($api, "recvtypes", IntentIN, TypeDatatype, "*");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Topo_test
$api = newAPI("MPI_Topo_test");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(OUT) :: status
APIArg      ($api, "status", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Abort
$api = newAPI("MPI_Abort");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Add_error_class
$api = newAPI("MPI_Add_error_class");
APIAuto     ($api);
# INTEGER, INTENT(OUT) :: errorclass
APIArg      ($api, "errorclass", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Add_error_code
$api = newAPI("MPI_Add_error_code");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: errorclass
APIArg      ($api, "errorclass", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: errorcode
APIArg      ($api, "errorcode", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Add_error_string
$api = newAPI("MPI_Add_error_string");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# CHARACTER(LEN=*), INTENT(IN) :: string
APIArg      ($api, "string", IntentIN, TypeCharacter);
APIArgModify($api, "string", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Alloc_mem
$api = newAPI("MPI_Alloc_mem");
APIAuto     ($api);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeAint);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(C_PTR), INTENT(OUT) :: baseptr
APIArg      ($api, "baseptr", IntentOUT, TypeC);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_call_errhandler
$api = newAPI("MPI_Comm_call_errhandler");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_create_errhandler
$api = newAPI("MPI_Comm_create_errhandler");
# PROCEDURE(MPI_Comm_errhandler_function) :: comm_errhandler_fn
APIArg      ($api, "comm_errhandler_fn", IntentNONE, TypeProcedureCommErrhandler);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_get_errhandler
$api = newAPI("MPI_Comm_get_errhandler");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_set_errhandler
$api = newAPI("MPI_Comm_set_errhandler");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Errhandler), INTENT(IN) :: errhandler
APIArg      ($api, "errhandler", IntentIN, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Errhandler_free
$api = newAPI("MPI_Errhandler_free");
APIAuto     ($api);
# TYPE(MPI_Errhandler), INTENT(INOUT) :: errhandler
APIArg      ($api, "errhandler", IntentINOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Error_class
$api = newAPI("MPI_Error_class");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: errorclass
APIArg      ($api, "errorclass", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Error_string
$api = newAPI("MPI_Error_string");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# CHARACTER(LEN=MPI_MAX_ERROR_STRING), INTENT(OUT) :: string
APIArg      ($api, "string", IntentOUT, TypeCharacter);
APIArgModify($api, "string", "LEN=MPI_MAX_ERROR_STRING");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_call_errhandler
$api = newAPI("MPI_File_call_errhandler");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_create_errhandler
$api = newAPI("MPI_File_create_errhandler");
# PROCEDURE(MPI_File_errhandler_function) :: file_errhandler_fn
APIArg      ($api, "file_errhandler_fn", IntentNONE, TypeFileErrhandler);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_errhandler
$api = newAPI("MPI_File_get_errhandler");
# TYPE(MPI_File), INTENT(IN) :: file
APIArg      ($api, "file", IntentIN, TypeFile);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_set_errhandler
$api = newAPI("MPI_File_set_errhandler");
# TYPE(MPI_File), INTENT(IN) :: file
APIArg      ($api, "file", IntentIN, TypeFile);
# TYPE(MPI_Errhandler), INTENT(IN) :: errhandler
APIArg      ($api, "errhandler", IntentIN, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Finalize
$api = newAPI("MPI_Finalize");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Finalized
$api = newAPI("MPI_Finalized");
APIPMPI     ($api);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Free_mem
$api = newAPI("MPI_Free_mem");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: base
APIArg      ($api, "base", IntentIN, TypeChoice);
APIArgAsync ($api, "base");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_library_version
$api = newAPI("MPI_Get_library_version");
# CHARACTER(LEN=MPI_MAX_LIBRARY_VERSION_STRING), INTENT(OUT) :: version
APIArg      ($api, "version", IntentOUT, TypeCharacter);
APIArgModify($api, "version", "LEN=MPI_MAX_LIBRARY_VERSION_STRING");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_processor_name
$api = newAPI("MPI_Get_processor_name");
# CHARACTER(LEN=MPI_MAX_PROCESSOR_NAME), INTENT(OUT) :: name
APIArg      ($api, "name", IntentOUT, TypeCharacter);
APIArgModify($api, "name", "LEN=MPI_MAX_PROCESSOR_NAME");
# INTEGER, INTENT(OUT) :: resultlen
APIArg      ($api, "resultlen", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_version
$api = newAPI("MPI_Get_version");
# INTEGER, INTENT(OUT) :: version
APIArg      ($api, "version", IntentOUT, TypeInteger);
# INTEGER, INTENT(OUT) :: subversion
APIArg      ($api, "subversion", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Init
$api = newAPI("MPI_Init");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Initialized
$api = newAPI("MPI_Initialized");
APIPMPI     ($api);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_call_errhandler
$api = newAPI("MPI_Win_call_errhandler");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, INTENT(IN) :: errorcode
APIArg      ($api, "errorcode", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_create_errhandler
$api = newAPI("MPI_Win_create_errhandler");
# PROCEDURE(MPI_Win_errhandler_function) :: win_errhandler_fn
APIArg      ($api, "win_errhandler_fn", IntentNONE, TypeProcedureWinErrhandler);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_get_errhandler
$api = newAPI("MPI_Win_get_errhandler");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
APIArg      ($api, "errhandler", IntentOUT, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_set_errhandler
$api = newAPI("MPI_Win_set_errhandler");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Errhandler), INTENT(IN) :: errhandler
APIArg      ($api, "errhandler", IntentIN, TypeErrhandler);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_create
$api = newAPI("MPI_Info_create");
# TYPE(MPI_Info), INTENT(OUT) :: info
APIArg      ($api, "info", IntentOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_delete
$api = newAPI("MPI_Info_delete");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeCharacter);
APIArgModify($api, "key", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_dup
$api = newAPI("MPI_Info_dup");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Info), INTENT(OUT) :: newinfo
APIArg      ($api, "newinfo", IntentOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_free
$api = newAPI("MPI_Info_free");
# TYPE(MPI_Info), INTENT(INOUT) :: info
APIArg      ($api, "info", IntentINOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_get
$api = newAPI("MPI_Info_get");
APIPMPI     ($api);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeCharacter);
APIArgModify($api, "key", "LEN=*");
# INTEGER, INTENT(IN) :: valuelen
APIArg      ($api, "valuelen", IntentIN, TypeInteger);
# CHARACTER(LEN=valuelen), INTENT(OUT) :: value
APIArg      ($api, "value", IntentOUT, TypeCharacter);
APIArgModify($api, "value", "LEN=valuelen");
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_get_nkeys
$api = newAPI("MPI_Info_get_nkeys");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, INTENT(OUT) :: nkeys
APIArg      ($api, "nkeys", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_get_nthkey
$api = newAPI("MPI_Info_get_nthkey");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, INTENT(IN) :: n
APIArg      ($api, "n", IntentIN, TypeInteger);
# CHARACTER(LEN=*), INTENT(OUT) :: key
APIArg      ($api, "key", IntentOUT, TypeCharacter);
APIArgModify($api, "key", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_get_valuelen
$api = newAPI("MPI_Info_get_valuelen");
APIPMPI     ($api);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeCharacter);
APIArgModify($api, "key", "LEN=*");
# INTEGER, INTENT(OUT) :: valuelen
APIArg      ($api, "valuelen", IntentOUT, TypeInteger);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Info_set
$api = newAPI("MPI_Info_set");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: key
APIArg      ($api, "key", IntentIN, TypeCharacter);
APIArgModify($api, "key", "LEN=*");
# CHARACTER(LEN=*), INTENT(IN) :: value
APIArg      ($api, "value", IntentIN, TypeCharacter);
APIArgModify($api, "value", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Close_port
$api = newAPI("MPI_Close_port");
APIAuto     ($api);
# CHARACTER(LEN=*), INTENT(IN) :: port_name
APIArg      ($api, "port_name", IntentIN, TypeCharacter);
APIArgModify($api, "port_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_accept
$api = newAPI("MPI_Comm_accept");
APIAuto     ($api);
# CHARACTER(LEN=*), INTENT(IN) :: port_name
APIArg      ($api, "port_name", IntentIN, TypeCharacter);
APIArgModify($api, "port_name", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_connect
$api = newAPI("MPI_Comm_connect");
APIAuto     ($api);
# CHARACTER(LEN=*), INTENT(IN) :: port_name
APIArg      ($api, "port_name", IntentIN, TypeCharacter);
APIArgModify($api, "port_name", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: newcomm
APIArg      ($api, "newcomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_disconnect
$api = newAPI("MPI_Comm_disconnect");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(INOUT) :: comm
APIArg      ($api, "comm", IntentINOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_get_parent
$api = newAPI("MPI_Comm_get_parent");
APIAuto     ($api);
# TYPE(MPI_Comm), INTENT(OUT) :: parent
APIArg      ($api, "parent", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_join
$api = newAPI("MPI_Comm_join");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: fd
APIArg      ($api, "fd", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(OUT) :: intercomm
APIArg      ($api, "intercomm", IntentOUT, TypeComm);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_spawn
$api = newAPI("MPI_Comm_spawn");
APIAuto     ($api);
# CHARACTER(LEN=*), INTENT(IN) :: command
APIArg      ($api, "command", IntentIN, TypeCharacter);
APIArgModify($api, "command", "LEN=*");
# CHARACTER(LEN=*), INTENT(IN) :: argv
APIArgArray ($api, "argv", IntentIN, TypeCharacter, "*");
APIArgModify($api, "argv", "LEN=*");
# INTEGER, INTENT(IN) :: maxprocs
APIArg      ($api, "maxprocs", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: intercomm
APIArg      ($api, "intercomm", IntentOUT, TypeComm);
# INTEGER :: array_of_errcodes
APIArgArray ($api, "array_of_errcodes", IntentNONE, TypeInteger, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Comm_spawn_multiple
$api = newAPI("MPI_Comm_spawn_multiple");
APIAuto     ($api);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# CHARACTER(LEN=*), INTENT(IN) :: array_of_commands
APIArgArray ($api, "array_of_commands", IntentIN, TypeCharacter, "*");
APIArgModify($api, "array_of_commands", "LEN=*");
# CHARACTER(LEN=*), INTENT(IN) :: array_of_argv
APIArgArray ($api, "array_of_argv", IntentIN, TypeCharacter, "count,*");
APIArgModify($api, "array_of_argv", "LEN=*");
# INTEGER, INTENT(IN) :: array_of_maxprocs
APIArgArray ($api, "array_of_maxprocs", IntentIN, TypeInteger, "*");
# TYPE(MPI_Info), INTENT(IN) :: array_of_info
APIArgArray ($api, "array_of_info", IntentIN, TypeInfo, "*");
# INTEGER, INTENT(IN) :: root
APIArg      ($api, "root", IntentIN, TypeInteger);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Comm), INTENT(OUT) :: intercomm
APIArg      ($api, "intercomm", IntentOUT, TypeComm);
# INTEGER :: array_of_errcodes
APIArgArray ($api, "array_of_errcodes", IntentNONE, TypeInteger, "*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Lookup_name
$api = newAPI("MPI_Lookup_name");
# CHARACTER(LEN=*), INTENT(IN) :: service_name
APIArg      ($api, "service_name", IntentIN, TypeCharacter);
APIArgModify($api, "service_name", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=MPI_MAX_PORT_NAME), INTENT(OUT) :: port_name
APIArg      ($api, "port_name", IntentOUT, TypeCharacter);
APIArgModify($api, "port_name", "LEN=MPI_MAX_PORT_NAME");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Open_port
$api = newAPI("MPI_Open_port");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=MPI_MAX_PORT_NAME), INTENT(OUT) :: port_name
APIArg      ($api, "port_name", IntentOUT, TypeCharacter);
APIArgModify($api, "port_name", "LEN=MPI_MAX_PORT_NAME");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Publish_name
$api = newAPI("MPI_Publish_name");
# CHARACTER(LEN=*), INTENT(IN) :: service_name
APIArg      ($api, "service_name", IntentIN, TypeCharacter);
APIArgModify($api, "service_name", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: port_name
APIArg      ($api, "port_name", IntentIN, TypeCharacter);
APIArgModify($api, "port_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Unpublish_name
$api = newAPI("MPI_Unpublish_name");
# CHARACTER(LEN=*), INTENT(IN) :: service_name
APIArg      ($api, "service_name", IntentIN, TypeCharacter);
APIArgModify($api, "service_name", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# CHARACTER(LEN=*), INTENT(IN) :: port_name
APIArg      ($api, "port_name", IntentIN, TypeCharacter);
APIArgModify($api, "port_name", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Accumulate
$api = newAPI("MPI_Accumulate");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Compare_and_swap
$api = newAPI("MPI_Compare_and_swap");
APIAuto     ($api);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: compare_addr
APIArg      ($api, "compare_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "compare_addr");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: result_addr
APIArg      ($api, "result_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "result_addr");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Fetch_and_op
$api = newAPI("MPI_Fetch_and_op");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: result_addr
APIArg      ($api, "result_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "result_addr");
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get
$api = newAPI("MPI_Get");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Get_accumulate
$api = newAPI("MPI_Get_accumulate");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: result_addr
APIArg      ($api, "result_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "result_addr");
# INTEGER, INTENT(IN) :: result_count
APIArg      ($api, "result_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: result_datatype
APIArg      ($api, "result_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Put
$api = newAPI("MPI_Put");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Raccumulate
$api = newAPI("MPI_Raccumulate");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Rget
$api = newAPI("MPI_Rget");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Rget_accumulate
$api = newAPI("MPI_Rget_accumulate");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: result_addr
APIArg      ($api, "result_addr", IntentNONE, TypeChoice);
APIArgAsync ($api, "result_addr");
# INTEGER, INTENT(IN) :: result_count
APIArg      ($api, "result_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: result_datatype
APIArg      ($api, "result_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Op), INTENT(IN) :: op
APIArg      ($api, "op", IntentIN, TypeOp);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Rput
$api = newAPI("MPI_Rput");
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: origin_addr
APIArg      ($api, "origin_addr", IntentIN, TypeChoice);
APIArgAsync ($api, "origin_addr");
# INTEGER, INTENT(IN) :: origin_count
APIArg      ($api, "origin_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: origin_datatype
APIArg      ($api, "origin_datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: target_rank
APIArg      ($api, "target_rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: target_disp
APIArg      ($api, "target_disp", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: target_count
APIArg      ($api, "target_count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: target_datatype
APIArg      ($api, "target_datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_allocate
$api = newAPI("MPI_Win_allocate");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: disp_unit
APIArg      ($api, "disp_unit", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(C_PTR), INTENT(OUT) :: baseptr
APIArg      ($api, "baseptr", IntentOUT, TypeC);
# TYPE(MPI_Win), INTENT(OUT) :: win
APIArg      ($api, "win", IntentOUT, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_allocate_shared
$api = newAPI("MPI_Win_allocate_shared");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: disp_unit
APIArg      ($api, "disp_unit", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(C_PTR), INTENT(OUT) :: baseptr
APIArg      ($api, "baseptr", IntentOUT, TypeC);
# TYPE(MPI_Win), INTENT(OUT) :: win
APIArg      ($api, "win", IntentOUT, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_attach
$api = newAPI("MPI_Win_attach");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: base
APIArg      ($api, "base", IntentNONE, TypeChoice);
APIArgAsync ($api, "base");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_complete
$api = newAPI("MPI_Win_complete");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_create
$api = newAPI("MPI_Win_create");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: base
APIArg      ($api, "base", IntentNONE, TypeChoice);
APIArgAsync ($api, "base");
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeAint);
# INTEGER, INTENT(IN) :: disp_unit
APIArg      ($api, "disp_unit", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Win), INTENT(OUT) :: win
APIArg      ($api, "win", IntentOUT, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_create_dynamic
$api = newAPI("MPI_Win_create_dynamic");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# TYPE(MPI_Win), INTENT(OUT) :: win
APIArg      ($api, "win", IntentOUT, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_detach
$api = newAPI("MPI_Win_detach");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: base
APIArg      ($api, "base", IntentNONE, TypeChoice);
APIArgAsync ($api, "base");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_fence
$api = newAPI("MPI_Win_fence");
# INTEGER, INTENT(IN) :: assert
APIArg      ($api, "assert", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_flush
$api = newAPI("MPI_Win_flush");
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_flush_all
$api = newAPI("MPI_Win_flush_all");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_flush_local
$api = newAPI("MPI_Win_flush_local");
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_flush_local_all
$api = newAPI("MPI_Win_flush_local_all");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_free
$api = newAPI("MPI_Win_free");
# TYPE(MPI_Win), INTENT(INOUT) :: win
APIArg      ($api, "win", IntentINOUT, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_get_group
$api = newAPI("MPI_Win_get_group");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Group), INTENT(OUT) :: group
APIArg      ($api, "group", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_get_info
$api = newAPI("MPI_Win_get_info");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Info), INTENT(OUT) :: info_used
APIArg      ($api, "info_used", IntentOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_lock
$api = newAPI("MPI_Win_lock");
# INTEGER, INTENT(IN) :: lock_type
APIArg      ($api, "lock_type", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: assert
APIArg      ($api, "assert", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_lock_all
$api = newAPI("MPI_Win_lock_all");
# INTEGER, INTENT(IN) :: assert
APIArg      ($api, "assert", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_post
$api = newAPI("MPI_Win_post");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: assert
APIArg      ($api, "assert", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_set_info
$api = newAPI("MPI_Win_set_info");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_shared_query
$api = newAPI("MPI_Win_shared_query");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeAint);
# INTEGER, INTENT(OUT) :: disp_unit
APIArg      ($api, "disp_unit", IntentOUT, TypeInteger);
# TYPE(C_PTR), INTENT(OUT) :: baseptr
APIArg      ($api, "baseptr", IntentOUT, TypeC);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_start
$api = newAPI("MPI_Win_start");
# TYPE(MPI_Group), INTENT(IN) :: group
APIArg      ($api, "group", IntentIN, TypeGroup);
# INTEGER, INTENT(IN) :: assert
APIArg      ($api, "assert", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_sync
$api = newAPI("MPI_Win_sync");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_test
$api = newAPI("MPI_Win_test");
APIPMPI     ($api);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_unlock
$api = newAPI("MPI_Win_unlock");
# INTEGER, INTENT(IN) :: rank
APIArg      ($api, "rank", IntentIN, TypeInteger);
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_unlock_all
$api = newAPI("MPI_Win_unlock_all");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Win_wait
$api = newAPI("MPI_Win_wait");
# TYPE(MPI_Win), INTENT(IN) :: win
APIArg      ($api, "win", IntentIN, TypeWin);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Grequest_complete
$api = newAPI("MPI_Grequest_complete");
# TYPE(MPI_Request), INTENT(IN) :: request
APIArg      ($api, "request", IntentIN, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Grequest_start
$api = newAPI("MPI_Grequest_start");
# PROCEDURE(MPI_Grequest_query_function) :: query_fn
APIArg      ($api, "query_fn", IntentNONE, TypeProcedureGrequestQuery);
# PROCEDURE(MPI_Grequest_free_function) :: free_fn
APIArg      ($api, "free_fn", IntentNONE, TypeProcedureGrequestFree);
# PROCEDURE(MPI_Grequest_cancel_function) :: cancel_fn
APIArg      ($api, "cancel_fn", IntentNONE, TypeProcedureGrequestCancel);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
APIArg      ($api, "extra_state", IntentIN, TypeAint);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Init_thread
$api = newAPI("MPI_Init_thread");
# INTEGER, INTENT(IN) :: required
APIArg      ($api, "required", IntentIN, TypeInteger);
# INTEGER, INTENT(OUT) :: provided
APIArg      ($api, "provided", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Is_thread_main
$api = newAPI("MPI_Is_thread_main");
APIPMPI     ($api);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Query_thread
$api = newAPI("MPI_Query_thread");
# INTEGER, INTENT(OUT) :: provided
APIArg      ($api, "provided", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Status_set_cancelled
$api = newAPI("MPI_Status_set_cancelled");
APIPMPI     ($api);
# TYPE(MPI_Status), INTENT(INOUT) :: status
APIArg      ($api, "status", IntentINOUT, TypeStatus);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Status_set_elements
$api = newAPI("MPI_Status_set_elements");
# TYPE(MPI_Status), INTENT(INOUT) :: status
APIArg      ($api, "status", IntentINOUT, TypeStatus);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Status_set_elements_x
$api = newAPI("MPI_Status_set_elements_x");
# TYPE(MPI_Status), INTENT(INOUT) :: status
APIArg      ($api, "status", IntentINOUT, TypeStatus);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_COUNT_KIND), INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeCount);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_close
$api = newAPI("MPI_File_close");
# TYPE(MPI_File), INTENT(INOUT) :: fh
APIArg      ($api, "fh", IntentINOUT, TypeFile);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_delete
$api = newAPI("MPI_File_delete");
# CHARACTER(LEN=*), INTENT(IN) :: filename
APIArg      ($api, "filename", IntentIN, TypeCharacter);
APIArgModify($api, "filename", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_amode
$api = newAPI("MPI_File_get_amode");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER, INTENT(OUT) :: amode
APIArg      ($api, "amode", IntentOUT, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_atomicity
$api = newAPI("MPI_File_get_atomicity");
APIPMPI     ($api);
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# LOGICAL, INTENT(OUT) :: flag
APIArg      ($api, "flag", IntentOUT, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_byte_offset
$api = newAPI("MPI_File_get_byte_offset");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(OUT) :: disp
APIArg      ($api, "disp", IntentOUT, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_group
$api = newAPI("MPI_File_get_group");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(MPI_Group), INTENT(OUT) :: group
APIArg      ($api, "group", IntentOUT, TypeGroup);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_info
$api = newAPI("MPI_File_get_info");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(MPI_Info), INTENT(OUT) :: info_used
APIArg      ($api, "info_used", IntentOUT, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_position
$api = newAPI("MPI_File_get_position");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(OUT) :: offset
APIArg      ($api, "offset", IntentOUT, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_position_shared
$api = newAPI("MPI_File_get_position_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(OUT) :: offset
APIArg      ($api, "offset", IntentOUT, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_size
$api = newAPI("MPI_File_get_size");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(OUT) :: size
APIArg      ($api, "size", IntentOUT, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_type_extent
$api = newAPI("MPI_File_get_type_extent");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(OUT) :: extent
APIArg      ($api, "extent", IntentOUT, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_get_view
$api = newAPI("MPI_File_get_view");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(OUT) :: disp
APIArg      ($api, "disp", IntentOUT, TypeOffset);
# TYPE(MPI_Datatype), INTENT(OUT) :: etype
APIArg      ($api, "etype", IntentOUT, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(OUT) :: filetype
APIArg      ($api, "filetype", IntentOUT, TypeDatatype);
# CHARACTER(LEN=*), INTENT(OUT) :: datarep
APIArg      ($api, "datarep", IntentOUT, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iread
$api = newAPI("MPI_File_iread");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iread_at
$api = newAPI("MPI_File_iread_at");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iread_shared
$api = newAPI("MPI_File_iread_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iwrite
$api = newAPI("MPI_File_iwrite");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iwrite_at
$api = newAPI("MPI_File_iwrite_at");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_iwrite_shared
$api = newAPI("MPI_File_iwrite_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Request), INTENT(OUT) :: request
APIArg      ($api, "request", IntentOUT, TypeRequest);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_open
$api = newAPI("MPI_File_open");
# TYPE(MPI_Comm), INTENT(IN) :: comm
APIArg      ($api, "comm", IntentIN, TypeComm);
# CHARACTER(LEN=*), INTENT(IN) :: filename
APIArg      ($api, "filename", IntentIN, TypeCharacter);
APIArgModify($api, "filename", "LEN=*");
# INTEGER, INTENT(IN) :: amode
APIArg      ($api, "amode", IntentIN, TypeInteger);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# TYPE(MPI_File), INTENT(OUT) :: fh
APIArg      ($api, "fh", IntentOUT, TypeFile);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_preallocate
$api = newAPI("MPI_File_preallocate");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read
$api = newAPI("MPI_File_read");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_all
$api = newAPI("MPI_File_read_all");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_all_begin
$api = newAPI("MPI_File_read_all_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_all_end
$api = newAPI("MPI_File_read_all_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_at
$api = newAPI("MPI_File_read_at");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_at_all
$api = newAPI("MPI_File_read_at_all");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_at_all_begin
$api = newAPI("MPI_File_read_at_all_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_at_all_end
$api = newAPI("MPI_File_read_at_all_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_ordered
$api = newAPI("MPI_File_read_ordered");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_ordered_begin
$api = newAPI("MPI_File_read_ordered_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_ordered_end
$api = newAPI("MPI_File_read_ordered_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_read_shared
$api = newAPI("MPI_File_read_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..) :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_seek
$api = newAPI("MPI_File_seek");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# INTEGER, INTENT(IN) :: whence
APIArg      ($api, "whence", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_seek_shared
$api = newAPI("MPI_File_seek_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# INTEGER, INTENT(IN) :: whence
APIArg      ($api, "whence", IntentIN, TypeInteger);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_set_atomicity
$api = newAPI("MPI_File_set_atomicity");
APIPMPI     ($api);
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# LOGICAL, INTENT(IN) :: flag
APIArg      ($api, "flag", IntentIN, TypeLogical);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_set_info
$api = newAPI("MPI_File_set_info");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_set_size
$api = newAPI("MPI_File_set_size");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeOffset);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_set_view
$api = newAPI("MPI_File_set_view");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: disp
APIArg      ($api, "disp", IntentIN, TypeOffset);
# TYPE(MPI_Datatype), INTENT(IN) :: etype
APIArg      ($api, "etype", IntentIN, TypeDatatype);
# TYPE(MPI_Datatype), INTENT(IN) :: filetype
APIArg      ($api, "filetype", IntentIN, TypeDatatype);
# CHARACTER(LEN=*), INTENT(IN) :: datarep
APIArg      ($api, "datarep", IntentIN, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# TYPE(MPI_Info), INTENT(IN) :: info
APIArg      ($api, "info", IntentIN, TypeInfo);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_sync
$api = newAPI("MPI_File_sync");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write
$api = newAPI("MPI_File_write");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_all
$api = newAPI("MPI_File_write_all");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_all_begin
$api = newAPI("MPI_File_write_all_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_all_end
$api = newAPI("MPI_File_write_all_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_at
$api = newAPI("MPI_File_write_at");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_at_all
$api = newAPI("MPI_File_write_at_all");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_at_all_begin
$api = newAPI("MPI_File_write_at_all_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
APIArg      ($api, "offset", IntentIN, TypeOffset);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_at_all_end
$api = newAPI("MPI_File_write_at_all_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_ordered
$api = newAPI("MPI_File_write_ordered");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_ordered_begin
$api = newAPI("MPI_File_write_ordered_begin");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_ordered_end
$api = newAPI("MPI_File_write_ordered_end");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
APIArgAsync ($api, "buf");
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_File_write_shared
$api = newAPI("MPI_File_write_shared");
# TYPE(MPI_File), INTENT(IN) :: fh
APIArg      ($api, "fh", IntentIN, TypeFile);
# TYPE(*), DIMENSION(..), INTENT(IN) :: buf
APIArg      ($api, "buf", IntentIN, TypeChoice);
# INTEGER, INTENT(IN) :: count
APIArg      ($api, "count", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(IN) :: datatype
APIArg      ($api, "datatype", IntentIN, TypeDatatype);
# TYPE(MPI_Status) :: status
APIArg      ($api, "status", IntentNONE, TypeStatus);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Register_datarep
$api = newAPI("MPI_Register_datarep");
# CHARACTER(LEN=*), INTENT(IN) :: datarep
APIArg      ($api, "datarep", IntentIN, TypeCharacter);
APIArgModify($api, "datarep", "LEN=*");
# PROCEDURE(MPI_Datarep_conversion_function) :: read_conversion_fn
APIArg      ($api, "read_conversion_fn", IntentNONE, TypeProcedureDatarepConversion);
# PROCEDURE(MPI_Datarep_conversion_function) :: write_conversion_fn
APIArg      ($api, "write_conversion_fn", IntentNONE, TypeProcedureDatarepConversion);
# PROCEDURE(MPI_Datarep_extent_function) :: dtype_file_extent_fn
APIArg      ($api, "dtype_file_extent_fn", IntentNONE, TypeProcedure);
# INTEGER(KIND=MPI_ADDRESS_KIND), INTENT(IN) :: extra_state
APIArg      ($api, "extra_state", IntentIN, TypeAint);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_F_sync_reg
$api = newAPI("MPI_F_sync_reg");
# TYPE(*), DIMENSION(..), ASYNCHRONOUS :: buf
APIArg      ($api, "buf", IntentNONE, TypeChoice);
APIArgAsync ($api, "buf");
#----------------------------------------------------------------------------
# MPI_Type_create_f90_complex
$api = newAPI("MPI_Type_create_f90_complex");
# INTEGER, INTENT(IN) :: p
APIArg      ($api, "p", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: r
APIArg      ($api, "r", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_f90_integer
$api = newAPI("MPI_Type_create_f90_integer");
# INTEGER, INTENT(IN) :: r
APIArg      ($api, "r", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_create_f90_real
$api = newAPI("MPI_Type_create_f90_real");
# INTEGER, INTENT(IN) :: p
APIArg      ($api, "p", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: r
APIArg      ($api, "r", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(OUT) :: newtype
APIArg      ($api, "newtype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Type_match_size
$api = newAPI("MPI_Type_match_size");
# INTEGER, INTENT(IN) :: typeclass
APIArg      ($api, "typeclass", IntentIN, TypeInteger);
# INTEGER, INTENT(IN) :: size
APIArg      ($api, "size", IntentIN, TypeInteger);
# TYPE(MPI_Datatype), INTENT(OUT) :: datatype
APIArg      ($api, "datatype", IntentOUT, TypeDatatype);
# INTEGER, OPTIONAL, INTENT(OUT) :: ierror
APIArg      ($api, "ierror", IntentOUT, TypeInteger);
#----------------------------------------------------------------------------
# MPI_Pcontrol
$api = newAPI("MPI_Pcontrol");
# INTEGER, INTENT(IN) :: level
APIArg      ($api, "level", IntentIN, TypeInteger);
