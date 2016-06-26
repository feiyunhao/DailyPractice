//: [Previous](@previous)

import Foundation

/**
 Currying
 
 在计算机科学中，柯里化（英语：Currying），又译为卡瑞化或加里化，是把接受多个参数的函数变换成接受一个单一参数（最初函数的第一个参数）的函数，并且返回接受余下的参数而且返回结果的新函数的技术
 */

func addOne(num: Int) -> Int {
    return num + 1
}

addOne(3)

func addTo(adder: Int) -> Int -> Int {
    return {
        num in
        return num + adder
    }
}

let addTwo = addTo(2)
addTwo(2)

func greaterThan(comparer: Int) -> Int -> Bool {
    return { $0 > comparer }
}

let greaterThanTen = greaterThan(10)
greaterThanTen(11)

//柯里化是一种量产相似方法的好办法，避免写重复代码，方便后期维护

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
    
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T, action: (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
    
}








        