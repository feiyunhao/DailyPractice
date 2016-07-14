//
//  TimesTwoArray.m
//  KVC-Collection
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "TimesTwoArray.h"

@interface TimesTwoArray ()
@property (nonatomic, readwrite, assign) NSUInteger count;
@end

@implementation TimesTwoArray

- (NSUInteger)countOfNumbers {
    return self.count;
}

- (id)objectInNumbersAtIndex:(NSUInteger)index {
    return @(index * 2);
}

- (void)incrementCount {
    self.count++;
}
@end
