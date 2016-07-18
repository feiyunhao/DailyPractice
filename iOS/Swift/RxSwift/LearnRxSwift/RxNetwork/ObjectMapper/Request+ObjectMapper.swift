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
    case Underlying(ErrorType)
}

public extension ObservableType where E == (NSHTTPURLResponse,AnyObject) {
    
}
