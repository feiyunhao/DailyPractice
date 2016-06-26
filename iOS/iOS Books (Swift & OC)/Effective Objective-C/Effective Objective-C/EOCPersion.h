//
//  EOCPersion.h
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPersion : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, assign) NSUInteger age;

- (NSString*)fullName;
- (void)setFullName:(NSString*)fullName;
- (BOOL)isEqualToPersion:(EOCPersion*)otherPersion;
@end
