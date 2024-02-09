/*
 Optional Chaining
 
 Access members of an optional value without unwrapping.
 (설명 자체가 unwrapping 없이 옵셔널 값의 멤버에 액세스 하세요 이다)
 */

//MARK: - Optional Chaining as an Alternative to Forced Unwrapping
/*
 The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil.

 옵셔널 체이닝의 결과는 forced unwrapping 과 달리 런타임 에러를 유발하지 않고, 최종 체이닝 결과는 옵셔널이다.
 
 */
class Person_ {
    var residence: Residence_?
}


class Residence_ {
    var numberOfRooms = 1
}

let john = Person_()
//let roomCount = john.residence!.numberOfRooms     // this triggers a runtime error


if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."


john.residence = Residence_()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."

//MARK: Optional Chaining as an Alternative to Forced Unwrapping -



//MARK: - Defining Model Classes for Optional Chaining

class Person {
    var residence: Residence?
}

class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { print("Room(\(name)) 생성"); self.name = name }
}

class Address : CustomStringConvertible{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    init(buildingName: String? = nil, buildingNumber: String? = nil, street: String? = nil){
        print("Address 생성자 호출")
        
        self.buildingName = buildingName
        self.buildingNumber = buildingNumber
        self.street = street
    }
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
    var description: String{
        """
        \(type(of: self)) {
            buildingName : \(self.buildingName ?? "nil")
            buildingNumber : \(self.buildingNumber ?? "nil")
            street : \(self.street ?? "nil")
        }
        """
    }
    
    func getDes() -> String{
        return self.description
    }
    
    func setDefault(){
        self.buildingName = "kk"
        self.buildingNumber = "1"
        self.street = "k"
    }
}

//MARK: Defining Model Classes for Optional Chaining -



//MARK: - Accessing Properties Through Optional Chaining

let johnWick = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."


let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
johnWick.residence?.address = someAddress // residence 가 nil 이므로, 이 구문은 성공하지 못한다.

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}

johnWick.residence?.address = createAddress() // residence 가 nil 이므로, 이 구문은 성공하지 못한다.

print("존윅 :", johnWick.residence?.address as Any)

/*
 **중요**
 위의 예제에서 "function was called." 가 출력되지 않는 이유는
 할당하는 과정 또한 옵셔널 체이닝의 일부이며, 등호의 오른쪽 부분이 산정/평가되지 않는다(none of the code on the right-hand side of the = operator is evaluated) 라고 써있는데, 수행되지 않는다고 이해하면 된다.
 
 옵셔널 체이닝을 사용한 변수에 할당할 경우, 할당 주체가 최종적으로 nil 인 경우 할당될 값을 계산하지 않는다. 라고 보면 된다.
 */

// 위의 address 할당 구문을 첫번째 예를 아래와 같이 바꿔보면, Address 생성자조차 호출하지 않는다.
johnWick.residence?.address = Address(buildingNumber: "29", street: "Acacia Road")



//MARK: Accessing Properties Through Optional Chaining -



//MARK: - Calling Methods Through Optional Chaining

if johnWick.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."


//MARK: Void?
// 옵셔널 체이닝을 통한 속성에 값을 할당하는 경우. 할당 구문 자체는 Void? 이라는 특수한 반환타입을 가진다.
// 값이 없는 것을 옵셔널로 래핑(?!!) 한다는 의미인데,
// 비어 있는 옵셔널을 반환하거나(할당이 성공), nil을 반환(할당이 실패)하거나 둘중 하나라는 말인데,

// 개념은 좀 이상하고 어렵지만,
// 아래와 같이 활용할 수는 있다.

if (johnWick.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."

//MARK: Calling Methods Through Optional Chaining -



//MARK: - Accessing Subscripts Through Optional Chaining

if let firstRoomName = johnWick.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."

johnWick.residence?[0] = Room(name: "Bathroom") // 할당실패, residence가 nil이므로, Room 또한 생성되지 않음

if let firstRoomName = johnWick.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}


let johnWicksHouse = Residence()
johnWicksHouse.rooms.append(Room(name: "Living Room"))
johnWicksHouse.rooms.append(Room(name: "Kitchen"))
johnWick.residence = johnWicksHouse

print((johnWick.residence?[1] = Room(name: "Bathroom")) as Any) // 여기서는 할당 성공
print(johnWick.residence?[1].name as Any)

if let firstRoomName = johnWick.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."


//MARK: Accessing Subscripts of Optional Type
// If a subscript returns a value of optional type — such as the key subscript of Swift’s Dictionary type — place a question mark after the subscript’s closing bracket to chain on its optional return value:
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]

//MARK: Accessing Subscripts Through Optional Chaining -



//MARK: - Linking Multiple Levels of Chaining

/*
 옵셔널 체이닝은 위에서 이야기 했듯, 여러 체이닝의 결과로써, 무조건 옵셔널의 값을 반환한다.
 또한 이러한 반환 옵셔널은 중첩되지 않는다.
 
 결과는 nil 이거나 (값에 엑세스 실패), optional(type) 이거나 (값에 엑세스 성공) 두가지 뿐이다.
 */


if let johnsStreet = johnWick.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."


let johnWicksAddress = Address()
johnWicksAddress.buildingName = "The Larches"
johnWicksAddress.street = "Laurel Street"
johnWick.residence?.address = johnWicksAddress


if let johnWicksStreet = johnWick.residence?.address?.street {
    print("John's street name is \(johnWicksStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "John's street name is Laurel Street."

//MARK: Linking Multiple Levels of Chaining -



//MARK: - Chaining on Methods with Optional Return Values

if let buildingIdentifier = johnWick.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."

if let beginsWithThe =
    johnWick.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}


// 함수의 리턴값이 만약 옵셔널이 아니라고 해도 속성과 마찬가지로, 체이닝 결과는 반환값 or 옵셔널
if let a = johnWick.residence?.address{print(a)}
if let a = johnWick.residence?.address?.getDes(){print(a)}

// 반환값이 없는 함수에 대한 체이닝이라면 수행 여부의 차이가 있고, 반환값은 nil or Void?
print(johnWick.residence?.address?.setDefault() as Any)
print(johnWick.residence?.address as Any)

johnWick.residence = nil
print(johnWick.residence?.address?.setDefault() as Any)
print(johnWick.residence?.address as Any)
// Prints "John's building identifier begins with "The"."


// 리턴 결과의 옵셔널을 해제하고 싶으면, 변수와 마찬가지로 함수 호출 뒤에(소괄호 뒤) ?를 붙여서 체이닝
if let beginsWithThe =
    johnWick.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."


//MARK: Chaining on Methods with Optional Return Values -
/*--------------------------------------------------------------------------------
 옵셔널은 기본적으로 nil 값 마저 데이터의 한 종류로 활용하거나, 다루는 과정에 발생할 수 있는 오류를
 줄이기 위해 만든것이기 때문에, 옵셔널을 해제 한다는 것은 nil 인지 여부를 확인하는 과정인 경우가 대부분이다.
 
 옵셔널 체이닝은 이러한 해제 과정에서 발생하는 많은 조건문 혹은 예외처리 과정을 줄이고자 하는 의도가 있다.
 --------------------------------------------------------------------------------*/









































//MARK: - 공식문서 내용 아님
// 옵셔널 값의 추출
var number : Int? = 5

//----------------------------옵셔널값의 추출------------------------------------------
// 옵셔널로 래핑된 변수를 사용하는 데에는 여러 방법이 있다.
//---------------------------------------------------------------------------------
print(type(of: number as Any))

// 1. 강제 해제 - 확실하게 값이 들어있는 경우에 사용가능하지만 런타임 에러를 유발하기 때문에 사용X
//var myString = String(number!) // nil 인 경우 runtime Error

// 2. nil-coalescing 을 통한 다른 값으로의 대체 - 디폴트 값이 존재하는 경우 사용하기 편리함
import UIKit
var defaultBackgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
var configuredBackgroundColor : CGColor?
var currentBackgroundColor = configuredBackgroundColor ?? defaultBackgroundColor


// 3. 옵셔널 바인딩 - 해제해 보고 추출 실패 시 일정 프로시저 수행 (조건문(분기)과 해제문이 합쳐진 기능)
if let optbinding = number{
    print(optbinding)
}
else{
    // 값 추출 실패시
    print("값이 없습니다.")
    print("값을 입력 후 다시 실행하세요")
    // some input Creating(Scanning) procedure....
}

var intOuter:Int = 0
// guard문으로 옵셔널 바인딩 - if문 바인딩은 중괄호 블록 내에서만 값이 사용될 수 있는 반면
//                        해당 변수가 유효한 모든 범위에 사용이 가능

// 또 다른 점으로는 가드문은 반드시 조건이 실패 컨텍스트에서 return, throw 둘중 하나를 사용해야 하며,
// return 구문을 사용하려면 함수 및 메서드 내에서 사용해야 하고 필요하다.
// throw 를 사용하려면 에러를 정의하고 예외 처리 구문을 만들어야 한다.

// 바인딩 실패 시 그냥 pass through 구문이 필요하면 가드문을 사용하면 안된다.

func test(input:Int?, output: inout Int) {
    guard let num = input else { print("값이 nil 가드문에 걸림"); return }
    output = num
}

enum MyError :Error{
    case throwExError
}
var opt :Int?
func test_(input:Int?, output: inout Int) throws {
    guard let num = opt else { print("값이 nil 가드문에 걸림"); throw MyError.throwExError }
}

guard let num = opt else { print("값이 nil 가드문에 걸림"); throw MyError.throwExError }

test(input: number, output: &intOuter)
//print(intOuter)

//MARK: 공식문서 내용 아님 -
