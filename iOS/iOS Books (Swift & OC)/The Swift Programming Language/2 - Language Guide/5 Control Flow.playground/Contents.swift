//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/// Control Flow

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


for var index = 0; index < 3; ++index {    
    print(index)
}

for index in 0 ..< 3 {
    print(index)
}


// a game

let finalSquare = 25 //胜利的时候 在第25个

//设置 梯子
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
board.count

var square = 0
var diceRoll = 0

while square <= finalSquare {
    diceRoll =  random() % 7
    square += diceRoll
    print("diceRoll: \(diceRoll)  square :\(square) ")
    if square < board.count && board[square] != 0 {
        let temp = square
        square += board[temp]
        print("board: \(board[temp]), square:\(square)")
    }
    print("##########")
}
print("Game over!")

square = 0
diceRoll = 0

repeat {
    
    let temp = square
    square += board[square]
    print("board: \(board[temp]), square:\(square)")
    
    diceRoll =  random() % 7
    square += diceRoll
    print("diceRoll: \(diceRoll)  square :\(square) ")
    print("**********")
    
} while square <= finalSquare

print("Game over!")

let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}

let anotherCharacter: Character = "a"
switch anotherCharacter {
//case "a": 
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}

//区间匹配

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5 :
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings)")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0,0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0,_):
    print("(0,\(somePoint.1) is on the y-axis)")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default :
    print("\(somePoint) is outside the box")
    
}


let anotherPoint = (2, 2)
switch anotherPoint {
case (let x, 0):
    print("On the x-axis with an x value of \(x) ")
case (0, let y):
    print("On the y-axis with an x value of \(y) ")
case let (x, y):
    print("somewhere else at",(x,y))
    
}

let yetAnotherPoint = (1, 9)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print((x, y), "is on the line x == y")
case let (x, y) where x == -y:
    print((x, y), "is on the line x == -y")
case let (x, y):
    print(yetAnotherPoint,"is just some arbitrary point")
}

/**
 *  控制转移语句
 */

// continue break fallthrough   ///return throw

let pizzleInput = "great minds think alike"
var puzzleOutput = ""
for character in pizzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default :
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)


let numberSymbol: Character = "6" // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "?", "一", "?":
    possibleIntegerValue = 1
case "2", "?", "二", "?":
    possibleIntegerValue = 2
case "3", "?", "三", "?":
    possibleIntegerValue = 3
case "4", "?", "四", "?":
    possibleIntegerValue = 4
default:
    break }
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)


square = 0
diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll = random() % 7
    switch square + diceRoll {
    case finalSquare :
        print("\(square) -> \(square + diceRoll)")
        break gameLoop
    case let newSquare where newSquare > finalSquare :
        continue gameLoop
    default :
        print("\(square) -> \(square + diceRoll)")
        square += diceRoll
        print(square, "->" ,square + board[square] )
        square += board[square]
        print("@@@@@@@@@@@@")
    }
}
print("Game over!")


//提前退出
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
    
}

greet(["name": "Jim"])
greet(["name": "Lucy", "location": "xi san qi"])

//检测 api 可用性

if #available(iOS 9, OSX 10.10, *) {
    //
    print("#available(iOS 9, OSX 10.10, *)")
} else {
    //
}


