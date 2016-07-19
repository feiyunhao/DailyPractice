//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//为了演示 “如何利用递归枚举，”

func empty<Element>() -> [Element] {
    return []
}

func isEmpty<Element>(set: [Element]) -> Bool {
    return set.isEmpty
}

func contains<Element: Equatable>(x: Element, _ set: [Element]) -> Bool {
    return set.contains(x)
}

func insert<Element: Equatable>(x: Element, _ set:[Element]) -> [Element] {
    return contains(x, set) ? set : [x] + set
}

indirect enum BinarySearchTree<Element:Comparable> {
    case Leaf
    case Node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

let leaf: BinarySearchTree<Int> = .Leaf
let five: BinarySearchTree<Int> = .Node(leaf, 5, leaf)

extension BinarySearchTree {
    init() {
        self = .Leaf
    }
    init(_ value: Element) {
        self = .Node(.Leaf, value, .Leaf)
    }
}

extension BinarySearchTree {
    var count: Int {
        switch self {
        case .Leaf:
            return 0
        case let .Node(left, _ ,right):
            return left.count + right.count + 1
        }
    }
    
}

extension BinarySearchTree {
    var elements: [Element] {
        switch self {
        case .Leaf:
            return []
        case let .Node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
}

extension BinarySearchTree {
    var isEmpty: Bool {
        if case .Leaf = self {
            return true
        }
        return false
    }
}

extension BinarySearchTree where Element: Comparable {
    var isBST: Bool {
        switch self {
        case .Leaf:
            return true
        case let .Node(left, x, right):
            return left.elements.all { y in y < x }
                && right.elements.all { y in y > x }
                && left.isBST
                && right.isBST
        }
    }
}

extension SequenceType {
    func all(predicate: Generator.Element -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}

extension BinarySearchTree {
    func contains(x: Element) -> Bool {
        switch self {
        case .Leaf:
            return false
        case let .Node(_, y, _) where x == y:
            return true
        case let .Node(left, y, _) where x < y:
            return left.contains(x)
        case let .Node(_, y, right) where x > y:
            return right.contains(x)
        default:
            fatalError("The impossible occurred")
        }
    }
}

extension BinarySearchTree {
    mutating func insert(x: Element) {
        switch self {
        case .Leaf:
            self = BinarySearchTree(x)
        case .Node(var left, let y, var right):
            if x < y { left.insert(x) }
            if x > y { right.insert(x) }
            self = .Node(left, y, right)
        }
    }
}

let myTree: BinarySearchTree<Int> = BinarySearchTree()
var copied = myTree
copied.insert(5)
(myTree.elements, copied.elements)


//: ## Autocompletion Using Tries

func autocomplete(history: [String], textEntered: String) -> [String] {
    return history.filter { $0.hasPrefix(textEntered) }
}

//“字典树 (Tries)，也被称作数字搜索树 (digital search trees)，是一种特定类型的有序树，通常被用于搜索由一连串字符组成的字符串。不同于将一组字符串储存在一棵二叉搜索树中，字典树把构成这些字符串的字符逐个分解开来，储存在了一个更高效的数据结构中”

struct Trie<Element: Hashable> {
    let isElement: Bool //这个布尔值会标记截止于当前节点的字符串是否在树中”
    let children: [Element: Trie<Element>]
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }
}

extension Trie {
    var elements: [[Element]] {
        
//        “首先，我们会检查当前的 “根节点” 是否被标记为一棵字典树的成员。如果是，这个字典树就包含了一个空的键，反之，result 变量则会被实例化为一个空的数组。”
        var result: [[Element]] = isElement ? [[]] : []
        
//        “接着，函数会遍历字典，计算出子树的所有元素 —— 这是通过调用 value.elements 实现的。”
        for (key, value) in children {
//            “最后，每一棵子字典树对应的 “character” (也就是代码中的 key) 会被添加到子树 elements 的首位”
            result += value.elements.map { [key] + $0 }
        }
        
        return result
    }
}

extension Array {
    var decompose: (Element, [Element])? {
        return isEmpty ? nil : (self[startIndex], Array(self.dropFirst()))
    }
}

func sum(xs: [Int]) -> Int {
    guard let (head, tail) = xs.decompose else { return 0 }
    return head + sum(tail)
}

func qsort(input: [Int]) -> [Int] {
    guard let (pivot, rest) = input.decompose else { return [] }
    let lesser = rest.filter { $0 < pivot }
    let greater = rest.filter { $0 >= pivot }
    return qsort(lesser) + [pivot] + qsort(greater)
}

extension Trie {
    func lookup(key: [Element]) -> Bool {
        guard let (head, tail) = key.decompose else { return isElement }
        guard let subtrie = children[head] else { return false }
        return subtrie.lookup(tail)
    }
}
// MARK: 后续再看

