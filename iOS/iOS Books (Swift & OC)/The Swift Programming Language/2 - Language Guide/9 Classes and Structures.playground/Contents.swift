//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class SomeClass {
    
}

struct SomeStruct {
    
}

//分辨率
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

someResolution.width
someVideoMode.resolution.height

someVideoMode.resolution.height = 100
someVideoMode.resolution.height

let vga = Resolution(width: 188, height: 190)
//与结构体不同,类实例没有默认的成员逐一构造器。

//结构体 和枚举 都是值类型
//值类型 赋予一个变量，常量，或者被传递给一个函数，其值会被拷贝
// string array dictionary 是值类型

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
cinema.width
hd.width


enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

//类是引用类型

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0


let alsoTenEighty = tenEighty

tenEighty.frameRate
alsoTenEighty.frameRate = 30.0
tenEighty.frameRate

tenEighty === alsoTenEighty
tenEighty !== alsoTenEighty

currentDirection == rememberedDirection

//等价于 ＝＝＝ 与等于 ＝＝
//
//等价于 表示两个 类 类型 的 常量 货值变量引用同一个类实例
//等于 表示两个实例的值 相等 或者 相同， 判定时要遵循按照设计者定义的判断标准










