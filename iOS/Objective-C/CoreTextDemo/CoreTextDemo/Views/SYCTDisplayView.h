//
//  SYCTDisplayView.h
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCTData.h"

extern NSString *const SYCTDisplayViewImagePressedNotification;
extern NSString *const SYCTDisplayViewLinkPressedNotification;

@interface SYCTDisplayView : UIView

@property (nonatomic,strong)SYCTData *ctData;

@end
