//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///协议 Protocols
/*
    protocol SomeProtocol {
        //
    }
    struct SomeStructure: FirstProtocol, AnotherProtocol {
        // 结构体内容 
    }
    class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
        // 类的内容
    }
 */

//协议可以规定其 遵循者 提供特定 名称 和 类型的 实例属性(instance property) 或 类属性(type property) ,
//而不用 指定是 存储型属性(stored property) 还是 计算型属性(calculate property) 。
//此外还必须指明是只读的还是可读可写的。

//在类型声明后加上 { set get } 来表示属性是可读可写的,只读属性则用 { get } 来表示。

protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    static var someTypeProperty: Int { get set }
}
protocol AnotherProtocol {}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed{
    var fullName: String
}
var john = Person(fullName: "John Appleseed")
john.fullName = "赵日天"
john.fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

//协议可以要求其遵循者实现某些指定的 实例方法 或 类方法。
//这些方法作为协议的一部分,像普通的方法一样放在协议的定义中,
//但是不需要大括号和方法体。
//可以在协议中定义具有 可变参数 的方法,和普通方法的定义方式相同。
//但是在协议的方法定义中,不支持 参数 默认值。

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")


//有时需要在方法中改变它的实例。例如,值类型(结构体,枚举)的实例方法中,
//将 mutating 关键字作为函数的前 缀,写在 func 之前,表示可以在该方法中修改它所属的实例及其实例属性的值。
//用类实现协议中的 mutating 方法时,不用写 mutating 关键字;
//用结构体,枚举实现协议中的 mutating 方法 时,必须写 mutating 关键字。

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()


//在遵循该协议的类中实现构造器,并指定其为类的指定构造器(designated initializer)或者便利构造 器(convenience initializer)。

//在这两种情况下,必须给构造器实现标上"required"修饰符 
//保证:所有的遵循该协议的子类,同样能为构造器规定提供一个显式的实现或继承实 现。

protocol SomeInitialzationProtocol{
    init(someParameter: Int)
}

class SomeClass: SomeInitialzationProtocol {
    required init(someParameter: Int) {
        //构造器实现
//      使用 required 修饰符可以保证:所有的 遵循该协议的 子类,
//      同样能为 构造器 规定提供一个 显式的 实现 或 继承实现。
    }
}

//在类的构造器前添加required修饰符表明所有 该类的子类 都必须实现该构造器:
//在子类重写父类的必要构造器时,必须在子类的构造器前 也添加 required 修饰符,这是为了保证继承链上子类的 构造器也是必要构造器。在重写父类的必要构造器时,不需要添加 override 修饰符:

//如果类已经被标记为 final ,那么不需要在协议构造器的实现中使用 required 修饰符。因为final类不能有子 类。


protocol SomeProtocol1 {
    init()
}
class SomeSuperClass1 {
    init() {
    // 构造器的实现 
    }
}
class SomeSubClass1: SomeSuperClass1, SomeProtocol1 {
        // 因为遵循协议,需要加上"required"; 因为继承自父类,需要加上"override" 
    required override init() {
        // 构造器实现
    }
}

//如果在协议中定义一个可失败构造器,则在遵顼该协议的类型中必须添加同名同参数的可失败构造器或非可失败 构造器。
//如果在协议中定义一个非可失败构造器,则在遵循该协议的类型中必须添加同名同参数的非可失败构造器或 隐式解析类型的可失败构造器( init! )。

//可失败构造器是一种可以生成 可选实例 或者是一类 构造器声明的隐式解析可选实例(an implicitly unwrapped op tional instance)类型。所以,构造区通过返回 nil 来指明构造过程失败。

//声明可以生成可选实例的可失败构造器,在构造器声明的 init 关键字后加追加一个问号( init? )。
//声明可生成隐式解析可选实例的 可失败构造器 ,在构造器声明后追加一个叹号( init! )。


//协议可以像其他普通类型一样使用,使用场景: 
//• 作为函数、方法或构造器中的 参数类型 或 返回值类型
//• 作为常量、变量或属性的 类型
//• 作为数组、字典或其他容器中的 元素 类型

class Dice {
    let sides: Int
    
//    generator 属性的类型为 RandomNumberGenerator ,
//    因此任何遵循了 RandomNumberGenerator 协议的类型的实例都 可以赋值给 generator ,除此之外,无其他要求。
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1 }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

///委托(代理)模式

//委托是一种设计模式,它允许 类 或 结构体 将一些需要它们负责的功能 交由(或委托) 给其他的类型的实例。
//委托 模式的实现很简单: 定义协议来封装那些需要被委托的函数和方法,使其 遵循者 拥有这些被委托的 函数和方 法 。
//委托模式可以用来 响应 特定的动作或 接收 外部数据源提供的数据,而无需要知道 外部数据源的类型信息。

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self,didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//在扩展中添加协议成员

//即便无法修改源代码,依然可以通过扩展(Extension)来扩充已存在类型( 类,结构体,枚举等)。
//扩展可以为已存在的类型添加 属性,方法,下标脚本,协议 等成员。

//通过扩展为已存在的类型 遵循协议时,该类型的 所有实例也会随之添加协议中的方法
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
print(d12.textualDescription)


//当一个类型已经实现了协议中的所有要求,却没有声明为遵循该协议时,可以通过扩展(空的扩展体)来补充协议 声明:
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

let things: [TextRepresentable] = [d12,simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

//协议的继承
//协议能够继承一个或多个其他协议,可以在继承的协议基础上增加新的内容要求。协议的继承语法与类的继承相 似,多个被继承的协议间用逗号分隔:

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
    
    var textualDescription: String {
        return " "
    }
    
    
}
print(game.prettyTextualDescription)


//有时候需要同时遵循多个协议。
//可以将多个协议采用 protocol<SomeProtocol, AnotherProtocol> 这样的格式进 行组合,称为 协议合成(protocol composition) 。可以在 <> 中罗列任意多个你想要遵循的协议,以逗号分隔。
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


//检验协议的一致性

//• is 操作符用来检查实例是否 遵循 了某个 协议 。 
//• as? 返回一个可选值,当实例 遵循 协议时,返回该协议类型;否则返回 nil 。 
//• as 用以强制向下转型,如果强转失败,会引起运行时错误。

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [ Circle(radius: 2.0), Country(area: 243_610), Animal(legs: 4) ]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//可选协议的规定

//可选协议只能在含有 @objc 前缀的协议中生效。
//@objc 的协议只能由继承自 Objective-C 类的 类或者其他的 @objc 类来遵循。它也不能被结构体和枚举遵循。

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: CounterDataSource {
    @objc let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: CounterDataSource {
    @objc func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//使用扩展协议的方式可以为遵循者提供 方法或属性的 实现。
//通过这种方式,可以让你无需在每个遵循者中都实现 一次,无需使用全局函数,你可以通过扩展协议的方式进行定义。

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
print("And here's a random Boolean: \(generator1.randomBool())")

extension CollectionType where Generator.Element : TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
print(hamsters.textualDescription)

