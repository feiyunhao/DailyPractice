
#import "FastCall.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

const NSUInteger kTotalCount = 100000000;

typedef void (*voidIMP)(id, SEL, ...);

void FastCall() {
  NSMutableString *string = [NSMutableString string];
  NSTimeInterval totalTime = 0;
  NSDate *start = nil;
  NSUInteger count = 0;
  
  // With objc_msgSend
  start = [NSDate date];
  for (count = 0; count < kTotalCount; ++count) {
    [string setString:@"stuff"];
  }
  
  totalTime = -[start timeIntervalSinceNow];
  printf("w/ objc_msgSend = %f\n", totalTime);
  
  // Skip objc_msgSend.
  start = [NSDate date];
  SEL selector = @selector(setString:);
  voidIMP
  setStringMethod = (voidIMP)[string methodForSelector:selector];
  
  for (count = 0; count < kTotalCount; ++count) {
    setStringMethod(string, selector, @"stuff");
  }
  
  totalTime = -[start timeIntervalSinceNow];
  printf("w/o objc_msgSend  = %f\n", totalTime);
}
