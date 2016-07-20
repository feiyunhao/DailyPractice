
#import "NSObject+SetClass.h"
#import <objc/runtime.h>

@implementation NSObject (SetClass)
- (void)setClass:(Class)aClass {
  NSAssert(class_getInstanceSize([self class]) ==
           class_getInstanceSize(aClass),
           @"Classes must be the same size to swizzle.");
  object_setClass(self, aClass);
}
@end
