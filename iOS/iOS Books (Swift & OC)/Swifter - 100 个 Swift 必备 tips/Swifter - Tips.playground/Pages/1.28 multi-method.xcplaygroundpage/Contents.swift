//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//Swift中可以同过dynamicType来获取一个对象的动态类型（运行时的实际类型，而非代码指定的 或者编译器看到的类型）
//但是Swift不支持多方法， 也就是 不能根据 对象在动态时的类型进行合适的 重载方法

class Pet {}
class Cat: Pet {}
class Dog: Pet {}

func printPet(pet: Pet) {
    print("Pet")
}

func printPet(cat: Cat) {
    print("Meow")
}

func printPet(dog: Dog) {
    print("Bark")
}

//发生在编译期
printPet(Cat()) // Meow
printPet(Dog()) // Bark
printPet(Pet()) // Pet

func printThem(pet: Pet, _ cat: Cat) {
    printPet(pet)
    printPet(cat)
}

printThem(Dog(), Cat())

//方法的调用在编译期决定

//想要绕过这个限制，通过对输入类型进行判断和转换
func printThemAgain(pet: Pet, _ cat: Cat) {
    if let aCat = pet as? Cat {
        printPet(aCat)
    } else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}

printThemAgain(Dog(), Cat())

