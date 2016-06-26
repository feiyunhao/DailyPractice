//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let arr = [1,2,3]

let doubled = arr.map{
    $0 * 2
}

print(doubled)

//let num: Int? = 3
//var result: Int?
//
//if let realNum = num {
//    result = realNum * 2
//} else {
//    result = nil
//}

//不仅在CollectionType里可以用map，在Optional的声明中也有一个map方法

let num: Int? = 3
let result = num.map {
    $0 * 2
}

result
// result 为 {Some 6}

//这符合函子（Functor）的概念
//函子是指可以被某个函数作用，并映射为另一组结果，而这组结果就是函子的值


