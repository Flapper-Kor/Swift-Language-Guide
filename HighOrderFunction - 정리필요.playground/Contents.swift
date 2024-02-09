/*
 Higher-Order Function (고차함수)
 다른 함수를 전달인자로 받거나, 반환값으로 반환하는 함수

 대표적인 기본제공 고차함수
 map, filter, reduce (collection type 에 구현되어 있음)
 */

// map :
let numbers = [0,1,2,3]
let mapArray = numbers.map { (number) -> Int in
    return number * 2
}
print("map \(mapArray)")
print(type(of: numbers))
print(type(of: mapArray))

// filter
let intArray = [10,5,20,13,4]
let filterArray = intArray.filter { $0 > 10 }
print("filter \(filterArray)")

let strArray = ["hello", "hell", "hi", "critical"]
let a = strArray.filter { $0.contains("cri") }
strArray.firstIndex(of: a[0])
print(a, type(of: a))
//    return 0
//    return strArray.firstIndex(of: element)
    
//}

// reduce
let someArray = [1,2,3,4,5]
let reduceResult = someArray.reduce(0) {
    (result:Int, element:Int) -> Int in
    print("\(result) + \(element)")
    return result + element
}

let numberSum = numbers.reduce(0, { x, y in
    x + y
})
numberSum

var k  : String = ""
k += "hip" + " " + "hop"

let tags = ["hip", "young", "funky"]
print(tags.reduce("", { partialResult, word -> String in
    return partialResult + "#" + word
}))
