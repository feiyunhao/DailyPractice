//
//  EOCAutoDictionary.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>
#import "EOCEmployeeDeveloper.h"
@interface EOCAutoDictionary ()
@property (nonatomic, strong)NSMutableDictionary *backingStore;
@end

@implementation EOCAutoDictionary

@dynamic string, number, date, opaqueObject;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%@",NSStringFromSelector([anInvocation selector]));
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSString *selString = NSStringFromSelector(aSelector);
    if ([selString isEqualToString:@"eatSometing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return nil;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *selectorString = NSStringFromSelector(aSelector);
    if ([selectorString isEqualToString:@"doADaysWork"]) {
        return [EOCEmployeeDeveloper new];
    }else
    {
        return nil;
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selectorString = NSStringFromSelector(sel);
    
    if ([selectorString isEqualToString:@"doADaysWork"] || [selectorString isEqualToString:@"eatSometing"]) {
        return NO;
    }
    
    if ([selectorString hasPrefix:@"set"]) {
        //v@:@是什么东西呢？实际上，这里的第一个字符v代表函数的返回类型是void
        //第二个参数类型必须是id（就是self的类型）
        //第三个参数类型必须是SEL（就是_cmd的类型）
        //从第四个参数起，可以按照原方法的参数类型定义。
        class_addMethod(self, sel, (IMP) autoDictionarySetter, "v@:@");
    }else{
        //"@@:"作为方法签名类型返回。这里第一字符@代表函数返回类型NSString，第二个字符@代表self的类型id，第三个字符:代表_cmd的类型SEL。
        class_addMethod(self, sel, (IMP) autoDictionaryGetter, "@@:");
    }
    return YES;
}

id autoDictionaryGetter (id self ,SEL _cmd) {
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary*)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return  [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary*)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length -1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    }else{
        [backingStore removeObjectForKey:key];
    }

}

@end
