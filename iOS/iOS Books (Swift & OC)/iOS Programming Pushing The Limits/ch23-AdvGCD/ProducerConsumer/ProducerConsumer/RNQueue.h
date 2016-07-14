//
//  RNQueue.h
//  ProducerConsumer
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

void RNQueueTag(dispatch_queue_t q);

dispatch_queue_t RNQueueCreateTagged(const char *label, dispatch_queue_attr_t attr);

BOOL RNQueueCurrentIsTaggedQueue(dispatch_queue_t q);

dispatch_queue_t RNQueueGetCurrentTagged();

BOOL RNQueueCurrentIsMainQueue();

void RNQueueSafeDispatchSync(dispatch_queue_t q, dispatch_block_t block);

#define RNAssertQueue(q) NSAssert(RNQueueCurrentIsTaggedQueue(q), @"Must run on queue: " #q )

#define RNAssertMainQueue() NSAssert(RNQueueCurrentIsMainQueue(), @"Must run on main queue")

