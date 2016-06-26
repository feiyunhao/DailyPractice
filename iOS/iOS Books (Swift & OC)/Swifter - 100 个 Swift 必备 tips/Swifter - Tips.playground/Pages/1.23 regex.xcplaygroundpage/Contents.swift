//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//Swift至今没有在语言层面上支持正则表达式

struct RegexHelper {
    let regex: NSRegularExpression
    
//    用 throws 关键字标来识一个可抛出错误的函数,方法或是构造器。在函数声明中的参数列表之后加上 throws 。一个标识了 throws 的函数被称作throwing函数。如果这个函数还有返回值类型, throws 关键词需要写在箭头(->)的前面。
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let matches = regex.matchesInString(input,
                                            options: [],
                                            range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

let mailPattern =
"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"

let matcher: RegexHelper
do {
    matcher = try RegexHelper(mailPattern)
}

let maybeMailAddress = "haoshen191@163.com"

if matcher.match(maybeMailAddress) {
    print("有效的邮箱地址")
}
//正则表达式30分钟入门
//http://deerchao.net/tutorials/regex/regex.htm
//8个常用的正则表达式
//http://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149

infix operator =~ {
    associativity none
    precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
        
    } catch _ {
        return false
    }
}

if maybeMailAddress =~
    "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
    print("有效的邮箱地址")
}