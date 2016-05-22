//
//  ViewController.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import "EOCSmithPersion.h"
#import "EOCEmployee.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "EOCAutoDictionary.h"
#import "NSString+EOCMyAdditions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EOCPersion *eocPersionOne = [[EOCPersion alloc] init];
//    EOCSmithPersion *eocSmithpersion = [[EOCSmithPersion alloc] init];
    EOCPersion *eocPersionTwo = [[EOCPersion alloc]init];
    
    BOOL isEqual = [eocPersionOne isEqual:eocPersionTwo];
    NSLog(@"%d",isEqual);
    BOOL isEqualToPersion = [eocPersionOne isEqualToPersion:eocPersionTwo];
    NSLog(@"%d",isEqualToPersion);
    
#pragma mark - 容器可变类的等同性
    
    NSMutableSet *set = [NSMutableSet new];
    
    NSMutableArray *arrayA = @[@1,@2].mutableCopy;
    [set addObject:arrayA];
    NSLog(@"%@",set);
    
    NSMutableArray *arrayB = @[@1,@2].mutableCopy;
    [set addObject:arrayB];
    NSLog(@"%@",set);
    
    NSMutableArray *arrayC = @[@1].mutableCopy;
    [set addObject:arrayC];
    NSLog(@"%@",set);
    
    [arrayC addObject:@2];
    NSLog(@"%@",set);
    
    NSSet *setB = [set copy];
    NSLog(@"%@",setB);
    
    
#pragma mark - Class Cluster 类族
    
    EOCEmployee *employee = [EOCEmployee employeeWithType: EOCEmployeeTypeDeveloper];
    NSLog(@"%@",[employee class]);
    
    NSLog(@"%@",[arrayC class]);
    NSLog(@"%@",[NSMutableArray class]);
    
    NSLog(@"%d",[arrayC class] == [NSMutableArray class]);
    NSLog(@"%d",[arrayC isKindOfClass:[NSArray class]]);
    
#pragma mark - 关联对象
   
    void (^block)(void) = ^ {
        NSLog(@"Associated");
    };
    objc_setAssociatedObject(self.view, @"EOCBlockKey", block, OBJC_ASSOCIATION_COPY);

    void (^AssociatedBlock)(void) = objc_getAssociatedObject(self.view, @"EOCBlockKey");
    AssociatedBlock();
    
#pragma mark - objc_msgSend
    
    objc_msgSend(self,@selector(print:),@"objc_msgSend");
//    objc_msgSend_stret();
//    objc_msgSend_fpret();
//    objc_msgSendSuper();
    
#pragma mark - message forwarding 消息转发
    
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    
    //resolveInstanceMethod
    dict.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"%@",dict.date);
    
    //forwordingTargetForSelector
    objc_msgSend(dict, @selector(doADaysWork));
    
    //methodSignatureForSelector
    //forWordInvocaton
    objc_msgSend(dict, @selector(eatSometing));

    
#pragma mark - method swizzling (方法调配)
    
    NSString *string = @"This is a test tring";
//    NSLog(@"%@",[string lowercaseString]);
//    NSLog(@"%@",[string uppercaseString]);
    
//    Method orginalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
//    Method swappedMethod = class_getInstanceMethod([NSString class], @selector(uppercaseString));
//    method_exchangeImplementations(orginalMethod, swappedMethod);
    
//    NSLog(@"%@",[string lowercaseString]);
//    NSLog(@"%@",[string uppercaseString]);
    
    Method eoc_orginalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method eoc_swappedMethod = class_getInstanceMethod([NSString class], @selector(eoc_mylowercaseString));
    method_exchangeImplementations(eoc_orginalMethod, eoc_swappedMethod);

    [string lowercaseString];
    
    
    
}

- (void)print:(NSString*) sender{
    NSLog(@"%@",sender);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
