//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//Optional是Swift的一大特色，解决了“有” “无”两个困扰了Objcetive－C的哲学问题
//也使代码安全得到了大大的提升

//多重Optional


//使用类型后边加上？ 是Optional类型的语法糖
//Optional   

var string: String? = "string"
var anotherString: String?? = string
var literalOptional: String?? = "string"


var aNil: String? = nil
var anotherNil: String?? = aNil
var literalNil: String?? = nil

if let a = anotherNil {
    print("anotherNil")
}

if let b = literalNil {
    print("literalNil")
}



