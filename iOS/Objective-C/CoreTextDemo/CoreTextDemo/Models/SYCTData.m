//
//  SYCTData.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTData.h"
#import "SYCTImageData.h"

@implementation SYCTData

- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if (_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

- (void)dealloc {
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

-(void)setImageDataArray:(NSArray *)imageDataArray {
    _imageDataArray = imageDataArray;
    [self fillImagePosition];
}

- (void)fillImagePosition {
    
    //ctframe -> ctline -> ctrun
    
    if (self.imageDataArray.count == 0) {
        return;
    }
    
    NSArray *lines = (NSArray*)CTFrameGetLines(self.ctFrame);
    NSUInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    
    //把每一个CTLine的origin坐标写到数组里。
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imgIndex = 0;

    SYCTImageData * imageData = self.imageDataArray[0];
    
    for (int i = 0; i< lineCount ; i++) {
            
        if (imageData == nil) {
            break;
        }
        
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runObjArray =(NSArray *) CTLineGetGlyphRuns(line);
        
         for (id obj in runObjArray) {
            
            CTRunRef run =(__bridge CTRunRef) obj;
             
             //取出字符串的 kCTRunDelegateAttributeName （有即是图片）
            NSDictionary *runAttributes = (NSDictionary*)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)([runAttributes valueForKey:(id) kCTRunDelegateAttributeName]);
             
            if (delegate == nil) {
                continue ;
            }
             
            NSDictionary *metaDict = CTRunDelegateGetRefCon(delegate);
            if (![metaDict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            
             //ctrun的宽高
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            //计算在行当中的x偏移量
            CGFloat xOffSet = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            
            runBounds.origin.x = lineOrigins[i].x + xOffSet;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
             //获得ctframe的绘制区域
             CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
             
             //计算此绘制区域的范围
             CGRect colRect = CGPathGetBoundingBox(pathRef);
             
             //计算在此区域中空白字符的位置
             CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
             
             //记录空白字符位置
             imageData.imagePosition = delegateBounds;
             
             imgIndex++;
             
             if (imgIndex == self.imageDataArray.count) {
                 imageData = nil;
                 break;
             } else {
                 imageData = self.imageDataArray[imgIndex];
             }

            
        };
        
    };
}

@end
