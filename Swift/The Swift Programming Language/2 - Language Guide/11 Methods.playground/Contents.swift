//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///Instance Method
///Type Method

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}


let counter = Counter()
// 初始计数值是0
counter.increment()
// 计数值现在是1 
counter.incrementBy(5) // 计数值现在是6 
counter.reset()
// 计数值现在是0