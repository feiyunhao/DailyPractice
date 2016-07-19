//
//  RNMainThreadTrampoline.m
//  ObserverTrampoline
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "RNMainThreadTrampoline.h"

@implementation RNMainThreadTrampoline

- (id)initWithTarget:(id)aTarget {
    if ((self = [super init])) {
        _target = aTarget;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation setTarget:self.target];
    [invocation retainArguments];
    [invocation performSelectorOnMainThread:@selector(invoke)
                                 withObject:nil
                              waitUntilDone:NO];
}


@end
