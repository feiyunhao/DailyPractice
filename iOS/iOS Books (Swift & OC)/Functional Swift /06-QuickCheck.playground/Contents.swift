//: Playground - noun: a place where people can play

import UIKit

let numberOfIterations = 10


protocol Smaller {
    func smaller() -> Self?
}

protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary,Smaller {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}

extension Character: Arbitrary,Smaller {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(Int.random(from: 65, to: 90)))
    }
    func smaller() -> Character? { return nil }
}

func tabulate<A>(times: Int, transform: Int -> A) -> [A] {
    return (0..<times).map(transform)
}

extension Int {
    static func random(from from: Int, to: Int) -> Int {
        return from + (Int(arc4random()) % (to - from))
    }
}

extension String: Arbitrary,Smaller {
    static func arbitrary() -> String {
        let randomLength = Int.random(from: 0, to: 40)
        let randomCharacters = tabulate(randomLength) { _ in
            Character.arbitrary()
        }
        return String(randomCharacters)
    }
    func smaller() -> String? {
        return isEmpty ? nil : String(characters.dropFirst())
    }
}

func check1<A: Arbitrary>(message: String, _ property: A -> Bool) -> () {
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            print("\"\(message)\" doesn't hold: \(value)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}

extension CGSize: Arbitrary, Smaller {
    static func arbitrary() -> CGSize {
        return CGSize(width: CGFloat.arbitrary(),
                      height: CGFloat.arbitrary())
    }
    func smaller() -> CGSize? {
        return nil
    }
}

extension CGFloat: Arbitrary,Smaller {
    static func arbitrary() -> CGFloat {
        let random: CGFloat = CGFloat(arc4random())
        let maxUint = CGFloat(UInt32.max)
        return 10000 * ((random - maxUint/2) / maxUint)
    }
    func smaller() -> CGFloat? {
        return nil
    }
}

check1("Area shoubld be at least 0") { (size: CGSize) -> Bool in
    size.area >= 0
}

check1("Every string starts with Hello") { (s: String) -> Bool in
    s.hasPrefix("Hello")
}

100.smaller()

func iterateWhile<A>(condition: A -> Bool, initial: A, next: A -> A?) -> A {
    if let x = next(initial) where condition(x) {
        return iterateWhile(condition, initial: x, next: next)
    }
    return initial
}

protocol ArbitrarySmaller: Arbitrary, Smaller {
    
}

func check2<A: ArbitrarySmaller>(message: String, _ property: A -> Bool) -> () {
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            let smallerValue = iterateWhile({ !property($0) }, initial: value) {
                $0.smaller()
            }
            print("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

//check2("Area shoubld be at least 0") { (size: CGSize) in
//   return size.area >= 0
//}
//
//check2("Every string starts with Hello") { (s: String) in
//    return s.hasPrefix("Hello")
//}

func qsort(var array: [Int]) -> [Int] {
    if array.isEmpty { return [] }
    let pivot = array.removeAtIndex(0)
    let lesser = array.filter { $0 < pivot }
    let greater = array.filter { $0 >= pivot }
    return qsort(lesser) + [pivot] + qsort(greater)
}

extension Array: Smaller {
    func smaller() -> [Element]? {
        guard !isEmpty else { return nil }
        return Array(dropFirst())
    }
}

extension Array where Element: Arbitrary {
    static func arbitrary() -> [Element] {
        let randomLength = Int(arc4random() % 50)
        return tabulate(randomLength) { _ in Element.arbitrary() }
    }
}

//check2("qsort should behand like sort") { (x: [Int]) in
//    return qsort(x) 
//}

