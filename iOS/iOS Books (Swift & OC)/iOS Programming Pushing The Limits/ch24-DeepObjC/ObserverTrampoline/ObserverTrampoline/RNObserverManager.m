//
//  RNObserverManager.m
//  ObserverTrampoline
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "RNObserverManager.h"
#import <objc/runtime.h>

@interface RNObserverManager ()
@property (nonatomic, readonly, strong) NSMutableSet *observers;
@property (nonatomic, readonly, strong) Protocol *protocol;
@end

@implementation RNObserverManager

- (id)initWithProtocol:(Protocol *)protocol
             observers:(NSSet *)observers {
    if ((self = [super init])) {
        _protocol = protocol;
        _observers = [NSMutableSet setWithSet:observers];
    }
    return self;
}

- (void)addObserver:(id)observer {
    NSAssert([observer conformsToProtocol:self.protocol],
             @"Observer must conform to protocol.");
    [self.observers addObject:observer];
}

- (void)removeObserver:(id)observer {
    [self.observers removeObject:observer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];
    if (result) {
        return result;
    }
    struct objc_method_description desc = protocol_getMethodDescription(self.protocol, aSelector, YES, YES);
    
    if (desc.name == NULL) {
        desc = protocol_getMethodDescription(self.protocol, aSelector, NO, YES);
    }
    
    if (desc.name == NULL) {
        [self doesNotRecognizeSelector:aSelector];
        return  nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:desc.types];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    for (id responder in self.observers) {
        if ([responder respondsToSelector:selector]) {
            [anInvocation setTarget:responder];
            [anInvocation invoke];
        }
    }
}

@end
