//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/// 下标脚本 Subscripts


//下标脚本允许你通过在 实例 后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
//语法类似于 实例方法 和 计算型属性 的混合。
//与定义实例方法类似, 定义下标脚本使用 subscript 关键字,显式声明入参(一个 或多个)和返回类型。
//与 实例方法 不同的是下标脚本可以设定为 读写 或 只读 。这种方式又有点像 计算型属性的 getter和setter:


struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")



//通常下标脚本是用来访问集合(collection),列表(list)或 序列(sequence)中元素的快捷方式。
//可以在你自己特定的类或结构体中自由的实现下标脚本来提供合适的功 能。

//同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为 nil 即可。



//下标脚本允许 任意数量的入参索引,并且每个入参类型也没有限制。
//下标脚本的返回值也可以是任何类型。

//下标 脚本可以使用 变量 参数和 可变 参数,

///通过在参数名前加关键字var来定义 变量参数:
///一个 可变参数(variadic parameter) 可以接受零个或多个值。函数调用时,你可以用可变参数来指定函数参数 可以被传入不确定数量的输入值。通过在变量类型名后面加入 (...) 的方式来定义可变参数。

//但使用 写入读出(in-out)参数 或给 参数设置默认值都是不允许的。

struct Matrix {
    
    let rows: Int, columns: Int
    
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0) }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
    
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        
        get {
//            断言
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}


var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

matrix[2,2] = 3.4


