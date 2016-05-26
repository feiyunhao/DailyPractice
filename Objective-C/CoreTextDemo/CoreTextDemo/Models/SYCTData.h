//
//  SYCTData.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCTData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) NSAttributedString *content;

@property (strong, nonatomic) NSArray * imageArray;
@property (strong, nonatomic) NSArray * linkArray;

@end
