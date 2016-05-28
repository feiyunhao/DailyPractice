//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//简单值

print("Hello World")

var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 90.0
let explicitDouble: Double = 70
let explicitFloat:Float = 70

let label = "The width is"
let width = 94
let widthLabel = label + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

var shoppingList = ["catfish", "water", "tulips", "blue paint"];
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic"
]
occupations["Jayne"] = "Public Relations"

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

shoppingList = []
occupations = [:];


//控制流

let individualScores = [75, 43, 103, 87, 12];
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = "Jhon Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello,\(name)"
}

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

let vegetable = "red pepper"

switch vegetable {
    
case "celery":
    print("Add some raisins and make ants on a log")
case "cucumber", "watercress":
    print("That would make a good tea sandwich")
case let x where x.hasPrefix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("EveryThing tates good in soup")
    
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7],
    "Fibnacci": [1, 1, 2],
    "Square": [1, 4, 9]
]

var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        print("\(kind) : \(number)")
        if number > largest {
            largest = number
        }
    }
}
print(largest)

var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

var firstForLoop = 0
for i in 0...4 {
    firstForLoop += i
    print(i)
}
print(firstForLoop)

var secondForLoop = 0
for i in 0..<4 {
    secondForLoop += i
    print(i)
}
print(secondForLoop)


//函数和闭包

func calcuateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}


let statistics = calcuateStatistics([5,3,10])


func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(2,3,4,5)

func meanOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return  numbers.count == 0 ? 0 : sum / numbers.count
}
meanOf()
meanOf(1,2,3,4)

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
makeIncrementer()(4)

func hasAnyMaches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [100, 1000, 10000]
hasAnyMaches(numbers, condition: lessThanTen)

//???:
let test = numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
print(test)

let mapedNumbers = numbers.map({number in 3 * number})
print(mapedNumbers)

let sortedNumber = numbers.sort({$0 > $1})
print(sortedNumber)


//类和对象

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

var shape = Shape()
shape.numberOfSides = 7
shape.simpleDescription()

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

class Square: NamedShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let testSquare = Square(sideLength: 5.2, name: "my test square")
testSquare.area()
testSquare.simpleDescription()

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
//        willSet {
//            print(newValue)
//        }
//        didSet {
//            print(oldValue)
//        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter
triangle.simpleDescription()
triangle.perimeter = 9.0
triangle.sideLength

let optionalSquare: Square? = nil//Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength


//枚举和结构体

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queue, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queue:
            return "queue"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue

//init?(rawValue:)
Rank(rawValue: 0)

Rank.Ten.simpleDescription()

if let convertedRank = Rank(rawValue:3) {
    let thressDescription = convertedRank.simpleDescription()
}

Rank.init(rawValue: 3)

enum Suit {
    case Spades, Hearts, Diamonds, Cluds
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Cluds:
            return "cluds"
        }
    }
}

let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescriprion() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadeDescription = threeOfSpades.simpleDescriprion()

enum ServerResponse {
    case Result(String, String)//成员值、实际值  （实例值）
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let fail = ServerResponse.Error("Out of cheese")

switch success {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunnset is at \(sunset)"
case let .Error(error):
    let serverResponse = "Failure... \(error)"
}

enum ServerResponseTest: Int {
    case Result = 1 //原始值
    case Error
}


//协议和扩展

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust() //mutating 会修改结构体的方法
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "a simple structure"
     mutating func adjust() {
        simpleDescription += "adjust"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)


//泛型

func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
repeatItem("knock", numberOfTimes:4)

enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3])


