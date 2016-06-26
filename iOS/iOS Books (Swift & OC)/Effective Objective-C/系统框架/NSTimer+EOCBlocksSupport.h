//
//  NSTimer+EOCBlocksSupport.h
//  Effective Objective-C
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (EOCBlocksSupport)

+ (NSTimer*)eoc_scheduledTimerWithInterval:(NSTimeInterval)interval
                                     block:(void(^)())block
                                   repeats:(BOOL)yesOrNo;

@end
