//
//  RNQueue.m
//  ProducerConsumer
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "RNQueue.h"

static const char sQueueTagKey;

void RNQueueTag(dispatch_queue_t q) {
    dispatch_queue_set_specific(q, &sQueueTagKey, (__bridge void *)(q), NULL);
}

dispatch_queue_t RNQueueGetCurrentTagged() {
    return (__bridge dispatch_queue_t)(dispatch_get_specific(&sQueueTagKey));
}

dispatch_queue_t RNQueueCreateTagged(const char *label, dispatch_queue_attr_t attr) {
    dispatch_queue_t q = dispatch_queue_create(label, attr);
    RNQueueTag(q);
    return q;
}

BOOL RNQueueCurrentIsTaggedQueue(dispatch_queue_t q) {
    return (RNQueueGetCurrentTagged() == q);
}

BOOL RNQueueCurrentIsMainQueue() {
    return [NSThread isMainThread];
}

void RNQueueSafeDispatchSync(dispatch_queue_t q, dispatch_block_t block) {
    if (RNQueueCurrentIsTaggedQueue(q)) {
        block();
    } else {
        dispatch_sync(q, block);
    }
}
