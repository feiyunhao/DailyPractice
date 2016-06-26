//
//  NSTimer+EOCBlocksSupport.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "NSTimer+EOCBlocksSupport.h"

@implementation NSTimer (EOCBlocksSupport)


+ (NSTimer*)eoc_scheduledTimerWithInterval:(NSTimeInterval)interval
                                     block:(void(^)())block
                                   repeats:(BOOL)yesOrNo{
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(eoc_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+(void) eoc_blockInvoke:(NSTimer*)timer {
    
    void(^block)() = timer.userInfo;
    if (block) {
        block();
    }
    
}
@end
