//
//  main.m
//  ISASwizzle
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "NSObject+SetClass.h"
#import "MYNotificationCenter.h"

@interface Observer : NSObject
@end

@implementation Observer

- (void)somthingHappened:(NSNotification*)note {
    NSLog(@"Something happened");
}
@end

int main(int argc, char *argv[])
{
    int retVal = 0;
    @autoreleasepool {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc setClass:[MYNotificationCenter class]];
        Observer *observer = [[Observer alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:observer
                                                 selector:@selector(somthingHappened:)
                                                     name:@"SomethingHappenedNotification"
                                                   object:nil];
    }
    return retVal;
}
