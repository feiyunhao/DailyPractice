//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/// Closures

/// 利用上下文推断参数 和 返回值类型
/// 隐式返回单表达式闭包，（单表达式闭包可以省略 return 关键字）
/// 参数名称缩写


/**
 *  Closure Expressions
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 < s2
}

names.sort(backwards)
names.sort({
    (s1: String, s2: String) ->Bool in
    return s1 < s2
})

names.sort({(s1: String, s2: String) -> Bool in return s1 < s2 })

names.sort({s1, s2 in return s1 < s2 })

names.sort({s1, s2 in s1 < s2})

names.sort({$0 < $1})

names.sort(){$0 < $1}

names.sort{$0 < $1}

names.sort(<)


/**
 *  Trailing Closures
 */

func someFunctionThatTakesAClosure(closure: () -> Void) -> Void {
    //函数主题部分
    closure()
}

someFunctionThatTakesAClosure({
    //闭包主题部分
    print("Closure")
})

someFunctionThatTakesAClosure() {
    
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]


numbers.map { (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}


/**
 *  Capturing Values
 */

func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

makeIncrementor(forIncrement: 1)
makeIncrementor(forIncrement: 1)()
makeIncrementor(forIncrement: 1)()


let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()

/**
 *  Closure Are Reference Types
 */

let alsoInrementByTen = incrementByTen
alsoInrementByTen()

/**
 *  Nonescaping Closures
 */


/**
 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称闭包从函数中逃逸，当定义接受闭包作为函数参数时，在参数名钱标注 @noescape 指明不许逃逸
*/
func someFunctionWithNoescapingClosure(@noescape closure:() -> Void) -> () {
    closure()
}


/// 一种能使闭包逃逸出函数的方法是，将这个闭包保存在函数外部定义的变量中

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { 
            self.x = 100
        }
        someFunctionWithNoescapingClosure { 
            x = 200
//            self.x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
instance.x
completionHandlers.first?()
instance.x


/**
 *  Autoclsures
 */

/// 自动闭包是一种 自动创建的 闭包，用于 包装 传递给函数的 作为参数的 表达式 （自动创建， 用于 包装 表达式）
///这种闭包不接受任何参数，当被调用的时候，自动返回包装在其中的表达式。
///这种便利的语法让你能够用一个普通的表达式来代替显示的闭包

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")

print(customersInLine.count)


func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )

//没有接受显示闭包
//将参数标记为 @autoclosure 接收自动闭包
func serveCustomer(@autoclosure customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))


//autoclosure 暗示了 @noescape
// 如果想逃逸 @autoclosure(escaping)

var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))
print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}


