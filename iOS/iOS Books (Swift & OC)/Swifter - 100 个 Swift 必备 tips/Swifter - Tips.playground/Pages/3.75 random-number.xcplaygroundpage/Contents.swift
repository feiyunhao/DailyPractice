//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//由于cup时钟，进程，和线程所构建出来的世界，是没有真正的随机数
//在给定一个随机种子后，使用某些算法可以得到伪随机的序列

//iphone5 及之前 Int 是 Int32
//64位处理器 Int 是 Int64
//arc4random() -> UInt32
//在32位平台就有一半几率在进行Int转换是 越界 ？？

let diceFaceCount1 = 6

let randomRoll1 = Int(arc4random()) % diceFaceCount1 + 1

print(randomRoll1)

let diceFaceCount: UInt32 = 6

let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1

print(randomRoll)

func randomInRange(range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return  Int(arc4random_uniform(count)) + range.startIndex
}

for _ in 0...100 {
    print(randomInRange(1...6))
}
