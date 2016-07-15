//
//  JuliaOperation.h
//  JuliaOp
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <complex.h>
#import <UIKit/UIKit.h>

@interface JuliaOperation : NSOperation

@property (nonatomic, readwrite, assign) NSUInteger width;
@property (nonatomic, readwrite, assign) NSUInteger height;
@property (nonatomic, readwrite, assign) complex long double c;
@property (nonatomic, readwrite, assign) complex long double blowup;
@property (nonatomic, readwrite, assign) CGFloat contentScaleFactor;
@property (nonatomic, readwrite, assign) NSUInteger rScale;
@property (nonatomic, readwrite, assign) NSUInteger gScale;
@property (nonatomic, readwrite, assign) NSUInteger bScale;
@property (nonatomic, readonly, strong) UIImage *image;

@end
