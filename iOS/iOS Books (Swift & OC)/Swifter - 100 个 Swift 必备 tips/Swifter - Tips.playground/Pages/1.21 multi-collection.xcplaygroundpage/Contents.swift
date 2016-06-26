//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let numbers = [1,2,3,4,5]
// numbers 的类型是 [Int]

let strings = ["hello", "world"]
// strings 的类型是 [String]

import UIKit

let mixed1: [Any] = [1, "two", 3]

// 如果不指明类型，由于 UIKit 的存在
// 将被推断为 [NSObject]
let objectArray = [1, "two", 3]

let any = mixed1[0]  // Any 类型
let nsObject = objectArray[0] // NSObject 类型

//Any就是protocol，而不是具体的某个类型
//在容器类型泛型的帮助下，不仅可以添加具体同一类型的对象，
//还可以添加实现了同一接口的类型的对象

let mixed2: [CustomStringConvertible] = [1, "two", 3]
for obj in mixed2 {
    print(obj.description)
}

//另一种做法是使用enum可以带有值的特性，将类型信息封装到特定的enum中

enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}

let mixed3 = [IntOrString.IntValue(1),
              IntOrString.StringValue("two"),
              IntOrString.IntValue(3)]

for value in mixed3 {
    switch value {
    case let .IntValue(i):
        print(i)
    case let .StringValue(s):
        print(s.capitalizedString)
    }
}

