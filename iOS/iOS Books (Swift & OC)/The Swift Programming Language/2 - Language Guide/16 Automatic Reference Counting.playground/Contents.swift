//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//weak reference
//unowned reference

//在实例的生命周期中，如果某些时候引用没有值，那么使用弱引用可以避免循环强引用
//如果引用总是有值，则可以使用无主引用
//弱引用声明成可选类型变量


class Country {
    let name: String
//    第一次被赋值之后,可以确定一个可选类型总会有值。
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}



var country = Country(name: "China", capitalName: "BeiJing")

country.name
country.capitalCity.name
country.capitalCity.country.name


class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>" }
        else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}


let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML()
heading.asHTML = {
    [unowned heading] in
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// prints "<h1>some default text</h1>"

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

//定义闭包时同时定义捕获列表




