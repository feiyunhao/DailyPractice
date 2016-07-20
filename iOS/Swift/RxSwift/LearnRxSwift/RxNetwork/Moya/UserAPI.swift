//
//  UserAPI.swift
//  LearnRxSwift
//
//  Created by feiyun on 16/7/16.
//  Copyright © 2016年 feiyun. All rights reserved.
//


import Moya

 let UserProvider = RxMoyaProvider<UserAPI>()

public enum UserAPI {
    case Users
}

extension UserAPI: TargetType {
    public var baseURL: NSURL { return NSURL(string: host)! }
    public var path: String {
        switch self {
        case .Users:
            return "/users"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject]? {
        return nil
    }
    
    public var sampleData: NSData {
        switch self {
        case .Users:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    public var multipartBody: [MultipartFormData]? { return nil }
}
