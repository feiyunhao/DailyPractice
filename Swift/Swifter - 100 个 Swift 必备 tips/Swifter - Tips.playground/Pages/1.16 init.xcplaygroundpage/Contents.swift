//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Swift 要保证类型的所有属性都被初始化
//在某个子类中，初始化语句的顺序并不是随意的，
//要保证当前子类实例的成员初始化之后再调用父类的初始化方法

class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init()
        name = "tiger"
    }
}
//1、设置子类自己需要初始化的参数
//2、调用父类的相应初始化方法
//3、对父类中需要改变的成员进行设定

class Cat1 {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger1: Cat1 {
    let power: Int
    override init() {
        power = 10
        // 如果我们不需要打改变 name 的话，
        // 虽然我们没有显式地对 super.init() 进行调用
        // 不过由于这是初始化的最后了，Swift 替我们自动完成了
    }
}

let cat = Cat1()

let tiger = Tiger1()
