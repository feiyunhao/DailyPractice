//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import RxSwift
/*:
 ### `retry`
 先来看看 `retry` ，可能这个操作会比较常用，一般用在网络请求失败时，再去进行请求。
 `retry` 就是失败了再尝试，重新订阅一次序列。
 
 */

example("retry") {
    var count = 1
    let funnyLookingSequence = Observable<Int>.create { observer in
        let error = NSError(domain: "Test", code: 0, userInfo: nil)
        observer.on(.Next(0))
        observer.on(.Next(1))
        observer.on(.Next(2))
        if count < 2 {
            observer.on(.Error(error))
            count += 1
        }
        observer.on(.Next(3))
        observer.on(.Next(4))
        observer.on(.Next(5))
        observer.on(.Completed)
        
        return NopDisposable.instance
    }
    
    _ = funnyLookingSequence
        .retry()
        .subscribe {
            print($0)
    }
}

//不难发现这里的 retry 会出现数据重复的情况，推荐 retry 只用在会发射一个值的序列（可能发射 Error 的序列）中。
//需要注意的是不加参数的 `retry` 会无限尝试下去。我们还可以传递一个 Int 值，来说明最多尝试几次。像这样 `retry(2)` ，最多尝试两次。

/*:
 ### `catchError`
 
 当出现 Error 时，用一个新的序列替换。
 
 我想这个理解起来直接看方法声明最好了：
 
 public func catchError(handler: (ErrorType) throws -> RxSwift.Observable<Self.E>) -> RxSwift.Observable<Self.E>
 
 其实就有点类似 `flatMap` 哈，返回的都是一个序列，好了，区别还是很大的。只是我想在这里强调 `catchError` 中你需要传递一个返回序列的闭包。
 
 */
example("catchError") {
    let sequenceThatFails = PublishSubject<Int>()
    let recoverySequence = Observable.of(100, 200, 300, 400)

    _ = sequenceThatFails
        .catchError { error in
            return recoverySequence
        }
        .subscribe {
            print($0)
    }

    sequenceThatFails.on(.Next(1))
    sequenceThatFails.on(.Next(2))
    sequenceThatFails.on(.Next(3))
    sequenceThatFails.on(.Error(NSError(domain: "Test", code: 0, userInfo: nil)))
    sequenceThatFails.on(.Next(4))
}



/*:
 ### `catchErrorJustReturn`
 这个就很好理解了，就是遇到错误，返回一个值替换这个错误。
 */

example("catchErrorJustReturn") {
    let sequenceThatFails = PublishSubject<Int>()
    
    _ = sequenceThatFails
        .catchErrorJustReturn(100)
        .subscribe {
            print($0)
    }
    
    sequenceThatFails.on(.Next(1))
    sequenceThatFails.on(.Next(2))
    sequenceThatFails.on(.Next(3))
    sequenceThatFails.on(.Error(NSError(domain: "Test", code: 0, userInfo: nil)))
    sequenceThatFails.on(.Next(4))
}
/*:
 注意：你也应该理解成是替换一个序列。可以看到这个 4 并没有成功发射到订阅者中。
 */