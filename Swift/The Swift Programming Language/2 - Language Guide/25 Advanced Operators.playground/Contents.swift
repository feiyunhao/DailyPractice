//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/// Bitwise operators

//Bitwise NOT Operator
//按位取反运算符( ~ ) 可以对一个数值的全部位进行取反:

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits //  0b11110000

//按位与运算符(Bitwise AND Operator)
//按位与运算符( & )可以对两个数的比特位进行合并。
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 =  0b00111111
let middleFourBits = firstSixBits & lastSixBits //  00111100

//按位或运算符(Bitwise OR Operator)
//按位或运算符( | )可以对两个数的比特位进行比较。
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  //  11111110

//按位异或运算符(Bitwise XOR Opoerator)
//按位异或运算符( ^ )可以对两个数的比特位进行比较。它返回一个新的数,当两个操作数的对应位不相同时,该 数的对应位就为 1 :
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101  //  00010001
let outputBits = firstBits ^ otherBits

//按位左移/右移运算符(Bitwise Left and Right Shift Operators)
//按位左移运算符( << )和按位右移运算符( >> )可以对一个数进行指定位数的左移和右移,
//对一个数进行按位左移或按位右移,相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位,等价 于将这个数乘以 2,同样地,将一个整数右移一位,等价于将这个数除以 2。


//对无符号整型进行移位的规则如下: 
//1. 已经存在的比特位按指定的位数进行左移和右移。 
//2. 任何移动超出整型存储边界的位都会被丢弃。 
//3. 用 0 来填充移动后产生的空白位。

let shiftBits: UInt8 = 4    // 即二进制的00000100
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000001

//十六进制中每两个字符表示 8 个比特位
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16      // redComponent 是 0xCC, 即 204
let greenComponent = (pink & 0x00FF00) >> 8     // greenComponent 是 0x66, 即 102
let blueComponent = pink & 0x0000FF             // blueComponent 是 0x99, 即 153


/// overflow operators

//可以使用 Swift 提供的三个溢出操作 符( overflow operators )来让系统支持整数溢出运算。
//这些操作符都是以 & 开头的: 
//• 溢出加法 &+
//• 溢出减法 &- 
//• 溢出乘法 &*

var unsignedOverflow = UInt8.max            //  0b 11111111
unsignedOverflow = unsignedOverflow &+ 1    //  0b100000000

unsignedOverflow = UInt8.min                //0b 00000000
unsignedOverflow = unsignedOverflow &- 1    //0b 11111111

//对于无符号与有符号整型数值来说,当出现上溢时,它们会从数值所能容纳的最大数变成最小的数。
//同样地,当 发生下溢时,它们会从所能容纳的最小数变成最大的数。
var signedOverflow = Int8.min               //0b 10000000
0b10000000
0b01111111
signedOverflow = signedOverflow &- 1        //0b 01111111



/// precedence & associativity

//运算符的优先级( precedence )使得一些运算符优先于其他运算符,高优先级的运算符会先被计算。
//结合性( associativity )定义了相同优先级的运算符是如何结合(或关联)的 —— 是与左边结合为一组,还是 与右边结合为一组。
//乘法运算符( * )与取余运算符( % )的优先级高于加法运算符( + )
//乘法与取余运算都是左结合 的。


/**
 *  运算符函数
 */

//类和结构可以为现有的操作符提供自定义的实现,这通常被称为运算符重载( overloading )。

struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
combinedVector.x

//要实现前缀或者后缀运算符,需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 限定符:
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
negative.x
let alsoPositive = -negative

//复合赋值运算符( Compound assignment operators )将 赋值运算符 ( = )与 其它运算符 进行结合。
func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

prefix func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement

//不能对默认的赋值运算符( = )进行重载。只有组合赋值符可以被重载。同样地,也无法对三目条件运算 符 a ? b : c 进行重载。


//等价操作符

func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}

/**
 *  自定义运算符
 */
//新的运算符要在全局作用域内,,使用operator关键字进行声明,同时还要指定prefix 、 infix或者postfix 限定符:

prefix operator +++ {} //定义了一个新的名为 +++ 的前缀运算符。

prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

//自定义的中缀( infix )运算符也可以指定优先级( precedence )和结合性( associativity )。

//结合性( associativity )的默认值是 none ,优先级( precedence )如果没有指定,则默认为100 。

infix operator +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
