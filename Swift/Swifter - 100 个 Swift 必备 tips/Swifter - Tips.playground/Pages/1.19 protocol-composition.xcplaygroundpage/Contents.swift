//: [Previous](@previous)

import Foundation


//: [Next](@next)
protocol KittenLike {
    func meow() -> String
}

protocol DogLike {
    func bark() -> String
}

protocol TigerLike {
    func aou() -> String
}

class MysteryAnimal: KittenLike, DogLike, TigerLike {
    func meow() -> String {
        return "meow"
    }
    
    func bark() -> String {
        return "bark"
    }
    
    func aou() -> String {
        return "aou"
    }
}

//协议能够继承一个或多个其他协议,可以在继承的协议基础上增加新的内容要求。协议的继承语法与类的继承相 似,多个被继承的协议间用逗号分隔:
//protocol PetLike: KittenLike, DogLike {
//
//}
//
//protocol CatLike: KittenLike, TigerLike {
//
//}

typealias PetLike = protocol<KittenLike, DogLike>
typealias CatLike = protocol<KittenLike, TigerLike>


struct SoundChecker {
    static func checkPetTalking(pet: PetLike) {
        
    }
    static func checkCatTalking(cat: CatLike) {
        
    }
}

protocol A {
    func bar() -> Int
}

protocol B {
    func bar() -> String
}

class Class: A, B {
    func bar() -> Int {
        return 1
    }
    
    func bar() -> String {
        return "Hi"
    }
}

let instance = Class()

//instance.bar()
//instance.bar()
let num = (instance as A).bar()  // 1
let str = (instance as B).bar()  // "Hi"