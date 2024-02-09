
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


// MARK: - Functions with Multiple Return Values

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
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)

// MARK: - Specifying Argument Labels
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
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)


// MARK: - Default Parameter Values
//
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

// 참조에 의한 호출 과 일맥상통하는 키워드로
// 기본적으로 스위프트 함수에서 전달되는 매개변수는 값타입이자, 상수로 변경조차 불가능한데,
// 변수를 참조타입으로 전달하고 싶을 경우에 사용한다.
// 상수를 매개변수로 넘겨줄 수 없다.


/*
  아래와 같은 특징을 가지고 있다.
 디폴트값을 가질수 없고, 가변매개변수에 사용불가.
 In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.
 */


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
