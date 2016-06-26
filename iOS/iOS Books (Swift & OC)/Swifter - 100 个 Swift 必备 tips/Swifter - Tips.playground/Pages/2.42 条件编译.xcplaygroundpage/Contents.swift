//: [Previous](@previous)

import Foundation
import UIKit
var str = "Hello, playground"

//: [Next](@next)

//c语言中，可以使用 ＃if ＃ifdef 之类的编译条件分支来控制哪些代码需要编译，哪些不需要
//Swift中没有宏定义的概念，因此不能使用 ＃ifdef 的方法来检查某个符号是否宏定义过


/*
#if   //condition
    
#elseif //condition  //可选
    
#else   //可选
    
#endif
 */

//os() : iOS OSX
//arch(): x86_64（64位模拟器） arm（32位CPU）  arm64（64位CPU）, i386（32位模拟器）

#if os(OSX)
    typealias Color = NSColor
#else
    typealias Color = UIColor
#endif


//另一种方式是对自定义的符号进行条件编译

func someAciton() {
    #if FREE_VERSION
    
    #else
    
    #endif
}

//为了使 FREE_VERSION 这个编译符号来代表免费版本 有效，需要在项目的编译选项设置里
//Bulid Settings -> Swift Compiler - Custom Flags ->Other Swift Flags -D  FREE_VERSION
