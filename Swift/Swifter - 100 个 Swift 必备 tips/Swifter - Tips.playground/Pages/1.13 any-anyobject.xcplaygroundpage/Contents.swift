//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//AnyObject: 任何Class类型   id
//不会对实例的方法调用做出检查，所有的方法调用都返回optional的结果
//应该选择的做法是，在使用前先确定真正类型并转换后再使用

//Any: 任何类型
//Array Dictionary 是 struct 类型

let swiftInt: Int = 1
let swiftString: String = "miao"

//自动转化为 NSString 和 NSNumber
var array: [AnyObject] = []
array.append(swiftInt)
array.append(swiftString)

// Without UIKit:
//let swiftInt: Int = 1
//let swiftString: String = "miao"
//
//var array: [Any] = []
//array.append(swiftInt)
//array.append(swiftString)
//array

//最好明确指明类型