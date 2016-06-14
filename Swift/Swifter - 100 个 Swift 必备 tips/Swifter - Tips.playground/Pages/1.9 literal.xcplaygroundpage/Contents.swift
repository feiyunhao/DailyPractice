//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let aNumber = 3
let aString = "Hello"
let aBool = true

let anArray = [1,2,3]
let aDictionary = ["key1": "value1", "key2": "value2"]

typealias Array_LC  = ArrayLiteralConvertible
typealias Bool_LC   = BooleanLiteralConvertible
typealias Dict_LC   = DictionaryLiteralConvertible
typealias Float_LC  = FloatLiteralConvertible
typealias Nil_LC    = NilLiteralConvertible
typealias Integer_LC = IntegerLiteralConvertible
typealias String_LC = StringLiteralConvertible

enum MyBool: Int {
    case myTrue, myFalse
}

extension MyBool: BooleanLiteralConvertible {
    init(booleanLiteral value: Bool) {
        self = value ? myTrue : myFalse
    }
}

let myTrue: MyBool = true
let myFalse: MyBool = false
MyBool(booleanLiteral: true).rawValue
MyBool(booleanLiteral: false).rawValue

//class Person1 {
//    let name: String
//    init(name value: String) {
//        self.name = value
//    }
//}
//

class Person: StringLiteralConvertible {
    let name: String
    init(name value: String) {
        self.name = value
    }
    //子类也必须实现字面量转换
    required convenience init(stringLiteral value: String) {
        self.init(name: value)
    }

    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
}
//
let person: Person = "xiaoming"
print(person.name)



        
