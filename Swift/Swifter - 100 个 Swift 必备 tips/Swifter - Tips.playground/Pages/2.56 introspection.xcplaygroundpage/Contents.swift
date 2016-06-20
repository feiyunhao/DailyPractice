//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//introspection 自省

class ClassA1: NSObject { }
class ClassB1: ClassA1 { }

let obj11: NSObject = ClassB1()
let obj21: NSObject = ClassB1()


//如果是NSObject之类的话，使用没问题
obj11.isKindOfClass(ClassA1.self)    // true
obj21.isMemberOfClass(ClassA1.self)

//非NSObject子类
//在绝大多数情况，Swift类型应该在编译期间就确定类型

class ClassA2 { }
class ClassB2: ClassA2 { }

let obj12: AnyObject = ClassB2()
let obj22: AnyObject = ClassB2()

obj12.isKindOfClass(ClassA2.self)
obj22.isMemberOfClass(ClassA2.self)



class ClassA { }
class ClassB: ClassA { }

let obj: AnyObject = ClassB()
if (obj is ClassA) {
    print("ઃ属于 ClassA")
}

if (obj is ClassB) {
    print("ઃ属于 ClassB")
}

//is 功能上相当于 isKingOfClass 可用于 Class Struct enum

let string = "String"
if string is String {
    // Do something
}
