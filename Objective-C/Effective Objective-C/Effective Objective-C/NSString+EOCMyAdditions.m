//
//  NSString+EOCMyAdditions.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "NSString+EOCMyAdditions.h"

@implementation NSString (EOCMyAdditions)

- (NSString *)eoc_mylowercaseString{
    NSString *lowercase = [self eoc_mylowercaseString];
    NSLog(@"%@ -> %@",self,lowercase);
    return lowercase;
}
@end
