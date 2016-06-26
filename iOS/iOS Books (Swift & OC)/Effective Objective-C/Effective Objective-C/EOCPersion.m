//
//  EOCPersion.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCPersion.h"

@implementation EOCPersion
- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  init dealloc 中，总应该通过实例变量来读写数据
         */
        
//        self.firstName = @"";
//        self.lastName = @"";
        
        _firstName = @"";
        _lastName = @"";
    }
    return self;
}
- (NSString*)fullName {
    return [NSString stringWithFormat:@"%@ : %@",_firstName,_lastName];
}

- (void)setFullName:(NSString *)fullName{
    NSArray *compents = [fullName componentsSeparatedByString:@" "];
    self.firstName = compents[0];
    self.lastName = compents[1];
}

- (BOOL)isEqualToPersion:(EOCPersion*)otherPersion{
    if (self == otherPersion) {
        return YES;
    }
    
    if (![_firstName isEqualToString:otherPersion.firstName]){
        return NO;
    }
    if (![_lastName isEqualToString:otherPersion.lastName]) {
        return NO;
    }
    if (_age != otherPersion.age) {
        return NO;
    }
    
    return YES;
}
- (BOOL)isEqual:(id)other
{
    if ([self class] == [other class]) {
        return [self isEqualToPersion:other];
    } else {
        return [super isEqual:other];
    }
}

- (NSUInteger)hash
{
//    NSString *stringToHush = [NSString stringWithFormat:@"%@ : %@",_firstName,_lastName];
//    return [stringToHush hash];
    
    NSUInteger firstNameHash = [_firstName hash];
    NSUInteger lastNameHash = [_lastName hash];
    NSUInteger ageHash = _age;
    return firstNameHash ^ lastNameHash ^ ageHash;
}
@end
