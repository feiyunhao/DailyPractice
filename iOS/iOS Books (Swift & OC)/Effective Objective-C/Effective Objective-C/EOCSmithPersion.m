//
//  EOCSmithPersion.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCSmithPersion.h"

@implementation EOCSmithPersion

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)setLastName:(NSString*)lastName {
    if (![lastName isEqualToString:@"Smith"]) {
        [NSException raise:NSInvalidArgumentException format:@"Last name must be Smith"];
    }
    self.lastName = lastName;
}
@end
