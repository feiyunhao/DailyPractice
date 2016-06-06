//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
    extension SomeType {
         加到SomeType的新功能写到这里 
    }
 
    一个扩展可以扩展一个已有类型,使其能够适配一个或多个协议(protocol)。
    extension SomeType: SomeProtocol, AnotherProctocol {
         协议实现写到这里
    }
 */


//Computed Properties
//扩展可以向已有类型添加 计算型 实例属性 和计算型 类型属性。

extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//扩展可以添加新的 计算属性,但是不可以 添加 存储属性,
//也不可以向已有属性添加属性观测器(property observ ers)。


///Initializers
//扩展能向类中添加新的 便利构造器,
//但是它们不能向类中添加新的 指定构造器 或 析构器。
//指定构造器和析构器必须总是由原始的类实现来提供。






