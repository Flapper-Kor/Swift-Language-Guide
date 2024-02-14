
// MARK: - Defining and Calling Functions

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
// Prints "Hello, Anna!"
print(greet(person: "Brian"))
// Prints "Hello, Brian!"


func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"






// MARK: - Function Parameters and Return Values

// Functions Without Parameters
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"

//Functions With Multiple Parameters
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"

// Functions Without Return Values (return 타입이 정의되지 않으면 void<반환값이 없음>)
func greet_(person: String) {
    print("Hello, \(person)!")
}
greet_(person: "Dave")
// Prints "Hello, Dave!"

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value

/*
 Note
 Strictly speaking, this version of the greet(person:) function does still return a value, even though no return value is defined. Functions without a defined return type return a special value of type Void. This is simply an empty tuple, which is written as ().
 */


// MARK: - Functions with Multiple Return Values

/*
 이 항목을 보기 전에 스위프트에서의 기본 반환값과 표현에 대해 알아볼 필요가 있다. (위의 마지막 note를 잘 읽어보면 된다.)
 스위프트에서 리턴 타입이 정의되지 않았을 경우, Void 타입이라는 특수한 값을 반환하도록 되어 있으며, 이것은 단지 빈 튜플이다.
 튜플의 사용법은 공식 언어 가이드 [Basic] 항목에서 확인할 수 있다.(이 문서에서는 CH.01 Basic)
 좀 더 자세한 튜플의 사용은 [CH.01 Basic] 문서를 참조
 
 말하자면 swift는 return 값을 튜플로 선언(정의)할 수 있도록 설계되었고, defaul 값은 Void 즉, 빈 튜플이다.
 */


// 아래와 같은 형태를 사용하면 여러 리턴값을 가지는 함수를 만들 수 있고,
// 그 반환값은 일반적인 튜플을 사용하듯 사용할 수 있다.
func test() -> (zero : String, Int) {
    var zero = "hi"
    var one = 1

    return  (zero, one)
}
var testV = test()
print(testV, testV.0, testV.1, testV.zero)


// 아래는 스위프트 언어 가이드에 포함된 내용
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])

print(type(of: bounds))

print(bounds.0)

print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
print("min is \(bounds.0) and max is \(bounds.1)")





// MARK: - Optional Tuple Return Types

/*
 Note
 An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
 */

func minMax1(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}


if let bounds = minMax1(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"




// MARK: - Functions With an Implicit Return

/*
 함수의 본문이 단일 표현식인 경우, 암시적으로 그 표현식을 반환 (return 생략 가능)
 */
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// Prints "Hello, Dave!"

func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// Prints "Hello, Dave!"



// MARK: - Function Argument Labels and Parameter Names

/*
 Preknowledge
    이 부분을 살펴보기 위해서는 Argument와 Parameter의 차이점을 명확하게 짚고 넘어가야 한다.
 
    일반적인 컴퓨터 프로그래밍에서 두 용어는
 
        Parameter(formal parameter)는 선언시에 정의된 것을 의미하며,
        Argument(actual parameter)는 함수 호출에 사용된 입력을 의미한다.

    좀 더 직관적으로
 
        caller 입장에서는 인수 혹은 인자(Argument, actural parameter)
        callee 입장에서는 매개변수(Parameter, formal parameter)
 
    가 된다.
    
    Argument label 과 paramter name 의 개념이 혼란스러운 경우,
    영문위키 https://en.wikipedia.org/wiki/Parameter_(computer_programming) 의
    Parameters and arguments 항목을 참조하자.
 
 스위프트에서도 이러한 일반적인 용어의 구분을 따른다.
 
 또, 파라미터 이름을 좀 더 caller 입장에서 직관적인 이름으로 레이블링 하는 방법을 swift에서 제공한다.
 */

// 기본적으로 매개변수는 매개변수 이름을 인수명으로 사용한다.
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)



// MARK: Specifying Argument Labels
/*
 파라미터 이름 앞에 인수명을 별도로 지정할 경우, 지정된 인수명을 호출부에서 사용한다.
 (파라미터 이름 앞에 공백으로 구분하여 인수명을 지정)
 
 단, 이러한 경우, 함수 호출부에서 표현되는 레이블과 파라미터명을 혼돈하여 문서를 작성하지 않도록 유의한다.
 퀵펠프 주석은 단축키로 생성하여 사용하는 것이 편리하니 상관없지만, 직접 작성하는 경우 주의
 퀵헬프나, DocC 에서 잘못된 결과를 낼 수 있음.
 */

/// Description
/// - Parameter parameterName: paramterName is ......
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}

print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."





//MARK: - Omitting Argument Labels
/*
 일반적인 프로그래밍 언어에서 그러하듯, 인수명(Argument Label)은 호출부에서 사용을 생략하고 싶은 경우가 많다.
 그런 경우 _ 를 사용하여 인수명을 생략할 수 있고, 호출부에서는 변수명만 기입하여 함수를 호출하게 된다.
 */

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)





// MARK: - Default Parameter Values

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
    print(parameterWithoutDefault, parameterWithDefault)
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 2) // parameterWithDefault is 12


// 디폴트 파라메터를 아래와 같이 레이블이 생략된 함수에서 사용할 때,
// 아래와 같이 디폴트 값이 앞의 인자에만 적용될 경우,
// 사용이 무의미해지는 경우가 있다.
func someFunction1(_ parameterWithoutDefault: Int = 12 , _ parameterWithDefault: Int) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
//someFunction1(12) // parameterWithDefault is 6
//someFunction1(1) // parameterWithDefault is 12





// MARK: - Variadic Parameters

/*
 A function can have multiple variadic parameters. The first parameter that comes after a variadic parameter must have an argument label. The argument label makes it unambiguous which arguments are passed to the variadic parameter and which arguments are passed to the parameters that come after the variadic parameter.
 
 즉 가변매개변수 뒤의 첫 매개변수만 argument label 이 필요하다.
 */
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers

func lessThan(_
              numbers: Double...,
              lessThan // 만약 이 아규먼트 레이블이 셍략(_) 된다면 함수를 사용할 수 없게 된다.
              number: Double)
            -> Array<Double> {
    var list = Array<Double>()
    
    for i in numbers{
        if i < number{
            list.append(i)
        }
    }
    return list
}

print(lessThan(1,2,3,4,5,1,2,3,4,5,6,8,9,0, lessThan: 4))






//MARK: - In-Out Parameters

/*
 Preknowledge
     In-Out Parameter를 알아보기 전에 먼저 알아야 할 함수에 대한 지식을 짚고 넘어가야 한다.
    
     Call by Value     : 값을 복사하여 전달                                                         [caller : val, callee : val]
     Call by Reference : 전달한 값의 참조를 사용                                                     [caller : val, callee : &val]
     Call by Address   : 참조(주소)를 복사하여 전달 (call by value 이지만 넘겨받는 값이 포인터)              [caller : &, callee : *]
    
     inout             : 참조타입의 경우 Call by Reference 와 유사하게 동작                             [caller : &, callee : inout]
                         값 타입의 경우 함수 진입부에서 값이 복사되고, 반환될 때 복사본의 값이 기존 인수에 할당됨     [caller : &, callee : inout]
 
     기본적으로 대부분의 언어에서 함수는 Call by Value 로 동작하며(C, Java, Swift..)
     전달되는 매개변수는 값은 지역변수(Local Variable)로서 값이 복사되어 사용된다.
    
     때문에, 대부분의 언어에서 전달받은 매개변수를 바꿔도, 호출부(caller)의 변수에 할당된 값이 변하지 않는다.
     CPP에서는 & 를 사용하여 Call by Reference 로 함수 호출을 정의 할 수 있고
     C 언어에서는 이와 유사하게 포인터로 전달받아 Call by Address 호출을 구현한다.
     Java 언어에서는 모든 매개변수는 call by value 로 호출된다.
    
 
 Swift 에서는 callee에서 매개변수 값을 수정하려는 시도는 swift에서는 애초에 차단된다.
 이유는 스위프트의 매개변수는 기본적으로 상수(let)으로 선언되어 있기 때문이다.
 
 inout 키워드는 매개변수를 피호출부(callee)측에서 변수로 넘겨받고 함수 내에서의 변형이 일어나면 호춟부(caller)의 값도 변하도록 하고 싶을 때 사용한다.
 즉, inout 키워드는 참조자를 넘겨주는 의미이자, 이에 더해 파라미터를 변수화 시키는 키워드이다.
 
 간단히 말하면 call by address 와 유사하게 동작하지만, 동작하는 매커니즘을 살펴보면 다르게 동작하는 것을 알수 있다.
 
 우선 공통적인 규칙은 다음과 같다.
     1. 파라미터 타입의 앞에 공백으로 구분하여 inout 키워드를 작성한다.
     2. 상수 혹은 리터럴은 inout parameter로 넘겨줄 수 없다.
     3. 디폴트값을 가질수 없다.
     4. 가변매개변수에 사용불가.
 
 inout 파라미터는 전달되는 인수의 타입에 따라서 서로 다르게 동작한다.
 
     1. 파라미터 타입이 참조타입인 경우
        인수가 참조변수(when the argument is a value stored at a physical address in memory)일 경우에는 call by reference 와 같이 동작하고,
        동일한 메모리 위치가 함수 본문 내부와 외부 모두에서 사용된다고 한다.
            - 공식문서(https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#In-Out-Parameters)
     
     2. 파라미터 타입이 값타입인 경우
        참조 타입이 아닌 파라미터(struct, enum, 기본 자료형..)의 경우에는 값을 변경하고 싶을 때, inout 키워드를 함께 사용해야 값을 변경할 수 있다.
        In-out 파라미터가 동작하는 순서는 아래와 같다.
     
            1. 함수가 호출될 때, 인수의 값이 복사됨
            2. 함수 본문 내에서 복사된 값이 수정됨
            3. 함수가 반환될 때 복사본의 값이 기존 인수에 할당됨
 
 
     In-out 파라메터에 관한 공식 문서에서는 다음과 같은 규칙을 지키라고 말한다.
     [규칙]
         1. 원본에 대한 참조가 가능하더라도 원본에 접근하지 말것(inout 파라메터로 전달된 값을 참조하지 말것). 메모리 베타성 위반 (런타임 에러)
            Within a function, don’t access a value that was passed as an in-out argument, even if the original value is available in the current scope.
            Accessing the original is a simultaneous access of the value, which violates memory exclusivity.
   
         2. 같은 이유로 여러 파라미터에 동일한 값 전달하지 말것. (컴파일 에러)
            someFunction(a: &someValue, b: &someValue)
            For the same reason, you can’t pass the same value to multiple in-out parameters.
   
         3. 인아웃 파라미터를 캡쳐하는 클로저나 중첩함수는 nonescaping 이어야 할것.
            값을 캡쳐해서 함수 종료 후 사용 할 수 없도록 해야 한다.
 
         4. 인아웃 파라미터를 캡쳐하고 바꿔야 하는 스레드(함수 반환 전 변경이 완료되는 스레드 등) 상황에서는 로컬 복사본을 만들어서 사용할 것. 문서에서 defer 구문은 가장 후위 호출되도록 하는 구문이다. (return 직전)
   
         위의 내용은 파라미터 타입이 값 타입인 경우에 해당 되는 것으로,
         1번과 2번의 내용은 동작 메커니즘에 따른 접근충돌을 방지하기 위함이며(변수에 대한 읽기/쓰기 권한이 함수로 넘어감),
         3번과 4번은 캡쳐해서 값을 사용하고 다시 인수에 할당되는 메커니즘이니, 캡쳐할 경우 조심하라는 말이다. (함수내에서 모든 변경이 끝나도록)
                
 
 
 요약하면,
 1. 클래스의 경우에는 inout 을 굳이 사용할 필요 없으나, 변수로 전달된 클래스 자체의 값을 변경하고 싶을 때, inout 키워드를 사용할 수 있다.
 2. 값타입(struct, enum, 기본자료형 등)의 경우에는 함수 내에서 변경하고자 하면 inout을 사용하여 변경하도록 할 수 있다.
 3. 메모리 충돌 및 접근성을 고려하여야 한다.
 */

// 사용 예
func swapName(_ a : Animal, _ b: Animal) {
    let temp = a.name
    a.name = b.name
    b.name = temp
}
// (아래의 swap function의 경우에는 제네릭으로 정의된 built in function 이다.
//func swap(a: inout Animal, b: inout Animal){
//    let temp = a
//    a = b
//    b = a
//}

var mypet: Animal = Dog(name: "댕댕")
var yourPet: Animal = Cat(name: "냥냥")

print(mypet , yourPet)
swapName(mypet, yourPet)
print(mypet , yourPet)
swap(&mypet, &yourPet)
print(mypet , yourPet)






// 차이점
class Animal : CustomStringConvertible{
    var name : String
    var items: Set<Item> = []
    
    init(){
        self.name = ""
    }
    init(name : String){
        self.name = name
    }
    
    var description: String {
        get {
            String(describing: type(of: self)) + "[" + self.name + String(describing: items) + "]"
        }
    }
}
class Dog : Animal {}
class Cat : Animal {}

struct Animal_struct : CustomStringConvertible{
    var name : String
    var items: Set<Item> = []
    init(){
        self.name = ""
    }
    init(name : String){
        self.name = name
    }
    
    var description: String {
        get {
            String(describing: type(of: self)) + " [" + self.name + " " + String(describing: items) + " ]"
        }
    }
}


// 인스턴스의 속성을 변경하는 메서드는 키워드가 필요 없다.
extension Animal {
    func rename(name: String){
        self.name = name
    }
}

// 값 타입의 속성을 변경하는 메서드는 mutating 키워드를 사용한다.
extension Animal_struct {
    mutating func rename(name: String){ // struct 는 immutable (값타입) 이므로 mutating 키워드 필요(나중에)
        self.name = name
    }
}

// 인스턴스의 속성을 변경하는 함수는 키워드가 필요없다.
func rename(arg : Animal, name : String){
    arg.name = name
}

// 클래스와 다르게 값타입 변수는 속성 값을 변경하더라도 외부의 함수를 통해 변경하려면 inout 키워드가 필요하다.
func rename(arg : inout Animal_struct, name : String){
    arg.name = name
}

// 인스턴스 자체를 변경하는 함수는 inout 키워드를 사용한다.
func exchangePet(_ pet_local: inout Animal, name: String){
//    pet = Animal(name: name) // error
    pet_local = Animal(name: name)
    // 참조타입이므로 이전의 Dog 인스턴스는 알아서 ARC에 의해 컴파일 시점에 해제시점이 계산되어 런타임시 호출 구문에서 해제 됨
}

func exchangePet(_ pet_local: inout Animal_struct, name: String){
    pet_local = Animal_struct(name: name)
}

var pet: Animal = Dog()
var pet_struct: Animal_struct = Animal_struct()


// 속성 변경 (인스턴스 메서드)
pet.rename(name: "멍멍이")
print(pet.name, pet.self, type(of: pet))

// 속성 변경 (인스턴스 외부 함수)
rename(arg: pet, name: "댕댕이")
print(pet.name, pet.self, type(of: pet))

// 인스턴스 변경 (외부 함수)
exchangePet(&pet, name: "코끼리")
print(pet.name, pet.self, type(of: pet))

// 속성 변경 (스트럭트 메서드)
pet_struct.rename(name: "멍멍이")
print(pet_struct.name, pet_struct.self, type(of: pet_struct))

// 속성 변경 (스트럭트 외부 함수)
rename(arg: &pet_struct, name: "댕댕이")
print(pet_struct.name, pet_struct.self, type(of: pet_struct))

// 자체 참조 변경 (외부 함수)
exchangePet(&pet_struct, name: "코끼리")
print(pet_struct.name, pet_struct.self, type(of: pet_struct))



//import Foundation
/*
 참조 타입이 속성으로 존재하는 경우 외부와 내부에서 동일하게 변경되는가
 */
class Item: Hashable, CustomStringConvertible{
    var isValid : Bool = true
    var description : String { return String(describing: type(of: self)) }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        type(of: lhs) == type(of: rhs)
    }
    func hash(into hasher: inout Hasher){
        hasher.combine(isValid)
        hasher.combine(description)
    }
}

class Shoes: Item {}
class Hat: Item {}
class Clothes: Item{}

func addItem(pet: Animal, item:Item){
    pet.items.insert(item)
}
func removeItem(pet: Animal, item:Item){
    pet.items.remove(item)
}

addItem(pet: pet, item: Shoes())
addItem(pet: pet, item: Hat())
addItem(pet: pet, item: Clothes())
print(pet_struct.items)

removeItem(pet: pet, item: Shoes())
print(pet.items)


func addItem(pet: inout Animal_struct, item:Item){
    pet.items.insert(item)
}
func removeItem(pet: inout Animal_struct, item:Item){
    pet.items.remove(item)
}

addItem(pet: &pet_struct, item: Shoes())
addItem(pet: &pet_struct, item: Hat())
addItem(pet: &pet_struct, item: Clothes())
removeItem(pet: &pet_struct, item: Shoes())


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"


// 정리 : 인스턴스는 인스턴스 자체 변경을 위해서는 inout 키워드를 사용하고, 이는 call by reference와 같이 동작
//       이외 변수는 속성이건 자체 변경을 위해서건 inout 키워드를 사용함


//MARK: End In-Out Parameters





// MARK: - Function Types

// The type of both of these functions below is (Int, Int) -> Int.
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

// Using Function Types
// 특정 function 타입을 가지는 변수를 정의함으로써,
// 기타 언어에서 델리게이트, 혹은 함수포인터의 개념처럼 활용이 가능하다.
// 동일한 특정 형태의 프로시저를 상황에 맞게 지정하여 호출하는 매커니즘을 구현하는 데 조금 더 간결하게 표현할 수 있다.

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 6"

// 여타 변수 및 상수와 마찬가지로 타입추론이 가능
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int


// Function Types as Parameter Types
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"

printMathResult({ a, b in
    return (a + b) * b
}, 3, 5)

// MARK: - Function Types as Return Types

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

func chooseStepFunction_(backward: Bool) -> (Int) -> Int {
    return backward ? { input in return input - 1 } : { input in return input + 1 }
}


var currentValue = -5

var moveNearerToZero =  chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!


// MARK: - Nasted Function
// 함수 내에 함수를 정의 가능
func chooseStepFunction_Nasted(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue_ = -4
let moveNearerToZero_ = chooseStepFunction_Nasted(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue_ != 0 {
    print("\(currentValue_)... ")
    currentValue_ = moveNearerToZero_(currentValue_)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
