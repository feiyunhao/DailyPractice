//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//在涉及到一些数据结构的经典理论和模型（链表，树，图）往往会用到嵌套的类型

//class Node<T> {
//    let value: T?
//    let next: Node<T>?
//    
//    init(value: T?, next: Node<T>?) {
//        self.value = value
//        self.next = next
//    }
//}
//
//let list = Node(value:1,
//                next: Node(value:2,
//                    next: Node(value:3,
//                        next: Node(value:4, next: nil))))

//在Swift2中，我们可以使用嵌套的enum了

indirect enum LinkedList<Element: Comparable> {
    case Empty
    case Node(Element, LinkedList<Element>)
    
    func linkedListByRemovingElement(element: Element) -> LinkedList<Element> {
//        判断self 为Node（value，next） (即不为空 .Empty)
        guard case let .Node(value, next) = self else {
//            如果self为空，返回 .Empty
            return .Empty
        }
//        如果self不为空，即self 也为 .Node(value,next)形式
        
//        如果传入参数 element 跟 self 的value相等 返回 next （即把 value 删除了）
//        (value1 ,next1) = (value1 , (value2, next2)) ->  next1 = (value2, next2)
        
//        如果不相等，保留value ，让以后的链表 next 再执行以上逻辑
//        (value, next) -> (value, next.linkedListByRemovingElement(element))
//
        return value == element ?
            next : LinkedList.Node(value, next.linkedListByRemovingElement(element))
    }
    
}

let linkedList = LinkedList.Node(1, .Node(2, .Node(3, .Node(4, .Empty))))
print(linkedList)
let result1 = linkedList.linkedListByRemovingElement(2)
print(result1)
let result2 = linkedList.linkedListByRemovingElement(100)
print(result2)


let emptyList = LinkedList<Int>.Empty
let result3 = emptyList.linkedListByRemovingElement(12)
print(result3)



        
