/*
 리터럴(문자열 상수) 표기
 */

let someString = "Some string literal value"

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

// 멀티라인에서 줄바꿈을 할 경우 실제 문자열에 \n 삽입되는 결과
// 이를 원치 않을 경우 아래워 같이 백슬래시를 사용하여 줄바꿈이 아님을 표기

// 멀티라인 규칙1. 첫 라인은 """ 다음에 바로 엔터
// 멀티라인 규칙2. 마지막 따옴표 """ 보다 앞선행은 없어야 한다.
fffff = """
multiline Test
이게 맞나 싶다.
"""
print(fffff)

var fffff = """
multiline Test \
이게 맞나 싶다.
"""
print(fffff)


fffff = """
    1)
        sdfsdf
            multiline Test.
            이게 맞나 싶다.
    """ // 닫는 따옴표를 기준으로 들여쓰기의 기준을 정하여 공백을 무시함 ( 닫는 따옴표보다 앞에 있는 문자가 있으면 에러를 뱉음
print(fffff)


/*
 Special Characters in String Literals
 */

/*
 The escaped special characters
 \0 (null character),
 \\ (backslash),
 \t (horizontal tab),
 \n (line feed),
 \r (carriage return),
 \" (double quotation mark) and
 \' (single quotation mark)
 
 An arbitrary Unicode scalar value, written as \u{n}, where n is a 1–8 digit hexadecimal number
 */

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

// 특수 문자의 경우 백슬래시로 이스케이핑
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""

/*
 Extended String Delimiters
 */

var ExtendedStringDelimiters = #" 이 안에 있는 모든것은 /n // /0 /""""""""""" """하지 않음 "#
print(ExtendedStringDelimiters)


ExtendedStringDelimiters = #"""
        이 안에 있는
        모든 것은 /n //
        /0 /"""""""""
        "" """하지 않음
        """#

print(ExtendedStringDelimiters)


/*
 Initializing an Empty String
 */

// 빈 문자열 생성
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other

if emptyString.isEmpty {
    print("Nothing to see here")
}
if anotherEmptyString.isEmpty {
    print("Nothing to see here")
}


/*
 String Mutability
 */
// String 이 class로 생성되는 다른 것들과 달리 문자열에 nil 허용하지 않음
// let 은 수정불가 var 는 수정 가능


var variableString = "Horse"
variableString += " and carriage"

print(variableString)
print(type(of: variableString))
print(variableString.count)
print(variableString.utf8)

import Foundation
var nsstring: NSString = "이것은 NSString"
var nsmutablestring : NSMutableString = "이것은 NSMutableString"

print(nsstring, type(of: nsstring))
print(nsmutablestring, type(of: nsmutablestring))


/*
 String are Value Types
 */
// 문자열은 값타입의 struct로 상속불가하며, call by value 로 동작한다.

// 값을 변경하려면 이렇게 넘겨줘야 가능
var string : String = " 안녕 "
func stringChange( _ string : inout String){
    string += " 하세요 ??"
}
stringChange(&string)
print(string)

// 문자
let exclamationMark: Character = "!"

for character in "Dog!🐶" {
    print(character, " ::: ", type(of: character))
}

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
print(catCharacters, " ::: ", type(of: catCharacters))

let catString = String(catCharacters)
print(catString, type(of: catString))


/*
 concatenating
 */
// + 연산, append 함수 사용

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

welcome.append(exclamationMark)


/*
 String Interpolation
 */

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"

print(#"Write an interpolated string in Swift using \(multiplier)."#)
// Prints "Write an interpolated string in Swift using \(multiplier)."

print(#"6 times 7 is \#(6 * 7)."#)
// Prints "6 times 7 is 42."


/*
 Extended Grapheme Clusters
 */
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by
// eAcute is é, combinedEAcute is é

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed is 한, decomposed is 한

let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute is é⃝

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS is 🇺🇸


/*
 counting Characters
 */

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// Prints "unusualMenagerie has 40 characters"

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in cafe is 4"


word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301


print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"


/*
 Accessing and Modifying a String
 */

var greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
var index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a

var sss = "hi"
//print(sss[1]) 이런거 안됨

// 범위 넘는것은 당연히 에러
//greeting[greeting.endIndex] // Error
//greeting.index(after: greeting.endIndex) // Error


for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
print("")
//print("안녕하세요", terminator: "/t")

/*
 Insert and Removing
 */
// endIndex는 hello_ 와 같이 문장 마지막에 있는 커서 위치와 같음.

welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"



welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"

welcome += "?"
print(welcome[range.lowerBound])


/*
 Substrings
 */

greeting = "Hello, world!"
index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)

print(beginning, type(of: beginning))
print(newString, type(of: newString))

// Both String and Substring conform to the StringProtocol protocol,
// which means it’s often convenient for string-manipulation functions to accept a StringProtocol value.
// You can call such functions with either a String or Substring value.

// 둘다 스트릴 프로토콜을 준수하므로 이 프로토콜을 허용하는 함수내에서 비교 없이 사용가능하다고 한다.
// 하지만 다른 타입이기 때문에 주의해서 사용해야 할듯.

// 스트링 연산을 하는 경우 앞선 것의 타입에 따라간다.
var combined1 = beginning + newString
var combined2 = newString + beginning

print(combined1, type(of: combined1))
print(combined2, type(of: combined2))


// 컴파일러가 이상한 부분을 감지해서 알아서 알려줘서 크게 문제될 것은 없을 듯...;;;
if(combined1 is String){ //Cast from 'String.SubSequence' (aka 'Substring') to unrelated type 'String' always fails
    print("응스트링이야") // Will never be executed
    
}else{
    print("응아니야")
}

/*
 Comparing Strings
 */

/*
 String and Character Equality
 */
// 문자열 비교는 == 인스턴스 비교는 ===

var quot = "We're a lot alike, you and I."
var sameQuot = "We're a lot alike, you and I."
if quot == sameQuot {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"

// Extended grapheme clusters are canonically equivalent
//      if they have the same linguistic meaning and appearance,
//      even if they’re composed from different Unicode scalars behind the scenes.
// --> is means,

// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

// 조합으로 완성되는 경우, 완성된 최종 결과가 동일하면 같음.
// 반면 라틴(영어) A와 러시아어 A는 시각적으로 같으나 동일하지 않음.
// 결국 최종 형태의 유니코드를 비교한다는 말인듯

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters aren't equivalent.")
}
// Prints "These two characters aren't equivalent."


/*
 Prefix and Suffix Equality
 */
// 접두사와 접미사 : hasPrefix(), hasSuffix()


let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"



var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"

// MARK: - The hasPrefix(_:) and hasSuffix(_:) methods perform a character-by-character canonical equivalence comparison
// MARK:   between the extended grapheme clusters in each string, as described in String and Character Equality.

// 포함여부
var count = 0
for scene in romeoAndJuliet {
    if scene.contains("scene"){
        count += 1
    }
}
print(count)



/*
 Unicode Representation of Strings
 */

let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 55357 56374 "

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 128054 "


for scalar in dogString.unicodeScalars {
    print("\(scalar) ", terminator: "")
}
