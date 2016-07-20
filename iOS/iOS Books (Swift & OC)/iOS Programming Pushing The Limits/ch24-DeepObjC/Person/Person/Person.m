//
//  Person.m
//  Person
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person()
@property (strong) NSMutableDictionary *properties;

@end

@implementation Person

- (id)init {
    if ((self = [super init])) {
        _properties = [[NSMutableDictionary alloc] init];
    }
    return self;
}


static id propertyIMP(id self, SEL _cmd) {
    return [[self properties] valueForKey:
            NSStringFromSelector(_cmd)];
}

static void setPropertyIMP(id self, SEL _cmd, id aValue) {
    id value = [aValue copy];
    
    NSMutableString *key =
    [NSStringFromSelector(_cmd) mutableCopy];
    
    // Delete "set" and ":" and lowercase first letter
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    [key deleteCharactersInRange:
     NSMakeRange([key length] - 1, 1)];
    NSString *firstChar = [key substringToIndex:1];
    [key replaceCharactersInRange:NSMakeRange(0, 1)
                       withString:[firstChar lowercaseString]];
    
    [[self properties] setValue:value forKey:key];
}

+ (BOOL)resolveInstanceMethod:(SEL)aSEL {
    if ([NSStringFromSelector(aSEL) hasPrefix:@"set"]) {
        class_addMethod([self class], aSEL,
                        (IMP)setPropertyIMP, "v@:@");
    }
    else {
        class_addMethod([self class], aSEL,
                        (IMP)propertyIMP, "@@:");
    }
    return YES;
}

@end
