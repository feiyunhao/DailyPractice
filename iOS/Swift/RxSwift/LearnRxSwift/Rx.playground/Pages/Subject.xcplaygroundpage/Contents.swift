//: [Previous](@previous)

/*:
 ## 什么是 Subject
 
 我们可以把 Subject 当作一个桥梁（或者说是代理），就是说 Subject 既是 Observable 也是 Observer 。
 
 * 作为一个 Observer ，它可以订阅序列
 * 同时作为一个 Observable ，它可以转发或者发射数据。
 
 > 在这里， Subject 还有一个特别的功能，就是将冷序列变成热序列，订阅后重新发送嘛，冷就变成了热。
 
 */

import RxSwift

/*:
 
 ## PublishSubject
 
 当有观察者订阅 `PublishSubject` 时，`PublishSubject` 会发射订阅之后的数据给这个观察者。
 
 > 于是这里存在丢失数据的问题，如果需要全部数据，我推荐改用 `ReplaySubject` 。
 
 如果序列因为错误终止发射序列，此时 `PublishSubject` 就不会发射数据，只是传递这次错误事件。
 
 */

example("publishSubject") { 
    let publishSubject = PublishSubject<String>()
    _ = publishSubject.subscribe({ (event) in
        print("Subscription: 1, event: \(event)")
    })
    publishSubject.on(.Next("a"))
    publishSubject.on(.Next("b"))

    
    _ = publishSubject.subscribe({ (event) in
        print("Subscription: 2, event: \(event)")
    })
    
    publishSubject.on(.Next("c"))
    publishSubject.on(.Next("d"))
    
}


/*:
 
 ## ReplaySubject
 
 和 `PushblishSubject` 不同，不论观察者什么时候订阅， `ReplaySubject` 都会发射完整的数据给观察者。
 */

example("ReplaySubject") { 
    let replaySubject = ReplaySubject<String>.createUnbounded()
    _ = replaySubject.subscribe({ (event) in
        print("Subscription: 1, event: \(event)")
    })
    replaySubject.on(.Next("a"))
    replaySubject.on(.Next("b"))
    
    _ = replaySubject.subscribe { event in /// 这个订阅收到了四个数据
        print("Subscription: 2, event: \(event)")
    }
    
    replaySubject.on(.Next("c"))
    replaySubject.on(.Next("d"))
    
}


/*:
 
 ## BehaviorSubject
 
 当一个观察者订阅一个 `BehaviorSubject` ，它会发送原序列最近的那个值
 
 When an observer subscribes to a `BehaviorSubject`, it begins by emitting the item most recently emitted by the source Observable (or a seed/default value if none has yet been emitted) and then continues to emit any other items emitted later by the source Observable(s).
 */

example("behaviorSubject") { 
    let behaviorSubject = BehaviorSubject(value: "z")
    _ = behaviorSubject.subscribe({ (event) in
        print("Subscription: 1, event: \(event)")
    })
    
    behaviorSubject.on(.Next("a"))
    behaviorSubject.on(.Next("b"))
    
    _ = behaviorSubject.subscribe { event in /// 我们可以在这里看到，这个订阅收到了四个数据
        print("Subscription: 2, event: \(event)")
    }
    
    behaviorSubject.on(.Next("c"))
    behaviorSubject.on(.Next("d"))
    behaviorSubject.on(.Completed)
}

/*:
 `Variable` 是 `BehaviorSubject` 的一个封装。相比 `BehaviorSubject` ，它不会因为错误终止也不会正常终止，是一个无限序列。
 */

example("variable") {
    let variable = Variable("z")
    _ = variable.asObservable().subscribe { e in
        print("Subscription: 1, event: \(e)")
    }
    variable.value = "a"
    variable.value = "b"
    _ = variable.asObservable().subscribe { e in
        print("Subscription: 1, event: \(e)")
    }
    variable.value = "c"
    variable.value = "d"
}
