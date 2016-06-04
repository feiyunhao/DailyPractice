//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///Instance Method
///Type Method



class Counter {
    var count = 0
    func increment() {
        count += 1
        self.count
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
    
    func incrementBy(amount amount: Int, _ numberOfTimes: Int) {
        
        count += amount * numberOfTimes
    }
}


let counter = Counter()
// 初始计数值是0
counter.increment()
// 计数值现在是1 
counter.incrementBy(5) // 计数值现在是6 
counter.reset()
// 计数值现在是0


//方法就是函数，只不过与某个类型相关联了
//像在 Objective-C 中一样,Swift 中方法的名称通常用一 个介词指向方法的第一个参数,比如: with , for , by 等等。介词的使用让方法在被调用时能像一个句子一样被解读。
//swift默认只给方法的第一个参数一个局部参数名字；第二个及后续，一个局部、一个外部

//默认情况下,Swift 只把 amoun  当作一个局部名称,但是把 numberOfTimes 即看作局部名称又看作外部名称。
//counter.incrementBy(3, numberOfTimes: 2)

counter.incrementBy(amount: 3, 3)


//类型的每一个实例都有一个隐含属性叫做 self , self 完全等同于该实例本身。你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。


struct Point {
    var x = 0.0, y = 0.0
    
    func isToTheRightOfX(x: Double) -> Bool {
        //参数名享有优先权
//    如果不使用 self 前缀,Swift 就认为两次使用的 x 都指的是名称为 x 的函数参数。
    return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)

if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}

//一般情况下,值类型的属性不能在它的 实例方法 中被修改。
struct PointOne {
    var x = 0.0, y = 0.0
    

    mutating func moveByX(deltaX: Double,y deltaY: Double){
        
        //    moveByX 方法在被调 用时修改了这个点,而不是返回一个新的点。方法定义时加上 mutating 关键字,这才让方法可以修改值类型的属 性
        x += deltaX
        y += deltaY
        
//        新版的可变方法 moveByX(_:y:) 创建了一个新的结构(它的 x 和 y 的值都被设定为目标值)。调用这个版本的 方法和调用上个版本的最终结果是一样的。
        self = PointOne(x: x + deltaX, y: y + deltaY)
    }
}

var pointone_1 = PointOne(x: 1, y: 2)
pointone_1.moveByX(2, y: 2)

let pointone_2 = PointOne(x: 1, y: 2)
//pointone_2.moveByX(2, y: 2)




enum TriStateSwitch
{
    case Off, Low, High
    
//    枚举的可变方法可以把 self 设置为相同的枚举类型中不同的成员:
    
    mutating func next(){
        
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var overLinght = TriStateSwitch.High
overLinght.next()
overLinght.next()
overLinght.next()
overLinght.next()


/**
 *  Type Method
 */


//声明 结构体和枚举的类型方法,在方法的 func 关键字之前加上关键字 static 。类可能会用关键字 class 来允许子类 重写父类的实现方法。

class SomeClass {
    static func someTypeMethod() {
        // 在类型方法的方法体(body)中, self 指向这个类型本身
    }
}

SomeClass.someTypeMethod()

//一般来说，任何 未限定的 方法 和 属性 名称 将会来自于 本类 中 另外的 类型级别 的 方法 和 属性。
//一个类型方法 可以 调用 另一个 类型方法 的 名称， 而 不需 在 方法名称 前边 加上 类型的 名称 前缀 ，
//同样，结构体 和 枚举 的 类型方法 也 能够 直接通过 静态属性 的 名称 访问 静态属性， 而不需要类型名称 前缀

struct LevelTracker {
    
    static var highestUnlockedLevel = 1
    
    static func unlockLevel(level: Int) {
        
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
            }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    
    mutating func advanceToLevel(level: Int) -> Bool {
        
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
    
}



class Player {
    
    var tracker = LevelTracker()
    
    let playerName: String
    
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
    
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "Beto")

player.completedLevel(5)

if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

