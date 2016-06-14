//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//@autoclosure把表达式自动封装成一个闭包

func logIfTure(predicate: () -> Bool) {
    if predicate() {
        print("true")
    }
}

logIfTure({ 2 < 3 })

logIfTure{ 2 < 3 }

func logIfTrue(@autoclosure predicate: () -> Bool) {
    if predicate() {
        print("true")
    }
}

logIfTrue(2 < 3)

var value: Int?
let startValue = 1

var currentValue = value ?? startValue


//@autoclosure 并不支持带参数的写法， 也就是只有形式为 () -> T的才可以简化


