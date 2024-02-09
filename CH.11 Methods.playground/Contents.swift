/*
 Methods
 
 Define and call functions that are part of an instance or type.
 instance 나 type 내의 일부로서의 함수
 
 Methods are functions that are associated with a particular type.
 특정 타입과 연관된 함수가 메서드.
 
 Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.
 
 타입 메서드와 인스턴스 메서드 두가지 유형이 있으며, class, struct, enum 세 가지 모두 두가지 유형의 메서드들을 가질 수 있다.
 
 스위프트에서 타입이라고 부르는 것은 대부분 언어에서 클래스 에 귀속된 그것과 유사하나, 타입이라고 부르는 이유는 클래스에만 국한된 것이 아니라,
 구조체, 열거형 두가지 모두 공통된 성질을 가지기 때문에 타입이라고 일컫는다.
 */

//MARK: - Instance Methods

// 특정 열거형, 구조체, 클래스의 인스턴스에 속하는 메서드.
// 인스턴스화 하였을 때만 사용 가능한 메서드.

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
    func sayHello(){
        print("hello")
    }
}

let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0

//MARK: Instance Methods -



//MARK: - The self Property

// Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
// 모든 타입의 인스턴스는 self라고 하는 (자기 자신 인스턴스와 정확히 같은)암묵적인 속성을 가지고 있고, 이는 인스턴스 메서드 내에서 현재 인스턴스를 참조하기 위해서 사용할 수 있다.

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"


/*
 *중요*
 
 Without the self prefix, Swift would assume that both uses of x referred to the method parameter called x.
 
 mutating 이건 클래스로 정의하건, 지역변수(매개변수) 명과 속성명이 동일하다면, 지역변수(매개변수) 라고 가정한다.
 */
struct Point_ {
    var x = 0.0, y = 0.0
    mutating func isToTheRightOf(x: Double) -> Bool {
        var x : Int = 30 // 이런 경우는 어떻게 되는건지...
        
        print(x)
//        x = x
        return x > x
    }
}

var somePoint_ = Point_(x: 4.0, y: 5.0)

if somePoint_.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

//MARK: The self Property -



//MARK: - Modifying Value Types from Within Instance Methods

// 기본적으로 밸류타입 인스턴스의 속성을 인스턴스 매서드 내에서 변경할 수 없지만, mutating 키워드를 사용하여 값을 변경할 수 있다.
// 상수로 선언된 값타입 인스턴스는 mutating 함수를 호출할 수 없다.


extension Point {
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"


// 값타입 상수는 변경 불가

//let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error

//MARK: Modifying Value Types from Within Instance Methods -



//MARK: - Assigning to self Within a Mutating Method

// Mutating methods can assign an entirely new instance to the implicit self property.
// mutating 메서드 내에서 self 를 새로운 인스턴스로 대체하여 할당할 수 있다.

extension Point {
    mutating func moveBy_newSelf(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
//The end result of calling this alternative version of the method will be exactly the same as for calling the earlier version.
// 이전 버전의 것과 정확히 일치한다는데....
// 그럼


enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

//This example defines an enumeration for a three-state switch.

//MARK: Assigning to self Within a Mutating Method -



//MARK: - Type Methods

// 타입 메서드는 특정 타입에 귀속된 메서드로, 인스턴스를 생성하지 않고 사용 가능한 static 메서드이다.
// static 키워드를 통해 정의한다.
// 인스턴스에서는 사용 불가.
// class 한정 class 라는 키워드로도 정의할 수 있으며, class 와 static 의 차이는 서브클래스에서 오버라이딩 할 수 있는지 여부이다.

class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()


// example : self in static method
// self 키워드를 인스턴스에서만 사용가능한 다른 언어와 달리 스위프트에서는 타입 메서드에서도 본인 참조를 위해 사용 가능.
// 타입 메서드에서도 셀프를 사용할 수 있고, 메서드 내에서 지역변수와 구분하기 위해 self를 사용할 수 있다.
// 이에 더해서 static 변수 및 함수에서는 mutating 키워드를 사용하지 않아도 값을 변경 가능
struct SelfEx {
    static var integer = 0
    
    static func changeValue(interger : Int){
        self.integer = interger
    }
}

print(SelfEx.integer)
SelfEx.changeValue(interger: 30)
print(SelfEx.integer)
// end of example : self in static method


struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1


    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }


    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }


    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var level: Int = 4

var player = Player(name: "Argyrios")
player.complete(level: level)

print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")

level = 6

if player.tracker.advance(to: level) {
    print("player is now on level \(level)")
} else {
    print("level \(level) hasn't yet been unlocked")
}
// Prints "level 6 hasn't yet been unlocked"

//MARK: Type Methods -
