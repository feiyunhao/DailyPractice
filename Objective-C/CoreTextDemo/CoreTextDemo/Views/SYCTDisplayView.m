//
//  SYCTDisplayView.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTDisplayView.h"
#import "SYCTImageData.h"
#import "SYCTLinkTouchUtils.h"

NSString *const SYCTDisplayViewImagePressedNotification = @"SYCTDisplayViewImagePressedNotification";
NSString *const SYCTDisplayViewLinkPressedNotification = @"SYCTDisplayViewLinkPressedNotification";


@implementation SYCTDisplayView

#pragma mark - touchEvents

- (void) setupEvents {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecognizer];
    
    UILongPressGestureRecognizer *longPressRecongnizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(userLongPressedGuestureDetected:)];
    [self addGestureRecognizer:longPressRecongnizer];
    
    UIPanGestureRecognizer *panRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userPanGuestureDetected:)];
    [self addGestureRecognizer:panRecongnizer];
    
    self.userInteractionEnabled = YES;
}

- (void)userTapGestureDetected:(UITapGestureRecognizer*)tapRecognizer {
    
    CGPoint point = [tapRecognizer locationInView:self];
    
    for (SYCTImageData *imageData in self.ctData.imageDataArray) {
        // 翻转坐标系，因为imageData中的坐标是CoreText的坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        // 检测点击位置 Point 是否在rect之内
        if (CGRectContainsPoint(rect, point)) {
            NSLog(@"hint image");
            // 在这里处理点击后的逻辑
            NSDictionary *userInfo = @{ @"imageData": imageData };
            [[NSNotificationCenter defaultCenter] postNotificationName:SYCTDisplayViewImagePressedNotification object:self userInfo:userInfo];
            return;
        }
        
        SYCTLinkData *linkData = [SYCTLinkTouchUtils linkDataForTouchPoint:point inCTView:self];
        if (linkData) {
            NSDictionary *userInfo = @{ @"linkData": linkData };
            [[NSNotificationCenter defaultCenter] postNotificationName:SYCTDisplayViewLinkPressedNotification  object:self userInfo:userInfo];
            return;
        }
    }
}

-(void) userLongPressedGuestureDetected:(UILongPressGestureRecognizer*)longPressRecognizer {
    
    
}

-(void) userPanGuestureDetected:(UILongPressGestureRecognizer*) panRecognizer {
    
    
}

#pragma mark - drawRect

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.ctData) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CTFrameDraw(self.ctData.ctFrame, context);
    
    for (SYCTImageData * imageData in self.ctData.imageDataArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            NSLog(@"%@",NSStringFromCGRect(imageData.imagePosition));
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
}
-(void)setCtData:(SYCTData *)ctData{
    _ctData = ctData;
    self.height = _ctData.height;
    
}

#pragma mark - rewrite init

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupEvents];
    }
    return self;
}


@end
