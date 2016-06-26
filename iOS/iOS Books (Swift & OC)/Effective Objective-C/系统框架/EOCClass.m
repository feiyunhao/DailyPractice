//
//  EOCClass.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCClass.h"

@implementation EOCClass

+(void)load{
    //当包含 类 或 分类 的程序载入系统时（通常指程序启动时,iOS肯定会执行）
    //真正的用途仅在： 调试
    NSLog(@"%s",__FUNCTION__);
}

+(void)initialize{
    
    //只能用来设置内部数据
    //即便是类自己的方法，也尽量不要调用
    if (self == [EOCClass class]) {
        NSLog(@"%@ : %s",self,__FUNCTION__);
    }
}

@end
