//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let absoluteZeroInCelsius = -273.15

func convertToKelvin(celsius: Double) -> Double {
    assert(celsius > absoluteZeroInCelsius, "输入的摄氏温度不能低于绝对零度")
    return celsius - absoluteZeroInCelsius
}

let roomTemperature = convertToKelvin(27)
// roomTemperature = 300.15

let tooCold = convertToKelvin(absoluteZeroInCelsius+1)

//只在debug编译时有效，在运行时不被编译执行，不会消耗运行时性能

//Other Swift Flags
//-assert-config Debug
//-assert-config Release