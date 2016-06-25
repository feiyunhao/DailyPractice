//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


//每次对sum的调用都要在栈上保存当前状态，否则无法计算 n ＋ sum（n － 1），如果n足够大，调用栈足够深的话，栈空间将会被耗尽，也就是stackoverflow

func sum(n: UInt) -> UInt {
    if n == 0 {
        return 0
    }
    return n + sum(n - 1)
}

sum(4)

sum(100)

//sum(1000000)


//一半来说，解决栈溢出的一个好方法就是采用尾递归的形式的写法；
//尾递归就是让函数里的最后一次动作是函数调用形式，这个调用的返回值将直接被当前函数返回，避免在栈上保存状态
//这样以来程序就可以更新最后一个栈帧，而不是新建一个，从而避免栈溢出

func tailSum(n: UInt) -> UInt {
    
    func sumInternal(n: UInt, current: UInt) -> UInt {
        if n == 0 {
            return current
        } else {
            return sumInternal(n - 1, current: current + n)
        }
    }
    return sumInternal(n, current: 0)
}

//tailSum(1000000)
