//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import RxSwift

let disposeBag = DisposeBag()

example("filter") { 
    Observable
    .of(1,2,3,4,5,6,7)
    .filter({ (a) -> Bool in
        a % 2 == 0
    })
    .subscribe({ (event) in
        print(event)
    })
    .addDisposableTo(disposeBag)
}


/*:
 ### `distinctUntilChanged`
 
 阻止发射与上一个重复的值。
 
 */

example("distinctUntilChanged") { 
    Observable
        .of(1,3,3,3,3,3,2,2,2)
        .distinctUntilChanged()
        .subscribe({ (event) in
            print(event)
        }).addDisposableTo(disposeBag)
}

/*:
 ### `take`
 
 只发射指定数量的值。
 
 */

example("take") { 
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*:
 ### `takeLast`
 
 只发射序列结尾指定数量的值。
 
 > 这里要注意，使用 `takeLast` 时，序列一定是有序序列，`takeLast` 需要序列结束时才能知道最后几个是哪几个值。所以 `takeLast` 会等序列结束才向后发射值。如果你需要舍弃前面的某些值，你需要的是 `skip` 。
 
 */

example("takeLast") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeLast(3)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}


/*:
 ### `skip`
 
 忽略指定数量的值。
 
 */


example("skip") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .skip(3)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}


/*:
 ### `debounce` / `throttle`
 
 仅在过了一段指定的时间还没发射数据时才发射一个数据，换句话说就是 `debounce` 会抑制发射过快的值。注意这一操作需要指定一个线程。来看下面这个例子。
 
 > `debounce` 和 `throttle` 是同一个东西。
 
 */

example("debounce / throttle") { 
    Observable.of(1,2,3,4)
        .debounce(1, scheduler: MainScheduler.instance)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*:
 ### `elementAt`
 
 使用 `elementAt` 就只会发射一个值了，也就是指发射序列指定位置的值，比如 `elementAt(2)` 就是只发射第二个值。
 
 > 注意序列的计算也是从 0 开始的。
 
 */

example("elementAt") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .elementAt(2)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*:
 ### `single`
 
 `single` 就类似于 `take(1)` 操作，不同的是 `single` 可以抛出两种异常： `RxError.MoreThanOneElement` 和 `RxError.NoElements` 。当序列发射多于一个值时，就会抛出 `RxError.MoreThanOneElement` ；当序列没有值发射就结束时， `single` 会抛出 `RxError.NoElements` 。
 
 */
example("single") {
    Observable.of(1)
        .single()
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*:
 ### `sample`
 
 `sample` 就是抽样操作，按照 `sample` 中传入的序列发射情况进行抽样。
 
 > 如果源数据没有再发射值，抽样序列就不发射，也就是说不会重复抽样。
 
 */

example("sample") {
    Observable<Int>.interval(0.1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
        .take(100)
        .sample(Observable<Int>.interval(1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background)))
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}
