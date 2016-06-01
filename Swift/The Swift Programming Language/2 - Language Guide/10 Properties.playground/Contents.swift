//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///Properties

//Stored Properties
//Computed Properties
//Properties Observers
//Global and Local Variables
//Tpye Properties

//属性 将 值 跟 特定的 类、结构体、或者枚举关联。
//存储属性 存储常量 或者 变量 作为 实例的一部分，而计算属性 计算一个值（不是存储）
//计算属性可以用于 类、 结构体、枚举
//存储属性 只能用于 类 和 结构体

//存储属性 和 计算属性 通常与特定 类型的实例关联 
//但是，属性也可以直接引语类型本身， 称为 类型属性

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3) // 该区间表示整数0,1,2
rangeOfThreeItems.firstValue = 6
// 该区间现在表示整数6,7,8

//结构体(struct)属于值类型。当值类型的实例被声明为常量的时候,它的所有属性也就成了常 量。
//属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后,仍然可以修改该实例的变量属 性。

//延迟存储属性

//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储 属性。
//必须将延迟属性生命成 变量； 因为属性的初始值可能在实例构造完成之后才能得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性
//当属性的值依赖于在构造过程结束后才会知道具体值的外部因素的时候，或者当获得属性的初始值需要复杂或大量计算时,可以只在需要的时候计算它。

class DataImporter {
    /*
     DataImporter 是一个将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这是提供数据导入功能 
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这是提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建

manager.importer.fileName

//如果一个被标记为 lazy 的属性÷在没有初始化时就同时被多个线程访问,则无法保证该属性只会被初始化一次。

//Objective-C 为类实例存储值和引用提供两种方法。属性来  实例变量 (作为属性值的后端存储。)
//Swift 编程语言中把这些理论统一用属性来实现。Swift 中的属性没有对应的实例变量,属性的后端存储也无法 直接访问。



//除存储属性外,类、结构体和枚举可以定义计算属性。计算属性不直接存储值,而是提供一个 getter 和一个可 选的 setter,来间接获取和设置其他属性或变量的值。


struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            
            //如果计算属性的 setter 没有定义表示新值的参数名,则可以使用默认名称 newValue
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    } }
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// 输出 "square.origin is now at (10.0, 10.0)”

//必须使用  var 关键字定义计算属性,包括只读计算属性,因为它们的值不是固定的。 
//关键字 let 只用来声明常 量属性,表示初始化后再也无法修改的值。

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

//可以为 除了 延迟属性 之外 的其它存储属性 添加 属性观察器， 也可以通过重写属性的方式为继承的属性 （包括存储属性 和 计算属性）添加属性观察器
//注意： 不需要为 非重写的计算属性添加属性观察器，因为可以通过她的setter直接监控和响应值的变化
//注意：父类的属性在之类的构造器中被赋值，他在父类中的 willset didset 观察器 会被 调用

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            } }
    } }
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896



