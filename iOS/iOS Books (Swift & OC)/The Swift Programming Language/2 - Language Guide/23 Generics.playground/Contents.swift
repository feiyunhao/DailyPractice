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


struct IntStack1 {
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

protocol Container {
//    关联类型被指定为 typealias 关键字。
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    
    // IntStack的原始实现 
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack1<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol 
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

extension Array: Container {}


//where

//类型约束 能够确保 类型 符合 泛型函数 或 类 的 定义约束。

//你可以在参数列表中通过where语句定义参数的约束。
//一个 where 语句能够使 一个关联类型遵循 一个特定的协议,
//以及(或)那个特定的 类型参数 和 关联类型 可以是相同的。
//你可以写一个 where 语句,紧跟在在 类型参数列表 后面,where语句后跟一个或者多个针对关联类型的约束,
//以及(或)一个或多个类型和关联类型间的等价(equality)关系。

//一个类型约束和 where 语句结合:
func allItemsMatch< C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable> (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // 检查两个Container的元素个数是否相同 
    if someContainer.count != anotherContainer.count { return false}

    // 检查两个Container相应位置的元素彼此是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {return false }
    }
    // 如果所有元素检查都相同则返回true
    return true
}


var stackOfStrings1 = Stack<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings1, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}



