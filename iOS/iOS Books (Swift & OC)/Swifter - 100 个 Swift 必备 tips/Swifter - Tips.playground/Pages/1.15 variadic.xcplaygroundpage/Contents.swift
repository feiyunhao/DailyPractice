//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

func sum(input: Int...) -> Int {
    return input.reduce(0, combine: +)
}

sum(1, 2, 3, 4)

func myFunc(numbers: Int..., string: String) {
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
    
//    for (index, i) in numbers.enumerate() {
//        print("\(index) - \(i): \(string)")
//    }
}

myFunc(1, 2, 3, string: "hello")

[1,2,3].forEach { (s) in
    print(s)
}

let name = "Tom"
let date = NSDate()
let string = NSString(format: "Hello %@. Date: %@", name, date)



