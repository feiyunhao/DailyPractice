//
//  SYCTLinkTouchUtils.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCTLinkData.h"
#import "SYCTDisplayView.h"

@interface SYCTLinkTouchUtils : NSObject

+ (SYCTLinkData*)linkDataForTouchPoint:(CGPoint)point inCTView:(SYCTDisplayView *)view;

@end
