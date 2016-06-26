//
//  ViewController.m
//  Blocks And Grand Central Dispatch
//
//  Created by feiyun on 16/5/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)NSLock *lock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
    
     _lock = [[NSLock alloc] init];
    
    //Already learned form  "狮子"！，therefor no coding;
}
-(void)synchronizedMethod{
    @synchronized (self) {
        //Safe
    }
    
    [_lock lock];
    
    [_lock unlock];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
