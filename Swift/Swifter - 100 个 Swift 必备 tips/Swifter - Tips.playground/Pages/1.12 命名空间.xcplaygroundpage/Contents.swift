//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//OC没有命名空间，为了避免冲突，一般加上前缀
//Swift可以使用命名空间，即是是名字相同的类型，只要来自不同的命名空间，都可以和平相处
//Swift命名空间基于module
//Cocoa(Touch) FrameWork 的 target 方法 创建一个新的module




//另一种方式是使用类型嵌套的方法来指定访问范围

struct MyClassContainer1 {
    class MyClass {
        class func hello() {
            print("hello from MyClassContainer1")
        }
    }
}

struct MyClassContainer2 {
    class MyClass {
        class func hello() {
            print("hello from MyClassContainer2")
        }
    }
}

MyClassContainer1.MyClass.hello()

MyClassContainer2.MyClass.hello()