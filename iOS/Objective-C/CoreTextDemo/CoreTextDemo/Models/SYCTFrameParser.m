//
//  SYCTFrameParser.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTFrameParser.h"
#import "SYCTImageData.h"
#import "SYCTLinkData.h"

@implementation SYCTFrameParser

static CGFloat ascentCallback(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void* ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

+(SYCTData *)parseTempateArray:(NSArray *)tempateArr config:(SYCTFrameParserConfig *)config {
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    NSMutableArray *imageDataArr = [NSMutableArray array];
    NSMutableArray *linkDataArr = [NSMutableArray array];
    
    if (tempateArr) {
        for (NSDictionary *dict in tempateArr) {
            
            NSString *type = dict[@"type"];
            
            if ([type isEqualToString:@"txt"]) {
                //根据 单个字典数据（格式一致的一段文字）生成AttributedString
                NSAttributedString *as =[self parseAttributedContentFromNSDictionary: dict config:config];
                //添加到总的NSAttributedString中
                [result appendAttributedString:as];
            }
            else if ([type isEqualToString:@"link"]) {
                
                NSUInteger startPos = result.length;
                NSAttributedString *as =[self parseAttributedContentFromNSDictionary: dict config:config];
                //添加到总的NSAttributedString中
                [result appendAttributedString:as];
                
                // 创建 CoreTextLinkData
                NSUInteger length = result.length - startPos;
                NSRange linkRange = NSMakeRange(startPos, length);
                SYCTLinkData *linkData = [[SYCTLinkData alloc] init];
                linkData.title = dict[@"content"];
                linkData.urlStr = dict[@"url"];
                linkData.range = linkRange;
                [linkDataArr addObject:linkData];
                
            }
            else if ([type isEqualToString:@"img"]) {
                
                SYCTImageData *imageData = [[SYCTImageData alloc] init];
                imageData.name = dict[@"name"];
                imageData.position = [result length];
                [imageDataArr addObject:imageData];
                
                // 创建空白占位符，并且设置它的CTRunDelegate信息(主要通过设置占位的大小，来适应图片大小)
                NSAttributedString *as = [self parseImageDataFromDictionary:dict config:config];
                [result appendAttributedString:as];
                
                
            }
        }
    }
    
    //根据NSAttributedString 和 config生成 SYCTData
    SYCTData *data = [self parseAttributedContent:result config:config];
    data.imageDataArray = imageDataArr;
    data.linkDataArray = linkDataArr;
    return data;
}

+ (NSAttributedString*)parseImageDataFromDictionary:(NSDictionary*)dict
                                             config:(SYCTFrameParserConfig*)config {
    
    //CTRunDelegateCallBacks:用于保存指针的结构体，由CTRun delegate进行回调
    CTRunDelegateCallbacks callBacks;
    
    //将指向的内存的前n个字节置为0
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    
    callBacks.version = kCTRunDelegateVersion1;
    
    //占位符高度
    callBacks.getAscent = ascentCallback;
    callBacks.getDescent = descentCallback;
    //占位符宽度
    callBacks.getWidth = widthCallback;
    
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)(dict));
    
    unichar objcetReplacementChar = ' ';
    NSString *content = [NSString stringWithCharacters:&objcetReplacementChar length:1];
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *space = [[NSMutableAttributedString alloc]initWithString:content attributes:attributes];
    
    //针对图片的占位字符 设置 CTRunDelegate
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1),kCTRunDelegateAttributeName, delegate);
    
    CFRelease(delegate);
    return space;
}

//根据NSAttributedString 和 config生成 SYCTData
+ (SYCTData*)parseAttributedContent:(NSAttributedString*)content
                             config:(SYCTFrameParserConfig*)config {
    
    // 生成的ctframe 将context绘制到上边
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) content);
    
    //高度
    CGSize constraintSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, constraintSize, nil);
    CGFloat coreTextHeigt = coreTextSize.height;
    
    //生成CTFrame
    CTFrameRef ctFrame = [self createFrameWithFramesetter:frameSetter
                                                 config:config
                                                 height:coreTextHeigt];
    SYCTData *data = [[SYCTData alloc] init];
    //
    data.ctFrame = ctFrame;
    data.height = coreTextHeigt;
    data.content = content;
    
    CFRelease(ctFrame);
    CFRelease(frameSetter);
    
    
    return data;
}

//生成CTFrame
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(SYCTFrameParserConfig *)config
                                  height:(CGFloat)height {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    // 生成的ctframe 将context绘制到上边
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}


//根据 单个字典数据（格式一致的一段文字）生成AttributedString
+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
                                                        config:(SYCTFrameParserConfig*)config {
    //生成配置AttributedString 的字典(默认设置)
    NSMutableDictionary *attributes = [self attributesWithConfig:config].mutableCopy;
    
    //如果配置了颜色属性，就覆盖默认颜色
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }

    //如果配置了字体，就覆盖默认字体
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    
    
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
}

/**
 *  根据config属性 生成配置AttributedString 的字典
 */
+ (NSDictionary *)attributesWithConfig:(SYCTFrameParserConfig*)config {
    
    //config 共有四个实例变量 ，这里用了其中三个，分别设置：字体颜色、字体大小 行间距；
    //没用到的 是 设置 绘制宽度的
    
    UIColor *textColor = config.textColor;
    
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings [kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat),&lineSpace}
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontNameAttribute] = (__bridge id )(fontRef);
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id ) theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}

+ (UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else {
        return nil;
    }
}

@end
