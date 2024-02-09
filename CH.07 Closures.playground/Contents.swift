// 공식문서의 내용 추가 필요

/*
 함수조차 클로저의 서브셋이라고 설명하고 있다.
 
 Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
 
     - Global functions are closures that have a name and don’t capture any values.
     - Nested functions are closures that have a name and can capture values from their enclosing function.
     - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 
 Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
 
     - Inferring parameter and return value types from context
     - Implicit returns from single-expression closures
     - Shorthand argument names
     - Trailing closure syntax
 */

// MARK: - Closure Expressions

// The Sorted Method
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]


// Closure Expression Syntax
//{ (<#parameters#>) -> <#return type#> in
//   <#statements#>
//}

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// 리턴과 인자의 타입이 생략된 형식
reversedNames = names.sorted(by: { a, b in
    a < b
})

// Inferring Type From Context
// 인자의 타입 생략 가능

// Implicit Returns from Single-Expression Closures
// 암묵적인 키워드 return : 모호하지 않은 경우 리턴 키워드의 생략이 가능하다.

// Shorthand Argument Names
/*
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
 */
reversedNames = names.sorted(by: { $0 > $1 } )

// Operator Methods
// For more about operator methods, see Operator Methods.
reversedNames = names.sorted(by: >)


// MARK: - Trailing Closures
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

reversedNames = names.sorted() { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]

//func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
//    if let picture = download("photo.jpg", from: server) {
//        completion(picture)
//    } else {
//        onFailure()
//    }
//}
//
//loadPicture(from: someServer) { picture in
//    someView.currentPicture = picture
//} onFailure: {
//    print("Couldn't download the next picture.")
//}

//

//MARK: - Capturing Values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}


let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30


let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// returns a value of 7

incrementByTen()
// returns a value of 40


//MARK: - Closures are Reference type
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50

incrementByTen()
// returns a value of 60

// MARK: Closures are Reference type -


//MARK: - Escaping Closures
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    
    completionHandlers.append(completionHandler)
}

//MARK: Escaping Closures -

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}


class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
        
    }
}


let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"


completionHandlers.first?()
print(instance.x)
// Prints "100"


// 아래와 같이 캡쳐목록에 self를 포함시키고 암시적인 참조를 할 수 있다.
// struct 혹은 enumeration은 자동으로 클로저 내에서 암시적으로 자기자신을 참조한다.
class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

// structure 혹은 enum 일때, 탈출 클로저는 self에 대한 변경 가능한 참조를 캡쳐할 수 없다.
// However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration.

//struct SomeStruct {
//    var x = 10
//    mutating func doSomething() {
//        someFunctionWithNonescapingClosure { x = 200 }  // Ok
//        someFunctionWithEscapingClosure { x = 100 }     // Error
//    }
//}

//MARK: - Autoclosures

/*
 An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
 It’s common to call functions that take autoclosures, but it’s not common to implement that kind of function. For example, the assert(condition:message:file:line:) function takes an autoclosure for its condition and message parameters; its condition parameter is evaluated only in debug builds and its message parameter is evaluated only if condition is false.
 An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.
 */


/*
 아래는 주저리 주저리 써놓은 것에 대한 예문들인데, 그냥 클로저는 익명함수들과 같이 선언될 때 실행되지 않고,
 호출될 때 실행된다는 뜻
 
 그리고 아래 설명할 오토 클로져라는 것을 사용하면 함수의 인수로 사용하는 클로저에 대한 brace를 생략할 수 있는데, 이 때 함수가 실행되는 구문처럼 헷갈릴 여지가 있기 때문에 앞에서 이렇게 주저리 주저리...
 
 가장 아래 있는 예문 두개를 보면 이해가 빠르다.
 
*/
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"


let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"




// 오토클로저는 {brace} 를 생략 가능하게 해준다.

// 기존의 클로저 사용 예)
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

// 오토 클로저 사용 예
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"

// 오토 클로저를 너무 자주 사용하면 코드의 가독성이 떨어지니 자제하라고 권고하고 있다.


// 오토 클로저를 이스케이핑 하여 사용하고자 할 경우, 어노테이션을 중첩하여 사용 가능하다.
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))


print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"


// MARK: Autoclosures -







// ----------------------------------------------------------------------------------------------------------------------------
// 아래 내용은 공식문서의 내용이 아님
/*
 클로저
 스위프트에서는 일급객체의 역할을 하는 익명함수 자체를 클로저라 일컫는다.
 참조타입으로 코드에서 전달 및 사용할 수 있는 독립 기능 블록이며, 일급 객체의 역할을 할 수 있음

 일급객체 : 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수도 있다.

 스위프트는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어이므로 함수 자체가 일급객체이다.
 스위프트에서 클로저와 일반 함수의 차이는 그냥 익명이냐 아니냐로 나뉜다.
 
 즉 아래의 사용이 가능하다는 것
 
 */
func PrintH(){
    print("this is why i'm First-Class Citizen")
}

var prH = PrintH

prH()

func PrintGreeting(name : String, greeting: ()->()){
    print("hello")
    print(name)
    greeting()
}

PrintGreeting(name: "flapper", greeting: prH)

/*
 
 -- 배경지식 --
 
 First-Class Citizen (일급객체) 란?
 
 1. 변수/상수 에 값을 저장할 수 있으며,
 2. 함수의 인자로 보내고 받을 수 있고,
 3. 함수의 리턴값이 될 수 있다.
 
 라는 위의 세 가지 조건을 모두 충족하는 객체를 일급객체라 부른다.
 
 람다식, Anonymous function (익명함수) 란?
 람다 대수로부터 영향을 받아 만들어진, 프로그래밍에서 함수를 표한하는 방식의 일종이며, 이름이 정의되지 않은 함수를 일컽는다.
 자바에서의 람다가 익명함수를 일컫는다.
 대부분의 프로그래밍에서 람다함수(익명함수)는 일급함수이다.
 
 (Lexical) Closure (클로저) 란?
 클로저는 함수가 선언될 당시의 환경(environment)을 기억했다가 나중에 호출되었을때 원래의 환경에 따라 수행되는 함수이다.
 이름이 클로저인 이유는 함수 선언 시의 scope(lexical scope)를 포섭(closure)하여 이후 실행될 때 이용하기 때문이다.
 자주 '이름 없는 함수(익명함수)'와 혼동되곤 한다. 많은 언어의 익명함수가 closure를 포함하기 때문에 편하게 부를땐 서로 구분없이 부르기도 한다.
 
 보통 프로그래밍 언어에서 클로저라 함은 외부에서 선언된 변수를 사용하는 함수를 일컬으며, 클로저는 람다식을 활용하여 표현하는 경우가 많다.
 
외부함수보다 내부함수가 더 오래 유지되는 경우, 외부함수 밖에서 내부함수가 호출되더라도 외부함수의 지역변수에 접근할 수 있는데, 이러한 함수를 클로저라 한다.
 자바나 자바스크립트에서의 클로저에 대한 설명을 차용하자면
 
 func ExternalF(y) ->() ->(){
    var x
    return (y) -> (x + y)
 }
 
 위와 같은 함수가 있다고 가정할 때,
 
 반환과 함께 외부함수 ExternalF는 주기를 다하여 이에 따라 지역변수 x도 소멸되지만,
 ExternalF를 호출한 콜러가 반환값인 람다함수를 사용하면 사라진 지역변수 x는 이 람다식에서 사용할 수 있다.
 
 자바에서는 이러한 변수를 자유변수라고 하고, 자유변수에 지역변수등의 데이터를 저장하는 것을 람다캡쳐링이라 한다.
 스위프트에서는 이러한 변수의 캡쳐와 관련한 모든 메모리 및 행동을 알아서 처리한다.
 
 스위프트에서의 용어를 정리하자면,
 
 전역함수 : 이름이 있고, 어떤 값도 캡쳐하지 않는 클로저
 중첩함수 : 이름이 있고 관련한 함수로부터 값을 캡쳐할 수 있는 클로저
 클로저 표현 : 경량화 된 문법으로 쓰여지고 관련된 문맥(context)으로부터 값을 캡쳐할 수 있는 이름이 없는 클로저
 
 실제 xcode를 사용한 코드는 다음과 같다.

 func ExternalF() -> ((_ y : Int) ->Int){
     var x : Int = 0x03
     return {
         (y : Int) -> Int in
         return (x * y)
     }
 }

 var exF_45 = ExternalF()
 exF_45(12)
 */

// closure 라고 입력 후 자동완성(cmd+. or alt+esc)을 활용하면 바로 클로저 표현을 적용가능하다.
//{ (parameters) -> returntype in
//    statements
//}

let hello = { () ->() in
    print("hello")
}

// 컴파일러가 반환타입을 알고 있을 경우에는 생략도 가능하다
let hello_returnomitted = { () in
    print("hello")
}

print(hello())

hello()

// 파라미터와 리턴타입이 있는 클로저 (name : NOT Argument label, parameter name)
let hello2 = {
    (name : String) -> String in
    return "Hello, \(name)"
}

// 호출할 때는 argument 레이블을 적지 않는다.
hello2("asd")

// 함수의 파라미터 타입으로 전달이 가능
func doSomething(myClosure : () -> ()){
    myClosure()
}

doSomething(myClosure: {() -> () in
    print("hi man!!!")
})



// 함수의 반환 타입에 클로저를 사용
func doSomething2() -> () -> (){
    return {
        () -> () in
        print("hi woman")
    }
}

doSomething2()()

/*
 
 Trailing Closure (후행 클로저)
 클로저가 함수의 마지막 전달인자라면 마지막 매개변수 이름을 생략하고 함수 소괄호 외부에 클로저를 구현 가능
 맨 마지막 전달되는 매개변수의 클로저만 사용 가능, 여러 클로저를 전달하는 경우 마지막 변수만 가능
 */

doSomething(){
    // 파라미터와 리턴값 없다면 모두 생략 가능하고, in 키워드도 생략가능
    print("this is trailing closure")
}

/*
 다중후행 클로저
 매개변수로의 클로저가 여러개일 경우
 */

func doSomething2(success: () -> (), fail : () -> ()){
    
}

doSomething2 {
    print("success")
} fail: {
    print("fail")
}

func doSomething3(closure: (Int, Int, Int) -> Int){
    print(closure(1,2,3))
}

doSomething3(closure: {
    (a,b,c) in
    return a+b+c}
)
doSomething3(closure: {
    print("dosn't omitted return keyword")
    return $0+$1+$2
})

doSomething3(closure: {
    // 단일 리턴구문이라면 아래와 같이 리턴 키워드도 생략 가능
    $0+$1+$2
})
doSomething3(){
    $0+$1+$2
}

// 단 하나의 클로저만 매개변수로 전달하는 경우에는 아래와 같이 소괄소도 생략가능
doSomething3{
    $0+$1+$2
}
