//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  Basic Operators (基本运算符)
 */


/// 赋值运算符

let b = 10
var aa = 5
aa = b
let (x, y) = (aa, b)


/// 算数运算符

1 + 3
var a1: Int8 = 1
var a2: Int8 = Int8.max
var sum = a1 &+ a2

"hello, " + "word"

//求余运算符

9 % 4
-9 % 4
8 % 2.5

var i = 0
++i
i++
i += 1

let three = 3
let minusThress = -three


//组合运算符

var a = 1
a += 2

//比较运算符

1 == 1
2 != 1
2 > 1
1 < 2
1 >= 1
1 <= 1
1 === 1
2 !== 3

// ternary conditional operator

2 > 3 ? 2 : 3

// nil coalescing operator

2 != nil ? 2 : 0

nil ?? 0
2 ?? 0
//nil ?? nil

let defaultColorName = "Black"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName


//区间
1...3
1..<2

!true

true && false

false || true

false || true && false

false || (true && false)








