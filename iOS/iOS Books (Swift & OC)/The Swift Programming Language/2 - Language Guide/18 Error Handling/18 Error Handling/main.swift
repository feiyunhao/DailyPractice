//
//  main.swift
//  18 Error Handling
//
//  Created by feiyun on 16/6/6.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import Foundation

print("Hello, World!")


//: Playground - noun: a place where people can play

var str = "Hello, playground"

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

//throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

//Swift中有 4 种处理错误的方式。
//你可以把函数抛出的错误传递给调用此函数的 代码、
//用 do-catch 语句处理错误、
//将错误作为可选类型处理、
//或者断言此错误根本不会发生。


//为了标识出这些地方,在调用一个能抛出错误的函数,方法,或者构造器之前,加上 try 关键 字 - 或者 try? 或者 try! 的变体。

//func canThrowErrors() throws -> String
//func cannotThrowErrors() -> String


struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(name)
    }
}

let favoriteSnacks = [ "Alice": "Chips", "Bob": "Licorice", "Eve": "Pretzels", ]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

//try buyFavoriteSnack("zhangsan", vendingMachine: VendingMachine())

/*
     do {
     try expression
     statements
     } catch pattern 1 {
     statements
     }
     catch pattern 2 where condition {
     statements
     }
 */

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 100
do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}

//可以使用 try? 通过将其转换成一个可选值来处理错误。如果在评估 try? 表达式时一个错误被抛出,那么这个表 达式的值就是 nil 。
func someThrowingFunction() throws -> Int {
    // ...
    throw VendingMachineError.InvalidSelection
}
let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的。在这种条件下,你可以在表达式前面写 try! 来使错误传递失效,并把调用包装在一个运行时断言(runtime assertion)中来断定不会有错误抛出。


//有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的。在这种条件下,你可以在表达式前面写 try! 来使错误传递失效,并把调用包装在一个运行时断言(runtime assertion)中来断定不会有错误抛出。

//可以使用 defer 语句在代码执行到 要离开 当前的代码段 之前去执行一套语句。

//延迟执行的操作是按照它们被指定的相反顺序执行 - 意思是第一条 defer 语句中 的代码执行是在第二条 defer 语句中代码被执行之后,以此类推。
/*
func processFile(filename: String) throws {
    
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
        // 处理文件 
        }
        // 在这里,作用域的最后调用 close(file)
    }
}
 */
