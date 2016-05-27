//
//  SYCTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTFrameParserConfig.h"

@implementation SYCTFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineSpace = 8.0f;
        _width = [UIScreen mainScreen].bounds.size.width;
        _fontSize = 16.0f;
        _textColor = RGB(0, 0, 0);
    }
    return self;
}

@end
