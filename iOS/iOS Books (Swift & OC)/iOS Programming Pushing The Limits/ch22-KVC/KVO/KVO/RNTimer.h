//
//  RNTimer.h
//  KVO
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNTimer : NSObject

+ (RNTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(void))block;
- (void)fire;
- (void)invalidate;

@end
