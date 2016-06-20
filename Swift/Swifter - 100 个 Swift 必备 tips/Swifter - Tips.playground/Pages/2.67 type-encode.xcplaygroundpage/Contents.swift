//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

//类型编码
//通过NSValue的objcTpye来获取对应类型的指针

let int: Int = 0

let float: Float = 0.0

let double: Double = 0.0

let intNumber: NSNumber = int

let floatNumber: NSNumber = float

let doubleNumber: NSNumber = double

String.fromCString(intNumber.objCType)

String.fromCString(floatNumber.objCType)

String.fromCString(doubleNumber.objCType)


let p = NSValue(CGPoint: CGPointMake(3, 3))
String.fromCString(p.objCType)

let t = NSValue(CGAffineTransform: CGAffineTransformIdentity)
String.fromCString(t.objCType)


