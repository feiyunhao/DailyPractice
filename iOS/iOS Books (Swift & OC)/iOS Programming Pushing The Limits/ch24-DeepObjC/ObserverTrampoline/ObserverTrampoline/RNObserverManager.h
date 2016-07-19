//
//  RNObserverManager.h
//  ObserverTrampoline
//
//  Created by feiyun on 16/7/19.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNObserverManager : NSObject

- (id)initWithProtocol:(Protocol *)protocol
             observers:(NSSet *)observers;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end
