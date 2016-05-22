//
//  EOCNetWorkFetcher.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCNetWorkFetcher.h"

@interface EOCNetWorkFetcher(){
    
    //位域 位段
    struct {
        unsigned int didReceivedData : 1;
        unsigned int didFailWithError : 1;
        unsigned int didUpdateProgressTo : 1;
    } _delegateFlags;
    
}

@end

@implementation EOCNetWorkFetcher

-(void)setDelegate:(id<EOCNetWorkFetcherDelegate>)delegate{
    
    _delegate = delegate;
    _delegateFlags.didReceivedData = [_delegate respondsToSelector:@selector(networkFetcher:didReceiveData:)] ;
    _delegateFlags.didFailWithError = [_delegate respondsToSelector:@selector(networkFetcher:didFailWithError:)] ;
    _delegateFlags.didUpdateProgressTo = [_delegate respondsToSelector:@selector(networkFetcher:didUpdateProgressTo:)] ;
    
}

- (void)doSomeThing{
    
    if (_delegateFlags.didUpdateProgressTo) {
        [_delegate networkFetcher:self didUpdateProgressTo:[NSProgress currentProgress]];
    }
}
@end
