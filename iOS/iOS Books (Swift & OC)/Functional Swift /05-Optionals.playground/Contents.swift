//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]

let madridPopulation: Int? = cities["Madrid"]

if madridPopulation != nil {
    print("The population of Madrid is \(madridPopulation! * 1000)")
} else {
    print("Unknown city: Madrid")
}

if let madridPopulation = cities["Madrid"] {
    print("The population of Madrid is \(madridPopulation * 1000)")
} else {
    print("Unknown city: Madrid")
}


struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name: String
    let address: Address?
}

struct Address {
    let streetName: String
    let city: String
    let state: String?
}

let order = Order(orderNumber: 1, person: nil)

if let myState = order.person?.address?.state {
  print("ok")
} else {
    print("unkonwn")
}

switch madridPopulation {
    case 0?:print("0")
    case (1..<100)?: print("1..<100")
    case .Some(let x): print("\(x) people in Madrid")
    case .None: print("We don't know about Madrid")
}

func populationDescriptionForCity(city: String) -> String? {
    guard let population = cities[city] else { return nil }
    return "The population of Madrid is \(population * 1000)"
}

populationDescriptionForCity("Madrid")

func incrementOptional(optional: Int?) -> Int? {
    guard let x = optional else { return nil }
    return x + 1
}

func incrementOptional2(optional: Int?) -> Int? {
    return optional.map { $0 + 1 }
}

func addOptionals(optionalX: Int?, optionalY: Int?) -> Int? {
    guard let x = optionalX, y = optionalY else { return nil }
    return x + y
}

let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

func populationOfCapital(country: String) -> Int? {
    guard let capital = capitals[country], population = cities[capital]
        else { return nil }
    return population * 1000
}

func addOptionals2(optionalX: Int?, optionalY: Int?) -> Int? {
    return optionalX.flatMap { x in
        optionalY.flatMap { y in
             x + y
        }
    }
}

func populationOfCapital2(country: String) -> Int? {
    return capitals[country].flatMap { capital in
        cities[capital].flatMap {
            $0 * 1000
        }
    }
}

func populationOfCapital3(country: String) -> Int? {
    return capitals[country].flatMap {
        cities[$0]
    }.flatMap{
        $0 * 1000
    }
}

