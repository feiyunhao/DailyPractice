//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String, str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

sayHello1(str2: " ", str3: "World")
sayHello2("Hello", str2: " ")

//NSLocalizedString
//assert

