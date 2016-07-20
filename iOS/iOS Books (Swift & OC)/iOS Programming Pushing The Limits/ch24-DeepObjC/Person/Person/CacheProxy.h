//
//  CacheProxy.h
//  Person
//
//  Created by feiyun on 16/7/20.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheProxy : NSProxy
- (id)initWithObject:(id)anObject
          properties:(NSArray *)properties;
@end

@interface CacheProxy ()
@property (readonly, strong) id object;
@property (readonly, strong) NSMutableDictionary *valueForProperty;
@end
