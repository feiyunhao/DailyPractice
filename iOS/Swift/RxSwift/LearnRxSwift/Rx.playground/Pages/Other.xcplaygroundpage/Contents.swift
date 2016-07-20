//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import RxSwift

/*:
 ### `subscribe`
 
 操作序列的发射物和通知， `subscribe` 系列也就是连接序列和观察者的操作符，顾名思义就是订阅。
 
 这一部分理解起来很轻松，都是同样的订阅，只是 API 的花样多一些。
 
 下面这个是：
 
 public func subscribe(on: (event: RxSwift.Event<Self.E>) -> Void) -> Disposable
 
 就是说我们接收到的是事件，在这里一般通过 switch case 获取对应结果。
 
 */

example("subscribeNext") {
    let sequenceOfInts = PublishSubject<Int>()
    
    _ = sequenceOfInts
        .subscribeNext {
            print($0)
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Completed)
}

/*:
 
 ### `subscribeNext`
 
 `subscribeNext` 只订阅 Next 事件。
 
 public func subscribeNext(onNext: (Self.E) -> Void) -> Disposable
 
 因为只有一种事件，这里的 API 传入的就是事件中包含的具体的值了。
 
 */

example("subscribeNext") {
    let sequenceOfInts = PublishSubject<Int>()
    
    _ = sequenceOfInts
        .subscribeNext {
            print($0)
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Completed)
}

/*:
 
 ### `subscribeCompleted`
 
 `subscribeCompleted` 只订阅 Completed 事件。
 
 public func subscribeCompleted(onCompleted: () -> Void) -> Disposable
 
 */

example("subscribeCompleted") {
    let sequenceOfInts = PublishSubject<Int>()
    
    _ = sequenceOfInts
        .subscribeCompleted {
            print("It's completed")
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Completed)
}

/*:
 
 ### `subscribeError`
 
 `subscribeError` 只订阅 Error 事件。
 
 */

example("subscribeError") {
    let sequenceOfInts = PublishSubject<Int>()
    
    _ = sequenceOfInts
        .subscribeError { error in
            print(error)
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Error(NSError(domain: "Examples", code: -1, userInfo: nil)))
}

example("subscribe 2") {
    
    let sequenceOfInts = PublishSubject<Int>()
    let observableOfInts = sequenceOfInts.share()
    
    _ = observableOfInts.subscribeNext{
        print($0)
    }
    
    _ = observableOfInts
        .subscribeError { error in
            print(error)
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Error(NSError(domain: "Examples", code: -1, userInfo: nil)))
}

/*:
 ### `doOn`
 
 注册一个动作作为原始序列生命周期事件的占位符。

 
 对比其他操作符，底下的部分应该是一个序列，这里并不是。你可以把 `doOn` 理解成在任意的地方插入一个“插队订阅者”，这个“插队订阅者”不会对序列的变换造成任何影响。 `doOn` 和 `subscribe` 有很多类似的 API 。
 
 */

example("doOn") {
    let sequenceOfInts = PublishSubject<Int>()
    
    _ = sequenceOfInts
        .doOn {
            print("Intercepted event \($0)")
        }
        .subscribe {
            print($0)
    }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Completed)
}

/*:
 ### `takeUntil`
 
 当另一个序列开始发射值时，忽略原序列发射的值。
 
 */

example("takeUntil") {
    let originalSequence = PublishSubject<Int>()
    let whenThisSendsNextWorldStops = PublishSubject<Int>()
    
    _ = originalSequence
        .takeUntil(whenThisSendsNextWorldStops)
        .subscribe {
            print($0)
    }
    
    originalSequence.on(.Next(1))
    originalSequence.on(.Next(2))
    originalSequence.on(.Next(3))
    
    whenThisSendsNextWorldStops.on(.Next(1))
    
    originalSequence.on(.Next(4))
}


/*:
 ### `takeWhile`
 
 根据一个状态判断是否继续向下发射值。这其实类似于 `filter` 。需要注意的就是 `filter` 和 `takeWhile` 什么时候更能清晰表达你的意思，就用哪个。
 
 
 */
example("takeWhile") {
    
    let sequence = PublishSubject<Int>()
    
    _ = sequence
        .takeWhile { $0 < 4 }
        .subscribe {
            print($0)
    }
    
    sequence.on(.Next(1))
    sequence.on(.Next(2))
    sequence.on(.Next(3))
    sequence.on(.Next(4))
    sequence.on(.Next(5))
}


/*:
 ### `amb`
 
 `amb` 用来处理发射序列的操作，不同的是， `amb` 选择先发射值的序列，自此以后都只关注这个先发射序列，抛弃其他所有序列。
 
 有两种使用版本供选择。
 
 */

example("amb 1") {
    let intSequence1 = PublishSubject<Int>()
    let intSequence2 = PublishSubject<Int>()
    let intSequence3 = PublishSubject<Int>()
    
    let _ = [intSequence1, intSequence2, intSequence3].amb()
        .subscribe {
            print($0)
    }
    
    intSequence2.onNext(10) // intSequence2 最先发射
    intSequence1.onNext(1)
    intSequence3.onNext(100)
    intSequence1.onNext(2)
    intSequence3.onNext(200)
    intSequence2.onNext(20)
    
}


example("amb 2") {
    let intSequence1 = PublishSubject<Int>()
    let intSequence2 = PublishSubject<Int>()
    
    let _ = intSequence1.amb(intSequence2).subscribe { // 只用于比较两个序列
        print($0)
    }
    
    intSequence2.onNext(10) // intSequence2 最先发射
    intSequence1.onNext(1)
    intSequence1.onNext(2)
    intSequence2.onNext(20)
    
}


/*:
 ### `concat`
 
 串行的合并多个序列。你可能会想起 `switchLatest` 操作符，他们有些类似，都是将序列整理到一起。不同的就是 `concat` 不会在丢弃旧序列的任何一个值。全部按照序列发射的顺序排队发射。
 */

example("concat") {
    let var1 = BehaviorSubject(value: 0)
    let var2 = BehaviorSubject(value: 200)
    
    // var3 is like an Observable<Observable<Int>>
    let var3 = BehaviorSubject(value: var1)
    
    let d = var3
        .concat()
        .subscribe {
            print($0)
    }
    
    var1.on(.Next(1))
    var1.on(.Next(2))
    var1.on(.Next(3))
    var1.on(.Next(4))
    
    var3.on(.Next(var2))
    
    var2.on(.Next(201))
    
    var1.on(.Next(5))
    var1.on(.Next(6))
    var1.on(.Next(7))
    var1.on(.Completed)
    
    var2.on(.Next(202))
    var2.on(.Next(203))
    var2.on(.Next(204))
    var2.on(.Completed)
    
//        var3.on(.Completed)
}


/*:
 
 ### `reduce`
 
 不多解释了，和 Swift 的 `reduce` 差不多。只是要记得它和 `scan` 一样不仅仅只是用来求和什么的。注意和 `scan` 不同 `reduce` 只发射一次，真的就和 Swift 的 `reduce` 相似。还有一个 `toArray` 的便捷操作，我想你会喜欢。
 */