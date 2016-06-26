//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
    extension SomeType {
         加到SomeType的新功能写到这里 
    }
 
    一个扩展可以扩展一个已有类型,使其能够适配一个或多个协议(protocol)。
    extension SomeType: SomeProtocol, AnotherProctocol {
         协议实现写到这里
    }
 */


//Computed Properties
//扩展可以向已有类型添加 计算型 实例属性 和计算型 类型属性。

extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//扩展可以添加新的 计算属性,但是不可以 添加 存储属性,
//也不可以向已有属性添加属性观测器(property observ ers)。


///Initializers
//扩展能向类中添加新的 便利构造器,
//但是它们不能向类中添加新的 指定构造器 或 析构器。
//指定构造器和析构器必须总是由原始的类实现来提供。

//如果你使用扩展向一个 值类型 添加一个 构造器,
//在该 值类型 已经向所有的存储属性提供默认值,而且没有定义任 何定制构造器(custom initializers)时,
//你可以在值类型的扩展构造器中调用默认构造器(default initiali zers)和逐一成员构造器(memberwise initializers)。

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
        var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

/**
 *  Methods
 */

//扩展可以向已有类型添加新的实例方法和类型方法。
extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions({ print("Hello!") })

//使用尾随闭包
//Int.max.repetitions{ print("I love you!")}

/**
 *  Mutating Instance Methods
 */

//通过扩展添加的实例方法也可以 修改该实例本身。
//结构体和枚举类型中修改 self 或其属性的方法必须将该实例方 法标注为 mutating ,正如来自原始实现的修改方法一样。

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

///Subscripts

extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            digitIndex -= 1
        }
        return (self / decimalBase) % 10
    }
}
65[1]


/**
 *  Nested Types
 */


//扩展可以向已有的类、结构体和枚举添加新的嵌套类型:

extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

5.kind


func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("-", terminator: " ")
        case .Zero:
            print("0", terminator: " ")
        case .Positive:
            print("+", terminator: " ")
        }
    }
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
