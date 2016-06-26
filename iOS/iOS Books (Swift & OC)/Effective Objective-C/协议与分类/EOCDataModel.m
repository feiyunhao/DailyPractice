//
//  EOCDataModel.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCDataModel.h"
#import "EOCNetWorkFetcher.h"

@interface EOCDataModel ()<EOCNetWorkFetcherDelegate>

@end

@implementation EOCDataModel

-(void)networkFetcher:(EOCNetWorkFetcher *)fetcher didFailWithError:(NSError *)error{
    
}

-(void)networkFetcher:(EOCNetWorkFetcher *)fetcher didReceiveData:(NSData *)data{
    
}

@end
