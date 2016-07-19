//
//  RNMainThreadTrampoline.h
//  ObserverTrampoline
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNMainThreadTrampoline : NSObject

@property (nonatomic, readwrite, strong) id target;
- (id)initWithTarget:(id)aTarget;

@end
