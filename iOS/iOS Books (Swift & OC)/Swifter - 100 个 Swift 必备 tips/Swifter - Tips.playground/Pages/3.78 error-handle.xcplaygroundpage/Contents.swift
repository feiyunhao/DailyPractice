//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//带有NSError指针作为参数的API都可以改为抛出异常的形式

let d = NSData()

do {
    try d.writeToFile("Hello", options: [])
} catch let error as NSError {
    print ("Error: \(error.domain)")
}


enum LoginError: ErrorType {
    case UserNotFound, UserPasswordNotMatch
}

func login(user: String, password: String) throws {
    let users = [String: String]()
    
    if !users.keys.contains(user) {
        throw LoginError.UserNotFound
    }
    
    if users[user] != password {
        throw LoginError.UserPasswordNotMatch
    }
    
    print("Login successfully.")
}

do {
    try login("macbookpro", password: "111111")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
}


//可以看出，在Swift中，我们虽然把这块内容叫做异常，当实质上是错误而非真正意义的异常


//对于非同步API来说，抛出异常是不可用的 －－ 异常只是一个同步方法专用的处理机制。
//coco框架对于异步api，保留了原来的NSError机制，

enum Result {
    
    case Success(String)
    
    case Error(NSError)
    
}

//func doSomethingParam(param:AnyObject) -> Result {
//    if true {
//        return Result.Success("success")
//    } else {
//        let error = NSError(domain: "errorDomain", code: 1, userInfo: nil)
//        return Result.Error(error)
//    }
//｝

//let result = doSomethingParam(path)
//
//switch result {
//    
//case let .Success(ok):
//    
//    let serverResponse = ok
//    
//case let .Error(error):
//    
//    let serverResponse = error.description
//        
//}

/**
 *  在Swift2.0时代的错误处理，现在一般的最佳实践是，对于同步API使用异常机制，对于异步API使用泛型枚举
 */

//在可以throw的方法里，永远不要返回一个optional值
//因为结合try？使用的话，这个optional值会再次被包装一层optional

enum Error: ErrorType {
    case Negative
}

func methodThrowsWhenPassingNegative(number: Int) throws -> Int {
    if number < 0 {
        throw Error.Negative
    }
    return number
}

if let num = try? methodThrowsWhenPassingNegative(100) {
    print(num.dynamicType)
} else {
    print("failed")
}

// Never do this!
func methodThrowsWhenPassingNegative1(number: Int) throws -> Int? {
    if number < 0 {
        throw Error.Negative
    }
    if number == 0 {
        return nil
    }
    return number
}

if let num = try? methodThrowsWhenPassingNegative1(0) {
    print(num.dynamicType)
} else {
    print("failed")
}


//rethrows 一般用在参数中可以throws的方法的高阶函数

//简单理解：
//rethrows 是throws的“子类”
//rethrows的方法可以用来重载哪些被标记为throws的方法或者参数，或者用来满足被标记为throws的接口，反过来不行


func methodThrows(num: Int) throws {
    if num < 0 {
        print("Throwing!")
        throw Error.Negative
    }
    print("Executed!")
}

func methodRethrows(num: Int, f: Int throws -> ()) rethrows {
    try f(num)
}

do {
    try methodRethrows(1, f: methodThrows)
} catch _ {
    
}



