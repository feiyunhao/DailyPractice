//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

protocol MyProtocol {
    func method()
}

extension MyProtocol {
    func method() {
        print("Called in extension")
    }
}

//struct MyStruct: MyProtocol {
//
//}
//MyStruct().method()
//// 输出：
//// Called in extension


struct MyStruct: MyProtocol {
    func method() {
        print("Called in struct")
    }
}
MyStruct().method()
// 输出：
// Called in struct


//也就是说，protocol extension 为 protocol 中定义的方法提供了一个默认的实现


protocol A1 {
    func method1() -> String
}

struct B1: A1 {
    func method1() -> String {
        return "hello"
    }
}

let b1 = B1()
b1.method1()

let a1: A1 = B1()
a1.method1()




protocol A2 {
    func method1() -> String
}

extension A2 {
    func method1() -> String {
        return "hi"
    }
    
    func method2() -> String {
        return "hi"
    }
}

struct B2: A2 {
    func method1() -> String {
        return "hello"
    }
    
    func method2() -> String {
        return "hello"
    }
}

let b2 = B2()

b2.method1()
b2.method2()

let a2 = b2 as A2

a2.method1()
a2.method2()

/*
如果类型推断得到的是实际的类型：
    那么类型中的实现将会被调用；如果类型中没有实现的话，那么接口扩展的默认实现将被使用
 
如果类型推断得到的是接口，而不是实际类型：
    并且方法在接口中定义了，那么类型中的实现将会被调用；如果类型中没有实现，那么接口扩展中的默认实现被使用
    否则（也就是方法没有在接口中定义），扩展中的默认实现将被调用
 */

