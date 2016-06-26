//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

/// 实例方法的动态调用

//一个有意思些发：不直接使用实例调用这个实例上的方法
//通过类型取出这个类型的某个实例方法的签名，然后再通过传递实例来拿到实际需要调用的方法

class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

//限定来我们只有在编译的时候决定实例和对应的方法调用
let object = MyClass()
let result = object.method(1)

let f = MyClass.method
// f: MyClass -> (Int) -> Int
//let f = { (obj: MyClass) in obj.method }

let object1 = MyClass()
let result1 = f(object)(1)

//这种方法只适用于实例方法，对于属性的setter getter是不能这样写的

//冲突，需要显式声明
class MyClass1 {
    func method(number: Int) -> Int {
        return number + 1
    }
    
    class func method(number: Int) -> Int {
        return number
    }
}

let f1 = MyClass1.method
// class func method 的版本

let f2: Int -> Int = MyClass1.method
// 和 f1 相同

let f3: MyClass1 -> Int -> Int = MyClass1.method
// func method 的柯里化版本

