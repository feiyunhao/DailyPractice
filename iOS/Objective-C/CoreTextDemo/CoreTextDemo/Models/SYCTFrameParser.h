//
//  SYCTFrameParser.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYCTData.h"
#import "SYCTFrameParserConfig.h"
@interface SYCTFrameParser : NSObject

+ (SYCTData*)parseTempateArray:(NSArray*)tempateArr config:(SYCTFrameParserConfig*)config;

@end
