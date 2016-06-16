//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//我们希望接口中使用的类型就是这个接口本身的类型的话，就需要使用Self
//这种情况下，Self不仅指代实现该接口的类型本身，也包括其子类

protocol Copyable {
    func copy() -> Self
}

//class MyClass: Copyable {
//    var num = 1

        ///该方法要求返回一个抽象的，表示当前类型的Self

//    func copy() -> Self {
//        let result = MyClass()
//        result.num = num

            /// 返回了真实的MyClass

//        return result
//    }
//}

class MyClass: Copyable {
    
    var num = 1
//    该方法要求返回一个抽象的，表示当前类型的Self
    func copy() -> Self {
//        我们需要的是通过一个和当前上下文无关，又能指代当前类型的方法进行初始化
        let result = self.dynamicType.init()
        result.num = num
        return result
    }
//编译器提醒：  如果想构建一个Self类型的对象的话，需要有required关键字修饰的初始化方法
    required init() {
        
    }
}

let object = MyClass()

object.num = 100

let newObject = object.copy()

object.num = 2

print(object.num)

print(newObject.num)
