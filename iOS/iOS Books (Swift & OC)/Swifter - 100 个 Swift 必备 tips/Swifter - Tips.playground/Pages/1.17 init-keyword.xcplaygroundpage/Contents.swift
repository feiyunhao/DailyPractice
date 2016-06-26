//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//designated convenience and required

//Swift 使用超级严格的初始化方法
//Swift 强化了 designated 初始化方法的地位
//Swift不加修饰符的init方法都需要在方法中保证所有非optional 的实例变量被赋值初始化
//而在子类中也强制（显式 或隐式）调用super版的designatd初始化

class ClassA {
    let numA: Int
    init(num: Int) {
        numA = num
    }
}

class ClassAA: ClassA {
    let numB: Int
    override init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
}
ClassA(num:3)
ClassAA(num:2)

class ClassB {
    let numA: Int
    init(num: Int) {
        numA = num
    }
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassBB: ClassB {
    let numB: Int
    override init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
}


let bb = ClassBB(bigNum: true)

class ClassC {
    let numA: Int
    required init(num: Int) {
        numA = num
    }
    required convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassCC: ClassC {
    let numB: Int
    required init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
    
    required convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

