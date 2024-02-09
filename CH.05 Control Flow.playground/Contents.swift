/*
 For-In loop
 
 for [루프내에서 사용할 변수명] in [컨테이너 등의 반복할 개체]
 파이썬        for i in [컨테이너 등]:
 자바/CPP     for(Int v : [컨테이너 등]){}
 C#          foreach (int i in [컨테이너 등]){}
 */

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

// 딕셔너리를 키벨류 값으로 나눠서 받아옴
// 단, 이러한 경우 순서가 없는 dictionary의 특성 때문에 수행할 때마다의 순서를 보장할 수 없음
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

// 숫자 범위를 지정한 for 문
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// 값의 무시
// 연산에 필요하지 않은 값을 익명의 변수로 취급하여 무시할 수 있고
// 이는 성능에 다소 영향을 준다.
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"

print("using range of half open")
for i in 1..<3 {
    print(i)
}

// stride squence x...y by stepsize (using through)
//                x..<y by stepsize (using to)
print("for in stride (through) ---------------------------------------------")
let hours = 12
let hourInterval = 3

for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    print(tickMark)
}
print("---------------------------------------------------------------------")

print("for in stride (to) --------------------------------------------------")
print("using the stepsize")
// interval의 사용 ( from to by 세가지
for values in stride(from: 3, to: hours, by: hourInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    print(values)
}
print("---------------------------------------------------------------------")

// -------------------------------------------------------------------------------//
// 참고                                                                            //
// -------------------------------------------------------------------------------//
/*
 그러면 전통적인 비교문을 통한 for문은 사용할 수 없는 것일까?
 그렇다. 다시 생길지 모르지만 swift swift 3.0에서 사라졌고 현재 5.8 기준으로 존재하지 않는다.
 for 문 안에서 특정 조건을 비교하고 break 하거나 while문을 사용
 */

// 별도의 stop condition 이 있는 for문
// 아래 C스타일의 루프와 같이 만드려면
/*
 int arr[] = {1,5,3,5,6,7,2,2,45,7,7};

 for(int i = 0; arr[i]!=7; i++){
     printf("%d", arr[i]);
 }
 */
// 이렇게 for 문안에 조건문을 넣어 만들면 됨
var arr = [1,5,3,5,6,7,2,2,45,7,7];

for i in arr{
    if i == 7{
        break
    }
    print(i)
}
// --------------------------------------------------------------------------------//

//MARK: - While Loops

/*
  while         - evaluate it's condition at the start
  repeat while  - evaluate it's condition at the end (do once at least)
 */

// while
print("usage of while loop..............")
var start = 1
while start <= 10 {
    print(start)
    start += 1
}

var members: [String] = ["Kim", "Lee", "Park"]

while !members.isEmpty {
    print("Good bye \(members.removeFirst())")
}
print(members.isEmpty)


//This example plays a simple game of Snakes and Ladders (also known as Chutes and Ladders):
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
}
print("Game over!")



// repeat while

// 다른 언어의 do-while과 동일
members = ["Kim", "Lee", "Park"]
repeat {
    print("Good bye \(members.removeFirst())")
} while members.isEmpty == false

print(members.isEmpty)



board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
square = 0
diceRoll = 0

repeat {
    // move up or down for a snake or ladder
    square += board[square]
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
} while square < finalSquare
print("Game over!")


//MARK: - Conditional Statements

//Conditional Statements 정리

/* if ***********************************************************************/
// if condition is true, excutes set of statements
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's not that cold. Wear a T-shirt."

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's really warm. Don't forget to wear sunscreen."


temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}

let temperatureInCelsius = 25
let weatherAdvice: String

if temperatureInCelsius <= 0 {
    weatherAdvice = "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    weatherAdvice = "It's really warm. Don't forget to wear sunscreen."
} else {
    weatherAdvice = "It's not that cold. Wear a T-shirt."
}

print(weatherAdvice)



func fff(){
    print("hi")
}

// 아래는 swift 5.9 이상 버전에서 가능 - 현재 5.8.1
// 참조 :
// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions#Conditional-Expression

//var weatherAdvice2 = if temperatureInCelsius <= 0 {
//    "It's very cold. Consider wearing a scarf."
//} else if temperatureInCelsius >= 30 {
//    "It's really warm. Don't forget to wear sunscreen."
//} else {
//    "It's not that cold. Wear a T-shirt."
//}
//
//let freezeWarning: String? = if temperatureInCelsius <= 0 {
//    "It's below freezing. Watch for ice!"
//} else {
//    nil
//}

// 타입추론을 사용하게 되는 경우에는 nil 값은 모든 자료형에 사용될 수 있으므로 String? 옵셔널 자료형임을 명시적으로 작성해야 한다.
//let freezeWarning = if temperatureInCelsius <= 0 {
//    "It's below freezing. Watch for ice!"
//} else {
//    nil as String?
//}

// 오류 발생이나 fatalerror 함수를 사용할 수 있다.
//let weatherAdvice = if temperatureInCelsius > 100 {
//    throw TemperatureError.boiling
//} else {
//    "It's a reasonable temperature."
//}

// MARK: - Switch
/*
 switch <#some value to consider#> {
 case <#value 1#>:
     <#respond to value 1#>
 case <#value 2#>,
     <#value 3#>:
     <#respond to value 2 or 3#>
 default:
     <#otherwise, do something else#>
 }
 */

var someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the Latin alphabet")
case "z":
    print("The last letter of the Latin alphabet")
default:
    print("Some other character")
}
// Prints "The last letter of the Latin alphabet"


// Swift 5.9 이상의 버전에서 사용 가능 컨디션 조건절 + 대입
//let anotherCharacter: Character = "a"
//let message = switch anotherCharacter {
//case "a":
//    "The first letter of the Latin alphabet"
//case "z":
//    "The last letter of the Latin alphabet"
//default:
//    "Some other character"
//}
//print(message)
// Prints "The first letter of the Latin alphabet"

// if 표현식과 마찬가지로 error를 발생시키거나 fatalerror 함수를 사용가능


//MARK: -  No Implicit Fallthrough
// 스위프트의 switch 구문은 break 없이도 다음 case 스위치문으로 떨어지지 않으며,
// 해당되는 case 구문이 완료되면 스위치문 자체가 완료되는 구조
// if else 구문과의 차이가 거의 없다.


let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a":
    // The body of each case must contain at least one executable statement.
    print("a")
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// This will report a compile-time error.


switch anotherCharacter {
case "a", "A": //compound case
    print("The letter A")
default:
    print("Not the letter A")
}
// Prints "The letter A"

someCharacter = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) isn't a vowel or a consonant")
}
// Prints "e is a vowel"


// MARK: - fallthrough
// 스위프트의 switch 문은 앞에 설명한대로 기본적으로 다음 케이스로 fallthrough 하지 않는 특성을 가지고 있는데,
// 만약 이러한 행동이 필요한 경우라면 아래와 같이 fallthrough 키워드를 사용하여 다음 케이스 문을 실행하도록 할 수 있다.

let integerToDescribe = 2
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number"
    fallthrough
    
// fallthrough 는 바로 다음 단계의 case 구문을 무조건 실행 (조건비교 하지 않음)
//case 3, 5, 7, 11, 13, 17, 19:
//    description += ", and also odd"
//    fallthrough
default:
    description += ", and also an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."


//MARK: - Interval Matching case 구문을 범위로도 사용 가능 (floating point number 사용 가능)
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."

//MARK: - Tuples
// 튜플을 스위치 케이스 문에 사용할 수 있으며, 튜플의 각 값을 범위나 와일드카드로 사용할 수 있다.

var somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"


// 또한 모든 경우에 일치한다면, 가장 처음 기술된 case문을 실행하고 종료된다.(fallthrough 가 없을 시)
somePoint = (0, 0)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
    fallthrough
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}


//MARK: - Value Bindings
// case 문의 값을 와일드 카드가 아닌 변수나 상수로 바인딩 하는 경우는 해당 case 구문에서 변수/상수 값을 사용하기 위함이다.
// 아래에서 x 는 y=0 인 케이스의 모든 x 값이 된다.

let anotherPoint = (4, 0)
switch anotherPoint {
case (0, 0):
    print("on the origin")
//    fallthrough // 에러
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
//    fallthrough // 에러
case (0, let y):
    print("on the y-axis with a y value of \(y)")
//    fallthrough // 에러
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"


//let anotherPoint = (4, 0)
switch anotherPoint {
case let (x, y):
    print("somewhere else at (\(x), \(y))")
    fallthrough
case (let x, let y):
    print("on the y-axis with a y value of \(y)")
//    fallthrough // 에러
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
//    fallthrough // 에러
case (0, 0):
    print("on the origin")
//    fallthrough // 에러
}


