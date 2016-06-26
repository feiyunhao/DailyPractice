//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//相对于普通的optional值，Swift中还有一种特殊的optional
//ImplicitlyUnwrappedOptional
//声明的时候，后边加上一个！，表示我们需要一个可以隐式解析的Optional值

class MyClass {
    func foo() -> () {
        
    }
}

var maybeObject: MyClass! = MyClass()

maybeObject!.foo()

maybeObject.foo()


//有时候在程序架构中,第一次被赋值之后,可以确定一个可选类型总会有值。在这种情况下,每次都要判断和解 析可选值是非常低效的,因为可以确定它总会有值。 这种类型的可选状态被定义为隐式解析可选类型(implicitly unwrapped optionals)。把想要用作可选的类型 的后面的问号( String? )改成感叹号( String! )来声明一个隐式解析可选类型。
//当可选类型被第一次赋值之后就可以确定之后一直有值的时候,隐式解析可选类型非常有用。隐式解析可选类型 主要被用在 Swift 中类的构造过程中,
//一个隐式解析可选类型其实就是一个普通的可选类型,但是可以被当做非可选类型来使用,并不需要每次都使用 解析来获取可选值。下面的例子展示了可选类型 String 和隐式解析可选类型 String 之间的区别:

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 不需要感叹号
assumedString
assumedString!


