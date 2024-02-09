/*
 Error Handling
 
 Respond to and recover from errors. (에러를 발견하고, 대처하세요)
 */




//MARK: - Representing and Throwing Errors
// Error protocol을 준수하도록 하여 에러를 정의한다.
// 열거형은 에러를 정의하기에 적합하다.

// 에러의 정의 및 선언
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// 에러의 발생 (throw)
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

//MARK: Representing and Throwing Errors -


//MARK: - Handling Errors
// 예외 발생 가능한 함수/메서드/이니셜라이저를 실행하기 전에 try 키워드를 사용하여, 에러 발생 가능함을 지정한다.
// do catch 구문으로 에러 발생 가능한 구문에 대한 발생 에러를 감지한다.

/*
 Note
 Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords. Unlike exception handling in many languages — including Objective-C — error handling in Swift doesn’t involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a throw statement are comparable to those of a return statement.
 
 콜 스택을 푸는 것을 포함하지 않는다고 한다. 에러가 발생하여도 호출스택을 유지한다는 의미인듯 한데 아직 잘 모르겠음.
 */

//MARK: Propagating Errors Using Throwing Functions

// 에러의 전이
// 소괄호 뒤, 리턴타입 앞에 throws 키워드를 사용하여, 임의의 에러를 전파 가능한 함수임을 표시한다.
func canThrowErrors() throws -> String{
    return ""
}
func cannotThrowErrors() -> String{
    return ""
}

/*
 Note
 Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
 
 에러를 전이하지 않는 함수는 반드시 함수 내에서 발생가능한 에러를 처리해야 한다.
 */


struct Item {
    var price: Int
    var count: Int
}


class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0


    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//MARK: Handling Errors Using Do-Catch
/*
 // 에러의 처리
 do {
     try <#expression#>
     <#statements#>
 } catch <#pattern 1#> {
     <#statements#>
 } catch <#pattern 2#> where <#condition#> {
     <#statements#>
 } catch <#pattern 3#>, <#pattern 4#> where <#condition#> {
     <#statements#>
 } catch {
     <#statements#>
 }
 */
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."


func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Couldn't buy that from the vending machine."


func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
//    catch {} // 만약 이 구문이 없으면, 함수는 throws 해줘야 함 (정의된 모든 에러를 처리하였더라도...)
}


//MARK: Converting Errors to Optional Values

func someThrowingFunction() throws -> Int {
    // ...
    var i : Bool = false
    if i {
        throw SomeError.Error1
    }
    else{
        return 10
    }
}

// 아래의 do catch 구문은 에러가 발생하면 nil, error가 발생하지 않으면 리턴값을 가지는 옵셔널로 에러 처리를 하고 있다.
// x 와 y는 표현만 다를 뿐 동일하다.
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//MARK: Disabling Error Propagation
// try! 를 사용해서 에러 전이를 막을 수 있다.
// 이러한 구문은, 그냥 에러가 없다고 가정하고 실행하는 것이고, catch 구문도 필요없게 된다.
// 아래와 같은 예는 초기에 제공되는 이미지는 앱 자체에 포함되어 있기 때문에 에러가 없다고 가정하고, 실행하고자 하는 것이다.
//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

//MARK: Handling Errors -


//MARK: - Specifying Cleanup Actions
//You use a defer statement to execute a set of statements just before code execution leaves the current block of code.
// 코드 블록을 나가기 직전에 수행할 문장을 정의하는데, defer 문을 사용할 수 있다.
// 예외를 전파하는 구문에서 정리해야 할 리소스 등을 defer 문에 정의할 수 있다.


// 아래는 defer문을 사용하는 예제 sudo code

/*
 func processFile(filename: String) throws {
     if exists(filename) {
         let file = open(filename)
         defer {
             close(file)
         }
         while let line = try file.readline() {
             // Work with the file.
         }
         // close(file) is called here, at the end of the scope.
     }
 }
 */

/*
 defer 구문은 가장 나중에 실행되고,
 예외처리를 하지 않는 문장에서도 사용이 가능하다.
 defer 구문이 여러개 나열된 경우에는 나열된 순서의 역순으로 수행된다.
 
 return, throw, break, continue, fallthrough, 등의 Control Transfer Statements (제어 전달문) 을 포함할 수 없다.
 
 *중요*
 공식 문서에는 모든 제어전달문을 사용할 수 없다고 나와있는데,
 return, throw 두 가지를 제외하면, 루프나, 스위치 구문에서 사용이 가능함을 확인할 수 있다.
 */

func TestCallee() throws -> Int {
    // ...
    var i : Bool = true
    
    print("테스트 함수 진입")
    if i {
        throw SomeError.Error1
    }
    else{
        return 10
    }
}

func TestCaller() throws -> Int{
    do{
        var k:Int = 1
        defer{
            print("defer1 실행 ======================================") // 가장 나중에 실행됨
//            throw SomeError.Error2  // 사용할 수 없음
//            return k                // 사용할 수 없음
        }
        defer{
            print("defer2 실행 ======================================") // 여러개 나열된 경우 나열된 역순으로 실행됨
            var a = 0
            
            while true{
                if (a == 3){
                    break       // defer구문 안에 while 구문 안에 break, continue 키워드는 사용가능
                }
                else{
                    a += 1
                    print(a)
                    continue    // defer구문 안에 while 구문 안에 break, continue 키워드는 사용가능
                }
            }
        }
        defer{
            print("defer3 실행 ======================================") // 여러개 나열된 경우 나열된 역순으로 실행됨
            switch k{
            case 1:
                print("1")
                fallthrough     // fallthrough 는 사용 가능
            case 11:
                print("11")
                break           // defer 구문 내에서 break 는 while 및 switch 문에서 모두 사용 가능
//                fallthrough
            default:
                print("스위치 구문 default 실행")
            }
        }
        
        return try TestCallee()
    }
}

var i = try? TestCaller()

print(i as Any)



/*
 Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on.
 */

//MARK: Specifying Cleanup Actions -



//아래의 내용은 공식문서의 내용이 아님

//MARK: - Error Generating and throw and catch with Struct & Class that conform Error protocol
// 아래와 같이 struct/class로 만들어도 사용 가능하긴 하다. (자바에서 exception 생성 및 처리와 비슷)

enum SomeError : Error{
    case Error1
    case Error2
}
struct InvalidInputError: Error{
//    struct innerError: Error{}
//    struct innerError2: Error{}
}
class AnotherError : Error{
//    class innerError:Error{}
//    class innerError2:Error{}
}

var integerForCheckAvailableErrorProcedure : Int = 0


func availableErrorFunction(input: Int) throws {
    integerForCheckAvailableErrorProcedure = 1
    
    if input < 0{
        print("이 구문은 invaliInputError가 발생하는 경우 실행됨")
        integerForCheckAvailableErrorProcedure = 2 // 이 구문은 invaliInputError가 발생하는 경우 실행됨
        throw InvalidInputError() // 에러를 생성하여 throw
        print("이 구문은 항상 실행되지 않음")
        integerForCheckAvailableErrorProcedure = 3 // 이 구문은 항상 실행되지 않음
    }
    else if input == 8{
        print("이 구문은 anotherError가 발생하는 경우 실행됨")
        integerForCheckAvailableErrorProcedure = 4 // 이 구문은 anotherError가 발생하는 경우 실행됨
        throw AnotherError()
        print("이 구문은 항상 실행되지 않음")
        integerForCheckAvailableErrorProcedure = 5 // 이 구문은 항상 실행되지 않음
    }
    print("이 구문은 예외가 발생하지 않을 경우 실행됨")
    integerForCheckAvailableErrorProcedure = 6 // 이 구문은 예외가 발생하지 않을 경우 실행됨
}

// 에러 catch
do{
    try availableErrorFunction(input: 9)
    print("do 구문 실행 완료") // 이 구문은 에러 캐치 하지 못할 경우에만 실행됨
} catch is InvalidInputError {
    print("MyError 발생")
} catch is AnotherError {
    print("anotherError 발생")
}

print(integerForCheckAvailableErrorProcedure)

//MARK: Error Generating and throw and catch with Struct & Class that conform Error protocol -


/*
    try catch
    예외 처리 : 프로그램 내에서의 예외가 발생한 상황에 대해 이를 복구하는 과정
    
    발생(throwing)
    감지(catching)
    전파(propagating)
    조작(manipulating)
 */

// 에러 프로토콜을 상속받아 열거형으로 정의하여 사용하는 것이 일반적.
enum PhoneError : Error{
    case unknown
    case batteryLow(batteryLevel:Int)
}

//throw PhoneError.batteryLow(batteryLevel: 20)

//1. 함수(콜리)에서 발생한 오류를 해당함수의 콜러에게 전달하는 방법
func checkPhoneBatteryStatus(batteryLevel:Int) throws -> String{
    guard batteryLevel != -1 else { throw PhoneError.unknown }
    guard batteryLevel > 20 else {
        throw PhoneError.batteryLow(batteryLevel: batteryLevel)
    }
    return "배터리 상태가 정상입니다."
}

/*
 콜러는 다음과 같이 예외처리를 함
 1. do{
        try ...
    }catch{
        ...
    }
 */

do {
    try checkPhoneBatteryStatus(batteryLevel: 21)
}catch PhoneError.unknown{
    print("알수없는 에러입니다.")
}catch PhoneError.batteryLow(let batteryLevel){
    print("배터리 전원 부족 남은 배터리 : \(batteryLevel)%")
}catch{
    print("그 외 오류 발생 \(error)")
}

/*
 오류를 옵셔널 값으로 처리
 */
let status = try? checkPhoneBatteryStatus(batteryLevel: 30)

// 예외가 발생하지 않을 것이라 확실할 경우 아래와 같음
let status2 = try! checkPhoneBatteryStatus(batteryLevel: 30)
print(status)
