//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 4
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt

/**
 *  泛型函数
 */

func swapTwoValues<T>(inout a: T, inout _ b: T ) {
    let teporaryA = a
    a = b
    b = teporaryA
}
//使用占位类型名称来代替实际类型名

swapTwoValues(&someInt, &anotherInt)
someInt
anotherInt


/**
 *  Stack
 */


struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

//类型约束 指定了一个必须继承自指定类的类型参数， 或者遵循一个特定 的 协议 或 协议构成

//类型约束语法

/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // 这里是函数主体
}
 */

func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)")
}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")


/**
 *  Associated Types
 */

//typealias




