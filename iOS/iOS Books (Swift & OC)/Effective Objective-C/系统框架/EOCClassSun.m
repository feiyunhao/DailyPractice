//
//  EOCClassSun.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCClassSun.h"

@implementation EOCClassSun

+(void)load{
    //当包含 类 或 分类 的程序载入系统时（通常指程序启动时,iOS肯定会执行）
    NSLog(@"%s",__FUNCTION__);
}

//+(void)initialize{
//    NSLog(@"%s",__FUNCTION__);
//}

@end
