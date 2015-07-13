#!/bin/sh

VERBOSE=/bin/false

read prototype
params=$(echo ${prototype} | cut -d\( -f2 | cut -d\) -f1 | sed 's/,/ /g')
rm -rf /tmp/f08.tmp
while read line ; do
    if echo $line | grep -qv ^MPI_; then
        echo ${line} >> /tmp/f08.tmp
    else
        $VERBOSE && echo dealing with $prototype
        subroutine=$(echo $prototype | cut -d'(' -f1 | sed -e 's/ $//g')
        echo "#----------------------------------------------------------------------------"
        echo "# $subroutine"
        echo '$api = newAPI("'$subroutine'");'
        file=$(echo $subroutine | sed -e 's/^MPI_//g' | tr '[A-Z]' '[a-z]')_f08.F90
        if grep -q "^$file\$" auto.txt; then
            echo 'APIAuto     ($api);'
        fi
        file=../../mpi/fortran/use-mpi-f08/$file
        if grep -q PMPI $file ; then
            echo 'APIPMPI     ($api);'
        fi
        for p in $params; do
           found=false
           while read l; do
              type=$(echo ${l} | cut -d: -f1)
              ps=$(echo ${l} | cut -d: -f3 | sed 's/,/ /g')
              pre=""
              for _p in $ps; do
                 if [ -z "$pre" ]; then
                     if echo $_p | grep '(' | grep -q -v ')'; then
                         pre="$_p,"
                         continue
                     fi
                 elif echo $_p | grep -q ')'; then
                         _p="$pre$_p"
                         pre=""
                 else
                     $pre="$pre$p,"
                     continue
                 fi
                 if [ "X$p" = "X$(echo $_p | cut -d\( -f1)" ]; then
                     if echo $type | grep -q '^TYPE(C_PTR)'; then
                         typ=TypeC
                     elif echo $type | grep -q '^TYPE(\*), DIMENSION(..)'; then
                         typ=TypeChoice
                     elif echo $type | grep -q '^CHARACTER'; then
                         typ=TypeCharacter
                     elif echo $type | grep -q '^TYPE(MPI_Comm)'; then
                         typ=TypeComm
                     elif echo $type | grep -q '^TYPE(MPI_Datatype)'; then
                         typ=TypeDatatype
                     elif echo $type | grep -q '^TYPE(MPI_Errhandler)'; then
                         typ=TypeErrhandler
                     elif echo $type | grep -q '^TYPE(MPI_File)'; then
                         typ=TypeFile
                     elif echo $type | grep -q '^TYPE(MPI_Group)'; then
                         typ=TypeGroup
                     elif echo $type | grep -q '^TYPE(MPI_Info)'; then
                         typ=TypeInfo
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_ADDRESS_KIND)'; then
                         typ=TypeAint
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_COUNT_KIND)'; then
                         typ=TypeCount
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_OFFSET_KIND)'; then
                         typ=TypeOffset
                     elif echo $type | grep -q '^INTEGER'; then
                         typ=TypeInteger
                     elif echo $type | grep -q '^LOGICAL'; then
                         typ=TypeLogical
                     elif echo $type | grep -q '^TYPE(MPI_Message)'; then
                         typ=TypeMessage
                     elif echo $type | grep -q '^TYPE(MPI_Op)'; then
                         typ=TypeOp
                     elif echo $type | grep -q '^TYPE(MPI_Request)'; then
                         typ=TypeRequest
                     elif echo $type | grep -q '^TYPE(MPI_Status)'; then
                         typ=TypeStatus
                     elif echo $type | grep -q '^TYPE(MPI_Win)'; then
                         typ=TypeWin
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_copy_attr_function)'; then
                         typ=TypeProcedureCommCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_delete_attr_function)'; then
                         typ=TypeProcedureCommDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_errhandler_function)'; then
                         typ=TypeProcedureCommErrhandler
                     elif echo $type | grep -q '^PROCEDURE(MPI_Datarep_conversion_function)'; then
                         typ=TypeProcedureDatarepConversion
                     elif echo $type | grep -q '^PROCEDURE(MPI_Datarep_extent_function)'; then
                         typ=TypeProcedure
                     elif echo $type | grep -q '^PROCEDURE(MPI_File_errhandler_function)'; then
                         typ=TypeFileErrhandler
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_cancel_function)'; then
                         typ=TypeProcedureGrequestCancel
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_free_function)'; then
                         typ=TypeProcedureGrequestFree
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_query_function)'; then
                         typ=TypeProcedureGrequestQuery
                     elif echo $type | grep -q '^PROCEDURE(MPI_Type_copy_attr_function)'; then
                         typ=TypeProcedureCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Type_delete_attr_function)'; then
                         typ=TypeProcedureDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_User_function)'; then
                         typ=TypeProcedureUserFunction
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_copy_attr_function)'; then
                         typ=TypeProcedureWinCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_delete_attr_function)'; then
                         typ=TypeProcedureWinDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_errhandler_function)'; then
                         typ=TypeProcedureWinErrhandler
                     else
                         echo error processing $prototype: unknown type $type
                         exit 1
                     fi
                     
                     if echo $type | grep -q 'INTENT(IN)' ; then
                         intent=IntentIN
                     elif echo $type | grep -q 'INTENT(OUT)'; then
                         intent=IntentOUT
                     elif echo $type | grep -q 'INTENT(INOUT)'; then
                         intent=IntentINOUT
                     else
                         intent=IntentNONE
                     fi

                     asynchronous=no
                     if echo $type | grep -q ASYNCHRONOUS; then
                         asynchronous=yes
                     fi
                     echo '# '$type :: $p
                     found=true

                     array=no
                     if [ "X$p" != "X$_p" ]; then
                         array=$(echo $_p | cut -d\( -f2 | cut -d\) -f1)
                     fi
                     modify=no
                     if echo $type | grep -q '^CHARACTER(' ; then
                         modify=$(echo $type | cut -d\( -f2 | cut -d\) -f1)
                     fi
                     if [ X$array = Xno ]; then
                         echo 'APIArg      ($api, "'$p'", '$intent, $typ');'
                     else
                         echo 'APIArgArray ($api, "'$p'", '$intent, $typ, \"$array'");'
                     fi
                     if [ X$asynchronous = Xyes ]; then
                         echo 'APIArgAsync ($api, "'$p'");'
                     fi
                     if [ X$modify != Xno ]; then
                         echo 'APIArgModify($api, "'$p'", "'$modify'");'
                     fi
                 fi
              done
           done < /tmp/f08.tmp
           if [ X$found = Xfalse ]; then
               echo BUG with $prototype: could not find $p
               exit 1
           fi
        done
        prototype=${line}
        params=$(echo ${prototype} | cut -d\( -f2 | cut -d\) -f1 | sed 's/,/ /g')
        rm -rf /tmp/f08.tmp
    fi
done
        $VERBOSE && echo dealing with $prototype
        subroutine=$(echo $prototype | cut -d'(' -f1 | sed -e 's/ $//g')
        echo "#----------------------------------------------------------------------------"
        echo "# $subroutine"
        echo '$api = newAPI("'$subroutine'");'
        file=$(echo $subroutine | sed -e 's/^MPI_//g' | tr '[A-Z]' '[a-z]')_f08.F90
        if grep -q "^$file\$" auto.txt; then
            echo 'APIAuto     ($api);'
        fi
        file=../../mpi/fortran/use-mpi-f08/$file
        if grep -q PMPI $file ; then
            echo 'APIPMPI     ($api);'
        fi
        for p in $params; do
           found=false
           while read l; do
              type=$(echo ${l} | cut -d: -f1)
              ps=$(echo ${l} | cut -d: -f3 | sed 's/,/ /g')
              pre=""
              for _p in $ps; do
                 if [ -z "$pre" ]; then
                     if echo $_p | grep '(' | grep -q -v ')'; then
                         pre="$_p,"
                         continue
                     fi
                 elif echo $_p | grep -q ')'; then
                         _p="$pre$_p"
                         pre=""
                 else
                     $pre="$pre$p,"
                     continue
                 fi
                 if [ "X$p" = "X$(echo $_p | cut -d\( -f1)" ]; then
                     if echo $type | grep -q '^TYPE(C_PTR)'; then
                         typ=TypeC
                     elif echo $type | grep -q '^TYPE(\*), DIMENSION(..)'; then
                         typ=TypeChoice
                     elif echo $type | grep -q '^CHARACTER'; then
                         typ=TypeCharacter
                     elif echo $type | grep -q '^TYPE(MPI_Comm)'; then
                         typ=TypeComm
                     elif echo $type | grep -q '^TYPE(MPI_Datatype)'; then
                         typ=TypeDatatype
                     elif echo $type | grep -q '^TYPE(MPI_Errhandler)'; then
                         typ=TypeErrhandler
                     elif echo $type | grep -q '^TYPE(MPI_File)'; then
                         typ=TypeFile
                     elif echo $type | grep -q '^TYPE(MPI_Group)'; then
                         typ=TypeGroup
                     elif echo $type | grep -q '^TYPE(MPI_Info)'; then
                         typ=TypeInfo
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_ADDRESS_KIND)'; then
                         typ=TypeAint
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_COUNT_KIND)'; then
                         typ=TypeCount
                     elif echo $type | grep -q '^INTEGER(KIND=MPI_OFFSET_KIND)'; then
                         typ=TypeOffset
                     elif echo $type | grep -q '^INTEGER'; then
                         typ=TypeInteger
                     elif echo $type | grep -q '^LOGICAL'; then
                         typ=TypeLogical
                     elif echo $type | grep -q '^TYPE(MPI_Message)'; then
                         typ=TypeMessage
                     elif echo $type | grep -q '^TYPE(MPI_Op)'; then
                         typ=TypeOp
                     elif echo $type | grep -q '^TYPE(MPI_Request)'; then
                         typ=TypeRequest
                     elif echo $type | grep -q '^TYPE(MPI_Status)'; then
                         typ=TypeStatus
                     elif echo $type | grep -q '^TYPE(MPI_Win)'; then
                         typ=TypeWin
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_copy_attr_function)'; then
                         typ=TypeProcedureCommCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_delete_attr_function)'; then
                         typ=TypeProcedureCommDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Comm_errhandler_function)'; then
                         typ=TypeProcedureCommErrhandler
                     elif echo $type | grep -q '^PROCEDURE(MPI_Datarep_conversion_function)'; then
                         typ=TypeProcedureDatarepConversion
                     elif echo $type | grep -q '^PROCEDURE(MPI_Datarep_extent_function)'; then
                         typ=TypeProcedure
                     elif echo $type | grep -q '^PROCEDURE(MPI_File_errhandler_function)'; then
                         typ=TypeFileErrhandler
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_cancel_function)'; then
                         typ=TypeProcedureGrequestCancel
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_free_function)'; then
                         typ=TypeProcedureGrequestFree
                     elif echo $type | grep -q '^PROCEDURE(MPI_Grequest_query_function)'; then
                         typ=TypeProcedureGrequestQuery
                     elif echo $type | grep -q '^PROCEDURE(MPI_Type_copy_attr_function)'; then
                         typ=TypeProcedureCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Type_delete_attr_function)'; then
                         typ=TypeProcedureDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_User_function)'; then
                         typ=TypeProcedureUserFunction
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_copy_attr_function)'; then
                         typ=TypeProcedureWinCopyAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_delete_attr_function)'; then
                         typ=TypeProcedureWinDeleteAttr
                     elif echo $type | grep -q '^PROCEDURE(MPI_Win_errhandler_function)'; then
                         typ=TypeProcedureWinErrhandler
                     else
                         echo error processing $prototype: unknown type $type
                         exit 1
                     fi
                     
                     if echo $type | grep -q 'INTENT(IN)' ; then
                         intent=IntentIN
                     elif echo $type | grep -q 'INTENT(OUT)'; then
                         intent=IntentOUT
                     elif echo $type | grep -q 'INTENT(INOUT)'; then
                         intent=IntentINOUT
                     else
                         intent=IntentNONE
                     fi

                     asynchronous=no
                     if echo $type | grep -q ASYNCHRONOUS; then
                         asynchronous=yes
                     fi
                     echo '# '$type :: $p
                     found=true

                     array=no
                     if [ "X$p" != "X$_p" ]; then
                         array=$(echo $_p | cut -d\( -f2 | cut -d\) -f1)
                     fi
                     modify=no
                     if echo $type | grep -q '^CHARACTER(' ; then
                         modify=$(echo $type | cut -d\( -f2 | cut -d\) -f1)
                     fi
                     if [ X$array = Xno ]; then
                         echo 'APIArg      ($api, "'$p'", '$intent, $typ');'
                     else
                         echo 'APIArgArray ($api, "'$p'", '$intent, $typ, \"$array'");'
                     fi
                     if [ X$asynchronous = Xyes ]; then
                         echo 'APIArgAsync ($api, "'$p'");'
                     fi
                     if [ X$modify != Xno ]; then
                         echo 'APIArgModify($api, "'$p'", "'$modify'");'
                     fi
                 fi
              done
           done < /tmp/f08.tmp
           if [ X$found = Xfalse ]; then
               echo BUG with $prototype: could not find $p
               exit 1
           fi
        done
        prototype=${line}
        params=$(echo ${prototype} | cut -d\( -f2 | cut -d\) -f1 | sed 's/,/ /g')
        rm -rf /tmp/f08.tmp
