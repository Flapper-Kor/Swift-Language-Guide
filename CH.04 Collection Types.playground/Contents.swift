/*
 Collection Types
 */

// 기본적으로 제공되는 세가지 콜렉션 타입이 있으며, 아래와 같은 특징
// 배열 : Array      - 배열과 같이 사용할 수 있으며, 리스트, 어레이리스트, 큐, 스택 등의 요구되는 기능들을 모두 포함한다.
// 집합 : Set        - hashable 한 값을 저장. 중복이 허용되지 않고, 순서가 없는 자료형. 말그대로 집합
// 사전 : Dictionary - 키밸류로 이뤄진 맵, 해쉬테이블과 형태가 같은 콜렉션. 순서가 없는 자료형. set과 마찬가지로 key 값은 hashable value여야 함

// 세가지 모두 제네릭 컬렉션으로 정의되어 있고,
// 한번 타입이 지정되면(명시적이건, 추론적이건) 변경할 수 없다.

// 상수에 할당하면 해당 컬렉션은 변경 불가.
// 이러한 사용은 코드에 대해 추론이 쉽고 컴파일러가 성능을 최적화 할 수 있다고 함.
// 따라서 상수로 선언해도 되는 컬렉션은 가능하면 상수로 선언


// Declaration
var arr1 : Array<Int>
var arr2 : [Int]
var arr3 : Array<Int>


// Initialize
arr1 = [1,2,3,4,5]     // by literal
arr1 = Array(1...5)    // by Range


arr2 = Array()         // empty
arr2 = []

arr3 = arr1            // copy from another array

var arr4 = [1.0, 1.4, 1.6]  // type inference


print(arr1, type(of: arr1))
print(arr2, type(of: arr2))
print(arr3, type(of: arr3))


/*
 Creating an Array with a Default Value
 */

var arr5 = Array(repeating: 0.0, count: 5)
print(arr5, type(of: arr5))


/*
 Adding two Arrays Together
 */

var combineDoubles = arr4 + arr5
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
print(combineDoubles)

// 당연히 같은 자료유형의 컬렉션끼리만 연산 가능
arr1 += arr3
print(arr1)


/*
 Creating an Array with Array Literal
 */
var shoppingList: [String] = ["Eggs", "Milk"]


/*
 Accessing and Modifying an Array
 */

// count : get property
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."

// isEmpty : get property
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
// Prints "The shopping list isn't empty."


// append() method : 추가
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes


// appending 대신 연산자를 사용해서 추가할 수 있다.

shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items


// 인덱스를 통한 배열의 접근
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"

// change Values
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"
print(shoppingList)

// replacement set of values
shoppingList[4...] = ["Bananas", "Apples"]
// shoppingList now contains 6 items
print(shoppingList)

// insert
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list

let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string

firstItem = shoppingList[0]
// firstItem is now equal to "Six eggs"

// remove
let last = shoppingList.removeLast() // 마지막 요소 제거 (제거한 값을 리턴)
print(last)
print(shoppingList)

let first = shoppingList.removeFirst() // 첫번째 요소 제거 (제거한 값을 리턴)
print(first)
print(shoppingList)

let third = shoppingList.remove(at: 3) // 해당 인덱스의 값을 제거
print(third)
print(shoppingList)

//shoppingList.removeAll() // 모두 제거
//print(shoppingList)

shoppingList.removeAll { string in // 탐색 제거
    string.contains("Baking")
}

/*
 Iterating Over
 */
for item in shoppingList {
    print(item)
}

// 탐색
let powder = shoppingList.first { string in
    string.contains("Baking")
}


/*
 Sets
 */
//A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

// 집합의 기본은 중복허용하지 않으며(hashable for this), 순서가 없다는 것이다.
// 따라서 이러한 속성을 활용하여 중복되는 값을 제거하기 위해 set을 활용할 수 있다.

// Declaration
var set1 : Set<String>

// initialize
set1 = Set()                                    // empty
set1 = ["baseball", "basketball", "BasketBall"] // by literal
var set2 : Set = ["안녕", "하세요", "안녕"] // type inference
                                        // 선언과 동시에 할당 타입추론을 사용할 수 있지만, 리스트와 동일한 대괄호를 사용하므로
                                        // set이라고 명시적으로 타입을 선언해야 함



print(set2, type(of: set2))


// Creating a Set with an Array Literal
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

let arrliteral = ["asd", "bsd", "csd"]
//arrliteral.append("dsd") // error
//arrliteral = ["123"]     // error


/*
 Accessing and Modifying a Set
 */

// count : read-only property
print("I have \(favoriteGenres.count) favorite music genres.")
// Prints "I have 3 favorite music genres."

// isEmpty : read-only property
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// Prints "I have particular music preferences."

// insert() method : 순서가 없기 때문에 메서드명이 뒤에 붙이는 뜻의 append 대신 insert
favoriteGenres.insert("Jazz")
print(favoriteGenres)


// remove (제거) : remove()
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."

print(favoriteGenres)

// 순서가 없는데 removeFirst() 라는 메서드가 있는게 좀 웃기긴 함
let firstGenre = favoriteGenres.removeFirst() // 실행할 때마다 순서가 다르기 때문에 일정한 결과를 보장하지 않음
//favoriteGenres.removeFirst()
//favoriteGenres.removeFirst()

// 빈 set으로 만들기
favoriteGenres.removeAll()

favoriteGenres.insert("Rock")
favoriteGenres.insert("Blues Rock")
favoriteGenres.insert("Hard Rock")
favoriteGenres.insert("Gaspel")
favoriteGenres.insert("Funk")
favoriteGenres.insert("RnR")

// contains
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."


// iterating
for genre in favoriteGenres {
    print("\(genre)")
}


set1 = ["Rock", "Hard Rock"]
set2 = ["Blues Rock", "Hard Rock", "Hip Hop"]

// 리스트에서 제공되던 것과 달리 오퍼레이터가 제공되지 않는다.
// set1 += set2
// var set3 = set1 - set2
// 그러면 union, intersection 등의 연산을 어떻게 하느냐
// 메서드로 있음.
print(set1)
var set3 = set1.intersection(set2)
print(set3)


// Fundamental Set Operations
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted() // 합집합
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted() // 교집합
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // 차집합
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() // 대칭차집합 (A ∪ B) - (A ∩ B)
// [1, 2, 9]


/*
 Set Membership and Equality
 */

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]


houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true


let inner1: Set = [1, 2]
let outer1: Set = [1, 2, 3, 4, 5]
let outer2: Set = [3, 4, 5, 6, 7]

outer1.isSuperset(of: inner1)   // 슈퍼셋인가 (포함관계인가? 상위집합/필요조건)
inner1.isSubset(of: outer1)     // 서브셋인가 (포함관계인가? 하위집합/충분조건)
inner1.isDisjoint(with: outer2) // 분리되어 있는가? (교집합이 0인가)


/*
 Dictionaries
 */

// Declaration
var dict1 : Dictionary<String, Int>
var dict2 : [String : Int]

//initializing
dict1 = ["일":1, "이":2, "삼":3] // by literal
dict2 = Dictionary() // empty
dict2 = [:]          // empty
dict2 = dict1        // copy others



var namesOfIntegers: [Int: String] = [:]
// namesOfIntegers is an empty [Int: String] dictionary

namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]


// 어레이와 마찬가지로 타입추론 가능
// (as with arrays, you don't have to write the type of the dictionary if you're initializing it with a dictionary literal whose keys and values have consistent types.)
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]


/*
 Accessing and Modifying a Dictionary
 */

// count : get-only count property
print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."


// isEmpty : get-only count property
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary isn't empty.")
}
// Prints "The airports dictionary isn't empty."


// Add a key-Values
print("==================================================================================")
print(airports["LHR"] = "London")
print("==================================================================================")
// the airports dictionary now contains 3 items

// if key is exist, Exchange
print("==================================================================================")
print(airports["LHR"] = "London Heathrow") // 대입 연산자를 사용해서 create/update 반환값 없음.
print("==================================================================================")
// the value for "LHR" has been changed to "London Heathrow"


// 메서드를 사용해서 좀더 안전한 코드를 만들 수 있음.
// updateValue 의 리턴값은 옵셔널로 원래 값이 있으면 값을 반환, 없으면 nil 반환
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
    print(oldValue, type(of: oldValue))
}

// Access with key (using subscript syntax)
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

print(airports["dub"] as Any)
print(airports["DUB"] as Any)
// 서브스크립트 syntex 또한 옵셔널을 반환

// remove
// remove with key (using subscript syntax)
airports["APL"] = "Apple International"
// "Apple International" isn't the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary


if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."


/*
 Iterating Over a Dictionary
 */

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson

print(airports.keys, type(of: airports.keys))           // 어레이가 아닌 keys 자료형임을 확인
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ


print(airports.values, type(of: airports.values))       // 어레이가 아닌 Values 자료형임을 확인
      
for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson

var keys = airports.keys
var vals = airports.values

var keysArray = [String](keys)                          // casting to array (내부 자료형을 알고있을 경우에만 사용 가능)
var valsArray = Array(vals)                             // casting to array

print(keysArray, type(of: keysArray))
print(valsArray, type(of: valsArray))




print(dict1)
print(dict2)

dict2.updateValue(4, forKey: "사")
dict2.updateValue(5, forKey: "오")

// 연산자는 set과 마찬가지로 정의되어 있지 않음
//dict1 += dict2
// merge를 사용해 할수 있으며, 중복되는 키 값에 대한 밸류를 앞의 것을 선택할지 뒤의 것을 선택할 지 정하면 된다.
dict1.merge(dict2, uniquingKeysWith: { a, b in
    a // if duplicae key occur choose one of dict1
//    b // if duplicae key occur choose one of dict2
})

print(dict1)
