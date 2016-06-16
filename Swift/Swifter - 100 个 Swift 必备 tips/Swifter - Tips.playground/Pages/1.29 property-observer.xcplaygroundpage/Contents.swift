//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//willSet 观察器会将新的属性值作为常量参数传入,在 willSet 的实现代码中可以为这个参数指定一个名称,如 果不指定则参数仍然可用,这时使用默认名称 newValue 表示。
//类似地, didSet 观察器会将旧的属性值作为参数传入,可以为该参数命名或者使用默认参数名 oldValue 。

class MyClass {
    
    let oneYearInSecond: NSTimeInterval = 365 * 24 * 60 * 60
    
    var date: NSDate {
        willSet {
            let d = date
            print("即将将日期从 \(d) 设定至 \(newValue)")
        }
        
        didSet {
            if (date.timeIntervalSinceNow > oneYearInSecond) {
                print("设定的时间太晚了！")
                date = NSDate().dateByAddingTimeInterval(oneYearInSecond)
            }
            print("已经将日期从 \(oldValue) 设定至 \(date)")
        }
    }
    
    init() {
        date = NSDate()
    }
}

let foo = MyClass()
foo.date = foo.date.dateByAddingTimeInterval(foo.oneYearInSecond+12)

//在一个类型中，属性观察和计算属性不能同时共存
//也就是在属性定义中，同时出现 set 和 willset didset 是一件办不到事

class A {
    var number :Int {
        get {
            print("get")
            return 1
        }
        
        set {print("set")}
    }
}

class B: A {
    override var number: Int {
        willSet {print("willSet")}
//        didSet中用到oldValue，这个值需要在整个set动作前进行获取并存储，所以调用了get
        didSet {print("didSet")}
    }
}

let b = B()
b.number = 0






