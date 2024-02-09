/*
 Macros (Swift 5.9 부터 도입)
 
 Use macros to generate code at compile time.
 
 Swift has two kinds of macros:
    1. Freestanding macros appear on their own, without being attached to a declaration. (독립매크로 - 선언에 첨부되지 않음)
    2. Attached macros modify the declaration that they’re attached to. (첨부 매크로 - 자신이 첨부된 선언을 수정)
 */

import Foundation

//MARK: - Freestanding Macros

// To call a freestanding macro, you write a number sign (#) before its name, and you write any arguments to the macro in parentheses after its name. For example:
// 독립 매크로 이름 앞에 #을 붙여서 호출

func myFunction() {
    print("Currently running \(#function)") // 표준 라이브러리의 #function : 현재함수의 이름
    #warning("Something's wrong")           // 표준 라이브러리의 #warning  : 사용자 지정 컴파일 경고 생성
}
myFunction()

//MARK: Freestanding Macros -



//MARK: - Attached Macros

//struct SundaeToppings: OptionSet {
//    let rawValue: Int
//    static let nuts = SundaeToppings(rawValue: 1 << 0)
//    static let cherry = SundaeToppings(rawValue: 1 << 1)
//    static let fudge = SundaeToppings(rawValue: 1 << 2)
//}
//
//print(SundaeToppings.nuts)
//print(SundaeToppings.cherry)
//print(SundaeToppings.fudge)

//@OptionSet<Int> // 표준 라이브러리에 있는 @optionSet : 열거형에 케이스의 목록을 읽고 각 옵션에 대한 상수 목록을 생성하고 OptionSet 프로토콜의 준수성을 추가
//struct SundaeToppings {
//    private enum Options: Int {
//        case nuts
//        case cherry
//        case fudge
//    }
//}

// 아래의 코드와 동일한 결과를 위의 매크로로 대체할 수 있다.
//struct SundaeToppings {
//    private enum Options: Int {
//        case nuts
//        case cherry
//        case fudge
//    }
//
//    typealias RawValue = Int
//    var rawValue: RawValue
//    init() { self.rawValue = 0 }
//    init(rawValue: RawValue) { self.rawValue = rawValue }
//    static let nuts: Self = Self(rawValue: 1 << Options.nuts.rawValue)
//    static let cherry: Self = Self(rawValue: 1 << Options.cherry.rawValue)
//    static let fudge: Self = Self(rawValue: 1 << Options.fudge.rawValue)
//}
//extension SundaeToppings: OptionSet { }

//MARK: Attached Macros -



//MARK: - Macro Declarations

//public macro OptionSet<RawType>() =
//        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")

//MARK: Macro Declarations -


//let magicNumber = #fourCharacterCode("ABCD")
