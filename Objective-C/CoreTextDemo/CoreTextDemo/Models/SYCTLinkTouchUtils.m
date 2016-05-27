//
//  SYCTLinkTouchUtils.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/27.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTLinkTouchUtils.h"

@implementation SYCTLinkTouchUtils

+(SYCTLinkData *)linkDataForTouchPoint:(CGPoint)point inCTView:(SYCTDisplayView *)view
{
    CFIndex idx = [self touchContentOffsetInCTView:view atPoint:point];
    if (idx == -1) {
        return nil;
    }
    SYCTLinkData * foundLink = [self linkAtIndex:idx linkArray:view.ctData.linkDataArray];
    return foundLink;
    
}

// 将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1
+ (CFIndex)touchContentOffsetInCTView:(SYCTDisplayView *)view atPoint:(CGPoint)point{
    
    SYCTData *data = view.ctData;
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return -1;
    }
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CFIndex idx = -1;
    
    //遍历所有的ctline
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        // 获得每一行的CGRect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
            NSLog(@"======%ld",idx);
        }
    }
    
    return idx;
}

+ (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

+ (SYCTLinkData *)linkAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray {
    SYCTLinkData *linkData = nil;
    for (SYCTLinkData *data in linkArray) {
        if (NSLocationInRange(i, data.range)) {
            linkData = data;
            break;
        }
    }
    return linkData;
}

@end
