/*
 1. Constants and Variables (변수와 상수)
*/

/*
 1-1. Declare (선언) 동시에 초기화 가능
 */
print(" 1-1. Declare (선언) 동시에 초기화 가능 -----------------------------------------------------")
let a = 10 // constant
var b = 10 // Variable
var x = 1.1, y = 3.2 // multiple variables on a single line

/*
 1-2. Type Annotation (type-specifier:타입 지정자와 사용법은 비슷함)
 */
print(" 1-2. Type Annotation -----------------------------------------------------------------")
var say : String // type of a is String
say = "hi"

/*
 1-3. Naming
 Constant and variable names can contain almost any character, including Unicode characters
 스페이스, 수학기호, 화살표 등 불가
 숫자로 시작할 수 없음
 */
print(" 1-3. Naming --------------------------------------------------------------------------")
let 😀 = "smile"
let smile = "😀"

/*
 1-4. Printing
 */
print(" 1-4. Printing ------------------------------------------------------------------------")
print("value of variable 'smile' is \(😀)")
print("value of variable 😀 is \(smile)")

/*
 2. Comment
 */

// line comment (기본단축키 : Hot Key : cmd + /)
/*
 block comment
 */

/*
 3. Semicolons
 기본적으로 사용할 필요 없으나, 사용해도 무방하며, 한줄에 여러 문장을 작성하기 위해 사용할 수 있음.
 */
print(" 3. Semicolons -----------------------------------------------------------------------")
print("d");print("a");print("o")

/*
 4. Basic Data Type
*/

/*
 4.1 Integer
 */

print(" 4-1. Integer ------------------------------------------------------------------------")
print("\(UInt8.min) <= UInt8 <=\(UInt8.max)")

// Int, which has the same size as the current platform’s native word size
print("\(Int.min) <= Int <=\(Int.max)")
print("\(Int64.min) <= Int <=\(Int64.max)")
print("\(Int32.min) <= Int <=\(Int32.max)")

print("\(UInt.min) <= Int <=\(UInt.max)")
print("\(UInt64.min) <= Int <=\(UInt64.max)")
print("\(UInt32.min) <= Int <=\(UInt32.max)")

/*
 4.2 Floating-Point Numbers
 */
// float : 32bit(4byte) 소수점 6자리까지 정확
// Double : 64bit(8byte) 소수점 15~16자리까지 정확
print(" 4-1. Floating-Point Numbers ---------------------------------------------------------")
var float : Float =   1.234123486862871034123412345554985273495872
var double : Double = 1.234123486862871034123412345554985273495872

print(float, double)

/*
 오차범위 내에서 정확하게 표현이 가능하지만 계산식에 사용할 경우 주의가 필요하며,
 정확한 계산을 하기 위해서는 제공되는 다른 자료형을 사용하거나 부동소수점 오차를 없애기 위해
 정수변환 하여 계산하는 로직을 스스로 만들어서 사용하여야 함
 운좋게도 부동소수점 연산을 정확하게 하려면 C# 과 동일하게 Decimal(NSDecimal) 이라는 타입을 사용하면 된다.
 Foundation 에 정의되어 있다.
 */

print(" 번외. Decimal ------------------------------------------------------------------------")
import Foundation
//var number1 : Decimal = Decimal(double)
var number1 : Decimal = 1.234134151098274019650169265103984812
var number2 : Decimal = 1.234593849058234852940509349385943948

var float1 : Float = 1.234134151098274019650169265103984812
var float2 : Float = 1.234593849058234852940509349385943948

var double1 : Double = 1.234123486862871034123412345554985273495872
var double2 : Double = 1.234593849058234852940509349385943948

print(number1, type(of: number1))

print("계산결과의 비교 - 정밀한 계산결과를 요하는 프로그램에 연산을 위해 Double, Float을 사용하지 않는 이유--------")
print(number1 * number2, type(of: number1 * number2))
print(float1 * float2, type(of: float1 * float2))
print(double1 * double2, type(of: double1 * double2))
print("--------------------------------------------------------------------------------------")

// Decimal의 생성과 변환은 비교적 간단하며, 관련 문서를 확인해보면 된다
var intOrigin :Int = 1223123123988192089
var floatOrigin :Float =   0.23123123123123123444412344123412414414223
var doubleOrigin :Double = 0.23123123123123123444412344123412414414223

var intD = Decimal(intOrigin)
var doubleD = Decimal(doubleOrigin)
var floatD = Decimal(Double(floatOrigin))

print(intD)
print(doubleD)
print(doubleD)

//print(intOrigin * intOrigin) // error
print(intD * intD)           // good

/*
 Decimal을 사용하면 안정적(overflow :X) 으로 연산을 할 수 있을 뿐만 아니라 연산의 오류가 없다(approximation : X)
*/


/*
 5. Type Safety and Type Inference
 타입 안정성이란 컴파일러가 컴파일 단계에서 오류의 가능성이 있는 타입의 오사용을 걸러주며,
 타입 추론이란 컴파일러가 타입을 문맥적으로 추론하여, 명시하지 않아도 동작하도록 도와주는 기능을 말한다.
 */
print("Type Safety and Type Inference -------------------------------------------------------")
// 아래는 타입추론의 예시
let pi_long = 3.14159265359
let pi_short = 3.1415
let pi_float : Float = 3.141592

print(pi_long, type(of: pi_long))
print(pi_short, type(of: pi_short))
print(pi_float, type(of: pi_float))

// 아래는 타입 안정성
/*
 C 와 Cpp 같은 아래와 같이 타입이 다른 언어끼리의 연산을 컴파일러가 거르지 않을 뿐 아니라
 이들 언어는 정수로 저장되어있는 변수도 포인터를 사용해서 실수형 실수형 변수나 캐릭터 변수에 담을 수 있다.
 각종 사용에 있어 오류의 가능성을 높이며 이들은 타입 안정성이 매우 떨어지는 언어라고 할 수 있다.
*/
var intVal : Int = 1
var floatVal : Float = 0.1
var charVal : Character = "A"

// print(intVal+floatVal+charVal)
// 위의 기능을 원하는 바대로 컴파일애러 없이 돌아가게 하려면 아래와 같이 사용 가능

print(Float(intVal) + floatVal + Float(charVal.asciiValue!))

/*
 6. Numeric Literals
 */

let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation


// exponential expression
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1      // here e is not (base of the natural logarithm), it is 10^
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

/*
7. Numeric Type Conversion
*/

/*
 7.1 Integer Conversion
 */

//let cannotBeNegative: UInt8 = -1
//// UInt8 can't store negative numbers, and so this will report an error
//let tooBig: Int8 = Int8.max + 1
//// Int8 can't store a number larger than its maximum value,
//// and so this will also report an error


// swift 의 타입 안정성 때문에 다른 타입끼리의 연산이 허용되지 않으므로
// 연산을 할때 캐스팅을 하여야 한다.
// 아래는 UInt8 변수를 사용해 새로운 UInt16 을 생성하여 연산하는 예
// 참고로 이러한 자료형들은 struct(값타입)이다
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

/*
 7.2 Integer and Floating-Point Conversion
 */

// 부동소수점 숫자의 기본 타입추론 자료형은 Double 이므로 아래와 같이 가능
// swift 에서는 float과 double 간의 연산도 허용되지 않는다 기본적으로
// (확장으로 가능하긴 하지만 굳이 연산 결과가 정확하지 않은 연산을 할 필요가 없다.)
// swift 에서는 그냥 double 만 쓰도록 하자(아니면 Decimal)

let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double


let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int

// float to integer 연산에서는 truncate 가 기본임
// 때문에 소수점을 잘라내려면 Integer 변환을 사용하여 잘라낼 수도 있다.

/*
 번외 - 확장을 통한 서로 다른 형간의 오퍼레이션 정의 (추천하지 않음)
 */
var floatNum: Float = 0.1123455
var doubleNum: Double = 0.1

//infix operator -
//extension Double{
//    static func - (left : Double, right : Float) -> Double {
//        return left-Double(right)
//    }
//    static func - (left : Float, right : Double) -> Double {
//      return Double(left)-right
//    }
//}

// 위와 같은 방법으로 infix 스타일의 연산자를 정의 가능하며, 서로 다른 자료형간의 연산을 할 수 있다.
// 단, float과 Double 간의 형변환에 있어서 아래의 문제가 발생하며 이러한 문제가 연산 결과에 반영된다.

var castedDoubleNum:Double
// 기본적으로 아래와 같이 Double 형변환 자체가 제대로 되지 않음 (쓰레기 값이 들어가게 된다)
castedDoubleNum = Double(floatNum)
print(castedDoubleNum)

// 이러한 상황을 없애기 위해 float 자체가 표현 가능한 수치 외에는 0으로 만들어주는 과정이 필요
// 방법은 여러가지가 있음.
castedDoubleNum = round(Double(floatNum)*1e7)/1e7
castedDoubleNum = Double(Int(Double(floatNum)*1e7)) / 1e7
castedDoubleNum = Double(String(format: "%.7f", Double(floatNum)))!

// 정상적으로 캐스팅 된 것을 알수 있다.
print(doubleNum, castedDoubleNum, type(of: doubleNum), type(of: castedDoubleNum))

// 이제 위의 함수를 바꿔주면 되는데, 기본자료형은 struct라서 overriding 이 불가하므로
// 위에 것을 주석처리 하고

infix operator -
extension Double{
    static func - (left : Double, right : Float) -> Double {
        return left - Double(String(format: "%.7f", Double(left)))!
    }
    static func - (left : Float, right : Double) -> Double {
        return Double(String(format: "%.7f", Double(left)))! - right
    }
}

// 하지만 연산을 해서 결과를 보면 알겠지만, 자료형 자체가 오차가 있는 근사값 표현 자료형이라서
// 계산 결과가 정확하지 않음을 알 수 있다.
print(doubleNum - castedDoubleNum)
print(castedDoubleNum - doubleNum)

// 애초에 이런 연산 자체는 그냥 위에서 언급한 Decimal 자료형(struct)을 활용하도록 하자
// 자세한 내용은 Decimal(), NSDecimal 참고


/*
 8. Type Aliases
 */
// 타입 에일리어스는 여타 언어에서의 것과 같고, 사용법은 아래와 같다.

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

/*
 9. Boolean
 */
// Boolean 은 논리값을 표현하기 위해 정의된 기본 자료형으로 Bool 이라는 자료형 이름을 가지고 있다.
let orangesAreOrange = true
let turnipsAreDelicious = false
// if 구문 및 while 구문 등의 조건으로 들어가는 값은 이 값을 가져야 한다.

/*
 10. Tuple
 */

// 여러개의 값의 나열
// 특징 : 개수는 상관이 없다. 인덱스를 가지고 있다. 레이블링 가능하다. 레이블로 접근이 가능하다(like dictionary, map)
// 튜플은 반환값의 유형으로 지정하여 사용하면 상당히 유용하다.
let http404Error = (404, "Not Found", 1231233444)
// http404Error is of type (Int, String), and equals (404, "Not Found")
print(http404Error, type(of: http404Error))


// 튜플을 분해하여 여러 변수로 받을 수 있다.
let (statusCode, statusMessage, dummy) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"

let (justTheStatusCode, _, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"

// 인덱싱 접근은 array의 그것과는 약간 다름
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
print("dummy values is \(http404Error.2)")

// 튜플의 레이블링
let http200Status = (statusCode: 200, description: "OK")

// 레이블을 통한 접근
print(http200Status.statusCode, http200Status.description)


/*
 11. Optional
 */
// 옵셔널은 nil 값을 가질 수 있도록 하기 위한 장치로 값의 부재가 가능한 상황에서 활용할 수 있다.
// 자바나 다른 언어의 null, nullable을 모든 자료형에 쉽게 적용할 수 있다.
// 옵셔널은 래핑하는 객체이며, enum으로 정의되어 있다.
// 옵셔널로 래핑된 변수는, 언래핑 해야 사용할 수 있으며, 이러한 언래핑 과정을 다양하게 지원한다.

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"

var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value

print(serverResponseCode as Any, type(of: serverResponseCode))

//
//var sss = serverResponseCode!
//print(type(of: sss))

/*
 12. nil
 */

// nil 은 값의 부재를 나타내는 키워드로 기본적으로 String 클래스가 nullable인
// 여타 언어에서와 달리 옵셔널이 아닌 개체는 값의 부재를 표현할 수 없다.
//var sssk : String? = nil  // 옵셔널을 지정해야 nil을 사용가능
var sssk : String? = "sdfsdfsdf"



/*
 13. If Statements and Forced Unwrapping
 */
// 옵셔널을 해제(언래핑) 하는 방법 중 하나로 강제적으로 해제 하는 방법이 있는데,
// if 구문과 같이 사용하여, nil 이 아닌경우와 nil인 경우의 분기를 만들어 처리할 수 있다.
// 강제 언래핑은 변수 뒤에 !를 붙여주면 된다.
if(sssk != nil){
    print("sssk: \(sssk!)")
}else{
    print("sssk is nil")
}


/*
 14. Optional Binding
 */
// optional binding 은 해당 값을 임의의 변수에 할당해보고 값이 있으면 해당 변수를 사용,
// 값이 없으면 else 구문을 수행하는 위의 nil 비교 후 강제 언래핑 부분에 변수를 binding 해준다는 것 빼고 다를 게 없다.
// if let <#바인딩 변수#> = <#옵셔널 변수#>{}else{} 를 사용하며 이를 통해 얻을 수 있는 구문상의 이점은
// 강제 언래핑과 다르게 if 구문 내에서 계속 느낌표를 붙여 옵셔널을 사용할 때마다 강제해제 하지 않아도 된다는 것이다.
if let variableName = sssk{
    print("sssk : \(variableName)")
}else{
    print("sssk is nil")
}

// 원래 옵셔널변수가 더이상 필요없다면 변수아름을 재사용 가능
// 단, if let 구문의 변수명은 지역변수(if문 내에서만 통용)
if let sssk = sssk{
    print(sssk, type(of: sssk))
}else{
    print("sssk is nil")
}
// 위의 경우를 간소화된 표현으로 더 줄일수 있다.

if let sssk{
    print(sssk, type(of: sssk))
}else{
    print("sssk is nil")
}

print(sssk as Any, type(of: sssk))

if var sssk{            // 옵셔널 바인딩 개체는 변수로도 사용 가능
    print(sssk, type(of: sssk))
    sssk = "hi"
    print(sssk, type(of: sssk))
}

/**
 여러 옵셔널 바인딩과 비교문을  if statement에 콤마(,)로 묶어서 사용할 수도 있다.
 이 경우 하나의 옵셔널 값이라도 nil이거나 if 구문이 false가 되면 if 문은 당연히 실행되지 않는다.
 */
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100, true==true {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"


if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"

/*
 15. Implicitly Unwrapped Optionals
 */

// 이런식의 강제 암묵적인 강제 형변환은 값이 nil인 경우 런타임 에러를 유발한다.
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation point


/*
 16. Error Handling
 */

// 아래와 같은 식으로 에러를 던진다는 것을 함수 선언/정의에 명시
func canThrowAnError() throws {
    // this function may or may not throw an error
}
func canThrowAnError2() throws {
    // this function may or may not throw an error
}
// 에러의 처리는 아래의 구문으로 처리
// try는 에러 쓰로잉 되거나 발생하는 가능성이 있는 구문 앞에 각각 붙여주면 된다.
func makeASandwich() throws {
    // ...
}
func eatASandwich(){
    
}
func washDishes(){
    
}
func buyGroceries(_ ingredients: String){
    
}
// 에러는 exception 개체를 상속받아 클래스를 정의하는 것과 비슷하게
// Error 프로토콜을 채택하여 enum으로 정의한다.
enum SandwichError : Error{
    case outOfCleanDishes
    case missingIngredients(String)
}

do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
// 그렇다면 에러를 발생시키려면 어떻게 해야 할까?
// 그냥 throw 구문으로 발생시키면 되고 클래스가 아니므로 생성할 필요가 없다.
// throw SandwichError.outOfCleanDishes // 에러 발생 구문



/*
 15. Assertions and Preconditions
 */
// Assertions 와 precondition는 런타임 환경에서의 예외를 처리하는 구문은 아니고,
// 개발과정에서 디버깅을 위하여 사용된다.

/*
 15.1 Debugging with Assertions
 */
let age = -3
//assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.
//
//if age > 10 {
//    print("You can ride the roller-coaster or the ferris wheel.")
//} else if age >= 0 {
//    print("You can ride the ferris wheel.")
//} else {
//    assertionFailure("A person's age can't be less than zero.")
//}


/*
 15.2 Enforcing Preconditions
 */

var index2 : Int = -1

// In the implementation of a subscript...
// precondition(index2 > 0, "Index must be greater than zero.")


