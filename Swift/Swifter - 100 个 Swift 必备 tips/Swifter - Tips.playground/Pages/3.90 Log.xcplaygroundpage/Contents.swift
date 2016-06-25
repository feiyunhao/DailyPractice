//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func printLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

func method() -> () {
    printLog("hello")
}

method()