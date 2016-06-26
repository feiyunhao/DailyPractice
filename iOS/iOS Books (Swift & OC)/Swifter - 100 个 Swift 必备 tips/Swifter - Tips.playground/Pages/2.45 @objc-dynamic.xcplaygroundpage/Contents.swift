//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//在Swift中使用OC：{product-module-name}-Bridging-Header.h 会自动询问


class 我的类: NSObject {
    func 打招呼(名字: String) {
        print("哈喽\(名字)")
    }
}

我的类().打招呼("小明")

//@objc
//@dynamic


