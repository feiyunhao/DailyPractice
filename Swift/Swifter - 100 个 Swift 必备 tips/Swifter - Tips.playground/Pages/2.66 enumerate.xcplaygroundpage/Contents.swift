//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let arr: NSArray = [1,2,3,4,5]

var result = 0

arr.enumerateObjectsUsingBlock { (num, idx, stop) in
    result += num as! Int
    if idx == 2 {
        stop.memory = true
    }
}

print(result)

result = 0

for (idx, num) in [1,2,3,4,5].enumerate() {
    
    result += num
    
    if idx == 2 {
        
        break
        
    }
    
}

print(result)