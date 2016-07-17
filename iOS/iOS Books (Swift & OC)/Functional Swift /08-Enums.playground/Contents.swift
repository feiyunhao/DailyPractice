//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


enum Encoding {
    case ASCII
    case NEXTSTEP
    case JapaneseEUC
    case UTF8
}

extension Encoding {
    var nsStringEncoding: NSStringEncoding {
        switch self {
        case .ASCII:
            return NSASCIIStringEncoding
        case .NEXTSTEP:
            return NSNEXTSTEPStringEncoding
        case .JapaneseEUC:
            return NSJapaneseEUCStringEncoding
        case .UTF8:
            return NSUTF8StringEncoding
        }
    }
}

extension Encoding {
    init?(enc: NSStringEncoding) {
        switch enc {
        case NSASCIIStringEncoding: self = .ASCII
        case NSNEXTSTEPStringEncoding: self = .NEXTSTEP
        case NSJapaneseEUCStringEncoding: self = .JapaneseEUC
        case NSUTF8StringEncoding: self = .UTF8
        default: return nil
        }
    }
}

func localizedEncodingName(encoding: Encoding) -> String {
   return String.localizedNameOfStringEncoding(encoding.nsStringEncoding)
}

enum LookupError: ErrorType {
    case CapitalNotFound
    case PopulationNotFound
}

enum PopulationResult {
    case Success(Int)
    case Error(LookupError)
}

let exampleSuccess: PopulationResult = .Success(1000)


let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]

func populationOfCapital(country: String) -> PopulationResult {
    guard let capital = capitals[country] else {
        return .Error(.CapitalNotFound)
    }
    guard let population = cities[capital] else {
        return .Error(.PopulationNotFound)
    }
    return .Success(population)
}

switch populationOfCapital("France") {
case let .Success(population):
    print("France's capital has \(population) thousand inhabitants")
case let .Error(error):
    print("Error: \(error)")
}


let mayors = [
    "Paris": "Hidalgo",
    "Madrid": "Carmena",
    "Amsterdam": "van der Laan",
    "Berlin": "Müller"
]

func mayorOfCapital(country: String) -> String? {
    return capitals[country].flatMap { mayors[$0] }
}

enum MayorResult {
    case Success(Int)
    case Error(ErrorType)
}


enum Result<T> {
    case Success(T)
    case Error(ErrorType)
}


func populationOfCapital1(country: String) throws -> Int {
    guard let capital = capitals[country] else {
        throw LookupError.CapitalNotFound
    }
    guard let population = cities[capital] else {
        throw LookupError.PopulationNotFound
    }
    return population
}

do {
    let population = try populationOfCapital1("hehe")
    print(population)
} catch {
    print(error)
}

//??
enum Add<T, U> {
    case InLeft(T)
    case InRight(U)
}


enum Zero { }



