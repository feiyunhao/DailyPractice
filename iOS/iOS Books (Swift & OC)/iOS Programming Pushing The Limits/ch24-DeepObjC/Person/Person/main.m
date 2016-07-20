//
//  main.m
//  Person
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        [person setGivenName:@"Bob"];
        [person setSurname:@"Jones"];
        
        NSLog(@"%@ %@", [person givenName], [person surname]);
    }
}
