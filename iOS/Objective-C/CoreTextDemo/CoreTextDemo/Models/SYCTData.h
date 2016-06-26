//
//  SYCTData.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCTData : NSObject

@property(nonatomic, assign)CTFrameRef ctFrame;
@property(nonatomic, assign)CGFloat height;

@property(nonatomic, strong)NSAttributedString *content;

@property (strong, nonatomic) NSArray * imageDataArray;
@property (strong, nonatomic) NSArray * linkDataArray;

@end
