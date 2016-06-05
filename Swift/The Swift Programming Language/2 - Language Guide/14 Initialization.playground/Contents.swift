//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
    
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8 }
    init(fromKelvin kelvin: Double) {
        
        temperatureInCelsius = kelvin - 273.15
    }
    
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0) // boilingPointOfWater.temperatureInCelsius 是 100.0 
let freezingPointOfWater = Celsius(fromKelvin: 273.15) // freezingPointOfWater.temperatureInCelsius 是 0.0”


struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
    
    init (_ black: Double){
        red = black
        green = black
        blue = black
    }
}

struct Size {
    
    var width = 0.0, height = 0.0
}
struct Point {
        
        var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    //相当 默认构造器
    init() {}
    //相当 逐一构造器
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
    
}
//默认构造器
//结构体逐一构造器

//类的继承和构造过程
//指定构造器 便利构造器

//指定构造器 必须 调用其 直接父类的 指定构造器
//便利构造器必须调用同一类中定义的 其它构造器
//便利构造器必须最终以调用一个 指定构造器 结束

//两段式构造过程
//一、每个存储属性通过它的类的构造器来设置初始值
//二、给每个类一个机会在新实例准备使用前进一步定制它的存储属性

class Food {
    
    var name: String
    
    init(name: String) {
        print("super.init.name")
        self.name = name
    }
    
    convenience init(){
        print("super.init")
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    
    var quantity: Int
    
    init(name: String, quantity: Int) {
        print("self.init.name&quantity")
        self.quantity = quantity
        super.init(name: name)

    }
    
    override convenience init(name: String) {
        print("self.init.name")
        self.init(name: name, quantity: 1)
    }
    
}

print("@@@@@@@@@@@@@")
let oneMysteryItem = RecipeIngredient()
print("@@@@@@@@@@@@@")
let oneBacon = RecipeIngredient(name: "Bacon")
print("@@@@@@@@@@@@@")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ?" : " ?"
        return output
    }
}


struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "") // someCreature 的类型是 Animal? 而不是 Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}



struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
    
    var isBlack = false
    for i in 1...10 {
        for j in 1...10 {
            temporaryBoard.append(isBlack)
            isBlack = !isBlack
        }
        isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(1, column: 0))
// 输出 "true" 
print(board.squareIsBlackAtRow(0, column: 9))



