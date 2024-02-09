//구조체와 클래스의 차이

// 클래스 : 참조타입, ARC로 메모리를 관리, 상속이 가능,
// 구조체 : 값타입, 상속 불가능

class SomeClass{
    var count :Int = 0
}

struct SomeStruct {
    var count:Int = 0
}

var class1 = SomeClass()
var class2 = class1
var class3 = class1

class3.count = 2

class1.count
class2.count
class3.count

var struct1 = SomeStruct()
var struct2 = struct1
var struct3 = struct1

struct2.count = 3
struct3.count = 4

struct1.count
struct2.count
struct3.count


// 생성 하지 않아도 사용할 수 있는 구조체변수(in C/Cpp) 처럼 동작
// 스택 영역에 값이 저장되어 있음 (값 타입)
// 구조체를 사용할 때 주의할 점 : 인스턴스 생성 형태의 구문을 사용해야 한다는 것이다. (선언만으로 사용 불가)
//var struct4:SomeStruct
//struct4.count

var struct4 = SomeStruct()
struct4.count

// 반면 클래스는 보통의 클래스와 동일하고 소멸자(deinit)를 가질 수 있고,
// ARC(Automatic Reference Counting)로 메모리를 관리한다.
// GC 와의 차이점 : ARC는 컴파일 타임에 적절하게 해제시점을 정의. 레퍼런스 감소 코드를 삽입하여 줌
//               GC는 런타임 메모리 관리 기법임
