//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

func swapTwoValue<T>(inout a: T, inout _ b: T)  {
    let tempA = a
    a = b
    b = tempA
}

func swapTwoValueGracefully<T>(inout a: T, inout _ b: T) {
    (a, b) = (b, a)
}

var a = 1, b = 2
(a, b)
swapTwoValue(&a, &b)
(a, b)
swapTwoValueGracefully(&a, &b)
(a, b)

let rect = CGRectMake(0, 0, 100, 100)

let (small, large) = rect.divide(20, fromEdge: .MinXEdge)
large
small



