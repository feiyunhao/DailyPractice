//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//let array: NSArray = [1,2,3]
//array[100]
//    *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayI objectAtIndex:]: index 100 beyond bounds [0 .. 2]'


//let array1 = [1,2,3]
//array1[100]
//fatal error: Index out of range

//断言自在debug环境有效，在release编译中所有的断言被禁用

enum MyEnum {
    case Value1,Value2,Value3
}

func check(someValue: MyEnum) -> String {
    switch someValue {
    case .Value1:
        return "OK"
    case .Value2:
        return "Maybe OK"
    default:
        // 这个分支没有返回 String，也能编译通过
        fatalError("Should not show!")
    }
}

//check(.Value3)




class MyClass {
    func methodMustBeImplementedInSubclass() {
        fatalError("这个方法必须在子类中被重写")
    }
}

class YourClass: MyClass {
    override func methodMustBeImplementedInSubclass() {
        print("YourClass 实现了该方法")
    }
}

class TheirClass: MyClass {
    func someOtherMethod() {
        
    }
}

YourClass().methodMustBeImplementedInSubclass()
// YourClass 实现了该方法

TheirClass().methodMustBeImplementedInSubclass()
