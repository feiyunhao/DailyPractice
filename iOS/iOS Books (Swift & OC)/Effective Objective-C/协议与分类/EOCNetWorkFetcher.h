//
//  EOCNetWorkFetcher.h
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOCNetWorkFetcher;

@protocol EOCNetWorkFetcherDelegate <NSObject>

@optional

- (void)networkFetcher:(EOCNetWorkFetcher*)fetcher didReceiveData:(NSData*)data;
- (void)networkFetcher:(EOCNetWorkFetcher*)fetcher didFailWithError:(NSError*)error;
- (void)networkFetcher:(EOCNetWorkFetcher*)fetcher didUpdateProgressTo:(NSProgress*)progress;
- (BOOL)networkFetcher:(EOCNetWorkFetcher*)fetcher shouldFollowRedirectToURL:(NSURL*)url;

@end


@interface EOCNetWorkFetcher : NSObject

@property (nonatomic, weak)id <EOCNetWorkFetcherDelegate> delegate;

@end
