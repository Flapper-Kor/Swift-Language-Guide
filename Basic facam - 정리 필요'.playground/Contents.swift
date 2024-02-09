
// -----------------------------------------------------------------------------------------------------------------------------
// 아래는 공식문서의 내용이 아님 - 정리 필요

//1. 상수와 변수 ////////////////////////////////////////////
// 상수
// let 상수명 : 데이터 타입 = 값
//let a: Int = 100
//a = 200 //불가능 에러

// 변수
//var 변수명 : 데이터 타입 = 값

var b: Int = 100
b = 300

// ///////////////////////////////////////////////////////

// 2. 기본 데이터 타입 ///////////////////////////////////////
var int : Int = -100
var uint : UInt = 200
var float : Float = 1.1
float = 1

var double:Double = 3.0
double = 4

var bool:Bool = true
bool=false
//bool = 0  error

var char:Character = "가"
char = "n"

var string:String = "안녕하세요"
string = "hi"

// 타입 추론
var someVar = 100

var someVar2 = "hi my name is boolean false lee"
// ///////////////////////////////////////////////////////

// 3. 컬렉션 ///////////////////////////////////////////////

// Array
var numbers:Array<Int> = Array<Int>()
numbers.append(1)
numbers.append(2)
numbers.append(3)
numbers[0] = 2
numbers
numbers.insert(17, at: 2)
numbers.remove(at: 2)
numbers
numbers.count
//축약된 생성방법
var names:[String] = []
names.append("howl")

// Dictionary
var dict1:Dictionary<String, Int> = Dictionary<String, Int>()
//축약된 생성방법
var dict2:[String:Int] = [:]
// 생성과 함께 초기값 입력
var dict3:[String:Int] = ["flapper": 1]


dict2

dict1["flapper"] = 1
dict2["flapper"] = 1
dict3["kim"] = 30
dict3["flapper"] = 30

dict1
dict2
dict3

dict1.removeValue(forKey: "이희웅") // 반환값은 성공여부
dict1.removeValue(forKey: "howl")
/*
 nil 이란?
 ObjectC 에서 포인터에 대한 값의 부재를 Null로 표시하였고, 값의 부재에 대한 표현으로 nil을 사용하였는데 스위프트로 넘어오면서 포인터가 사라지고 nil이라는 표현만 남게 됨.
 null : objectC 랭귀지에서 포인터에 대한 값의 부재
 nil  : 특정 타입에 대한 값의 부재
 
 여타 객체지향 언어에서의 참조변수의 null, none등과는 조금 다른 개념
 
 None, Null 은 존재의 부재
 nil 은 값의 부재
 라고 이해하면 되겠으나....
 
 의미가 퇴색된듯....그냥 모두 같다고 보면 될듯
 */

dict1.count

// ///////////////////////////////////////////////////////

let k : Int = 7

print(k)

print("hi")

//var testChar:Character = as 65
//
//print(testChar is Int)
//
//testChar = Character(k)
//
//print(k)


// 4. function

func sum (a:Int, b:Int) -> Int{
    return a + b
}

sum(a : 5, b :4)

func hello () -> String{
    return "hello"
}

func greeting1() -> Void {
    print(hello)
}

func greeting2() {
    print("hi")
}


func greeting(friend:String, me:String) -> String{
    return "Hello \(friend) I'm \(me)"
}

greeting(friend:"bruce", me:"fahrenheit")
greeting(friend: "브루스", me: "페런하이트")

// 아래의 코드는 에러이다.
// 스위프트에서 기본적으로 argument lable을 써넣지 않으면 함수를 사용할 수 없다.
//greeting("bruce", "fahrenhiet")

// 전달인자 레이블의 재정의 사용
func sendmessage(from myName:String, to name:String) -> String{
    return("hello \(name) i'm \(myName)")
}
// 여기서 전달인자는 from, to 가 되고 이러한 방법을 사용하면 함수 사용자는 좀더 명확하고 직관적인 표현을 확인/사용할 수 있기 때문에 코드의 가독성이 높아진다.


var customerName:String = "jack"
sendmessage(from: "fahrenhiet", to: customerName)

// 전달인자를 사용하고 싶지 않을 때 와일드 카드 식별자를 사용할 수도 있다.
// 이렇게 하면 여타 다른 언어에서와 같이 함수를 사용할 수 있다.

func sendmessage(_ name:String) -> String{
    return("hello \(name)")
}

sendmessage("flapper")

// 가변 매개변수의 사용
// 가변 매개변수는 0개 이상의 값을 받아올 수 있고, 배열처럼 사용, 함수마다 하나만 사용 가능
// args

// 기존의 언어와 같이 함수의 제일 마지막 매개변수에만 정의 가능하지 않을까 생각했으나 매개변수 레이블 덕분에 처음이나 중간에 정의하여도 상관없음
func sendmessage(from me:String, to friends:String...) -> String {
    return "hello \(friends) I'm \(me)"
}

func sendmessage(to friends:String..., from me:String) -> String {
    return "hello \(friends) I'm \(me)"
}

// 그렇다면 매개변수 레이블을 와일드 카드로 사용하면 어떨까...
// 약간 혼란스러울 수 있는 사용이기 때문에 컴파일러가 에러를 내지 않을까?
// 아래는 에러 에러의 내용은 : A parameter following a variadic parameter requires a label

//func sendmessage(_ friends : String..., _ me : String) -> String {
//    return "hello \(friends) I'm \(me)"
//}

// 가변인자 다음에 오는 파라미터는 무조건 레이블을 필요로 한다.
// 즉, 다음과 같이 수정되어야 한다.

func sendmessage(_ friends : String..., from me : String) -> String{
    return "hello \(friends) i'm \(me)"
}
sendmessage("choi", "kim", "lee", "bruce", from: "fahrenheit")

sendmessage(from: "fahrenhiet", to: "kim", "choi", "stark")
sendmessage(to: "kim", "choi", "stark", from: "fahrenhiet")

// 5. 조건문
// if 조건문
var age = 8
if age < 19{
    print("미성년자입니다.")
}

if age < 19{
    print("미성년자입니다.")
}else{
    print("성년자입니다.")
}

var animal = "cat"

if animal == "dog"{
    print("강아지 사료 주기")
}else if animal == "cat"{
    print("고양이 사료 주기")
}else {
    print("해당하는 사료 없음")
}

// 위의 예제에서 사용한 것은 자바와 같은 객체지향 언어에서는 절대 하지 말아야 할 방법이다.
// 스위프트에서는 문자열 비교를 등호두개로 사용하는 듯...


//switch case 구문

var color = "green"
color = "gold"

switch color{
case "green" :
    print("초록색 입니다.")
case "blue":
    print("파란색 입니다.")
case "black":
    print("검은색 입니다.")
default:
    print("찾는 색상이 없습니다.")
}

// 범위연산자의 사용
let temperature = 0
switch temperature{
case ...0:
    print("춥습니다.")
case 0...30:
    print("적절합니다.")
default:
    print("덥습니다.")
}


// 6. 반복문
// for in, while, repeat while

//for 루프상수 in 순회대상{
//    ...
//}

for i in 1...4{
    print(i)
}

for i in ["kim", "choi", "lee"]{
    print(i)
}

var myList : Array<Int> = [11,2,3,4,5]
for entity in myList{
    
    print(type(of: entity), entity)
    entity+(entity+1)
}

//for i in Range(0, myList.count){
//    print(i)
//}


// 7. 옵셔널

// 값이 있을수도 있고 없을수도 있다.
// nil
// 모든 변수에 닐을 지정할 수는 없다. (문자열변수 등등)
// type 뒤에 물음표를 붙여서 옵셔널 타입으로 선언 가능

var name : String?

var optionalName : String? = "lee"

print(optionalName!)

//print(name as Any)
//var requireName : String = optionalName

// 8. 옵셔널 바인딩

var number : Int? = 3
print(number)
print(number!)  // 이렇게 optional을 강제로 해제하면 값이 nil 인 경우 프로그램 비정상 종료를 발생시킬수 있음

if let result = number{
    print(result)
}else{
    //값 추출이 실패할 경우의 코드블럭 실행
}


// 가드를 이용한 옵셔널 해제 (추후 확인)
func test(){
    guard let result2 = number else {
        // 값 추출 실패할 경우의 코드블럭
        return
    }
    print(result2)
}

// 묵시적 해제 : 비교연산자를 이용해 값을 비교할 경우 컴파일러가 자동으로 옵셔널 해제
let value : Int? = 6
if value == 6{
    //
}else{
    // 값이 다를 경우
}

//let myString
let myString = "12"
var stringToInt : Int! = Int(myString)
// 위의 방법은 값에 nil이 들어있을 경우 오류

// 9. 구조체와 클래스
struct User{
    var nickName : String
    var age : Int
    
    func printInfo(){
        print(self.nickName, self.age)
    }
}

var user = User(nickName: "heewoong", age: 20)
print(user)
user.nickName = "stark" // 타 언어에서 문자열 객체는 레퍼런스가 대체되고 참조변수가 없는 heewoong 인스턴스는 gc에 의해 처리된다.
                        // 여기서는?
print(user)

user.printInfo()

// 10. class
class Dog{
    var name:String = ""
    var age :Int = 0
    
    init(){
        
    }
    init(name:String){
        self.name = name
        self.age = 0
    }
    
    func introduce (){
        print("name : \(name) , age : \(age)")
    }
}
// 생성
var dog = Dog()
// 값 변경
dog.name = "Coco"
dog.age = 19

struct Stock {
    var averagePrice: Int
    var quantity : Int
    var puchasePrice : Int{
        get{
            return averagePrice * quantity
        }
        set(newPrice){
            averagePrice = newPrice / quantity
        }
    }
}

var stock :Stock = Stock(averagePrice: 2300, quantity: 15)
print(stock)
print(stock.puchasePrice)

stock.puchasePrice = 3200
print(stock.puchasePrice)
print(stock.averagePrice)
// 사용할 때 주의해야 할듯
// 나눗셈 들어가니깐 계산이 의도하지 않은 결과가 나올 수 있음
