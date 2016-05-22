//
//  ViewController.m
//  协议与分类
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @try {
        [[NSArray new] performSelector:@selector(doSomething)];
    } @catch (NSException *exception) {
        NSLog(@"Whoops, there was an error. Oh well ......");
    } @finally {
        NSLog(@"finally");
    }
    
    NSString __weak *string = [NSString new];
    [string length];
    
    [NSLinguisticTagger class];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
