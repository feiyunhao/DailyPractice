//
//  ViewController.m
//  系统框架
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "EOCClassSun.h"
//#import "EOCClassSun+Brother.h"
#import "NSTimer+EOCBlocksSupport.h"


const void* EOCRetainCallback(CFAllocatorRef allocator,
                             const void *value)
{
    return CFRetain(value);
}

void EOCReleaseCallback(CFAllocatorRef allocator,
                        const void *value)
{
    CFRelease(value);
}

CFDictionaryKeyCallBacks keyCallbacks = {
    0,
    EOCRetainCallback,
    EOCReleaseCallback,
    NULL,
    CFEqual,
    CFHash
};

CFDictionaryValueCallBacks valueCallbacks = {
    0,
    EOCRetainCallback,
    EOCReleaseCallback,
    NULL,
    CFEqual
};

@interface ViewController (){
    NSTimer *_polltimer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark - 多用块枚举，少用for循环
    
//    NSArray *array = @[@1,@2,@3,@4,@5];
//    NSSet *set = [NSSet setWithArray:array];
//    NSDictionary *dictionary = @{
//                                 @1 : @5,
//                                 @2 : @4,
//                                 @3 : @3,
//                                 @4 : @2,
//                                 @5 : @1,
//                                 };
//    id object;
    
//    NSEnumerator *arrayEnumuerator = [array objectEnumerator];
//    while ((object = [arrayEnumuerator nextObject]) != nil) {
//        NSLog(@"%@",object);
//    }
//    
//    NSEnumerator *setEnumuerator = [set objectEnumerator];
//    while ((object = [setEnumuerator nextObject]) != nil) {
//        NSLog(@"%@",object);
//    }
    
//    NSEnumerator *dictKeyEnumerator = [dictionary keyEnumerator];
//    while ((object = [dictKeyEnumerator nextObject]) != nil) {
//        NSLog(@"%@ : %@",object, dictionary[object]);
//    }
    
    
//    NSEnumerator *dictObjEnumerator = [dictionary objectEnumerator];
//    while ((object = [dictObjEnumerator nextObject]) != nil) {
//        NSLog(@"%@",object);
//    }
    
//    NSEnumerator *reverseEnumerator = [array reverseObjectEnumerator];
//    while ((object = [reverseEnumerator nextObject]) != nil) {
//        NSLog(@"%@",object);
//    }
    
//    for (id object in [array reverseObjectEnumerator]) {
//        NSLog(@"%@",object);
//    }
    
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"index: %ld obj: %@ ",idx,obj);
//        if (idx == 3) {
//            NSLog(@"Stop!");
//            *stop = YES;
//        }
//        
//    }];
    
//    [array enumerateObjectsWithOptions:NSEnumerationConcurrent | NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"index: %ld obj: %@ ",idx,obj);
//        if (idx == 3) {
//            NSLog(@"Stop!");
//            *stop = YES;
//        }
//    }];
    
    
//    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
//        ;
//    }];
//    
//    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@: %@",key,obj);
//    }];
    
#pragma mark - toll-free-bridging
    
//    NSArray *aNSArray = @[@1, @2, @3, @4, @5];
//    CFArrayRef aCFArray = (__bridge CFArrayRef)(aNSArray);
//    NSLog(@"Size of array = %li",CFArrayGetCount(aCFArray));
//
//    CFArrayRef bCFArray = (__bridge_retained CFArrayRef)(aNSArray);
//    CFRelease(bCFArray);
    
    CFMutableDictionaryRef aCFDictionary = CFDictionaryCreateMutable(NULL,
                                                                     0,
                                                                     &keyCallbacks,
                                                                     &valueCallbacks);
    
    NSMutableDictionary *aCoustomNSMultableDictionary = (__bridge_transfer NSMutableDictionary*) aCFDictionary;

    [aCoustomNSMultableDictionary setObject:@"Why does it not work" forKey:@"aCoustomNSMultableDictionary"];
    
#pragma mark - NSCache - NSPurgeableData
    
    NSCache *cache = [NSCache new];
    cache.countLimit = 100;
    cache.totalCostLimit = 5 * 1024 * 1024;
    
    NSPurgeableData *cachedData = [cache objectForKey:@"cachedData"];
    if (cachedData) {
        //do some thing with cachedData
        [cachedData endContentAccess];
    } else{
        //get data from someWhere
        NSPurgeableData *purgeableData = [NSPurgeableData data];
        [cache setObject:purgeableData forKey:@"cachedData"];

    }
   
#pragma mark - initialize load

    EOCClassSun *sun = [EOCClassSun new];
    
#pragma mark - NSTimer 会保留目标对象
    
    __weak ViewController *weakSelf = self;
    
    [NSTimer eoc_scheduledTimerWithInterval:5.0 block:^{
        
        ViewController *strongSelf = weakSelf;
        [strongSelf p_doPoll];
        
    } repeats:YES];
    
}

#pragma mark - initialize load

+(void)load{
    [super load];
   //当包含 类 或 分类 的程序载入系统时（通常指程序启动时,iOS肯定会执行）
    NSLog(@"%s",__FUNCTION__);
}

+(void)initialize{
    NSLog(@"%s",__FUNCTION__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)p_doPoll {
    NSLog(@"poll");
}
@end
