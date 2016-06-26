//: [Previous](@previous)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

var str = "Hello, playground"

//: [Next](@next)
let workingQueue = dispatch_queue_create("my_queue", nil)

dispatch_async(workingQueue) { 
    print("working hard")
    NSThread.sleepForTimeInterval(2)
    dispatch_async(dispatch_get_main_queue(), { 
        print("回到主线程，更新UI")
    })
}

//Swift中创建一个selector并不是一件安全的事情（需要通过字符串创建，这在之后的代码改动的时候很危险）
//performSelector在ARC下并不安全
//RAC为了保障参数在方法运行期间存在，在无法确定参数内存的情况下，会将参数在开始的石斛retain，然后在最后release
//performSelector 没有指定参数 被调用的selector可能指向未知的垃圾内存

let time: NSTimeInterval = 2.0
let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
dispatch_after(delay, dispatch_get_main_queue()) { 
    print("2秒后派发")
}

//dispatch_block_t
//dispatch_block_cancel(<#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)


typealias Task = (cancel: Bool) -> Void

func delay(time: NSTimeInterval, task: () -> ()) -> Task? {
    func dispatch_later(block: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), internalClosure);
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    return result;
}


func cancel(task:Task?) {
    task?(cancel: true)
}

delay(2) { print("2 秒后自曝") }

let task = delay(5) { print("自曝") }

// 仔细想一想..
// 还是放过地球人吧
cancel(task)









