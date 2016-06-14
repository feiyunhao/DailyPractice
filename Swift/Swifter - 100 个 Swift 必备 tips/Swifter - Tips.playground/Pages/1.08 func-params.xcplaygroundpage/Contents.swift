//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func incrementor(variable: Int) -> Int {
    return variable + 1
}

func incrementor1(var variable: Int) -> Int {
    variable += 1
    return variable
}

var luckyNumber = 6
let newNumber = incrementor1(luckyNumber)
luckyNumber

func incrementor2(variable: Int) -> Int {
    var num = variable
    num += 1
    return num
}

func incrementor3(inout variable: Int) {
    variable += 1
}

incrementor3(&luckyNumber)
luckyNumber
//参数的修饰就有传递性
//对于跨越层级的调用，我们要保证同一参数的修饰是统一的

func makeIncrementor(addNumber: Int) -> (inout Int) -> () {
    func incrementor(inout variable: Int) -> () {
        variable += addNumber
    }
    return incrementor
}

makeIncrementor(3)(&luckyNumber)

        