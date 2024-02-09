/*
 Protocols
 Define requirements that conforming types must implement.
 
 
 First, let’s look at the differences from Java’s interface.
 
 protocol VS interface
 
 protocol
    1. can only declare variable
    2. can include functions that do not necessarily need to be implemented by designating the functions as optional.
 interface :
    1. even can define(assign) (default)variable
    2. must implement all methods
 */


//MARK: - Protocol Syntax

protocol SomeProtocol {
    // protocol definition goes here
}

protocol FirstProtocol{
    
}

protocol AnotherProtocol{
    
}

struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}

class SomeSuperclass{
    
}

class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}

/*
 Note
 **implicit protocol** - not error
 Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double).
 */

//MARK: Protocol Syntax -



//MARK: - Property Requirements
// 프로토콜은 선언된 프로퍼티에 대해서 gettable settable을 반드시 지정해 주어야 한다.

// 인스턴스 프로퍼티 선언
protocol SomeProtocol_ {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
// 타입 프로퍼티 선언
protocol AnotherProtocol_ {
    static var someTypeProperty: Int { get set }
    static var someTypeProperty_: Int { get }
}

// read only
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"


protocol TestWriteOnly{
    var a : String { get }
//    var b : String { set } // error : impossible - 이러한 특성은 프로토콜 뿐만 아니라 클래스 스트럭트 모두 동일하다.
}

/*
 프로토콜은 따로 계산프로퍼티인지 저장프로퍼티인지 지정하지는 않지만, 선언된 제약조건에 의해서 몇가지 가능하지 않은 속성들이 특정된다.
 gettable, settable : can't be fulfilled by
                        1. constant stored property
                        2. read-only compute property
 gettable           : can be satisfied by any kind of property.
                      해당 프로토콜을 준수하는 클래스에서 getter 만 정의한 경우에만 read-only 가 된다.
                      프토토콜은 반드시 gettable, settable 여부를 정의해야 하는데, 모든 속성을 커버하는 정의가 반드시 필요하기 때문
 settable           : impossible - only settable property is not valid
*/

// gettable 로 지정된 속성은 자기 자신에 한해서 변경가능하다.
protocol ReadOnlyTest {
//    private var variable: String { get } // error : 'private' modifier cannot be used in protocols
    var variable: String { get }
    func addString(string : String)
}

class ReadOnlyTestClass : ReadOnlyTest{
    private var _variable: String
    var variable: String {
        get { self._variable }
    }
    
    func addString(string: String) {
        self._variable += string
    }
    
    init(){
        _variable = ""
    }
}

var testClass = ReadOnlyTestClass()
//testClass.variable = "sdf" // impossible : this property is read-only
testClass.addString(string: "added")
testClass.addString(string: " String")

print(testClass.variable)

// gettable 로 지정된 속성은 자기 자신에 한해서 변경가능하다.
//class ReadOnlyTestClass2: ReadOnlyTest{
//    var variable: String = ""
//    
//    func addString(string: String) {
//        self.variable = string
//    }
//    init(){
//    }
//    init(_ string:String){
//        self.variable = string
//    }
//}
//var test2 = ReadOnlyTestClass2("dfiggg")
//print(test2.variable)


class TestStaticProtocolProperty : AnotherProtocol_{
    static private var _someTypeProperty_: Int = 0
    static var someTypeProperty_: Int{
        get{
            self._someTypeProperty_
        }
    }
    
    static private var _someTypeProperty: Int = 0
    class var someTypeProperty: Int { // 계산 프로퍼티만 클래스 가능, static 으로 정의했어도 class 키워드의 타입 프로퍼티로 정의 가능
        get { self._someTypeProperty }
        set {
            self._someTypeProperty = newValue
        }
    }
    
    static func modTypeProperty(value : Int){
        _someTypeProperty_ = value
    }
}

TestStaticProtocolProperty.modTypeProperty(value: 30)
print(TestStaticProtocolProperty.someTypeProperty_)

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"


//MARK: Property Requirements -



//MARK: - Method Requirements

// 프로토콜은 매소드 요구사항을 정의 가능
// 본문없이 선언하여, 특정 형태의 매서드를 가지도록 정의할 수 있다.

protocol SomeProtocolMethod {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

//MARK: Method Requirements -



//MARK: - Mutating Method Requirements
// 만약 프로토콜에 mutating 키워드가 붙어있는 경우
// 이것을 준수하는 클래스에서는 mutating 키워드를 사용하지 않는다. (mutating 키워드만 삭제하고 구현해야 한다.)
// because 'mutating' keyword is only valid for structures & enumerations
protocol Togglable {
    mutating func toggle()
}

class TogglableClass : Togglable{
    func toggle() {
        print("implement just without 'mutating' keyword")
    }
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

//MARK: Mutating Method Requirements -



//MARK: - Initializer Requirements
// 프로토콜에서 선언된 initializer 는 무조건 required 키워드를 붙여서 정의해야 한다.
// 프로토콜에서 선언된 initializer 는 편의 이니셜라이저도 가능하고, 지정 이니셜라이저로도 가능하다.

// You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:
protocol SomeProtocol__1 {
    init(protocolParameter: Int)
}

protocol SomeProtocal__2{
    init(protocolParameter: String)
    init(protocolParameter: Int)
}

class SomeClass__: SomeProtocol__1, SomeProtocal__2 {
    required init(protocolParameter: Int) { // 이 required는 프로토콜에서 선언된 필수 이니셜라이저임을 명시
        // initializer implementation goes here
        print(protocolParameter)
    }

    required init(protocolParameter: String) { // 이 required 는 프로토콜에서 선언된 필수 이니셜라이저임을 명시
        print(protocolParameter)
    }
    
    required init(classParameter: String){ // 이 required 는 서브클래스에서 반드시 정의해야 하는 이니셜라이저임을 명시
        print("some class : \(classParameter)")
    }
    init(defaultName:String){
        
    }
    convenience init() {
        self.init(classParameter: "sds")
    }
    
    // 요약하자면 해당 프로토콜을 준수하도록 하기위하여 슈퍼클래스에서 required 키워드를 붙이도록 제약되는 것.
}

class SomeSubClass__: SomeClass__{
    init(){
        super.init(protocolParameter: "default")
    }
    
    required init(protocolParameter: String) {
        fatalError("init(protocolParameter:) has not been implemented")
    }
    
    required init(classParameter: String) {
        fatalError("init(classParameter:) has not been implemented")
    }
    
    required init(protocolParameter: Int) {
        fatalError("init(protocolParameter:) has not been implemented")
    }
    
    override init(defaultName: String) { // 생성자를 하나라도 정의하게 되면 상속을 받지 않으므로
                                         // 이 경우에는 overrid 하여 필요한 생성자를 재정의
        super.init(defaultName: defaultName)
    }
}

var s1 = SomeSubClass__(protocolParameter: 11)
var s2 = SomeSubClass__()
var s3 = SomeSubClass__(defaultName: "sdsd")

protocol SomeProtocol___ {
    init()
}

class SomeSuperClass___ {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass___: SomeSuperClass___, SomeProtocol___ {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// MARK: Failable Initializer Requirements
//

//MARK: Initializer Requirements -
