//
//  SYURLSessionManager.h
//  codeAFNetworking
//
//  Created by feiyun on 16/4/24.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 `AFURLSessionManager` creates and manages an `NSURLSession` object based on a specified `NSURLSessionConfiguration` object, which conforms to `<NSURLSessionTaskDelegate>`, `<NSURLSessionDataDelegate>`, `<NSURLSessionDownloadDelegate>`, and `<NSURLSessionDelegate>`.
 
 `AFURLSessionManager`创建并且管理一个基于指定的`NSURLSessionConfiguration`的`NSURLSession` 实例，它遵循以下协议：`<NSURLSessionTaskDelegate>`, `<NSURLSessionDataDelegate>`, `<NSURLSessionDownloadDelegate>`, 和 `<NSURLSessionDelegate>`.
 
 ## Subclassing Notes  创建子类的说明
 
 This is the base class for `AFHTTPSessionManager`, which adds functionality specific to making HTTP requests. If you are looking to extend `AFURLSessionManager` specifically for HTTP, consider subclassing `AFHTTPSessionManager` instead.
 
 这是`AFHTTPSessionManager`的父类，`AFHTTPSessionManager`针对HTTP请求增加了功能特性。针对HTTP的扩展可考虑继承`AFHTTPSessionManager`
 
 ## NSURLSession & NSURLSessionTask Delegate Methods
 
 `AFURLSessionManager` implements the following delegate methods:
 `AFURLSessionManager`实现了以下代理方法：
 
 ### `NSURLSessionDelegate`
 
 - `URLSession:didBecomeInvalidWithError:`
 - `URLSession:didReceiveChallenge:completionHandler:`
 - `URLSessionDidFinishEventsForBackgroundURLSession:`
 
 ### `NSURLSessionTaskDelegate`
 
 - `URLSession:willPerformHTTPRedirection:newRequest:completionHandler:`
 - `URLSession:task:didReceiveChallenge:completionHandler:`
 - `URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:`
 - `URLSession:task:needNewBodyStream:`
 - `URLSession:task:didCompleteWithError:`
 
 ### `NSURLSessionDataDelegate`
 
 - `URLSession:dataTask:didReceiveResponse:completionHandler:`
 - `URLSession:dataTask:didBecomeDownloadTask:`
 - `URLSession:dataTask:didReceiveData:`
 - `URLSession:dataTask:willCacheResponse:completionHandler:`
 
 ### `NSURLSessionDownloadDelegate`
 
 - `URLSession:downloadTask:didFinishDownloadingToURL:`
 - `URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesWritten:totalBytesExpectedToWrite:`
 - `URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:`
 
 If any of these methods are overridden in a subclass, they _must_ call the `super` implementation first.
 这些方法如果在子类里被重写了，需首先让父类执行
 
 ## Network Reachability Monitoring
 ## 网络状态监控
 
 Network reachability status and change monitoring is available through the `reachabilityManager` property. Applications may choose to monitor network reachability conditions in order to prevent or suspend any outbound requests. See `AFNetworkReachabilityManager` for more details.
 
`reachabilityManager`可以监控网络状态和网络状态的改变。应用有可能需要监控网络状态以便阻止或者暂停网络请求。详见`AFNetworkReachabilityManager`
 
 ## NSCoding Caveats
 
 - Encoded managers do not include any block properties. Be sure to set delegate callback blocks when using `-initWithCoder:` or `NSKeyedUnarchiver`.
  Encoded managers 不包含任何 block properties， 请设置 在使用`-initWithCoder:` or `NSKeyedUnarchiver`的时候
 
 ## NSCopying Caveats
 
 - `-copy` and `-copyWithZone:` return a new manager with a new `NSURLSession` created from the configuration of the original.
 `-copy` and `-copyWithZone:`返回一个利用原来的configuration生成的新的`NSURLSession`
 
 - Operation copies do not include any delegate callback blocks, as they often strongly captures a reference to `self`, which would otherwise have the unintuitive side-effect of pointing to the _original_ session manager when copied.
 - 拷贝Operation不包含任何delegate callback blocks，由于他们经常强引用`self`；bulabulabula
 
 @warning Managers for background sessions must be owned for the duration of their use. This can be accomplished by creating an application-wide or shared singleton instance.
 */

@interface SYURLSessionManager : NSObject
/**
 *  被管理的session
 */
@property (readonly, nonatomic, strong) NSURLSession *session;

/**
 *  代理回调所在的operation queue
 */
@property (readonly, nonatomic, strong) NSOperationQueue *operationQueue;
/**
 
data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods ，
 服务器的响应 被responseSerializer自动的确认和序列化。默认的是一个`AFJSONResponseSerializer`实例，不能为空！
 
 
 @warning `responseSerializer` must not be `nil`.
 */
// TODO: AFURLResponseSerialization
//@property (nonatomic, strong) id <AFURLResponseSerialization> responseSerializer;

/**
 安全设置，如果不特殊设置默认用`defaultPolicy`
 */
//TODO:AFSecurityPolicy
//@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

#if !TARGET_OS_WATCH
///--------------------------------------
/// @name Monitoring Network Reachability
///--------------------------------------

/**
  网络状态监控，默认用`sharedManager`单例
 */
//TODO:AFNetworkReachabilityManager
//@property (readwrite, nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
#endif

/**
   被管理的session中当前所有的任务（data, upload, and download tasks）
 */
@property (readonly, nonatomic, strong) NSArray <NSURLSessionTask *> *tasks;

/**
 The data tasks currently run by the managed session.
 */
@property (readonly, nonatomic, strong) NSArray <NSURLSessionDataTask *> *dataTasks;

/**
 The upload tasks currently run by the managed session.
 */
@property (readonly, nonatomic, strong) NSArray <NSURLSessionUploadTask *> *uploadTasks;

/**
 The download tasks currently run by the managed session.
 */
@property (readonly, nonatomic, strong) NSArray <NSURLSessionDownloadTask *> *downloadTasks;

/**
  `completionBlock 的 队列，如果为`NULL`（默认），使用主队列
 */
@property (nonatomic, strong, nullable) dispatch_queue_t completionQueue;

/**
 completionBlock`. 的GCD group 如果为`NULL`（默认），使用一个私有的group
 */
@property (nonatomic, strong, nullable) dispatch_group_t completionGroup;


@end
