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


