//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


//where可以限定某些条件case

let name = ["王小二","张三","李四","王二小"]

name.forEach {
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\(x)是笔者本家")
    default:
        print("你好，\($0)")
    }
}

//在 if let 后者 for 中 我们也可以使用where

let num: [Int?] = [48, 99, nil]
num.forEach {
    if let score = $0 where score > 60 {
        print("及格啦 - \(score)")
    } else {
        print(":(")
    }
}

for score in num where score > 60 {
    print("及格啦 - \(score)")
}

//以上两种方法都可以使用if代替，只不过让我们的代码更加易读

//也有些场合必须使用where才能准确表达，不如在泛型中想要对方法的类型进行限定的时候


//在2.0后，引入了，protocol extension 
//在有些时候，希望一个接口扩展的默认实现自由在某些特定条件下适用，这时可以使用where关键字

let sortableArray: [Int] = [3,1,2,4,5]
let unsortableArray: [AnyObject?] = ["Hello", 4, nil]

sortableArray.sort()
//unsortableArray.sort()




