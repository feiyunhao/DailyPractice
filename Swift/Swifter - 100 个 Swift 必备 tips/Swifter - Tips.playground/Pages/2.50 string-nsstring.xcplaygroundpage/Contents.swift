//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let levels = "ABCDE"
for i in levels.characters {
    print(i)
}

if (levels as NSString).containsString("BC") {
    print("包含字符串")
}

let nsRange = NSMakeRange(1, 4)


let indexPositionOne = levels.startIndex.successor()
let swiftRange = indexPositionOne ..< indexPositionOne.advancedBy(4)
levels.stringByReplacingCharactersInRange(swiftRange, withString: "AAAA")
// 输出：
// AAAAA

(levels as NSString).stringByReplacingCharactersInRange(
    nsRange, withString: "AAAA")

