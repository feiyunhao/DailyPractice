//
//  SYCTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTFrameParserConfig.h"

@implementation SYCTFrameParserConfig

- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(0, 0, 0);
    }
    return self;
}

@end
