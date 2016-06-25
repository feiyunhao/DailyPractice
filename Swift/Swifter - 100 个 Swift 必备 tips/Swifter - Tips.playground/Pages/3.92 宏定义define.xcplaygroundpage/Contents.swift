//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

//Swift中将宏定义彻底拿掉了
//使用合适范围的 let 或者 get 属性 来代替原来的宏定义
//宏定义的方法，在同样作用域写为Swift方法
//＃ifdef 睡着 ＃define 消失

#if os(OSX)
    typealias Color = NSColor
#else
    typealias Color = UIColor
#endif