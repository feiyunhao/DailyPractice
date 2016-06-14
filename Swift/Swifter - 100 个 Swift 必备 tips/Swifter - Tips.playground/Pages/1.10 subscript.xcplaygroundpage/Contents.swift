//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var arr = [1,2,3]
arr[2]            // 3
arr[2] = 4        // arr = [1,2,4]
//arr[4]
arr[0...2]

var dic = ["cat":"meow", "goat":"mie"]
dic["cat"]          // {Some "meow"}
dic["cat"] = "miao" // dic = ["cat":"miao", "goat":"mie"]
dic["nil"]

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "out of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index, i) in input.enumerate() {
                assert(i < self.count, "out of rang")
                self[i] = newValue[index]
            }
        }
        
    }
    
}

arr = [0,1,2,3,4]

arr[[0,2,3]]
arr[[1,3,4]] = [-1,-3,-4]
arr
