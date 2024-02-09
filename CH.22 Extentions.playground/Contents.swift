/*
 Extensions
 
 Add functionality to an existing type. (기능의 확장)
 
 Extensions in Swift can:
     Add computed instance properties and computed type properties (계산속성의 추가)
     Define instance methods and type methods                      (메서드의 추가)
     Provide new initializers                                      (이니셜라이저의 추가)
     Define subscripts                                             (첨자구문 추가)
     Define and use new nested types                               (중첩타입의 추가)
     Make an existing type conform to a protocol                   (프로토콜을 준수하도록 추가)
 
 
     Note
     Extensions can add new functionality to a type, but they can’t override existing functionality.
     상속과 관련된 행위들은 확장이 아닌 클래스 자체에 정의하도록 한다.
     상속 및 오버라이드는 extension 에서 할 수 없다.
 */

//MARK: - Extension Syntax

class superType {
    func add(){
        
    }
}

class SomeType{
    // new functionality to add to SomeType goes here

}

protocol SomeProtocol{
    
}

protocol AnotherProtocol{
    
}

extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}

//     상속 및 오버라이드는 extension 에서 할 수 없다.
//extension SomeType :superType{ // impossible : Inheritance from non-protocol type 'superType'
//    override func add(){  // impossible : Method does not override any method from its superclass
//
//    }
//}


/*
 Note
 If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 
 익스텐션이 정의되는 순서에 상관없이, 모든 인스턴스는 사용 가능하다.
 
 */
//MARK: Extension Syntax -



//MARK: - Computed Properties

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"


/*
 Note
 Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.
 
 익스텐션에서는 기본적으로 상속 관련된 키워드를 사용하면 에러인데,
 옵저버 추가 또한 override 키워드를 사용하는 항목이므로 불가능하다고 생각하면 쉽다.
 */

import Foundation

class superBubble{
    var count:Int = 0
}

class bubble: superBubble{
    
}

//extension bubble{
//    override var count: Int { // error
//        willSet{
//
//        }
//    }
//}

//MARK: Computed Properties -



//MARK: - Initializers
// can add new initializers
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

/*
 Note
 If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
 */

//MARK: Initializers -



//MARK: - Methods

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}
// Hello!
// Hello!
// Hello!

//MARK: Mutating Instance Methods
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9

// extension 에서 정의된 메서드에서 self 프로퍼티 등을 변경할 수 있으며, 경우에 따라 mutating 키워드를 사용한다.

//MARK: Methods -



//MARK: -Subscripts

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7
//MARK: Subscripts -


//MARK: - Nested Types

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "


/*
 Note
 number.kind is already known to be of type Int.Kind. Because of this, all of the Int.Kind case values can be written in shorthand form inside the switch statement, such as .negative rather than Int.Kind.negative.
 
 */
//MARK: Nested Types -



















// 공식문서 내용 업데이트 필요




// ------------------------------------------------------------------------------------------------------------------------
// 아래 내용은 공식문서 내용이 아님
/*
 Extension 이란
 기존의 클래스, 구조체, 열거형, 프로토콜에 새로운 기능을 추가하는 기능
 1. 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
 2. 타입 메서드 / 인스턴스 메서드
 3. 이니셜라이저
 4. 서브스크립트
 5. 중첩타입
 6. 특정 프로토콜을 준수할 수 있도록 하는 기능 추가
 */

/* 사용 예 */

/*
extension someType {
    // 추가 기능
}
 */

extension Int{
    var isEven: Bool{
        return self % 2 == 0
    }
    var isOdd: Bool{
        return self % 2 == 1
    }
}

var number = 3
number.isOdd
number.isEven

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
}

var string = "101"

var x = string.convertToInt()
var b = Int(string)
