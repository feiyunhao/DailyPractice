//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//
//char bytes[] = {1, 2, 3};
//
//sizeof(bytes);

// 3

// Swift
sizeof(Int)
sizeof(CChar)

var bytes: [CChar] = [1,2,3]
sizeofValue(bytes)
// 8 64位系统一个引用的长度

let data = NSData(bytes: &bytes, length:sizeof(CChar) * bytes.count)


enum MyEnum: UInt16 {
    
    case A = 0
    
    case B = 1
    
    case C = 65535
    
}

sizeof(UInt16)

sizeof(MyEnum)

sizeofValue(MyEnum.A)

sizeofValue(MyEnum.A.rawValue)

sizeofValue(MyEnum.C)

sizeofValue(MyEnum.C.rawValue)

