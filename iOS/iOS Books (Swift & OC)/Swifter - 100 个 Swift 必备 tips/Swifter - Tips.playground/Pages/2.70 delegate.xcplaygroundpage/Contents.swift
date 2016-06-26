//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)

protocol MyClassDelegate: class {
    func method()
}

class MyClass {
    weak var delegate: MyClassDelegate?
}

class ViewController: UIViewController, MyClassDelegate {
    
    // ...
    
    var someInstance: MyClass!
    override func viewDidLoad() {
        super.viewDidLoad()
        someInstance = MyClass()
        someInstance.delegate = self
        
    }
    
    func method() {
        print("Do something")
    }
    
    //...
    
}