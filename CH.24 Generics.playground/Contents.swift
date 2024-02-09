/*
 Generics
 */


// 특정 타입에 대한 종속성을 없애고 코드를 일반화하기 위한 장치 cpp template, java generic 등과 동일

//MARK: - The Problem That Generics Solve
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}


func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//MARK: The Problem That Generics Solve -



//MARK: - Generic Functions

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// using

//var someInt = 3
//var anotherInt = 107

print(someInt, anotherInt)
swapTwoValues(&someInt, &anotherInt)
print(someInt, anotherInt)


// someInt is now 107, and anotherInt is now 3


var someString = "hello"
var anotherString = "world"

print(someString, anotherString)
swapTwoValues(&someString, &anotherString)
print(someString, anotherString)
// someString is now "world", and anotherString is now "hello"


// 위의 두 변수를 스왑하는 함수는 표준라이브러리에 이미 swap(_:_:) 로 구현되어 있다.
swap(&someString, &anotherString)

//MARK: Generic Functions -


//MARK: - Type Parameters
// 타입 매개변수 (type parameter) 는 함수명 바로 뒤에 꺽쇠안에 문자로 표현한다.
// 괄호 안에 여러 매개변수 유형을 나열할 수 있음.
// are written immediately after the function’s name, between a pair of matching angle brackets

// 사용된 클래스는 문서 가장 하단에 별도로 정의

func switchType<T, H>(a : T) -> H where T : PlaceholderInt, H : A{
    return H(placeholder: a)
}

//MARK: Type Parameters -


//MARK: - Naming Type Parameters

// 타입 매개변수 네이밍은 매개변수들의 역할이나 관계에 대한 설명이 될 수 있게 작성하는 것이 일반적이며,
// 매개변수들이 관계나 설명할 만한 것들이 아닐 경우에는 T, U, V 등의 단일 대문자를 사용하는 것이 일반적이다.

//MARK: Naming Type Parameters -



//MARK: - Generic Types

// simple stack in swift using generic

class Stack<Element> : CustomStringConvertible{
    var items: [Element] = []
    func push(_ item: Element) {
        items.append(item)
    }
    func pop() -> Element {
        return items.removeLast()
    }
    func clear(keepingCapacity keepCapacity: Bool = false) {
        items.removeAll(keepingCapacity: keepCapacity)
    }
    public var description: String { return "\(type(of: self))\(items)" }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings

let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings

print(stackOfStrings)


//MARK: Generic Types -



//MARK: - Extending a Generic Type

// 타입 매개변수(type parameter) 를 확장에서 따로 정의하지 않음
// 처음 정의한 타입 파라메터 이름을 그대로 사용 가능

// 아래는 팝 하지 않고, 가장 위의 element를 반환하는 함수.
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."


// Extensions of a generic type can also include requirements that instances of the extended type must satisfy in order to gain the new functionality, as discussed in Extensions with a Generic Where Clause below.


// 확장은 where 절을 사용한 타입 파라메터 제약 조건을 정의 가능
extension Stack where Element : Numeric {
    func addAll() -> Element {
        return items.reduce(0) { $0 + $1 }
    }
}

let stackOfDouble = Stack<Double>()

stackOfDouble.push(14)
stackOfDouble.push(11)
stackOfDouble.push(25)
stackOfDouble.push(99)

print(stackOfDouble)
print(stackOfDouble.addAll())

//MARK: Extending a Generic Type -



//MARK: - Type Constraints

// 특정 타입에 대해서만 동작하도록 하는 타입 제약을 두어 정의할 수 있다.
// where 절을 사용하는 것과 다름
// 타입 파라메터 뒤에 바로 콜론을 붙여 사용

// 프로토콜 등을 특정하여, 사용하도록 할 수 있다.
// 예를 들면, dictionary 같은 경우 key 값을 hashable 인스턴스로 특정한다.

//MARK: Type Constraints -



//MARK: - Type Constraint Syntax

// 제약조건은 프로토콜, 클래스타입(부모클래스) 등의 이름으로 사용한다.
// 제약조건에 Int 등의 특정 타입을 언급하는 것은 제네릭의 사용을 애초에 무의미 하게 하는 것이므로 불가

//func someFunction<T : Int, U : AnyObject>(input : T) -> U {
//
//}
// 마찬가지로 where 절을 사용하는 제약조건에서도 불가능
//func someFunction<T, U : AnyObject>(input : T) -> U where T : Int{  // 컴파일 오류
//
//}
//func someFunction<T, U : AnyObject>(input : T) -> U where T == Int{  // 스위프트 5에서는 경고, swift6 에서는 에러
//
//}



func someFunction<T: Hashable, U: AnyObject>(hashable: T, _instance: U) {
    // function body goes here
    
    
}

// 기본적으로 where 절로 빼서 제약조건을 걸은것과 같지만,
// 하나의 타입파라미터에 대해 제약을 두가지 이상 걸고 싶다면
// where 절로 빼서 사용해야 한다.

// using multiple type constraint
func Dict_1<Key: Hashable & Numeric, Value>(keys: [Key], values: [Value]) throws -> Dictionary<Key, Value> {
    if keys.count != values.count{
        throw E.lengthError
    }

    var dict = Dictionary<Key, Value>()

    for i in keys.indices{
        dict.updateValue(values[i], forKey: keys[i])
    }

    // function body goes here
    return dict
}

// using multiple type constraint with where clause
func Dict_2<Key, Value>(keys: [Key], values: [Value]) throws -> Dictionary<Key, Value> where Key: Hashable, Key: Numeric {
    
    if keys.count != values.count{
        throw E.lengthError
    }

    var dict = Dictionary<Key, Value>()

    for i in keys.indices{
        dict.updateValue(values[i], forKey: keys[i])
    }

    // function body goes here
    return dict
}

func Dict_3<Key, Value>(keys: [Key], values: [Value]) throws -> Dictionary<Key, Value> where Key: Hashable & Numeric {
    if keys.count != values.count{
        throw E.lengthError
    }

    var dict = Dictionary<Key, Value>()

    for i in keys.indices{
        dict.updateValue(values[i], forKey: keys[i])
    }

    // function body goes here
    return dict
}

enum E: Error{
    case lengthError
}



do {
    try Dict_3(keys: [1.3, 2, 4.1, 2], values: [5, 1,2,3])
}
catch{
    print("length error")
}



func test<T>(input : T) where T: AnyObject & Hashable & CustomStringConvertible{
    print(input)
}

class IntPoint_1{
    var x : Int
    var y : Int
    
    init(x: Int = 0, y : Int = 0){
        self.x = x; self.y = y
    }
}

class IntPoint_2 : Hashable{
    var x : Int
    var y : Int
    
    init(x: Int = 0, y : Int = 0){
        self.x = x; self.y = y
    }
    
    static func == (lhs: IntPoint_2, rhs: IntPoint_2) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
class IntPoint : Hashable, CustomStringConvertible{
    var x : Int
    var y : Int
    
    init(x: Int = 0, y : Int = 0){
        self.x = x; self.y = y
    }
    
    static func == (lhs: IntPoint, rhs: IntPoint) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    public var description: String { return "\(type(of: self))(x:\(x), y:\(y))" }
}

//test(input: 4)            // Global function 'test(input:)' requires that 'Int' be a class type
//test(input: IntPoint_1()) // Global function 'test(input:)' requires that 'IntPoint_' conform to 'Hashable'
//test(input: IntPoint_2()) // Global function 'test(input:)' requires that 'IntPoint_2' conform to 'CustomStringConvertible'
test(input: IntPoint())

//MARK: Type Constraint Syntax -



//MARK: - Type Constraints in Action

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"



// string 이 아닌 제네릭으로 타입을 확장하고, 같은지 비교하는 로직이 포함되므로, equatable 타입 제약을 통해 구현.
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2


//MARK: Type Constraints in Action -



//MARK: - Associated Types

//

//MARK: Associated Types -



//MARK: - Associated Types in Action

// 아래와 같이 정의하고 프로토콜을 준수하는 struct, 혹은 class를 정의하였을 때
// 컴파일러는 subscript의 반환 유형 만으로 연관타입을 추론할 수 있다.

protocol Container {
//    typealias Item = Int
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
//    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 또한 위의 제네릭으로 해당 프로토콜 구현체를 만들수도 있다.
struct Stack_<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}



var stack = Stack_<String>()
stack.push("sdf")
stack.push("heello")

print(stack)

print(stack[1])

// 타입파라메터가 서브스크립트의 반환값 및 append의 매개변수 타입으로 사용되었고, 이를 통해 연관 타입을 컴파일러는 Element라고 추론할 수 있다.

//This time, the type parameter Element is used as the type of the append(_:) method’s item parameter and the return type of the subscript. Swift can therefore infer that Element is the appropriate type to use as the Item for this particular container.

//MARK: Associated Types in Action -



//MARK: - Extending an Existing Type to Specify an Associated Type

// 이미 존재하는 위 모든 함수 및 속성에 대해 빈 확장으로 선언만을 해줌으로써 Container 로 사용이 가능
extension Array: Container{}

var arr = Array<String>()
arr.append("hi")
arr.append("hello")

var con : any Container = arr

//con.append("ds") // 내부 타입이 특정지어지지 않은 any Container로는 사용하지 못함.
                   // 관련해서는 Array 와 연관타입에 대해 좀더 살펴봐야 할듯.
con.count
print(con[0], type(of: con[0])) // 그런데 con[0]에 대해서는 잘 동작한다.

//MARK: Extending an Existing Type to Specify an Associated Type -



//MARK: - Adding Constraints to an Associated Type

protocol Container_ {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//MARK: Adding Constraints to an Associated Type -



//MARK: - Using a Protocol in Its Associated Type’s Constraints


protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack_: SuffixableContainer {
    func suffix(_ size: Int) -> Stack_ {
        var result = Stack_()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stack_<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
// suffix contains 20 and 30

extension IntStack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack_<Int> {
        var result = Stack_<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack_<Int>.
}

//MARK: Using a Protocol in Its Associated Type’s Constraints -


//MARK: - Generic Where Clauses

func allItemsMatch<C1: Container, C2: Container>
        (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.Item == C2.Item, C1.Item: Equatable {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }
    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    // All items match, so return true.
    return true
}

var stackOfStrings_ = Stack_<String>()
stackOfStrings_.push("uno")
stackOfStrings_.push("dos")
stackOfStrings_.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings_, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."

//MARK: Generic Where Clauses -


//MARK: - Extensions with a Generic Where Clause

extension Stack_ where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings_.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
// Prints "Top element is tres."


struct NotEquatable { }
var notEquatableStack = Stack_<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // Error

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."


extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"

//MARK: Extensions with a Generic Where Clause -



//MARK: - Contextual Where Clauses

// 각각의 함수 및 프로퍼티

// 아래처럼 메소드에 where절을 사용해서 특정 제약조건을 만족하는 경우에만 사용할 수 있는 함수를 정의할 수 있다.
// 같은 이름의 함수를 제약조건을 다르게 설정하여 오버라이딩이나 함수내 분기분 처럼 비슷하게 사용 가능

extension Container {
    var toArray: Array<Item> {
        return self as! Array
    }
    
    func average_() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func average_() -> Double where Item == Double {
        print("여기는 아이템이 더블인 경우")
        return 0
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260.9, 1200.4, 98.0, 37.1]
//let numbers = [1260, 1200, 98, 37]
print(numbers.average_())
// Prints "648.75"
print(numbers.endsWith(37))
// Prints "true"



// 위처럼 제약조건을 각각의 함수에 적용하는 것을 Contextual Where Clauses 라고 하며,
// 이를 사용하지 않을 경우에는 각각의 함수마다 익스텐션을 별도로 만들어야 한다.

//extension Container where Item == Int {
//    func average() -> Double {
//        var sum = 0.0
//        for index in 0..<count {
//            sum += Double(self[index])
//        }
//        return sum / Double(count)
//    }
//}
//extension Container where Item: Equatable {
//    func endsWith(_ item: Item) -> Bool {
//        return count >= 1 && self[count-1] == item
//    }
//}

//MARK: Contextual Where Clauses -



//MARK: - Associated Types with a Generic Where Clause

protocol Container__ {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: Container__ where Item: Comparable { }

//MARK: Associated Types with a Generic Where Clause -



//MARK: - Generic Subscripts

//extension Container {
//    subscript<Indices: Sequence>(indices: Indices) -> [Item]
//            where Indices.Iterator.Element == Int {
//        var result: [Item] = []
//        for index in indices {
//            result.append(self[index])
//        }
//        return result
//    }
//}
//
//var stack_s = Stack_<String>()
//stack_s.append("sdf")
//stack_s.append("ddddd")
//
//stack_s.append("asdasd")
//
//print(stack_s[1...2])


var array = Array<String>()
array.append("12")
array.append("34")
array.append("56")
array.append("78")
array.append("910")

print(array.count)
print(array[2...3])

//MARK: Generic Subscripts -






// 아래는 공식문서의 내용이 아님

protocol PlaceholderInt{
    var int: Int {
        get
        set
    }
}

func resetInt<T>(_instance : inout T) where T : PlaceholderInt, T : AnyObject{
    _instance.int = 0
}


class A: PlaceholderInt{
    var int: Int = 0
    
    required init(){
        
    }
    
    required init(placeholder : PlaceholderInt){
        self.int = placeholder.int
    }
    func increaseInt(){
        self.int += 1
    }
}

class B : PlaceholderInt{
    var int: Int = 0
    var kkk : Double = 0
    
    required init(){
        
    }
    required init(placeholder : PlaceholderInt){
        self.int = placeholder.int
    }
}


var a = A()
var b = B()
var c = B()
var d = c

print(A() !== B())
print(c === d)

c.int = 4
print(d.int)


var k = 0
print(d.int)
print(c.int)

//extension A {

//}
//
