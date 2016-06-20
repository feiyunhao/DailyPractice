//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//Swift KVO 仅限NSObject子类，同时将要观测的对象标记为：dynamic



class MyClass: NSObject {
    
    var date = NSDate()
    
}

class MyChildClass: MyClass {
    
    dynamic override var date: NSDate {
        
        get { return super.date }
        
        set { super.date = newValue }
        
    }
    
}

/*

class MyClass: NSObject {
    dynamic var data = NSData()
}

private var myContext = 0

class Class: NSObject {
    var myObject: MyClass!
    override init() {
        myObject = MyClass()
        print("初始化 Myclass，当前时间：\(myObject.data)")
        myObject.addObserver(self, forKeyPath: "data", options: .New, context: &myContext)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?,
                                         
                                         ofObject object: AnyObject?,
                                                  
                                                  change: [String : AnyObject]?,
                                                  
                                                  context: UnsafeMutablePointer<Void>)
        
    {
        
        if let change = change where context == &myContext {
            
            let a = change[NSKeyValueChangeNewKey]
            
            print("日期发生变化 \(a)")
            
        }
        
    }
    
}
 
 */