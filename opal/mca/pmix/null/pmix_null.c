/* -*- Mode: C; c-basic-offset:4 ; indent-tabs-mode:nil -*- */
/*
 * Copyright (c) 2014      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include "opal_config.h"
#include "opal/constants.h"
#include "opal/types.h"

#include "opal_stdint.h"
#include "opal/mca/base/mca_base_var.h"
#include "opal/mca/hwloc/base/base.h"
#include "opal/util/opal_environ.h"
#include "opal/util/output.h"
#include "opal/util/proc.h"
#include "opal/util/show_help.h"

#include <string.h>

#include "opal/mca/pmix/base/base.h"
#include "pmix_null.h"

static int null_init(void);
static int null_fini(void);
static bool null_initialized(void);
static int null_abort(int flag, const char msg[]);
static int null_fence(opal_process_name_t *procs, size_t nprocs);
static int null_put(opal_pmix_scope_t scope,
                  opal_value_t *kv);
static int null_get(const opal_process_name_t *id,
                  const char *key,
                  opal_value_t **kv);
static int null_publish(const char service_name[],
                      opal_list_t *info,
                      const char port[]);
static int null_lookup(const char service_name[],
                     opal_list_t *info,
                     char port[], int portLen);
static int null_unpublish(const char service_name[],
                        opal_list_t *info);
static bool null_get_attr(const char *attr, opal_value_t **kv);
static int null_spawn(int count, const char * cmds[],
                    int argcs[], const char ** argvs[],
                    const int maxprocs[],
                    opal_list_t *info_keyval_vector,
                    opal_list_t *preput_keyval_vector,
                    char jobId[], int jobIdSize,
                    int errors[]);
static int null_job_connect(const char jobId[]);
static int null_job_disconnect(const char jobId[]);

const opal_pmix_base_module_t opal_pmix_null_module = {
    null_init,
    null_fini,
    null_initialized,
    null_abort,
    null_fence,
    NULL,
    null_put,
    null_get,
    NULL,
    null_publish,
    null_lookup,
    null_unpublish,
    null_get_attr,
    NULL,
    null_spawn,
    null_job_connect,
    null_job_disconnect,
    NULL,
    NULL
};

// usage accounting
static int pmix_init_count = 0;

// PMI constant values:

// Job environment description
static uint32_t null_jobid;
static int null_rank;
static uint16_t null_lrank;
static uint16_t null_nrank;
static int null_usize;
static int null_jsize;
static int null_appnum;
static int null_nlranks;
static int *null_lranks=NULL;
static opal_process_name_t null_pname;

static int null_init(void)
{
    int ret = OPAL_ERROR;
    uint32_t jobfam, stepid;
    opal_value_t kv;

    if (0 < pmix_init_count) {
        return OPAL_SUCCESS;
    }

    jobfam = getpid();
    stepid = 0;

    /* now build the jobid */
    null_jobid = (jobfam << 16) | stepid;

    /* get our rank */
    null_rank = 0;
    /* store our name in the opal_proc_t so that
     * debug messages will make sense - an upper
     * layer will eventually overwrite it, but that
     * won't do any harm */
    null_pname.jobid = null_jobid;
    null_pname.vpid = null_rank;
    opal_proc_set_name(&null_pname);
    opal_output_verbose(2, opal_pmix_base_framework.framework_output,
                        "%s pmix:null: assigned tmp name",
                        OPAL_NAME_PRINT(null_pname));

    /* get our local proc info to find our local rank */
    null_nlranks = 1;

    /* now get the specific ranks */
    null_lranks = &null_rank;

    /* get universe size */
    null_usize = 1;

    /* push this into the dstore for subsequent fetches */
    OBJ_CONSTRUCT(&kv, opal_value_t);
    kv.key = strdup(OPAL_DSTORE_UNIV_SIZE);
    kv.type = OPAL_UINT32;
    kv.data.uint32 = null_usize;
    if (OPAL_SUCCESS != (ret = opal_dstore.store(opal_dstore_internal, &OPAL_PROC_MY_NAME, &kv))) {
        OPAL_ERROR_LOG(ret);
        OBJ_DESTRUCT(&kv);
        goto err_exit;
    }
    OBJ_DESTRUCT(&kv);

    /* get job size */
    null_jsize = 1;

    /* get appnum */
    null_appnum = 0;

    /* setup any local envars we were asked to do */
    mca_base_var_process_env_list(&environ);

    pmix_init_count ++;
    return OPAL_SUCCESS;

 err_exit:
    return ret;
}

static int null_fini(void) {
    return OPAL_SUCCESS;
}

static bool null_initialized(void)
{
    if (0 < pmix_init_count) {
        return true;
    }
    return false;
}

static int null_abort(int flag, const char msg[])
{
    return true;
}

static int null_spawn(int count, const char * cmds[],
                    int argcs[], const char ** argvs[],
                    const int maxprocs[],
                    opal_list_t *info_keyval_vector,
                    opal_list_t *preput_keyval_vector,
                    char jobId[], int jobIdSize,
                    int errors[])
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static int null_put(opal_pmix_scope_t scope,
                  opal_value_t *kv)
{
    return OPAL_SUCCESS;
}

static int null_fence(opal_process_name_t *procs, size_t nprocs)
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static int null_get(const opal_process_name_t *id,
                  const char *key,
                  opal_value_t **kv)
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static int null_publish(const char service_name[],
                      opal_list_t *info,
                      const char port[])
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static int null_lookup(const char service_name[],
                     opal_list_t *info,
                     char port[], int portLen)
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static int null_unpublish(const char service_name[],
                        opal_list_t *info)
{
    return OPAL_ERR_NOT_IMPLEMENTED;
}

static bool null_get_attr(const char *attr, opal_value_t **kv)
{
    opal_value_t *kp;

    if (0 == strcmp(PMIX_JOBID, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_jobid;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_RANK, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_rank;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_UNIV_SIZE, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_usize;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_JOB_SIZE, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_jsize;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_LOCAL_SIZE, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_nlranks;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_APPNUM, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_appnum;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_LOCAL_RANK, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_lrank;
        *kv = kp;
        return true;
    }

    if (0 == strcmp(PMIX_NODE_RANK, attr)) {
        kp = OBJ_NEW(opal_value_t);
        kp->key = strdup(attr);
        kp->type = OPAL_UINT32;
        kp->data.uint32 = null_nrank;
        *kv = kp;
        return true;
    }

    return false;
}

static int null_job_connect(const char jobId[])
{
    return OPAL_ERR_NOT_SUPPORTED;
}

static int null_job_disconnect(const char jobId[])
{
    return OPAL_ERR_NOT_SUPPORTED;
}
