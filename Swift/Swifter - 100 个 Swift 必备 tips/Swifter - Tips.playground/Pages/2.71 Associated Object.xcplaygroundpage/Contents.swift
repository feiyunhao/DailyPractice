//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// MyClass.swift
class MyClass {
}

// MyClassExtension.swift
private var key = "key"

extension MyClass {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
        
        set {
            objc_setAssociatedObject(self,
                                     &key, newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


// 测试
func printTitle(input: MyClass) {
    if let title = input.title {
        print("Title: \(title)")
    } else {
        print("没有设置")
    }
}

let a = MyClass()
printTitle(a)
a.title = "Swifter.tips"
printTitle(a)





