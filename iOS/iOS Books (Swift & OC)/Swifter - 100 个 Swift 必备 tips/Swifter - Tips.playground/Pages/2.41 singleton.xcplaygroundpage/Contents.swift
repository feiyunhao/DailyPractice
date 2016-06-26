//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Swift1.2之前的讨论

class MyManager1 {
//    由于Swift1.2之前并不支持存储类属性，所以需要一个结构体来存储类型变量
    class var sharedManager : MyManager1 {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance : MyManager1? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            Static.staticInstance = MyManager1()
        }
        
        return Static.staticInstance!
    }
}

MyManager1.sharedManager

//上边写法没问题，但是有更简洁的let

class MyManager2 {
    private static let sharedInstance = MyManager2()
    class var sharedManager : MyManager2 {
        return sharedInstance
    }
}

MyManager2.sharedManager


class MyManager3  {
    class var sharedManager : MyManager3 {
        return sharedInstance
    }
}
private let sharedInstance = MyManager3()

MyManager3.sharedManager


//Swift1.2之后的改进

class MyManager  {
    //swift_once_block_invoke 保证 初始化实例变量的 唯一性
    static let sharedManager = MyManager()
    // 私有化初始方法，让项目不能在其它地方通过init生成自己的MyManage实例
    //如果需要类似defaultManage的形式单例，可以去掉这个私有init
    private init() {}
}

MyManager.sharedManager




