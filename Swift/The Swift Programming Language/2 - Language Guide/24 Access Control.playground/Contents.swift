//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//你可以明确地给单个类型(类、结构体、枚举)设置访问级别,
//也可以给这些类型的属性、函数、初始化方 法、基本类型、下标索引等设置访问级别。
//协议也可以被限定在一定的范围内使用,包括协议里的全局常量、变 量和函数。


//public :可以访问自己模块中源文件里的任何实体,别人也可以通过引入该模块来访问源文件里的所有实 体。通常情况下, Framework 中的某个接口是可以被任何人使用时,你可以将其设置为 public 级别。
//• internal :可以访问自己模块中源文件里的任何实体,但是别人不能访问该模块中源文件里的实体。通常情 况下,某个接口或 Framework 作为内部结构使用时,你可以将其设置为 internal 级别。
//• private :只能在   当前源文件   中使用的实体,称为私有实体。使用 private 级别,可以用作隐藏某些功能的实现细节。

//访问级别统一性:
//• 一个 public 访问级别的变量,不能将它的类型定义为 internal 和 private
//• 函数的访问级别不能高于它的参数、返回类型的访问级别。

//默认访问级别:
//如果你不为代码中的所有实体定义显式访问级别,那么它们默认为 internal 级别。在大多数情况下,我们不需要 设置实体的显式访问级别。因为我们一般都是在开发一个 app bundle 。

//如果在引入一个生产模块时使用 @testable 注解,然后用带测试的方式 编译这个生产模块,单元测试目标就可以访问所有 internal 级别的实体。

//public class SomePublicClass {}
//internal class SomeInternalClass {}
//private class SomePrivateClass {}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//private func somePrivateFunction() {}
//
//// 隐式访问级别 internal
//class SomeInternalClass1 {}
//var someInternalConstant1 = 0



//如果你将类申明为 public 或者 internal 类(或者 不明确的申明访问级别,而使用默认的 internal 访问级别),那么该类的所有成员的访问级别是 internal 。
public class SomePublicClass {          // 显式的 public 类
    public var somePublicProperty = 0   // 显式的 public 类成员
    var someInternalProperty = 0        // 隐式的 internal 类成员
    private func somePrivateMethod() {} // 显式的 private 类成员
}

class SomeInternalClass {               // 隐式的 internal 类
    var someInternalProperty = 0        // 隐式的 internal 类成员
    private func somePrivateMethod() {} // 显式的 private 类成员
}

//如果将类申明为 private 类,那么该类的所有成员的默认访问级别也会成为 private 。
private class SomePrivateClass {        // 显式的 private 类
    var somePrivateProperty = 0         // 隐式的 private 类成员
    func somePrivateMethod() {}         // 隐式的 private 类成员
}

//元组的访问级别与元组中访问级别最低的类型一致。

//如果根据参数类型和返回类型得出的函 数访问级别不符合默认上下文,那么就需要明确地申明该函数的访问级别。
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass(), SomePrivateClass());
}

//枚举中成员的访问级别继承自该枚举
public enum CompassPoint {
    case North
    case South
    case East
    case West
}
//枚举定义中的任何 原始值 或 关联值 的类型都必须有一个访问级别,这个级别至少要不低于枚举的访问级别。


//子类：子类的访问级别不得高于父类的访问级别。
//在满足子类不高于父类访问级别 以及 遵循各访问级别作用域(即模块或源文件)的前提下,
//你可以重写任 意类成员(方法、属性、初始化方法、下标索引等)。


//如果无法直接访问某个类中的属性或函数等,那么可以继承该类,从而可以更容易的访问到该类的类成 员。


//只要满足 子类不高于父类访问级别 以及 遵循各访问级别作用域 的前提下(即 private 的作用域在同一个源文件 中, internal 的作用域在同一个模块下),
//我们甚至可以在子类中,用子类成员访问父类成员,哪怕父类成员的访问级别比子类成员的要低:

public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//常量、变量、属性不能拥有比它们的类型更高的访问级别。

//在 var 或 subscript 定义作用域之前,通过 private(set) 或 internal(set) 先为它们的写权限申明一个较低的访问级别。
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

public struct TrackedString1 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//如果你定义了一个 public 访问级别的协议,那么实现该协议提供的必要函数也会是 public 的访问级 别。
//这一点不同于其他类型, public 访问级别的其他类型,他们成员的访问级别为 internal 。

//对类、结构体、枚举进行扩展。扩展成员应该具有和原始类成员一致的访问级别。