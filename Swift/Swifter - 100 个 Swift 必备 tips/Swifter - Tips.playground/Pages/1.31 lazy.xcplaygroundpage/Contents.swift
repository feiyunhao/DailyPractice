//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//必须将延迟存储属性声明成变量(使用 var 关键字),因为属性的初始值可能在实例构造完成之后才会得 到。而常量属性在构造过程完成之前必须要有初始值,因此无法声明成延迟属性。
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问,则无法保证该属性只会被初始化一次。

class ClassA {
    lazy var str: String = {
        let str = "Hello"
        print("只在首次访问输出")
        return str
    }()
}

print("Creating object")
let obj = ClassA()

print("Accessing str")
obj.str

print("Accessing str again")
obj.str


let data1 = 1...3
let result1 = data1.map {
    (i: Int) -> Int in
    print("正在处理 \(i)")
    return i * 2
}

print("准备访问结果")
for i in result1 {
    print("操作后结果为 \(i)")
}

print("操作完毕")


//对于那些不需要完全运行，可能提前退出的情况，使用lazy来进行性能优化效果会非常有效

let data2 = 1...3
let result2 = data2.lazy.map {
    (i: Int) -> Int in
    print("正在处理 \(i)")
    return i * 2
}

print("准备访问结果")
for i in result2 {
    print("操作后结果为 \(i)")
}

print("操作完毕")


