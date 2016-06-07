//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///协议 Protocols
/*
    protocol SomeProtocol {
        //
    }
    struct SomeStructure: FirstProtocol, AnotherProtocol {
        // 结构体内容 
    }
    class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
        // 类的内容
    }
 */

//协议可以规定其 遵循者 提供特定 名称 和 类型的 实例属性(instance property) 或 类属性(type property) ,
//而不用 指定是 存储型属性(stored property) 还是 计算型属性(calculate property) 。
//此外还必须指明是只读的还是可读可写的。

//在类型声明后加上 { set get } 来表示属性是可读可写的,只读属性则用 { get } 来表示。

protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed{
    var fullName: String
}
var john = Person(fullName: "John Appleseed")
john.fullName = "赵日天"
john.fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

//协议可以要求其遵循者实现某些指定的 实例方法 或 类方法。
//这些方法作为协议的一部分,像普通的方法一样放在协议的定义中,
//但是不需要大括号和方法体。
//可以在协议中定义具有 可变参数 的方法,和普通方法的定义方式相同。
//但是在协议的方法定义中,不支持 参数 默认值。

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")


//有时需要在方法中改变它的实例。例如,值类型(结构体,枚举)的实例方法中,
//将 mutating 关键字作为函数的前 缀,写在 func 之前,表示可以在该方法中修改它所属的实例及其实例属性的值。
//用类实现协议中的 mutating 方法时,不用写 mutating 关键字;
//用结构体,枚举实现协议中的 mutating 方法 时,必须写 mutating 关键字。

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()


//在遵循该协议的类中实现构造器,并指定其为类的指定构造器(designated initializer)或者便利构造 器(convenience initializer)。
//在这两种情况下,必须给构造器实现标上"required"修饰符 
//保证:所有的遵循该协议的子类,同样能为构造器规定提供一个显式的实现或继承实 现。

protocol SomeInitialzationProtocol{
    <#requirements#>
}

