//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//反射Reflection
//Swift所有的类都实现了_Reflectable
//_reflect 获取任意对象的一个镜像
//2.0之后使用 Mirror

struct Person {
    let name: String
    let age: Int
}

let shuaige = Person(name: "shuaige", age: 18)
let reflect = Mirror(reflecting:shuaige)

reflect.displayStyle!
reflect.children
for i in reflect.children.startIndex..<reflect.children.endIndex {
    print(reflect.children[i].label!,reflect.children[i].value)
}

dump(shuaige)

dump(shuaige)


func valueFrom(object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    
    for i in mirror.children.startIndex..<mirror.children.endIndex {
        let (targetKey, targetMirror) = mirror.children[i]
        if key == targetKey {
            return targetMirror
        }
    }
    
    return nil
}

if let name = valueFrom(shuaige, key: "name") as? String {
    print("通过 key 得到值: \(name)")
}


