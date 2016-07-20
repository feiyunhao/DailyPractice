//
//  NSNotificationCenter+Swizzle.m
//  MethodSwizzle
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "NSNotificationCenter+Swizzle.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"

@implementation NSNotificationCenter (Swizzle)

typedef void (*voidIMP)(id, SEL, ...);
static voidIMP sOrigAddObserver = NULL;

static void MYAddObserver(id self, SEL _cmd, id observer,
                          SEL selector,
                          NSString *name,
                          id object) {
    NSLog(@"Adding observer: %@", observer);
    
    // Call the old implementation
    NSAssert(sOrigAddObserver,
             @"Original addObserver: method not found.");
    if (sOrigAddObserver) {
        sOrigAddObserver(self, _cmd, observer, selector, name,
                         object);
    }
}

+ (void)swizzleAddObserver {
    NSAssert(! sOrigAddObserver,
             @"Only call swizzleAddObserver once.");
    SEL sel = @selector(addObserver:selector:name:object:);
    sOrigAddObserver = (void *)[self swizzleSelector:sel
                                             withIMP:(IMP)MYAddObserver];
}

@end
