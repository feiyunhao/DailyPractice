//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//final class var func

//类或者方法的功能确实已经完备了
//子类继承和修改是一件危险的事
//为了父类中某些代码一定会执行

//Objective-C:让编译器在子类没有调用负累的方法时候抛出异常 __attribute__((objc_requires_super))


class Parent {
    
    final func method() {
        print("开始配置")
        // ..必要的代码
        
        methodImpl()
        
        // ..必要的代码
        print("结束配置")
    }
    
    func methodImpl() {
        fatalError("子类必须实现这个方法")
        // 或者也可以给出默认实现
    }
    
}

class Child: Parent {
    override func methodImpl() {
        //..子类的业务逻辑
        print("Setup in Child")
    }
}

let c = Child()
c.method()

//性能考虑

