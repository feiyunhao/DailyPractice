//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//使用OptionalChaining可以让我们摆脱很多不必要的判断和取值
//Optional Chaining 所得到的东西都是 Optional 的

class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

let xiaoming = Child()

let toyName = xiaoming.pet?.toy?.name

if let toyName = xiaoming.pet?.toy?.name {
    
}

extension Toy {
    func play() {
        
    }
}

xiaoming.pet?.toy?.play()


//错误代码 ❌
let playClosure_Worng = {
    (child: Child) -> () in
    child.pet?.toy?.play()
}

if let result: () = playClosure_Worng(xiaoming) {
    print("好开心～")
} else {
    print("没有玩具可以玩")
}


let playClosure = {
    (child: Child) -> ()? in
    child.pet?.toy?.play()
}

if let result: () = playClosure(xiaoming) {
    print("好开心～")
} else {
    print("没有玩具可以玩")
}



        