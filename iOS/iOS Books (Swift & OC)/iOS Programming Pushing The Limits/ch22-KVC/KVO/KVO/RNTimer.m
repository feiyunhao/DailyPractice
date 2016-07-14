//
//  RNTimer.m
//  KVO
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "RNTimer.h"

@interface RNTimer()
@property (nonatomic, readwrite, copy) void (^block)();
@property (nonatomic, readwrite, strong) dispatch_source_t source;

@end

@implementation RNTimer

+ (RNTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(void))block {
    NSParameterAssert(block);
    NSParameterAssert(seconds);
    RNTimer *timer = [[self alloc] init];
    timer.block = block;
    timer.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    uint64_t nsec = (uint64_t)(seconds * NSEC_PER_SEC);
    dispatch_source_set_timer(timer.source, dispatch_time(DISPATCH_TIME_NOW, nsec), nsec, 0);
    dispatch_source_set_event_handler(timer.source, block);
    dispatch_resume(timer.source);
    return timer;
}

- (void)invalidate {
    
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
    self.block = nil;
}

- (void)dealloc {
    [self invalidate];
}

- (void)fire {
    if (self.block) {
        self.block();
    }
}
@end
