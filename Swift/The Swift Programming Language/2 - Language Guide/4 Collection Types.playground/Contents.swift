//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/// Array

var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items")

someInts.append(3)
someInts = []

var threeDoubles = [Double](count:3, repeatedValue: 0.0)
var anotherThreeDoubles = [Double](count:3, repeatedValue: 2.0)

var sixDoubles = threeDoubles + anotherThreeDoubles

var shoppingList = ["Eggs", "Milk"]

//let mylist = ["Eggs", "Milk"]
//mylist[0] = "can It work ?"


shoppingList.isEmpty

shoppingList.append("hot dog")

shoppingList += ["Baking", "Powder"]
var firstItem = shoppingList[0]

firstItem = "you tiao"

shoppingList
shoppingList[0] = "you tiao"
shoppingList

shoppingList[1...3] = ["Bananas", "Apples"]
shoppingList


shoppingList.insert("dou jiang", atIndex: shoppingList.count)
shoppingList.removeAtIndex(0)

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerate() {
    print(index,value)
}

/**
 *  Set
 */


var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
letters = []

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
print("I have \(favoriteGenres.count) favorite music genres.")
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

favoriteGenres

for item in favoriteGenres {
    print(item)
}

for item in favoriteGenres.sort() {
    print(item)
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()//并集
oddDigits.intersect(evenDigits).sort()//交集
oddDigits.subtract(singleDigitPrimeNumbers).sort()
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

let houseAnimals: Set = ["?", "?"]
let farmAnimals: Set = ["?", "?", "?", "?", "?"]
let cityAnimals: Set = ["?", "?"]

houseAnimals.isSubsetOf(farmAnimals)
farmAnimals.isSupersetOf(houseAnimals)
farmAnimals.isDisjointWith(cityAnimals)

/**
 *  dictionary
 */

var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers
namesOfIntegers = [:]

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

airports.count

airports.isEmpty

airports["LHR"] = "London"

airports.updateValue("cuole", forKey: "LHR")
airports["LHR"]
airports.updateValue("shishi", forKey: "shishi")
airports["LHR"] = nil
airports["shishi"] = nil
airports

if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys.sort())
let airportNames: Array<String> = Array(airports.values)




