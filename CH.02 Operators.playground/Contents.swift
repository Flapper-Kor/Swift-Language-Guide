/*
 연산자
 */

/*
 1. 대입연산자
 */
// 스위프트에서 대입연산자는 비교연산과의 혼동을 피하기 위해서 값을 반환하지 않는다.
var a : Int = 0
let b = a += 2
// 대입 연산자는 값을 반환하지 않는다. 첫번째 대입 연산자가 값을 반환하지 않으므로,b의 값은 존재하지 않는다.

print(a, b)
print(b==nil)
print(type(of: b))
// 근데 nil 은 아니다.

let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2

//var z: Int = 0
//if z = y{} // impossible

/*
 2. 산술 연산자
 */
print(x + y)
print(x - y)
print(x * y)
print(x / y)

// String 덧셈 infix 연산자는 concatenation
let stringadd = "sdf" + "qqwe"
print(stringadd)

//remainder operator
print(9%4)

import Darwin.C
//or
//import Foundation
print(remainder(9, 4))

/*
 unary prefix
 */

print(+12)
print(-12)


/*
 comparison operator
 */

/*
 
 Equal to (a == b)
 Not equal to (a != b)
 Greater than (a > b)
 Less than (a < b)
 Greater than or equal to (a >= b)
 Less than or equal to (a <= b)
 
 these all return Value of Boolean( true or false )
 */

// 스위프트에서는 String 값의 비교도 비교연산자를 통해 비교한다.
// 인스턴스 비교를 하고 싶은 경우는 (===) 연산을 사용한다.

// 정리하면 swift 에서 reference 비교 (===)
//                 value 비교 (==)
// String 은 값타입의 Stuct 이기 때문에 == 을 통해 값의 비교가 가능한 것!
class Person {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
// 클래스 간 비교연산을 수행하고 싶은 경우 아래의 두 가지 방법으로 가능
// 1. Equatable 프로토콜 준수 규칙
//extension Person: Equatable{
//    static func == (left:Person, right:Person) -> Bool{
//        return left.id == right.id
//    }
//}
// 2. infix operator 의 정의 규칙 (infix 는 생략, prefix, postfix 는 함수 구현부 앞에 키워드를 붙여줌
infix operator == // 연산자 선언의 경우 이미 있는(이미 선언된) 연산자는 생략 가능
func ==(left:Person, right:Person) -> Bool{
    return left.id == right.id
}

// 전역으로 선언하고 정의
prefix operator +++
postfix operator +++

prefix func +++ (number : inout Int) -> Void{
    number += 2
}

var l : Int = 3
+++l

print(l)

// 연산자 우선순위 이런 것은 좀 더 나중에 살펴보기로 함
//extension Int{
//    // infix : 키워드 생략
//    static func ==(left:Int, right:Int) -> Bool{
//        return left<right
//    }
//    prefix static func +++ (number : inout Int) -> Void{
//        number += 2
//    }
//    // postfix : 후위 연산자 // 이러한 경우 연산자 우선순위를 정하기 위해... 문서 참조
//    postfix static func +++ (number : inout Int) -> Void{
//        number += 2
//    }
//}
//print(1==2)

var Person1 = Person(id: 1, name: "kim")
var Person2 = Person(id: 1, name: "kim")

print(Person1 == Person2)
print(Person1 === Person2)

/*
 비교 연산자 (튜플)
 튜플의 경우 앞의 것 부터 차례대로 비교한다.
 */
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"

/*
 ternary condition Operator
 삼항연산자는 비교 및 결과의 합성이다
 삼항연산자를 활용하면 결과값의 대입도 쉽게 간단히 가능하다.
 */

// 조건절이 참이면 condition 1, 조건절이 거짓이면 condition 2 반환
// (conditional) ? (condition 1) : (condition 2)
let bs = 3<2 ? 123 : 321
print(3<2 ? 123 : 321)
print(bs)

// 아래와 같이 표현 가능하다.
if 3<2  {
    123
} else {
    321
}
// if 절의 경우 대입이 중괄호 안에서 이뤄져야 하고 조건에 따라 좀더 복잡한 프로시저를 수행할 때 사용.
// 단순한 조건과 결과에 따른 대입 등에는 삼항연산자를 사용
let contentHeight = 40
let hasHeader = true


var rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90

if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90


/*
 Nil-Coalescing Operator
 */
// 옵셔널을 해제하거나 nil 인경우 디폴트 값을 사용

var intA : Int?
var intB : Int? = 9999
var intC : Int = 10

print(intA ?? intC)
print(intB ?? intC)

// 풀어서 쓰면 다음과 같다.

intA != nil ? intA! : intC


let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil


var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName isn't nil, so colorNameToUse is set to "green"


/*
 Range Operators
 */


/*
 Closed Range Operator (a...b) includes the values a and b.
*/
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25


/*
 Half-Open Range Operator (a..<b) (doesn’t include b)
 */
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack

/*
 One-Sided Ranges
 */

// step 1) slicing
var slice = names[2...]
print(slice, type(of: slice), slice.count)

slice = names[...2]
print(slice, type(of: slice), slice.count)

slice = names[..<2]
print(slice, type(of: slice), slice.count)


// range......

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true

print(range, type(of: range), range.upperBound)

print(Range(1...23), type(of: Range(1...23)), Range(1...23).upperBound)


/*
 Logical Operators
 */

var abool = false
var bbool = true
var cbool = false

// Not (!)
print(!abool)
// And
print(abool && bbool)
// Or
print(abool || bbool)


// 순서 (왼쪽부터, 단항(unary : not) 부터)
abool && bbool || cbool
abool || bbool && !bbool

/*
 Explicit Parentheses
 */
// 괄호로 순서를 명확하게 표현

let enteredDoorCode = true
let passedRetinaScan = false
let hasDoorKey = false
let knowsOverridePassword = true
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
