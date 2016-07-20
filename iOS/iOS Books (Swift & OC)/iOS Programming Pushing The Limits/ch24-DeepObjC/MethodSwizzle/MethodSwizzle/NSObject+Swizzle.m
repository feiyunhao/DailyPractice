//
//  NSObject+Swizzle.m
//  MethodSwizzle
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (IMP)swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

@end
