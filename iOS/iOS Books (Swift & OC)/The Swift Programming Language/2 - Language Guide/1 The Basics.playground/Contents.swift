//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0, y = 0.0, z = 0

var welcomeMessage: String
welcomeMessage = "Hello"

var red, green, blue: Double

let π = 3.1415926
let 你好 = "你好世界"
let ？？ = "dogcow"
let `let` = 1
`let`

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

let languageName =  "Swift"
//languageName = "Swifter"

print(friendlyWelcome)

print("abcdefg", "higklmn", separator: " [separator] ", terminator: " [terminator] ")
print("123","456")

print("\(friendlyWelcome)")
print(friendlyWelcome)
print("a \(friendlyWelcome)")

/*
    这是外层的多行注释
 
    /**
     *  只是一个
     *  多行注释
     */

*/

let a = "!"; print(a)

let aInt8: UInt8  = 8
let aInt64: Int64  = 64

let minInt8 = Int8.min
let maxInt32 = Int32.max
let maxInt64 = Int64.max
let maxInt = Int.max

let uInt = UInt.max

let PI = 3 + 0.1415

let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11


let aFloat:Double = 1.25e-2
let anotherFloat = 0xfp2
0xfp-15

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.cp0

let paddedDouble = 000123.456
let oneMillon = 1_000_000
let justOverMIllion = 1_000_000.000_000_1


//let cannotBeNegative: UInt8 = -1
//let tooBig: Int8 = Int8.max + 1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

let integerPi = Int(pi)

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

let orangesAreOrange = true
let turnipsAreDelicious = false

if orangesAreOrange {
    print(orangesAreOrange)
} else {
    print(turnipsAreDelicious)
}

let i = 1
if i == 1 {
    print(1)
}

let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error

print("the statusCode is \(statusCode), the statusMessage is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print(justTheStatusCode)

http404Error.0
http404Error.1

let http200Status = (statusCode: 200, statusMessage: "OK")
http200Status.statusCode
http200Status.statusMessage

let possibleNumber = "123" //"hello word"
var convertednumber = Int(possibleNumber)

var serverResponseCode: Int? = 404
serverResponseCode = nil

/*
let nilInt: Int? = nil
//nilInt = 3
let nilInt32: Int32?
//print(nilInt32)
nilInt32 = 32
*/


var surveyAnswer: String?
print(surveyAnswer)
surveyAnswer = "ni cai cai kan"

if (convertednumber != nil) {
    print("convertedNumber constains a integer value of \(convertednumber!)")
}

//convertednumber = nil
//print("convertedNumber constains a integer value of \(convertednumber!)")

//可选绑定

if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
//    print("\'\(possibleNumber)\' could not be coverted to an integer \(actualNumber)")
}

if var firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}


let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

var assumedString: String! = "An implicitly unwrapped optional string"
var implicitString: String = assumedString

//assumedString = nil
//implicitString = assumedString

if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}

//一个变量之后可能变成nil的话，不要使用隐私可选类型

//error handling

func canThrowAnError() throws {
    //这个函数有可能抛出错误
}

do {
    try canThrowAnError()
    //没有错误抛出
} catch {
    //有错误抛出
}


func makeASandwich() {
    //...
}

/*

do {
    try makeASandwich()
//    eatASandich()
} catch Error.OutOfCleanDishes {
    washDishes()
} catch Error: MissingIngredients(let ingredients) {
    buyGroceries(ingredients)
}

*/

/**
 *  断言
 */

let age = -3
assert(age <= 0 , "A person's name cannot be less than zero")





