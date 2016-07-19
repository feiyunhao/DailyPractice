//: Playground - noun: a place where people can play

import RxSwift
import XCPlayground

var str = "Hello, playground"


Observable<Int>.create { observer in
    
    for i in 1...10 {
        observer.onNext(i)
    }
    observer.onCompleted()
    
    return NopDisposable.instance
    
}

.subscribe { event in
        
    switch event {
    case .Next(let value):
        print(value)
    case .Error(let error):
        print(error)
    case .Completed:
        print("Completed")
            
    }
}


/*:
 ### create
 使用 Swift 闭包的方式创建序列，这里创建了一个 Just 的示例
 */

let myJust = { (singleElement: Int) -> Observable<Int> in
    
    return Observable.create { observer in
        
        observer.on(.Next(singleElement))
        observer.on(.Completed)
        
        return NopDisposable.instance
    }
}

_ = myJust(5)
.subscribe({ (event) in
    print(event)
})


/*:
 ### `deferred`
 
 只有在有观察者订阅时，才去创建序列

 */

let deferredSequence: Observable<Int> = Observable.deferred {
    print("creating")
    return Observable.create({ (observer) -> Disposable in
        print("emmiting")
        observer.on(.Next(0))
        observer.on(.Next(1))
        observer.on(.Next(2))
        return NopDisposable.instance
    })
}

_ = deferredSequence
    .subscribe{ event in
        print(event)
}

_ = deferredSequence.subscribe({ (event) in
    print(event)
})

/*:
 ### empty
 创建一个空的序列，只发射一个 `.Completed`
 */


let emptySequence = Observable<Int>.empty()

_ = emptySequence.subscribe({ (event) in
    print(event)
})

/*:
 ### error
 创建一个发射 error 终止的序列
 */

let error = NSError(domain: "Test", code: -1, userInfo: nil)
let errorSequence = Observable<Int>.error(error)

_ = errorSequence.subscribe({ (event) in
    print(event)
})

/*:
 ### from
 使用 SequenceType 创建序列
 */

let sequenceFromArray = [1, 2, 3, "a"].toObservable()
_ = sequenceFromArray.subscribe({ (event) in
    print(event)
})

/*:
 ### interval
 创建一个每隔一段时间就发射的递增序列
 */

let intervalSequence = Observable<Int>.interval(3, scheduler: MainScheduler.instance)

_ = intervalSequence.subscribe({ (event) in
    print(event)
})

/*:
 ### never
 不创建序列，也不发送通知
 */

let neverSequence = Observable<Int>.never()

_ = neverSequence
    .subscribe { _ in
        print("这句话永远不会打出来.")
}

/*:
 ### just
 只创建包含一个元素的序列。换言之，只发送一个值和 `.Completed`
 */

let singleElementSequence = Observable.just(32)

_ = singleElementSequence
    .subscribe { event in
        print(event)
}

/*:
 ### of
 通过一组元素创建一个序列
 */

let sequenceOfElements/* : Observable<Int> */ = Observable.of(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

_ = sequenceOfElements
    .subscribe { event in
        print(event)
}

/*:
 ### range
 创建一个有范围的递增序列
 */

let rangeSequence = Observable.range(start: 2, count: 10)

_ = rangeSequence.subscribe { event in
    print(event)
}

/*:
 ### repeatElement
 创建一个发射重复值的序列
 */

let repeatElementSequence = Observable.repeatElement(1)

//_ = repeatElementSequence.subscribe { event in
//    print(event)
//}


/*:
 ### timer
 创建一个带延迟的序列
 */

let timerSequence = Observable<Int>.timer(1, period: 1, scheduler: MainScheduler.instance)

_ = timerSequence.subscribe { event in
    print(event)
}

