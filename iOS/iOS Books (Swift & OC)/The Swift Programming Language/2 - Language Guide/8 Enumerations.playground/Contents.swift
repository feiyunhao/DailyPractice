//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum SomeEnumeration {
    
}

enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn
}

var directionToHead = CompassPoint.East
directionToHead = .North

switch directionToHead {
case .East: break
case .South: break
case .West: break
case .North: break
}

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.QRCode("how are you")

switch productBarcode {
case .UPCA(let a, let b, let c, let d):
    print(a,b,c,d)
case .QRCode(let string):
    print(string)
}

switch productBarcode {
case let .UPCA(a, b, c, d):
    print(a,b,c,d)
case let .QRCode(string):
    print(string)
}

enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

enum PlanetOne: Int {
    case Mercury = 1,Venus
}

PlanetOne.Venus
PlanetOne.Venus.rawValue

enum CompassPointOne: String {
    case North, South, East, West
}

CompassPointOne.South
CompassPointOne.South.rawValue

CompassPointOne(rawValue: "East")!
CompassPointOne(rawValue: "1")

//recursive enumeration

enum ArithmeticExpression1 {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}


func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}
// 计算 (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))
// 输出 "18"
