//
//  MYStringConersion.c
//  CoreFoundation
//
//  Created by feiyun on 16/7/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#include "MYStringConersion.h"

char * MYCFStringCopyUTF8String(CFStringRef aString) {
    if (aString == NULL) {
        return NULL;
    }
    CFIndex legth = CFStringGetLength(aString);
    CFIndex maxSize = CFStringGetMaximumSizeForEncoding(legth,kCFStringEncodingUTF8);
    char *buffer = (char*)malloc(maxSize);
    if (CFStringGetCString(aString, buffer, maxSize, kCFStringEncodingUTF8)) {
        return buffer;
    }
    free(buffer);
    return NULL;
}

const char * MYCFStringGetUTF8String(CFStringRef aString, char **buffer) {
    if (aString == NULL) {
        return NULL;
    }
    
    const char *cstr = CFStringGetCStringPtr(aString, kCFStringEncodingUTF8);
    
    if (cstr == NULL) {
        CFIndex length = CFStringGetLength(aString);
        CFIndex maxSize = CFStringGetMaximumSizeForEncoding(length, kCFStringEncodingUTF8) + 1;
        
        if (maxSize > malloc_size(buffer)) {
            *buffer = realloc(*buffer, maxSize);
        }
        if (CFStringGetCString(aString,*buffer, maxSize, kCFStringEncodingUTF8)) {
            cstr = *buffer;
        }
    }
    return cstr;
}