//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let date1 = NSDate()
let name1: AnyClass! = object_getClass(date1)
print(name1)

let date2 = NSDate()
let name2 = date2.dynamicType
print(name2)

let string = "Hello"
let name = string.dynamicType
print(name)
debugPrint(name)