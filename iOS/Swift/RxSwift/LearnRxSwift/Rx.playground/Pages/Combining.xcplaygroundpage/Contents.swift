//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import RxSwift


/*:

 ### `startWith`
 在一个序列前插入一个值。
 
 */

example("startWith") {
    let subscription = Observable.of(4, 5, 6, 7, 8, 9)
        .startWith(3)
        .startWith(2)
        .subscribe {
            print($0)
    }
}

/*:
    当然也可能我们会在末尾添加一些默认数据，这个时候需要使用 `concat` 。
*/

/*:
 ### `combineLatest`
 
 当两个序列中的任何一个发射了数据时，`combineLatest` 会结合并整理每个序列发射的最近数据项。
 
 */

example("combineLatest 1") {
    
    let intObj1 = PublishSubject<String>()
    let intObj2 = PublishSubject<Int>()
    let intObj3 = PublishSubject<Int>()
    
    _ = Observable.combineLatest(intObj1, intObj2, resultSelector: {
        //这个是对两（多）个序列值的处理方式
        "\($0) \($1)"
    })
    .subscribe({
        print($0)
    })
    
    intObj1.on(.Next("A"))
    
    intObj2.on(.Next(1))
    
    intObj1.on(.Next("B"))
    
    intObj2.on(.Next(2))
    
}


example("combineLatest 2") {
    let intOb1 = Observable.just(2)
    let intOb2 = Observable.of(0, 1, 2, 3)
    let intOb3 = Observable.of(0, 1, 2, 3, 4)
    
    _ = Observable.combineLatest(intOb1, intOb2, intOb3) {
                ($0 + $1) * $2
//        "\($0) \($1) \($2)"
        }
        .subscribe {
            print($0)
    }
}

example("combineLatest 2 T") {
    let intOb1 = Observable.just(2)
    let intOb2 = ReplaySubject<Int>.create(bufferSize: 1)
    intOb2.onNext(0)
    let intOb3 = Observable.of(0, 1, 2, 3, 4)
    intOb2.onNext(1)
    
    _ = Observable.combineLatest(intOb1, intOb2, intOb3) {
                ($0 + $1) * $2
//        "\($0) \($1) \($2)"
        }
        .subscribe {
            print($0)
    }
    intOb2.onNext(2)
    intOb2.onNext(3)
}

example("combineLatest 3") {
    let intOb1 = Observable.just(2)
    let intOb2 = Observable.of(0, 1, 2, 3)
    let intOb3 = Observable.of(0, 1, 2, 3, 4)
    
    _ = [intOb1, intOb2, intOb3].combineLatest { intArray -> Int in
        Int((intArray[0] + intArray[1]) * intArray[2])
        }
        .subscribe { (event: Event<Int>) -> Void in
            print(event)
    }
}

/*:
 ### `zip`
 
 `zip` 和 `combineLatest` 相似，不同的是每当所有序列都发射一个值时， `zip` 才会发送一个值。它会等待每一个序列发射值，发射次数由最短序列决定。结合的值都是一一对应的。
 */

example("zip 1") {
    
    let intOb1 = PublishSubject<String>()
    let intOb2 = PublishSubject<Int>()
    
    _ = Observable.zip(intOb1, intOb2) {
        "(\($0) \($1))"
        }
        .subscribe {
            print($0)
    }
    
    intOb1.on(.Next("A"))
    
    intOb2.on(.Next(1))
    
    intOb1.on(.Next("B"))
    
    intOb1.on(.Next("C"))
    
    intOb2.on(.Next(2))
    
}

example("zip 2") {
    let intOb1 = Observable.of(0, 1)
    let intOb2 = Observable.of(0, 1, 2, 3)
    let intOb3 = Observable.of(0, 1, 2, 3, 4)
    
    _ = Observable.zip(intOb1, intOb2, intOb3) {
        ($0 + $1) * $2
        }
        .subscribe {
            print($0)
    }
}
/*:
 ### `merge`
 
 `merge` 会将多个序列合并成 一个序列，序列发射的值按先后顺序合并。要注意的是 `merge` 操作的是序列，也就是说序列 发射 序列才可以使用 merge 。来看例子：
 
 */

example("merge 1") {
    let subject1 = PublishSubject<Int>()
    let subject2 = PublishSubject<Int>()
    
    _ = Observable.of(subject1, subject2)
        .merge()
        .subscribe {
            print($0)
    }
    
    subject1.on(.Next(20))
    subject1.on(.Next(40))
    subject1.on(.Next(60))
    subject2.on(.Next(1))
    subject1.on(.Next(80))
    subject1.on(.Next(100))
    subject2.on(.Next(1))
}

example("merge 2") {
    let subject1 = PublishSubject<Int>()
    let subject2 = PublishSubject<Int>()
    
    _ = Observable.of(subject1, subject2)
        .merge(maxConcurrent: 1)
        .subscribe {
            print($0)
    }
    subject1.on(.Next(20))
    subject1.on(.Next(40))
    subject1.on(.Next(60))
    subject2.on(.Next(1))
    subject1.on(.Next(80))
    subject1.on(.Next(100))
    subject2.on(.Next(1))
    
}


/*:
 ### `switchLatest`
 
 `switchLatest` 和 `merge` 有一点相似，都是用来合并序列的。然而这个合并并非真的是合并序列。事实是每当发射一个新的序列时，丢弃上一个发射的序列。
*/

example("switchLatest") {
    let var1 = Variable(0)
    
    let var2 = Variable(200)
    
    // var3 是一个 Observable<Observable<Int>>
    let var3 = Variable(var1.asObservable())
    
    let d = var3
        .asObservable()
        .switchLatest()
        .subscribe {
            print($0)
    }
    
    var1.value = 1
    var1.value = 2
    var1.value = 3
    var1.value = 4
    
    var3.value = var2.asObservable() // 我们在这里新发射了一个序列
    
    var2.value = 201
    
    var1.value = 5 // var1 发射的值都会被忽略
    var1.value = 6
    var1.value = 7
}


