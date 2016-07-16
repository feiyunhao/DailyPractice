//: Playground - noun: a place where people can play


func incrementArray(xs: [Int]) -> [Int] {
    var reslut: [Int] = []
    for x in xs {
        reslut.append(x + 1)
    }
    return reslut
}

func doubleArray1(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}

func computeIntArray(xs: [Int], transform: Int -> Int) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func doubleArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs) { x in x * 2 }
}

func computeBoolArray(xs: [Int], transform: Int -> Bool) -> [Bool] {
    var resule: [Bool] = []
    for x in xs {
        resule.append(transform(x))
    }
    return resule
}

func isEvenArray(xs: [Int]) -> [Bool] {
    return computeBoolArray(xs, transform: { (x) -> Bool in
        x % 2 == 0
    })
}

func genericComputeArray1<T>(xs: [Int], transform: Int -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func map<Element, T>(xs: [Element], transform: Element -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func genericConputeArray2<T>(xs: [Int], transform: Int -> T) -> [T] {
    return map(xs, transform: transform)
}

func genericComputeArray<T>(xs: [Int], transform: Int -> T) -> [T] {
    return xs.map(transform)
}

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

func getSwiftFiles(files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

getSwiftFiles(exampleFiles)

func getSwiftFiles2(files: [String]) -> [String] {
    return files.filter({ (file) -> Bool in
        file.hasSuffix(".swift")
    })
}

getSwiftFiles2(exampleFiles)

func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    return result
}

sum([1, 2, 3, 4])

func product(xs: [Int]) -> Int {
    var result: Int = 1
    for x in xs {
        result = x * result
    }
    return result
}

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x
    }
    return result
}

func prettyPrintArray(xs: [String]) -> String {
    var result: String = "Entries in the array xs:\n"
    for x in xs {
        result = "  " + result + x + "\n"
    }
    return result
}

func sumUsingReduce(xs: [Int]) -> Int {
    return xs.reduce(0, combine: { (result, x) in
        result + x
    })
}

sumUsingReduce([1,2,3])

func productUsingReduce(xs: [Int]) -> Int {
    return xs.reduce(1, combine: { (result, x) -> Int in
        result * x
    })
}

productUsingReduce([1,2,3])

func concatUsingReduce(xs: [String]) -> String {
    return xs.reduce("", combine: +)
}

func flatten<T>(xss: [[T]]) -> [T] {
    var result: [T] = []
    for xs in xss {
        result += xs
    }
    return result
}

func flattenUsingReduce<T>(xss: [[T]]) -> [T] {
    return xss.reduce([]) { result, xs in result + xs }
}

extension Array {
    func mapUsingReduce<T>(transform: Element -> T) -> [T] {
        return reduce([]) { result, x in
            return result + [transform(x)]
        }
    }
    
    func filterUsingReduce(includeElement: Element -> Bool) -> [Element] {
        return reduce([]) { result, x in
            return includeElement(x) ? result + [x] : result
        }
    }
}

//reduce 遍历数组并计算结果

struct City {
    let name: String
    let population: Int
}


let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

let result =
    cities.filter { $0.population > 1000 }
        .map { $0.cityByScalingPopulation() }
        .reduce("City: Population") { (result, c) -> String in
            return result + "\n" + "\(c.name): \(c.population)"
}

//泛型可以用于定义灵活的函数，类型检查仍然由编译器负责
//Any类型可以避开Swift的类型系统

func noOp<T>(x: T) -> T {
    return x
}


func noOpAny(x: Any) -> Any {
    return x
}

func noOpAnyWrong(x: Any) -> Any {
    return 0
}


infix operator >>> { associativity left }
func >>> <A, B, C> (f: A -> B, g: B -> C) -> A -> C {
    return { x in g(f(x)) }
}

func curry<A,B,C>(f: (A, B) -> C) -> A -> B -> C {
    return {x in { y in f(x,y) } }
}
        