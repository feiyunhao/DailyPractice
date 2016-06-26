//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func sayHello(personName: String) -> String {
    let greeting = "Hello," + personName + "!"
    return greeting;
}
sayHello("playground")
print(sayHello("Swift"))


func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}
print(sayHelloAgain("Anna"))

func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())

func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}


sayHello("Tim", alreadyGreeted: true)
sayHello("Tim", alreadyGreeted: false)


func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")

//没有定义返回值的 返回一个空的元组

func printAndCount(stringToPrint: String) -> Int {
    print(stringToPrint)
    return stringToPrint.characters.count
}
func printWithoutCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}

printAndCount("hello, world")

printWithoutCounting("hello, world")

//func minMax(array: [Int]) -> (min: Int,max: Int) {
//    var currentMin = array[0]
//    var currentMax = array[0]
//    
//    for item in array {
//        if item > currentMax {
//            currentMax = item
//        } else if item < currentMin {
//            currentMin = item
//        }
//    }
//    
//    return (currentMin, currentMax)
//}

//minMax([1,2,-3,4,15,6]).1
//minMax([1,2,-3,4,15,6]).min

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
//    return minMax(array)
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array {
        if item > currentMax {
            currentMax = item
        } else if item < currentMin {
            currentMin = item
        }
    }
    
    return (currentMin, currentMax)
}

if let bounds = minMax([Int]()) {
    print(bounds)
} else {
    print("empty")
}

func someFunction(firstParameterName: Int, SecondParameterName: Int) -> () {
}
someFunction(1, SecondParameterName: 2)

func someFunction(externalParameterName localParameterName: Int) -> () {
    
}
someFunction(externalParameterName: 1)


func someFuncton(localParameterName: Int) -> () {
}
someFuncton(1)


func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello," + person + " and " + anotherPerson;
}

sayHello(to: "Bill", and: "Ted")

func someFunction(firstParameterName: Int, _ SecondParameterName: Int) -> () {
    
}
someFunction(1, 2)

func someFunctionDefault(parameterWithDefault: Int = 12) -> Int {
    return parameterWithDefault

}

someFunctionDefault()
someFunctionDefault(1)

func arithmeticMean(numbers: Int...) -> Int {
    var total: Int = 0
    for number in numbers {
        total += number
    }
    return total
}
arithmeticMean(1,2,3,4,5)
//一个函数最多只能有一个可变参数，

func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    
    return string
}

let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")

func swapTwoInts(inout a: Int, inout b: Int){
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

swapTwoInts(&someInt, b: &anotherInt)

someInt
anotherInt




