//
//  MYStringConersion.h
//  CoreFoundation
//
//  Created by feiyun on 16/7/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#include <CoreFoundation/CoreFoundation.h>
#include <malloc/malloc.h>

CF_IMPLICIT_BRIDGING_ENABLED

char * MYCFStringCopyUTF8String(CFStringRef aString) CF_RETURNS_NOT_RETAINED;
const char * MYCFStringGetUTF8String(CFStringRef aString, char **buffer);

CF_IMPLICIT_BRIDGING_DISABLED
