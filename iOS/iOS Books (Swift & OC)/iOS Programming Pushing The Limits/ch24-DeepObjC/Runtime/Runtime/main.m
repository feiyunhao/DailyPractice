//
//  main.m
//  Runtime
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "MyMsgSend.h"
#import "FastCall.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        unsigned int count = 0;
        Method *methods = class_copyMethodList([NSObject class],
                                               &count);
        for (unsigned int i = 0; i < count; ++i) {
            SEL sel = method_getName(methods[i]);
            const char *name = sel_getName(sel);
            printf("%s\n", name);
        }
        free(methods);
        
        printf("\n\nRunMyMsgSend()\n");
        RunMyMsgSend();
        printf("\n\nFastCall()\n");
        FastCall();
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
