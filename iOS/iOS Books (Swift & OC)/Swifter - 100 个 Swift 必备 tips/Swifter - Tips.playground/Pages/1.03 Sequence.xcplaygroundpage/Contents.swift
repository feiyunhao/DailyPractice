//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// 先定义一个实现了 GeneratorType protocol 的类型
// GeneratorType 需要指定一个 typealias Element
// 以及提供一个返回 Element? 的方法 next()
class ReverseGenerator<T>: GeneratorType {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = self.array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
    
}

// 然后我们来定义 SequenceType
// 和 GeneratorType 很类似，不过换成指定一个 typealias Generator
// 以及提供一个返回 Generator? 的方法 generate()
struct ReverseSequence<T>: SequenceType  {
    var array: [T]
    
    init(array: [T]) {
        self.array = array
    }
    
    typealias Generator = ReverseGenerator<T>
    
    func generate() -> Generator {
        return ReverseGenerator(array: self.array)
    }
}

//let arr = [0, 1, 2, 3, 4]
let arr = ["Zero", "One", "Two", "Three", "Four"]


for i in ReverseSequence(array: arr) {
//    print("Index",i,"is",arr[i])
    print(i)
}

let rg = ReverseSequence(array: arr).generate()
while let obj = rg.next() {
    print(obj)
}

print("@@@@@@@@@@@@")

var g = arr.generate()
while let obj = g.next() {
    print(obj)
}

print("@@@@@@@@@@@@")

//顺便可以得到的收益：
//可以使用像：map，filter，reduce 这些方法
//因为SequenceType 已经实现了他们

let rs = ReverseSequence(array: arr)

rs.map { s in print(s) }

rs.map({print($0)})

rs.map { (String) -> Int in
    return 1
}

//rs.reduce(T, combine: <#T##(T, String) throws -> T#>)
//
//rs.filter { (<#String#>) -> Bool in
//    <#code#>
//}