//: [Previous](@previous)

import Foundation

import RxSwift

class Foo {
    let bar: Int
    
    init(bar: Int) {
        self.bar = bar
    }
    
    deinit {
        print("Deinit \(bar)")
    }
}

enum ErrorSS: Int, ErrorType {
    case Foo = 2
    
    var _code: Int {
        return rawValue
    }
}


print(ErrorSS.Foo._code)
