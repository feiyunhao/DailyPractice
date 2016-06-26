//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class MyClass {
    var a = 1
    deinit {
        print("deinit")
    }
}

var pointer: UnsafeMutablePointer<MyClass>!

pointer = UnsafeMutablePointer<MyClass>.alloc(1)    //
pointer.initialize(MyClass())                       //

print(pointer.memory.a)
pointer.destroy()   //释放指针指向的内存的对象
pointer.dealloc(1)  //释放指针本身
pointer = nil

//谁创建，谁释放
var x:UnsafeMutablePointer<tm>!
var t = time_t()
time(&t)
x = localtime(&t)
x = nil
