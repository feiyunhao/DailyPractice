//
//  SYCTDisplayView.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/25.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "SYCTDisplayView.h"
#import "SYCTUtils.h"
#import "SYCTImageData.h"
#import "MagnifiterView.h"

NSString *const SYCTDisplayViewImagePressedNotification = @"SYCTDisplayViewImagePressedNotification";
NSString *const SYCTDisplayViewLinkPressedNotification = @"SYCTDisplayViewLinkPressedNotification";

typedef enum CTDisplayViewState : NSInteger {
    CTDisplayViewStateNormal,       // 普通状态
    CTDisplayViewStateTouching,     // 正在按下，需要弹出放大镜
    CTDisplayViewStateSelecting     // 选中了一些文本，需要弹出复制菜单
}CTDisplayViewState;

@interface SYCTDisplayView ()<UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger selectionStartPosition;
@property (nonatomic) NSInteger selectionEndPosition;
@property (nonatomic) CTDisplayViewState state;
@property (strong, nonatomic) UIImageView *leftSelectionAnchor;
@property (strong, nonatomic) UIImageView *rightSelectionAnchor;
@property (strong, nonatomic) MagnifiterView *magnifierView;

@end


@implementation SYCTDisplayView

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

- (void)setupEvents {
    
    UIGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecognizer];
    
    UIGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(userLongPressedGuestureDetected:)];
    [self addGestureRecognizer:longPressRecognizer];
    
    UIGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(userPanGuestureDetected:)];
    [self addGestureRecognizer:panRecognizer];
    
    self.userInteractionEnabled = YES;
}

- (void)userLongPressedGuestureDetected:(UILongPressGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    debugMethod();
    debugLog(@"state = %ld", recognizer.state);
    debugLog(@"point = %@", NSStringFromCGPoint(point));
    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        CFIndex index = [SYCTUtils touchContentOffsetInView:self atPoint:point data:self.data];
        if (index != -1 && index < self.data.content.length) {
            _selectionStartPosition = index;
            _selectionEndPosition = index + 2;
        }
        self.magnifierView.touchPoint = point;
        self.state = CTDisplayViewStateTouching;
    } else {
        if (_selectionStartPosition >= 0 && _selectionEndPosition <= self.data.content.length) {
            self.state = CTDisplayViewStateSelecting;
            [self showMenuController];
        } else {
            self.state = CTDisplayViewStateNormal;
        }
    }
}

- (void)showMenuController {
    if ([self becomeFirstResponder]) {
        CGRect selectionRect = [self rectForMenuController];
        // 翻转坐标系
        CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
        transform = CGAffineTransformScale(transform, 1.f, -1.f);
        selectionRect = CGRectApplyAffineTransform(selectionRect, transform);
        
        UIMenuController *theMenu = [UIMenuController sharedMenuController];
        [theMenu setTargetRect:selectionRect inView:self];
        [theMenu setMenuVisible:YES animated:YES];
    }
}

- (CGRect)rectForMenuController {
    if (_selectionStartPosition < 0 || _selectionEndPosition > self.data.content.length) {
        return CGRectZero;
    }
    CTFrameRef textFrame = self.data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
    if (!lines) {
        return CGRectZero;
    }
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    CGRect resultRect = CGRectZero;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFRange range = CTLineGetStringRange(line);
        // 1. start和end在一个line,则直接弄完break
        if ([self isPosition:_selectionStartPosition inRange:range] && [self isPosition:_selectionEndPosition inRange:range]) {
            CGFloat ascent, descent, leading, offset, offset2;
            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
            offset2 = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, offset2 - offset, ascent + descent);
            resultRect = lineRect;
            break;
        }
    }
    if (!CGRectIsEmpty(resultRect)) {
        return resultRect;
    }
    
    // 2. start和end不在一个line
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFRange range = CTLineGetStringRange(line);
        // 如果start在line中，则记录当前为起始行
        if ([self isPosition:_selectionStartPosition inRange:range]) {
            CGFloat ascent, descent, leading, width, offset;
            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
            width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, width - offset, ascent + descent);
            resultRect = lineRect;
        }
    }
    return resultRect;
}

- (BOOL)isPosition:(NSInteger)position inRange:(CFRange)range {
    if (position >= range.location && position < range.location + range.length) {
        return YES;
    } else {
        return NO;
    }
}

- (void)fillSelectionAreaInRect:(CGRect)rect {
    UIColor *bgColor = RGB(204, 221, 236);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextFillRect(context, rect);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer{
    
    CGPoint point = [recognizer locationInView:self];
    
    for (SYCTImageData * imageData in self.data.imageArray) {
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
            [[NSNotificationCenter defaultCenter] postNotificationName:SYCTDisplayViewImagePressedNotification
                                                                object:self userInfo:userInfo];
            return;
        }
    }
    
    SYCTLinkData *linkData = [SYCTUtils touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        NSLog(@"hint link!");
        NSDictionary *userInfo = @{ @"linkData": linkData };
        [[NSNotificationCenter defaultCenter] postNotificationName:SYCTDisplayViewLinkPressedNotification
                                                            object:self userInfo:userInfo];
        return;
    }

}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.data) {
        return;
    }
    NSLog(@"%s",__func__);
    
    //步骤一
    //获取当前绘制画布的上下文，后续将内容绘制在画布上
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //步骤二
    //将坐标系上下翻转
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw(self.data.ctFrame,context) ;
    for (SYCTImageData * imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
    return;
    //步骤三
    //创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //步骤四
    NSAttributedString *attString = [[NSAttributedString alloc]initWithString:
                                     @"Hello World!"
                                     "创建绘制的区域，CoreText本身支持各种文字排版区域，"
                                     "我们这里简单地将UIVIew的整个界面作为排版的区域。"
                                     "为了加深理解，介意读者将该步骤的代码替换成如下代码，"
                                     "测试设置不同的绘制区域带来的界面变化"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    //步骤五
    CTFrameDraw(frame, context);
    
    //步骤六
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
