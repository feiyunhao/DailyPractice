//
//  MyMsgSend.c
//  Runtime
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#include <stdio.h>
#include <objc/runtime.h>
#include "MyMsgSend.h"

static const void *myMsgSend(id recevier, const char *name) {
    SEL selector = sel_registerName(name);
    IMP methodIMP = class_getMethodImplementation(object_getClass(recevier), selector);
    return methodIMP(recevier, selector);
}

void RunMyMsgSend() {
    Class class = (Class)objc_getClass("NSObject");
    id object = class_createInstance(class, 0);
    myMsgSend(object, "init");
    
    id description = (id)myMsgSend(object, "description");
    
    const char *cstr = myMsgSend(description, "UTF8String");
    printf("%s\n",cstr);
}
