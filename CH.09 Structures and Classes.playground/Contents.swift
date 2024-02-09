/*
 Structures and Classes
 
 스위프트에서는 개개의 클래스마다 별도의 파일을 만들 필요가 없다.
 단일 파일에서 구조체와 클래슬를 선언/정의 하고, 사용할 수 있다.
 
 클래스의 인스턴스를 호칭할 때, 오브젝트(object)라는 표현 대신, 스위프트에서는 보다 일반적인 instance(인스턴스)라는 표현의 사용을 지향한다.
 */

// MARK: - Comparing Structures and Classes
/*
 Structures and classes in Swift have many things in common. Both can:
 1. Define properties to store values (속성(저장변수) 정의)
 2. Define methods to provide functionality (함수 정의)
 3. Define subscripts to provide access to their values using subscript syntax (서브스크립드 정의)
 4. Define initializers to set up their initial state (이니셜라이저 정의)
 5. Be extended to expand their functionality beyond a default implementation (기능 확장을 위한 extend 사용 가능)
 6. Conform to protocols to provide standard functionality of a certain kind (특정 기능을 위한 프로토콜을 준수 / 구현)
    For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
 
 Classes have additional capabilities that structures don’t have:
 1. Inheritance enables one class to inherit the characteristics of another. (상속 가능)
 2. Type casting enables you to check and interpret the type of a class instance at runtime. (타입캐스팅, 인스턴스 타입 확인)
 3. Deinitializers enable an instance of a class to free up any resources it has assigned. (소멸자 정의 가능)
 4. Reference counting allows more than one reference to a class instance. (하나 이상의 참조를 가지는 인스턴스에 대해 레퍼런스 카운팅 가능)
    For more information, see Inheritance, Type Casting, Deinitialization, and Automatic Reference Counting. The additional capabilities that classes support come at the cost of increased complexity. As a general guideline, prefer structures because they’re easier to reason about, and use classes when they’re appropriate or necessary. In practice, this means most of the custom types you define will be structures and enumerations. For a more detailed comparison, see Choosing Between Structures and Classes.
 */

// MARK: Comparing Structures and Classes -

import SwiftUI

//MARK: - Definition Syntax
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
struct otherstruct : View{
    var body: some View{
        Text("sdfdf")
    }
}
struct otherclass : View{
    var body: some View{
        Text("sdfdf")
    }
}

var viewsrt : any View = otherstruct()
var viewcls : any View = otherclass()

// 저장 프로퍼티
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String? // 초기화 하지 않으면 nil 자동 대입
}

// 특별히 생성자를 만들지 않아도, 모든 저장프로퍼티에 대한 초기화가 이뤄지면,
// 디폴트 생성자는 컴파일러가 자동으로 생성

// structure : init(), init(memberwise)
// class     : init()

//MARK: Definition Syntax -



//MARK: - Structure and Class Instances

var someResolution = Resolution()
var someVideoMode = VideoMode()

//MARK: Structure and Class Instances -



//MARK: - Accessing Properties
someResolution.width = 1920; someResolution.height = 1080
someVideoMode.resolution.width = 3840; someVideoMode.resolution.height = 2160

print(someResolution)
print(someVideoMode.resolution)
//MARK: Accessing Properties -



//MARK: - Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)

// Unlike structures, class instances don’t receive a default memberwise initializer. Initializers are described in more detail in Initialization.
//MARK: Memberwise Initializers for Structure Types -



//MARK: - Structures and Enumerations Are Value Types
// Value Type (structure, enumeration)
// 값타입 변수들은 변수 상수에 할당되거나, 함수로 전달될 때 값이 복사되는 유형

var hd = Resolution(width: 1920, height: 1080) // structure
var cinema = hd
cinema.width = 3840; cinema.height = 2160
print(hd, cinema)

var otherVideo = someVideoMode // class
otherVideo.frameRate = 180
print(someVideoMode.frameRate, otherVideo.frameRate)

// 값타입과 참조타입의 차이점은 C언어의 그것(struct, allocated pointer) 와 동일시 하면 된다.



// enum
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
var rememberedDirection = currentDirection
currentDirection.turnNorth()


print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"

// 위와 같은 특성은 함수에 매개변수로 전달되는 경우에도 동일하며,
func res(resolution : Resolution){
    print(resolution)
//    resolution.width = 5000 // 값타입으로 복사되어 전달되는 structure는 애초에 let(상수)로 전달되어 변경이 불가
}
res(resolution: someResolution)
print(someResolution)


func vid(videoMode : VideoMode){
    print(videoMode)
    videoMode.resolution.width = 5000 // 참조타입인 class는 값의 변경이 가능하고, 변경 시 원본의 값을 변경
}
vid(videoMode: someVideoMode)
print(someVideoMode.resolution)


// 아래는 참고 :
//            inout 키워드를 사용하여 파라미터 타입을 정의하면, struct도 참조호출이 가능하다.
//            사용시에는 &를 사용하여 레퍼런스 변수임을 표시
//            요약 : inout keyword is * in C, & is & in C

func res(resolution : inout Resolution){
    print(resolution)
    resolution.width = 5000 // 값타입으로 복사되어 전달되는 structure는 애초에 let(상수)로 전달되어 변경이 불가
}
res(resolution: &someResolution)
print(someResolution)

//MARK: Structures and Enumerations Are Value Types -



//MARK: - Classes Are Reference Types

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"

//MARK: Classes Are Reference Types -


//MARK: - Identity Operators
// 인스턴스 비교를 위해서는 ===, !== 두가지를 사용하여 비교한다.

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

//// 인스턴스 비교 연산자이므로, struct 나 기타 자료형들에 대해서는 컴파일 에러
//if(someResolution === vga){
//    print("eq")
//}
//
//var i : Int = 10
//var j : Int = 20
//if ( i === j ){
//    print("eq aaa")
//}






//MARK: Identity Operators -



//MARK: - Pointers

// 기본적으로 스위프트에서 사용하는 참조변수들은 포인터와 유사하게 동작하지만, 직접적인 메모리 접근은 아니며, asterisk를 사용하지 않아도 된다는 것을 알 수 있다.
// 포인터와 버퍼 types 를 사용하려는 경우. 직접 메모리 접근에 대한 메뉴얼을 참조.
// https://developer.apple.com/documentation/swift/manual-memory-management

//MARK: Pointers -
