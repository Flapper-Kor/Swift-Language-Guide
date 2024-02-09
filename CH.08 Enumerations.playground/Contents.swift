//--------------------------------------------------------------------
//  열거형 (enumerations)
/*
 열거형 (enum)
 연관성이 있는 항목들을 묶어놓은 것을 말함
 상수화하여 특정 프로퍼티 집합이 가질 수 있는 값의 묶음을 정의할 때 유용하게 사용
 */

//MARK: - Enumeration Syntax

// declaration
enum CompassPoint{
    case north
    case south
    case east
    case west
}
//Multiple cases can appear on a single line, separated by commas:
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// Using...
var direction = CompassPoint.north


direction = .north //컴파일러가 타입추론을 통해 . 입력만으로 변수범위를 지정해준다
// direction = CompassPoint.north

print(direction, type(of: direction))

switch direction{
case .north :
    print("north")
case .south :
    print("south")
case .east :
    print("east")
case .west :
    print("west")
}

// Matching Enumeration Values with a Switch Statement

direction = .north
switch direction{
case .north :
    print("선택된 방향은 북쪽 방향입니다.")
case .south :
    print("선택된 방향은 남쪽 방향입니다.")
case .east :
    print("선택된 방향은 동쪽 방향입니다.")
case .west :
    print("선택된 방향은 서쪽 방향입니다.")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
//MARK: Enumeration Syntax -



//MARK: - Iterating over Enumeration Cases

/*
 아래부터는 클로저와 고차함수에 대한 코드가 포함되어 있으므로 간단하게 클로저와 고차함수를 학습한 뒤 볼 것
 */

/*
 열거형의 반복 (iterate in enum) & 열거형을 리스트[배열]로 (enum to Array[list])
 스위프트 버전 4.2(Xcode 10) 이후의 버전부터는 아래와 같이 CaseIterable 프로토콜을 상속받아 반복적으로 값을 출력하여 확인해볼 수도 있다.
 */

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

for beverage in Beverage.allCases {
    print(beverage, type(of: beverage))
}
// coffee
// tea
// juice

enum Numeric_iterable : Int, CaseIterable{
    case zero = 0,
    one,
    two,
    three,
    four
}

for val in Numeric_iterable.allCases{
    print(val.rawValue)
}

//MARK: Iterating over Enumeration Cases -



//MARK: - Associated Values
/*
 연관값(Associated Value) :
    모든항목이 동일한 연관값을 가질 필요는 없음
    하나의 항목은 여러개의 연관값을 가질 수 있음
 */

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 연관값을 지정하였으면 반드시 값을 입력하여 사용해야 한다.
//var productBarcode : Barcode = .upc // 에러

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//productBarcode = Barcode.upc(8, 85909, 51226, 3)
// enum 을 잘 활용하면 굳이 딕셔너리를 사용하지 않아도 되는 상황이 많이 있을 듯.


// 연관값을 추출(case 문 내에서 상수 혹은 변수로 사용 가능)
switch productBarcode {
case .upc(var numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    numberSystem = 19
    productBarcode = .upc(numberSystem, manufacturer, product, check)
    print(productBarcode)
    
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

// If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single let or var annotation before the case name, for brevity:

// 만약 모든 연관값들이 추출되는 경우에는 case name 앞에 let 이나 var 를 추가하여 간결하게 추출할 수 있다.
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."


enum PhoneError{
    case unknown
    case batteryLow(String)
}

// 연관상수의 정의
let error = PhoneError.batteryLow("배터리가 곧 방전됩니다.")

// 연관값의 추출
switch error{
case .batteryLow(let message) :
    print(message)
    break
case .unknown :
    print("알수 없는 에러입니다.")
}

//MARK: Associated Values -



//MARK: - Raw Values

// 연관값(Associated Value)과 원시값(Raw Value)의 차이는
// 생성할 때 값이 지정되는지 (Associated Value)
// 선언 및 정의할 때 값이 지정되는지 (Raw Value)

// Associated Value(연관값) 은 인스턴스의 변수 개념에 가깝고, 생성되는 변수마다 서로 다른 값을 가질 수 있다.

// 여러 언어에서의 enum이 갖는 고유값과 가까운 형태는 raw Value 이다.

enum ex1 {
    case EAST, WEST, NORTH, SOUTH
}

enum ex2 {
    case EAST
    case WEST
    case NORTH
    case SOUTH
}

// enum 자체가 Integer 값을 가지고 자동 인덱싱 되는 C언어와 달리
// 기본적으로 원시값 타입을 지정하지 않을 경우 Integer로 자동 인덱싱 되지 않는다.

// 인티저가 아니므로 아래의 연산은 수행 불가
//print(ex2.EAST + ex2.WEST)

// 원시값은 enum 자체가 가진 고유의 값으로 타입을 지정해서 사용할 수 있다.
print(ex2.EAST)
print(type(of: ex2.EAST))
//print(ex2.EAST.rawValue)          // 에러

// 아래와 같이 rawvalue 타입을 지정할 수 있다.
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum ex3: String{
    case DEFAULT = "default"
    case CLOUD = "systemName.cloud.fill"
    case SQUARE = "systemName.square.fill"
}

print(ex3.CLOUD.rawValue)
print(type(of: ex3.CLOUD.rawValue))


// Implicitly Assigned Raw Values

/*
 로우 타입을 지정하고 정의하지 않았다면,
 String 은 각 열거형의 네이밍을 그대로 String으로 변환하여 저장하고
 Int 는 각 열거형의 순서대로 0 부터 증가하여 저장하고,
 Float 은 각 열거형의 순서대로 0.0 부터 1씩 증가하여 저장한다.
*/
enum ex4:Float{
    case DEFAULT
    case CLOUD
    case SQUARE
}

print(ex4.CLOUD.rawValue)

print(type(of: ex4.CLOUD.rawValue))

// enum의 Type을 지정하여 사용하고자 할 때는
// 아래와 같이 typealias를 사용하여 정의한다.
typealias BGImage = ex4

//하지만 굳이 typealias를 하지 않더라도 enum의 이름으로 type이 define되어 있다.
var x : ex4?
print(ex3.DEFAULT is ex4)


// 열거형 값의 자동대입 (아래와 같은 용법으로 여타 언어에서의 자동증가값 대입을 사용가능
// (타입을 지정해야 한다는 것과, case 키워드를 사용하는 것만 차이남)
enum Numeric : Int{
//    case zero = 0,
//    one,
//    two,
    case three = 3,
    four
}
print(Numeric.four.rawValue)

// 스위프트에서는 열거형에 정수 뿐만 아니라 다양한 형태의 값을 지정할 수 있다.
enum CompassPointInt : Int{
    case north = 0
    case south = 180
    case east = 90
    case west = 270
}

enum CompassPointString : String{
    case north = "북"
    case south = "남"
    case east = "동"
    case west = "서"
}
let direction2 = CompassPointString(rawValue: "남")
type(of:direction2)

var directionHex = CompassPointInt.north
var directionString = CompassPointString.east

print(directionHex.rawValue)
print(directionString.rawValue)


//Multiple cases can appear on a single line, separated by commas:
enum Planet2 :Int{
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// Initializing from a Raw Value
let possiblePlanet = Planet2(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus
print(possiblePlanet as Any, type(of: possiblePlanet))

//The raw value initializer is a failable initializer, because not every raw value will return an enumeration case. For more information, see Failable Initializers.
// 위와 같이 원시값 이니셜라이저를 사용하여 enum을 생성하는 경우 생성에 실패할 수 있다.
let pl = Planet2(rawValue: 11)
print(pl as Any, type(of: pl))


let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"

//MARK: Raw Values -


//MARK: - Recursive Enumerations
// A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.

// 다른 enum 인스턴스의 값을 Associated Value(연관값/관련값)으로 포함하는 enum.
// indirect 키워드로 재귀열거 값임을 나타낸다.


// The code below shows the ArithmeticExpression recursive enumeration being created for (5 + 4) * 2
// (5 + 4) * 2 를 표현함.
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))


// 위와 같은 재귀적인 데이터 구조를 가진 enum을,
// 아래와 같이 재귀함수에 활용할 수 있다.
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"

// 이미 enum으로 유한한 호출이 보장되면 보다 안전하게 재귀호출을 사용할 수 있다.


// enum 은 생성자 및 함수를 가질 수 있으므로 메서드의 정의도 가능하다.
// 가급적이면 extention 으로 기능을 확장하여 관리하는 것이 enum 본질을 유지하고 확장기능을 수정하고 변형하기에 용이하려나?

extension Numeric_iterable {
    
    static func ToArray() -> Array<Numeric_iterable>{
        return Numeric_iterable.allCases.map {$0}
    }
    
    static func ToArray_Rawvalues() -> Array<Int>{
        // return array of the all rawvalues in the enum
        return Numeric_iterable.allCases.map {$0.rawValue}
    }
    
    static func ToDict() -> Dictionary<Numeric_iterable, Int>{
        return Dictionary(uniqueKeysWithValues: zip(Numeric_iterable.allCases.map {$0}, Numeric_iterable.allCases.map{$0.rawValue}))
    }
}

//print(Numeric_iterable.ToArray(), type(of: Numeric_iterable.ToArray()))
//print(Numeric_iterable.ToDict(), type(of:Numeric_iterable.ToDict()))

// 확장한 기능의 사용
//for val in Numeric_iterable.ToArray(){
//    print(val, type(of: val))
//}

for val in Numeric_iterable.ToDict(){
    print(val.key, "(", type(of: val.key), ")", val.value, "(", type(of: val.value), ")")
}

// 다른 언어처럼 jar 나 dll 같이 라이브러리 형식으로 관련 에러나 프로토콜을 제공한다면, 주석만큼이나 참고할만한 기능이 될지도.

var dict = Numeric_iterable.ToDict()
dict[Numeric_iterable.four]
dict.count
//: [Next](@next)

