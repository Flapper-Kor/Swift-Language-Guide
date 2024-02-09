// 프로토콜 : 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진
// 인터페이스와 유사

// EX )
// definition
//protocol Name{
//
//}

protocol SomeProtocol1{
    
}
protocol SomeProtocol2{
    
}
struct SomeStruct : SomeProtocol1, SomeProtocol2{
    
}

protocol FirstProtocol {
    var name : Int { get set } // 읽기 쓰기
    var age: Int { get } // 읽기전용
}

protocol AnotherProtocol {
    static var someTypeProperty : Int{ get set }
}


protocol FullyNames{
    var fullName:String { get set }
    func printFullName()
}

struct Person: FullyNames{
    var fullName: String
    func printFullName() {
        print(fullName)
    }
}

protocol SomeProtocol3{
    func someTypeMethod()
}
protocol SomeProtocol4{
    init(somemParameter: Int)
}
protocol SomeProtocol5{
    init()
}

class SomeClass: SomeProtocol5{
    // 클래스에서는 생성자 요구사항을 충족하려면 required 식별자 필요
    required init() {
//        print("hi")
    }
}
