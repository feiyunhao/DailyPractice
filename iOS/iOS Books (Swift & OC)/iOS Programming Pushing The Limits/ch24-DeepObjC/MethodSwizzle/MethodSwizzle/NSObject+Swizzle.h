//
//  NSObject+Swizzle.h
//  MethodSwizzle
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)
+ (IMP)swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP;
@end
