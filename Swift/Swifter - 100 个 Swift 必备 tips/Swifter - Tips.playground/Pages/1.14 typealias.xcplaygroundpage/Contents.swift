//: [Previous](@previous)

import Foundation
import UIKit
var str = "Hello, playground"

//: [Next](@next)

//typealias 用来为已经存在的类型重新定义名字的

typealias Location = CGPoint
typealias Distance = Double

func distanceBetweenPoint(point: Location, _ toPoint: Location) -> Distance {
    let dx = Distance(toPoint.x - point.x)
    let dy = Distance(toPoint.y - point.y)
    return sqrt(dx * dx + dy * dy)
}

let origin: Location = Location(x: 0, y: 0)
let point: Location = Location(x: 1, y: 1)
let distance: Distance = distanceBetweenPoint(origin, point)

//typealias是单一的，必须指定某个特定的类型通过 typealias 赋值为新名字，而不能将整个泛型类型重新命名
//❌
//class Person<T> {}
//typealias Worker = Person
//typealias Worker = Person<T>
//typealias Worker<T> = Person<T>

//一旦泛型类型的确定性保证后，就可以重命名了
class Person<T> {}
typealias WorkId = String
typealias Worker = Person<WorkId>


