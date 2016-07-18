//: Playground - noun: a place where people can play

import RxSwift

var str = "Hello, playground"

/*:
 ## 创建序列 Observable
 
 > 基本上你不用担心会记不住这些操作符，我有一个好的建议，每当你想创建序列时，又忘记了都有什么方法，就试着想一下，你想创建什么样的序列，它应该有一个什么样的方法。
 */

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



