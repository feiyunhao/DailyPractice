//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

"as" ~= "as"
1 ~= 1
0...5 ~= 1
let aInt: Int? = nil
nil ~= aInt
//let anotherInt: Int? = 1
//anotherInt ~= aInt

let password = "123456"
switch password {
    case "123456": print("密码通过")
    default:        print("验证失败")
}

let num: Int? = nil
switch num {
    case nil: print("没值")
    default:  print("\(num!)")
}

let x = 0.5
switch x {
    case -1.0...1.0: print("区间内")
    default: print("区间外")
}

//switch 隐式使用了～＝操作符进行匹配
//case指定的模式作为左边的参数，等待匹配的被switch的元素作为操作符右边的参数

//在switch做case判断的时候，可以使用我们自定义的模式匹配方法进行判断
//只需要按照要求重载～＝

func ~=(pattern: NSRegularExpression, input: String) -> Bool {
    return pattern.numberOfMatchesInString(input,
                                           options: [],
                                           range: NSRange(location: 0, length: input.characters.count)) > 0
}

prefix operator ~/ {}

prefix func ~/(pattern: String) throws -> NSRegularExpression {
    return try NSRegularExpression(pattern: pattern, options: [])
}

let contact = ("http://www.caoliuzuiixin.com", "123@caoliu.com")

let mailRegex: NSRegularExpression
let siteRegex: NSRegularExpression

mailRegex = try ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
siteRegex = try ~/"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"


switch contact {
case (siteRegex, mailRegex): print("同时拥有有效的网站和邮箱")
case (_, mailRegex): print("只拥有有效的邮箱")
case (siteRegex, _): print("只拥有有效的网站")
default: print("嘛都没有")
}

