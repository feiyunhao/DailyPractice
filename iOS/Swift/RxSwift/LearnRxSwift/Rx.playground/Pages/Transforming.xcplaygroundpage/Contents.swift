//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import RxSwift

/*:
 ## 变换 Observables
 
 下面的这些操作符可以变换一个序列发射的值。这样我们的序列功能就强大了许多，创建，然后进行变换。甚至这里就类似于一条生产线。先做出一个原型，然后再进行各种加工，最后出我们想要的成品。
 */

/*:
 ### `map`
 
 map 就是用你指定的方法去**变换每一个值**，这里非常类似 Swift 中的 map ，特别是对 SequenceType 的操作，几乎就是一个道理。一个一个的改变里面的值，并返回一个新的 functor 。
  */

let disposeBag = DisposeBag()

let originalSequence = Observable.of(1,2,3)

originalSequence
    .map { num in
        num * 10
    }
    .subscribe {print($0)}
    .addDisposableTo(disposeBag)



/*:
 #### `mapWithIndex`
 
 这是一个和 map 一起的操作，唯一的不同就是我们有了 **index** ，注意第一个是序列发射的值，第二个是 index 。
 */

originalSequence
    .mapWithIndex { (number, index) in
    number * index
    }
    .subscribe {print($0)}
    .addDisposableTo(disposeBag)

/*:
 ### `flatMap`
 
 将一个序列发射的值**转换成序列**，然后将他们压平到一个序列。这也类似于 SequenceType 中的 `flatMap` 。
*/

let sequenceInt = Observable.of(1,2,3)

let sequenceString = Observable.of("A", "B", "C", "D", "E", "F", "--")

sequenceInt
    .flatMap { (x) -> Observable<String> in
        print("from sequenceInt \(x)")
        return sequenceString
    }
    .subscribe { (event) in
    print(event)
    }
    .addDisposableTo(disposeBag)

/*:
 ### `scan`
 
 应用一个 accumulator (累加) 的方法遍历一个序列，然后**返回累加的结果**。此外我们还需要一个初始的累加值。实时上这个操作就类似于 Swift 中的 `reduce` 。
*/

let sequenceToSum = Observable.of(1,2,3,4,5,6)

sequenceToSum
    .scan(0) { (acum, element) in
        acum + element
    }
    .subscribe { (event) in
        print(event)
    }.addDisposableTo(disposeBag)

//: scan 以及 reduce 可不仅仅是只能用来累加，这是一个遍历所有值得过程，所以你可以在这做任何你想做的操作。

//: 和 scan 非常相似，唯一的不同是， reduce 会在序列结束时才发射最终的累加值。就是说，最终只发射一个最终累加值。

sequenceToSum
    .reduce(0) { acum, elem in
        acum + elem
    }
    .subscribe {
        print($0)
    }.addDisposableTo(disposeBag)


/*:
 ### `buffer`
 在特定的线程，定期定量收集序列发射的值，然后发射这些的值的集合。
*/

sequenceToSum
    .buffer(timeSpan: 5, count: 2, scheduler: MainScheduler.instance)
    .subscribe { (event) in
        print(event)
    }.addDisposableTo(disposeBag)

/*:
 ### `window`
 
 window 和 buffer 非常类似。唯一的不同就是 window 发射的是序列， buffer 发射一系列值。
 `buffer` 返回的序列发射的值是 `[Self.E]` ，而 `window` 是 `RxSwift.Observable<Self.E>` 。
 */

sequenceToSum
    .window(timeSpan: 5, count: 2, scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }.addDisposableTo(disposeBag)

        