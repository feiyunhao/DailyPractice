//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Swift 中默认情况下初始化方法不能写return语句来返回值，也就是没有机会初始化一个optional值

let url: NSURL? = NSURL(string: "ht tp://swifter。tips")
print(url)


extension Int {
    
//    在init声明时在后边加上一个 ？ ！ 表示初始化失败时可返回nil
    init?(fromString: String) {
        self = 0
        var digit = fromString.characters.count - 1
        for c in fromString.characters {
            var number = 0
            if let n = Int(String(c)) {
                number = n
            } else {
                switch c {
                case "一": number = 1
                case "二": number = 2
                case "三": number = 3
                case "四": number = 4
                case "五": number = 5
                case "六": number = 6
                case "七": number = 7
                case "八": number = 8
                case "九": number = 9
                case "零": number = 0
                default: return nil
                }
            }
            
            self = self + number * Int(pow(10, Double(digit)))
            digit = digit - 1
        }
    }
}

let number1 = Int(fromString: "12")
// {Some 12}

let number2 = Int(fromString: "三二五")
// {Some 325}

let number3 = Int(fromString: "七9八")
// {Some 798}

let number4 = Int(fromString: "吃了么")
// nil

let number5 = Int(fromString: "1a4n")
// nil

//对于可能初始化失败的情况，应当始终是用可返回nil的初始化方法

