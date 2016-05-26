//
//  SYCTFrameParser.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCTData.h"
#import "SYCTFrameParserConfig.h"

@interface SYCTFrameParser : NSObject


+ (NSMutableDictionary *)attributesWithConfig:(SYCTFrameParserConfig *)config;

+ (SYCTData*)parseContent:(NSString*)content config:(SYCTFrameParserConfig*)config;

+ (SYCTData *)parseAttributedContent:(NSAttributedString *)content config:(SYCTFrameParserConfig*)config;

+ (SYCTData *)parseTemplateFile:(NSString *)path config:(SYCTFrameParserConfig*)config;

@end
