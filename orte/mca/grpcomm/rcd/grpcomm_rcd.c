/* -*- Mode: C; c-basic-offset:4 ; -*- */
/*
 * Copyright (c) 2007      The Trustees of Indiana University.
 *                         All rights reserved.
 * Copyright (c) 2011      Cisco Systems, Inc.  All rights reserved.
 * Copyright (c) 2011-2013 Los Alamos National Security, LLC. All
 *                         rights reserved.
 * Copyright (c) 2014      Intel, Inc.  All rights reserved.
 * Copyright (c) 2014      Research Organization for Information Science
 *                         and Technology (RIST). All rights reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

#include "orte_config.h"
#include "orte/constants.h"
#include "orte/types.h"
#include "orte/runtime/orte_wait.h"

#include <string.h>
#include <poll.h>

#include "opal/dss/dss.h"

#include "orte/mca/errmgr/errmgr.h"
#include "orte/mca/rml/rml.h"
#include "orte/util/name_fns.h"
#include "orte/util/proc_info.h"

#include "orte/mca/grpcomm/base/base.h"
#include "grpcomm_rcd.h"


/* Static API's */
static int init(void);
static void finalize(void);
static int xcast(orte_vpid_t *vpids,
                 size_t nprocs,
                 opal_buffer_t *msg);
static int allgather(orte_grpcomm_coll_t *coll,
                     opal_buffer_t *buf);
static void rcd_allgather_send_dists(orte_grpcomm_coll_t *coll, opal_buffer_t *buffer, orte_vpid_t distance);
static int rcd_allgather_send_dist(orte_grpcomm_coll_t *coll, orte_vpid_t distance);
static void rcd_allgather_recv_dist(int status, orte_process_name_t* sender,
                                     opal_buffer_t* buffer, orte_rml_tag_t tag,
                                     void* cbdata);
static int rcd_finalize_coll(orte_grpcomm_coll_t *coll, int ret);

static inline int rcd_log2 (size_t s) {
    size_t i;
    int lg;
    assert((0 != s) && !(s & (s - 1)));
    for (i=1,lg=0;i < s; i<<=1, lg++);
    assert(s == ((size_t)1<<lg));
    return lg;
}

/* Module def */
orte_grpcomm_base_module_t orte_grpcomm_rcd_module = {
    init,
    finalize,
    xcast,
    allgather
};

/**
 * Initialize the module
 */
static int init(void)
{
    /* setup recv for distance data */
    orte_rml.recv_buffer_nb(ORTE_NAME_WILDCARD,
                            ORTE_RML_TAG_ALLGATHER_RCD,
                            ORTE_RML_PERSISTENT,
                            rcd_allgather_recv_dist, NULL);
    return OPAL_SUCCESS;
}

/**
 * Finalize the module
 */
static void finalize(void)
{
    /* cancel the recv */
    orte_rml.recv_cancel(ORTE_NAME_WILDCARD, ORTE_RML_TAG_ALLGATHER_RCD);
    return;
}

static int xcast(orte_vpid_t *vpids,
                 size_t nprocs,
                 opal_buffer_t *msg)
{
    return ORTE_ERR_NOT_IMPLEMENTED;
}

static int allgather(orte_grpcomm_coll_t *coll,
                     opal_buffer_t *sendbuf)
{
    /* check the number of involved daemons - if it is not a power of two,
     * then we cannot do it */
    if ((0 == coll->ndmns) || (coll->ndmns & (coll->ndmns - 1))) {
        return ORTE_ERR_TAKE_NEXT_OPTION;
    }

    assert(0 == coll->bucket.bytes_allocated);

    OPAL_OUTPUT_VERBOSE((5, orte_grpcomm_base_framework.framework_output,
                         "%s grpcomm:coll:recdub algo employed for %d daemons",
                         ORTE_NAME_PRINT(ORTE_PROC_MY_NAME), (int)coll->ndmns));

    /* record that we tributed */
    coll->nreceived |= 1;

    /* Communication step:
     At every step i, rank r:
     - exchanges message containing all data collected so far with rank peer = (r ^ 2^i).
     */
    rcd_allgather_send_dists(coll, sendbuf, 0);
    if (coll->nreported == coll->ndmns) {
        assert(NULL != coll->cbfunc);
        rcd_finalize_coll(coll, ORTE_SUCCESS);
    }

    return ORTE_SUCCESS;
}

static void rcd_allgather_send_dists(orte_grpcomm_coll_t *coll, opal_buffer_t *buffer, uint32_t distance) {
    int rc;
    uint32_t d;
    if (distance > 0 && coll->nreported != ((size_t)1<<(distance-1))) {
        /* buffer cannot be sent because data was not received from nearer peers
         * save it for later
         */
        if (NULL == coll->buffers) {
            if (NULL == (coll->buffers = (opal_buffer_t **)calloc(sizeof(opal_buffer_t *), rcd_log2(coll->ndmns)))) {
                rc = OPAL_ERR_OUT_OF_RESOURCE;
                ORTE_ERROR_LOG(rc);
                rcd_finalize_coll(coll, rc);
                return;
            }
        }
        coll->buffers[distance-1] = OBJ_NEW(opal_buffer_t);
        if (OPAL_SUCCESS != (rc = opal_dss.copy_payload(coll->buffers[distance-1], buffer))) {
            ORTE_ERROR_LOG(rc);
            rcd_finalize_coll(coll, rc);
            return;
        }
        return;
    }
    if (OPAL_SUCCESS != (rc = opal_dss.copy_payload(&coll->bucket, buffer))) {
        ORTE_ERROR_LOG(rc);
        rcd_finalize_coll(coll, rc);
        return;
    }
    for(d=distance;;d++) {
        if (d == 0) {
            coll->nreported += 1;
        } else {
            coll->nreported += (1<<(d-1));
        }
        if (((size_t)1<<d) == coll->ndmns) {
            break ;
        }
        rcd_allgather_send_dist(coll, d);
        if (NULL != coll->buffers && NULL != coll->buffers[d]) {
            if (OPAL_SUCCESS != (rc = opal_dss.copy_payload(&coll->bucket, coll->buffers[d]))) {
                ORTE_ERROR_LOG(rc);
                rcd_finalize_coll(coll, rc);
                return;
            }
            OBJ_RELEASE(coll->buffers[d]);
            coll->buffers[d] = NULL;
        } else {
            break;
        }
    }
}

static int rcd_allgather_send_dist(orte_grpcomm_coll_t *coll, uint32_t distance) {
    orte_process_name_t peer;
    opal_buffer_t *send_buf;
    int rc;

    peer.jobid = ORTE_PROC_MY_NAME->jobid;

    if (1 == coll->ndmns) {
        peer.vpid = ORTE_PROC_MY_NAME->vpid;
    } else {
        orte_vpid_t nv, rank;
        rank = ORTE_VPID_INVALID;
        for (nv = 0; nv < coll->ndmns; nv++) {
            if (coll->dmns[nv] == ORTE_PROC_MY_NAME->vpid) {
                rank = nv;
                break;
            }
        }
        /* check for bozo case */
        if (ORTE_VPID_INVALID == rank) {
            ORTE_ERROR_LOG(ORTE_ERR_NOT_FOUND);
            return ORTE_ERR_NOT_FOUND;
        }
        /* first send my current contents */
        nv = rank ^ (1<<distance);
        peer.vpid = coll->dmns[nv];
    }

    send_buf = OBJ_NEW(opal_buffer_t);

    /* pack the signature */
    if (OPAL_SUCCESS != (rc = opal_dss.pack(send_buf, &coll->sig, 1, ORTE_SIGNATURE))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(send_buf);
        return rc;
    }
    /* pack the current distance */
    if (OPAL_SUCCESS != (rc = opal_dss.pack(send_buf, &distance, 1, OPAL_UINT32))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(send_buf);
        return rc;
    }
    /* pack the number of daemons whose data we are including in this message */
    if (OPAL_SUCCESS != (rc = opal_dss.pack(send_buf, &coll->nreported, 1, OPAL_UINT32))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(send_buf);
        return rc;
    }
    /* pack the data */
    if (OPAL_SUCCESS != (rc = opal_dss.copy_payload(send_buf, &coll->bucket))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(send_buf);
        return rc;
    }

    OPAL_OUTPUT_VERBOSE((5, orte_grpcomm_base_framework.framework_output,
                         "%s grpcomm:coll:recdub sending to %s",
                         ORTE_NAME_PRINT(ORTE_PROC_MY_NAME),
                         ORTE_NAME_PRINT(&peer)));


    if (0 > (rc = orte_rml.send_buffer_nb(&peer, send_buf,
                                          ORTE_RML_TAG_ALLGATHER_RCD,
                                          orte_rml_send_callback, NULL))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(send_buf);
        return rc;
    };

    return ORTE_SUCCESS;
}

static void rcd_allgather_recv_dist(int status, orte_process_name_t* sender,
                                    opal_buffer_t* buffer, orte_rml_tag_t tag,
                                    void* cbdata)
{
    int32_t cnt;
    uint32_t num_remote;
    int rc;
    orte_grpcomm_signature_t *sig;
    orte_grpcomm_coll_t *coll;
    uint32_t distance, new_distance;

    OPAL_OUTPUT_VERBOSE((5, orte_grpcomm_base_framework.framework_output,
                         "%s grpcomm:coll:recdub received data from %s",
                         ORTE_NAME_PRINT(ORTE_PROC_MY_NAME),
                         ORTE_NAME_PRINT(sender)));

    /* unpack the signature */
    cnt = 1;
    if (OPAL_SUCCESS != (rc = opal_dss.unpack(buffer, &sig, &cnt, ORTE_SIGNATURE))) {
        ORTE_ERROR_LOG(rc);
        return;
    }

    /* check for the tracker and create it if not found */
    if (NULL == (coll = orte_grpcomm_base_get_tracker(sig, true))) {
        ORTE_ERROR_LOG(ORTE_ERR_NOT_FOUND);
        OBJ_RELEASE(sig);
        return;
    }

    /* unpack the distance */
    distance = 1;
    if (OPAL_SUCCESS != (rc = opal_dss.unpack(buffer, &distance, &cnt, OPAL_UINT32))) {
        OBJ_RELEASE(sig);
        ORTE_ERROR_LOG(rc);
        rcd_finalize_coll(coll, rc);
        return;
    }

    /* unpack number of reported */
    num_remote = 0;
    if (OPAL_SUCCESS != (rc = opal_dss.unpack(buffer, &num_remote, &cnt, OPAL_UINT32))) {
        OBJ_RELEASE(sig);
        ORTE_ERROR_LOG(rc);
        rcd_finalize_coll(coll, rc);
        return;
    }

    assert (num_remote == ((size_t)1<<distance));
    new_distance = distance+1;
    if (coll->nreceived&(1<<new_distance)) {
        /* save the buffer for the future collective */
        if (NULL == coll->next_buffers) {
            if (NULL == (coll->next_buffers = (opal_buffer_t **)calloc(sizeof(opal_buffer_t *), rcd_log2(coll->ndmns)))) {
                rc = OPAL_ERR_OUT_OF_RESOURCE;
                ORTE_ERROR_LOG(rc);
                rcd_finalize_coll(coll, rc);
                return;
            }
        }
        assert(NULL == coll->next_buffers[distance]);
        if (NULL == (coll->next_buffers[distance] = OBJ_NEW(opal_buffer_t))) {
            rc = OPAL_ERR_OUT_OF_RESOURCE;
            OBJ_RELEASE(sig);
            ORTE_ERROR_LOG(rc);
            rcd_finalize_coll(coll, rc);
            return;
        }
        if (OPAL_SUCCESS != (rc = opal_dss.copy_payload(coll->next_buffers[distance], buffer))) {
            OBJ_RELEASE(sig);
            ORTE_ERROR_LOG(rc);
            rcd_finalize_coll(coll, rc);
            return;
        }
        coll->next_nreceived |= (1<<new_distance);
        return;
    }

    coll->nreceived |= (1<<new_distance);

    rcd_allgather_send_dists(coll, buffer, new_distance);

    /* if we are done, then complete things */
    if (coll->nreported == coll->ndmns) {
        assert(NULL != coll->cbfunc);
        rcd_finalize_coll(coll, ORTE_SUCCESS);
    }

    OBJ_RELEASE(sig);

    return;
}

static int rcd_finalize_coll(orte_grpcomm_coll_t *coll, int ret) {
    opal_buffer_t *reply;
    int rc;

    OPAL_OUTPUT_VERBOSE((5, orte_grpcomm_base_framework.framework_output,
                         "%s grpcomm:coll:recdub declared collective complete",
                         ORTE_NAME_PRINT(ORTE_PROC_MY_NAME)));

    reply = OBJ_NEW(opal_buffer_t);

    if (OPAL_SUCCESS != (rc = opal_dss.pack(reply, &coll->nreported, 1, OPAL_UINT64))) {
        ORTE_ERROR_LOG(rc);
        OBJ_RELEASE(reply);
        return rc;
    }
    /* transfer the collected bucket */
    opal_dss.copy_payload(reply, &coll->bucket);

    /* execute the callback */
    if (NULL != coll->cbfunc) {
        coll->cbfunc(ret, reply, coll->cbdata);
    }

    if (NULL != coll->buffers) {
        /* bozo check */
        int i;
        for (i=0; i<rcd_log2(coll->ndmns); i++) {
            assert(NULL == coll->buffers[i]);
        }
        free(coll->buffers);
    }
    coll->buffers = coll->next_buffers;
    coll->next_buffers = NULL;
    coll->nreported = 0;
    coll->nreceived = coll->next_nreceived;
    coll->next_nreceived = 0;

    if (NULL == coll->buffers) {
        opal_list_remove_item(&orte_grpcomm_base.ongoing, &coll->super);
    } else {
        /* "reset" the collective bucket */
        assert(1 == coll->bucket.parent.obj_reference_count);
        OBJ_DESTRUCT(&coll->bucket);
        OBJ_CONSTRUCT(&coll->bucket, opal_buffer_t);
    }

    OBJ_RELEASE(reply);

    return ORTE_SUCCESS;
}
