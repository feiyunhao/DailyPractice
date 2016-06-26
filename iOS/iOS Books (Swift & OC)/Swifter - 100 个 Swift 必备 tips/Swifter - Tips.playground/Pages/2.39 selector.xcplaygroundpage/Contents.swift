//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//@selector OC关键字，将一个方法转换并赋值给一个SEL类型，很类似一个动态的函数指针
//OC中非常有用：target－action 自举询问是否响应某个方法 指定接受通知时调用的方法

//-(void) callMe {
//    //...
//}
//-(void) callMeWithParam:(id)obj {
//    //...
//}
//SEL someMethod = @selector(callMe);
//SEL anotherMethod = @selector(callMeWithParam:);
// NSSelectorFromString
// SEL someMethod = NSSelectorFromString(@"callMe");
// SEL anotherMethod = NSSelectorFromString(@"callMeWithParam:");

//#selector
//Selector
class MyObject: NSObject {
    func callMe() {
        //...
    }
    func callMeWithParam(obj: AnyObject!) {
        //...
    }
    func turnByAngle(theAngle: Int, speed: Float) {
        //...
    }
    @objc private func callMeObjc() {
        //...
    }
    
    let someMethod: Selector = #selector(callMe)
    let anotherMethod: Selector = #selector(callMeWithParam(_:))
    let method = #selector(turnByAngle(_: speed:))

    func commonFunc() {
    }
    
    func commonFunc(input: Int) -> Int {
        return input
    }
    
    func sameNameSelectors() -> [Selector] {
        let method1 = #selector(commonFunc as ()->())
        let method2 = #selector(commonFunc as Int->Int)
        return [method1, method2]
    }

}

//Selector 其实是OC runtime的概念，如果你的selector对应的方法只在Swift中可见的话（也就是说他是Swift方法中的private），在调用的时候会报错，正确做法是在 private 前 加上 @objc



