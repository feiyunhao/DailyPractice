//
//  SYCTUtils.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCTLinkData.h"
#import "SYCTData.h"

@interface SYCTUtils : NSObject

+ (SYCTLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(SYCTData *)data;

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(SYCTData *)data;

@end
