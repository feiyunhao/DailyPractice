//
//  ViewController.m
//  ObserverTrampoline
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import "RNObserverManager.h"

@protocol MyProtocol <NSObject>

- (void)doSomething;

@end

@interface MyClass : NSObject <MyProtocol>
@end

@implementation MyClass

- (void)doSomething {
    NSLog(@"doSomething :%@", self);
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSet *observers = [NSSet setWithObjects:[MyClass new],
                        [MyClass new], nil];
    
    self.observerManager = [[RNObserverManager alloc]
                            initWithProtocol:@protocol(MyProtocol)
                            observers:observers];
    
    [self.observerManager doSomething];
   
}


@end
