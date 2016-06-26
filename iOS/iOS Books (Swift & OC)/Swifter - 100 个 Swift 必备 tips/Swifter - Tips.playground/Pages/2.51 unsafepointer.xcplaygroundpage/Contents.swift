//: [Previous](@previous)

import Foundation


//: [Next](@next)

func method(num: UnsafePointer<CInt>) {
    print(num.memory)
}

var a: CInt = 123
method(&a)    // 输出 123

let arr = NSArray(object: "meow")
CFArrayGetValueAtIndex(arr, 0)
let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), CFString.self)

//我们不必遵守类型转换的检查，而拥有了在指针层面直接操作内存的机会

