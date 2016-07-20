//
//  Request+ObjectMapper.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import RxSwift
import ObjectMapper
import Alamofire

public enum AlamofireError: ErrorType {
    case ImageMapping(NSHTTPURLResponse)
    case JSONMapping(NSHTTPURLResponse)
    case StringMapping(NSHTTPURLResponse)
    case StatusCode(NSHTTPURLResponse)
    case Data(NSHTTPURLResponse)
    case Underlyng(ErrorType)
}

public extension ObservableType where E == (NSHTTPURLResponse,AnyObject) {
    
    public func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
        .flatMap{ response -> Observable<T> in
            guard let object = Mapper<T>().map(response.1["data"]) else {
                throw AlamofireError.JSONMapping(response.0)
            }
            return Observable.just(object)
        }
        .observeOn(MainScheduler.instance)
    }
    
    public func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<[T]> in
                guard let object = Mapper<T>().mapArray(response.1["data"]) else {
                    throw AlamofireError.JSONMapping(response.0)
                }
                return Observable.just(object)
            }
            .observeOn(MainScheduler.instance)
    }

}
