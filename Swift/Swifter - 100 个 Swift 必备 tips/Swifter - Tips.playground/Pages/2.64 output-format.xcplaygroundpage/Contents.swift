//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let a = 3;
let b = 1.234567  // 我们在这里不去区分 float 和 Double 了
let c = "Hello"
print("int:\(a) double:\(b) string:\(c)")


let format = String(format:"%.2f",b)
print("double:\(format)")

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

let f = ".2"
print("double:\(b.format(f))")
