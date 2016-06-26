//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//方法嵌套：在方法中定义其它方法
func appendQuery(var url: String,
                     key: String,
                     value: AnyObject) -> String {
    
    func appendQueryDictionary(var url: String,
                                   _ key: String,
                                     _ value: [String: AnyObject]) -> String {
        //...
        return "result"
    }
    
    func appendQueryArray(var url: String,
                              _ key: String,
                                _ value: [AnyObject]) -> String {
        //...
        return "result"
    }
    
    func appendQuerySingle(var url: String,
                               _ key: String,
                                 _ value: AnyObject) -> String {
        //...
        return "result"
    }
    
    if let dictionary = value as? [String: AnyObject] {
        
        return appendQueryDictionary(url, key, dictionary)
        
    } else if let array = value as? [AnyObject] {
        
        return appendQueryArray(url, key, array)
        
    } else {
        
        return appendQuerySingle(url, key, value)
        
    }
    
}

func makeIncrementor(addNumber: Int) -> (inout Int) -> Void {
    
    func incrementor(inout variable: Int) -> Void {
        variable += addNumber
    }
    return incrementor
    
}

