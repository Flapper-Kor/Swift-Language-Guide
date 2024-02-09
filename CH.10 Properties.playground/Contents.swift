/*
 Properties
 
 properties associate values with particular class, struct, enum..
 
 2 ways of define the property
 
    1. stored property - 값을 저장하고, 변경하거나 사용할 수 있는 프로퍼티
    2. computed property - 특정 대상과 바인딩하여 구독 및 업데이트 하는 기능과 같이 동작하는 프로퍼티
 
 */

//MARK: - Stored Properties

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8

//MARK: Stored Properties -



//MARK: - Stored Properties of Constant Structure Instances

// When an instance of a value type is marked as a constant, so are all of its properties.
// 값유형의 인스턴스가 상수로 지정되면, 모든 프로퍼티들이 마찬가지로 상수로 지정된다.

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
//rangeOfFourItems.firstValue = 6 // error
// this will report an error, even though firstValue is a variable property

//MARK: Stored Properties of Constant Structure Instances -


//MARK: - Lazy Stored Properties

// You indicate a lazy stored property by writing the lazy modifier before its declaration.
//Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed.

// 초기화 하는데 많은 비용이나 복잡한 계산이 필요한 경우에는, 이를 사용하는 시점에 초기화 될 수 있도록 속성을 정의할 수 있는데, 이를 lazy stored property라고 하고, lazy 키워드를 변수 선언부 앞에 표기하여 이를 나타낸다.

// Lazy property는 초기화를 init() 에서 할 수 없다. (변수 선언과 동시에 초기화 하여야 함)

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
    
    init(){
        print("데이터 임포터 생성")
    }
}


class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
    
    init(){
//        importer = DataImporter() // Lazy property는 선언과 동시에 초기화 하여야 한다.
    }
}


let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created

// 앞에서 클래스 DataManager를 생성했지만, DataImporter는 생성되지 않음
// 위의 예에서 DataImporter는 파일을 읽어서 데이터를 가져오는 기능을 수행한다고 가정하면, 이를 사용하기 이전에 수행하여 메모리에 적재하는 것은
// 비용이 많이 드는 작업(memory load) 이므로 사용하는 순간 로드하도록 이러한 키워드를 사용할 수 있다.

print(manager.importer.filename) // DataImporter를 속성을 사용하는 순간 생성
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"



/*
 Note
 
 If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
 
 멀티스레드 환경에서 이러한 lazy property에 동시 접근하려고 할 때, 초기화가 단 한번 이루어진다고 보장할 수 없다.
 */

//MARK: Lazy Stored Properties -



//MARK: - Stored Properties and Instance Variables

// object-c 와 달리 저장타입과 참조타입의 변수가 따로 존재하지 않고 하나의 속성 선언으로 통합되었다는 내용이 적혀있으나,
// 명확히 이해되지 않음.
// 대충 뭐 포인터(asterisk) 같은 표기법이 따로 있었던 모양으로 추정하고 넘어감.

//MARK: Stored Properties and Instance Variables -



//MARK: - Computed Properties

// 다른 속성 값을 검색하여 계산할 수 있는, 게터와 세터(선택적)을 가진 compute property를 가질 수 있다.
// 아래는 Rect struct는 시작 지점(point)와 넓이 높이를 지정하면, 자동으로 계산되는 compute property 인 center 변수를 포함한다.

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }   
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

//MARK: Computed Properties -



//MARK: - Shorthand Setter Declaration


// 아래와 같이 세터는 괄호안의 변수명을 생략하고, newValue 라는 기본 변수명으로 받을 수 있다.
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//MARK: Shorthand Setter Declaration -



//MARK: - Shorthand Getter Declaration

// 게터는 함수의 return 키워드 생략과 마찬가지로,
// 단일표현식이라면 return 을 생략 가능하고, 그 단일 표현식을 반환한다.

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//MARK: Shorthand Getter Declaration -



//MARK: - Read-Only Computed Properties

// A computed property with a getter but no setter is known as a read-only computed property.

/*
 Note
    use for read-only, keyword 'var'
 */

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
var fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
fourByFiveByTwo.width = 40
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"


//MARK: Read-Only Computed Properties -



//MARK: - Property Observers
/*
 property observer를 세가지 경우에 적용 가능
    1. Defined Store property
    2. Available in inherited instance properties (Stored, Computed)
 
 /*
  *중요*
  해당 챕터 외 내용
  상속받은 경우, read-only 프로퍼티에는 프로퍼티 옵저버를 사용할 수 없다.
  또한, 상수로 정의된 프로퍼티는 옵저버를 적용할 수 없다.
  참고 : https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/#Overriding-Property-Observers
  */
 
 For a computed property that you define, use the property’s setter to observe and respond to value changes, instead of trying to create an observer.
 본인이 정의한 계산 프로퍼티에서는 세터를 사용해서 값의 변경에 대응하란다. 옵저버를 사용하지 말고.
 
 You have the option to define either or both of these observers on a property:
    1. willSet : is called just before the value is stored.
    2. didSet  : is called immediately after the new value is stored.


 Note
 The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.
 For more information about initializer delegation, see Initializer Delegation for Value Types and Initializer Delegation for Class Types.
 */
//


class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps


/*
 *중요*
 Note
 
 If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function. For a detailed discussion of the behavior of in-out parameters, see In-Out Parameters.
 
 인아웃 파라미터로 옵저버가 정의된 프로퍼티를 넘겨줄 때 항상 한번씩 프로퍼티 옵저버들이 호출된다.
 이는 in-out 키워드를 통한 참조가 완전한 레퍼런스 호출이 아니고, copy-in copy-out 매커니즘으로 동작하기 때문이다.
 */

class Counter {
    var number: Int = 0 {
        willSet {
            print("willSet : \(newValue)")
        }
        didSet {
//            if number > oldValue  {
                print("didSet : \(number - oldValue)")
//            }
        }
    }
}

func someAction(number : inout Int){
    number += 3
    number -= 2
    number *= 4
}
func otherAction(number : inout Int){
    
}


// Called just once property observer with in-out
// 아래처럼 값을 세번 변경하는 함수와 값을 변경하지 않는 함수에 각각 옵저버가 포함된 변수를 넘겼을 때,
// 적어도 한번 (많아도 한번)
// 그냥 단 한번만 호출됨을 알수 있다.
// 이는 값이 실제 변경될 때 호출되는 것이 아니라.
// 함수가 종료되고 copy-out 되는 시점에 옵저버가 호출되기 때문

//someAction(number: &Counter().number)
//otherAction(number: &Counter().number)


// 그렇다면 실제 함수내에서 변화 일으키고, 이에 대한 변화를 프로퍼티 옵저버로 알고 싶으면 어떻게 해야 하나.
// 아래 예제는 의도한 대로의 결과를 도출
// copy-in copy-out 인 inout 변수를 사용하지 않고, 정확히 레퍼런스 타입인 인스턴스를 넘겨주면 된다.
// 혹은 @Observable, @Published 등의 옵저버 패턴을 사용하거나 바인딩을 통하여 구현 가능.

func someAction(counter : Counter){
    print("1")
    counter.number += 3
    print("2")
    counter.number -= 2
    print("3")
    counter.number *= 4
}

func otherAction(counter : Counter){
    
}
someAction(counter: Counter())  // 이 경우 someAction에서 옵저버는 세번 호출된다.
otherAction(counter: Counter()) // 이 경우 otherAction에서 옵저버는 호출되지 않는다.

//MARK: Property Observers -


//MARK: - Property Wrappers

// 커스텀 프로퍼티 래퍼의 선언
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

// 커스텀 프로퍼티 래퍼의 사용

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"


// 래퍼를 사용하지 않고, 명시적으로 구조체를 사용하여 정의
// 위의 SmallRectangle 구조체와 동일
struct SmallRectangle_ {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

var rectangle_ = SmallRectangle_()
print(rectangle_.height)
// Prints "0"

rectangle_.height = 10
print(rectangle_.height)
// Prints "10"

rectangle_.height = 24
print(rectangle_.height)
// Prints "12"

//MARK: Property Wrappers -



//MARK: - Setting Initial Values for Wrapped Properties


// 속성 래퍼에 이니셜라이저가 하나라도 정의되어 있으면,
// 프로퍼티 래퍼를 적용한 클래스 생성 시, 자동으로 값을 이니셜라이징 해 주며
// 그 값은 프로퍼티 래퍼의 이니셜라이저에서 초기화 한 값이 된다.

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    private var minimum: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        print("init() 호출")
        maximum = 12
        number = 0
        minimum = 0
    }
    init(wrappedValue: Int) {
        print("init(wrappedValue: Int) 호출")
        maximum = 12
        number = min(wrappedValue, maximum)
        minimum = 0
    }
    init(wrappedValue: Int, maximum: Int) {
        print("init(wrappedValue: Int, maximum: Int) 호출")
        self.maximum = maximum
        number = min(wrappedValue, maximum)
        minimum = 0
    }
    init(wrappedValue: Int = 0, maximum: Int = 20, minimum: Int = 0) {
        print("init(wrappedValue: Int = 0, maximum: Int = 0, minimum: Int = 0) 호출")
        self.maximum = maximum
        self.minimum = minimum
        number = min(wrappedValue, maximum)
    }
}



//When you apply a wrapper to a property and you don’t specify an initial value, Swift uses the init() initializer to set up the wrapper. For example:
// 프로퍼티 래퍼를 적용하고, 값을 초기화 하지 않는 경우
// 스위프트는 init() 를 호출하여 값의 초기화를 시도한다.
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()

print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"



// 아래와 같이 직접 래퍼의 이니셜라이저를 호출해서 초기화 가능 (디폴트 생성자 init()를 사용하는 클래스 구조체의 경우)
var zeroRectangle_ = ZeroRectangle(height: .init(wrappedValue: 14, maximum: 20), width: .init(wrappedValue: 14, maximum: 20))
print(zeroRectangle_.height, zeroRectangle_.width)
zeroRectangle_.height = 600
print(zeroRectangle_.height, zeroRectangle_.width)
print(type(of: zeroRectangle_.height), type(of: zeroRectangle_.width))




// When you specify an initial value for the property, Swift uses the init(wrappedValue:) initializer to set up the wrapper. For example:
// 특정 값을 사용하여 프로퍼티를 선언과 동시에 초기화 하는 경우, 스위프트는 init(wrappedValue:)를 사용한다.
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"


// When you write arguments in parentheses after the custom attribute, Swift uses the initializer that accepts those arguments to set up the wrapper. For example, if you provide an initial value and a maximum value, Swift uses the init(wrappedValue:maximum:) initializer:
// 특정 속성값을 괄호 안에 선언하여 wrapper를 정의하는 경우, 스위프트는 Memberwise Initializers 를 사용하여
// 값을 이니셜라이징 한다.

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4, minimum: 0) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"


//When you include property wrapper arguments, you can also specify an initial value using assignment. Swift treats the assignment like a wrappedValue argument and uses the initializer that accepts the arguments you include. For example:
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}


var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"


mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"

//MARK: Setting Initial Values for Wrapped Properties -


//MARK: - Projecting a Value From a Property Wrapper

@propertyWrapper
struct SmallNumber_ {
    private var number: Int
    private(set) var projectedValue: Bool


    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber_ var someNumber: Int
}
var someStructure = SomeStructure()


someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"


someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"


// projected property 에 대한 self 생략 가능

enum Size_ {
    case small, large
}


struct SizedRectangle {
    @SmallNumber_ var height: Int
    @SmallNumber_ var width: Int

    mutating func resize(to size: Size_) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

//MARK: Projecting a Value From a Property Wrapper -



//MARK: - Global and Local Variables

//The capabilities described above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.

// 전역/지역 변수 둘다 컴퓨팅 및 옵저빙 프로퍼티로 사용할 수 있다.
// 글로벌 변수는 함수 외부에 있는,
// 지역변수는 함수 내부에 있는 (타입 컨텍스트 포함)
// 컨텍스트라는 것은 대체로 brace {} 로 감싸진 문장을 일컫는듯.
// 타입 컨텍스트라는 것은 class, struct 등을 정의한 brace 내부. 말하자면 타입을 정의해놓은 문장.


// 위 문장을 한번 더 해석해 보면,
/*
 Global variables are variables that are
 defined outside of any function, method, closure, or type context.
 
 함수, 메서드, 클로저, 타입컨텍스트의 외부에 있는 것이 전역변수
 
 Local variables are variables that are
 defined within a function, method, or closure context.
 
 함수, 메서드, 클로저 내부에 있는 것이 지역변수
 */


var a : Int = 30 // global

class kkk {
    @SmallNumber var a : Int = 30
                            // ???? 글로벌도 아니고 로컬도 아닌것인가....
                            // 아무튼 옵저빙 / 컴퓨팅 속성 둘다 가능
    
                            // static 여부에 따라서 (클래스 맴버, 인스턴스 맴버)
                            // 자바에서는 여기를 전역변수라고 부르는 데, 그도 그럴것이 자바에서는 클래스 밖에 변수가 존재할 수 없음

                            // 파이썬에서는 클래스 내부의 변수를 그냥 멤버 변수 라고 했던거 같음
                            // @cls 어노테이션으로 클래스 멤버인지 인스턴스 멤버인지 식별하였음.
                            // 아무튼 파이썬에서도 멤버변수는 전역변수라고 하지 않았음.
                            // 파이썬에서는 변수를 클래스 외부에 정의할 수 있기 때문.

                            // 스위프트에서는 여기에 존재하는 녀석은 프로퍼티 라고 하는데 그냥 주변인인듯.
                            // 설명에 따르면 전역도 지역도 아닌 변수다.
    
                            // 프로퍼티, 즉 이번 장에서 소개하고 있는
                            // 클래스, 구조체, 열거형 내부에 프로퍼티라고 하는 녀석은
                            // 일반적인 변수들과 구분을 짓는듯 하다.
    
                            // 어쨋든 동일하게 static 키워드를 사용하여 클래스, 인스턴스 차이를 둘 수 있다.
                            // 이를 클래스라는 말보다 타입이라는 말을 사용한다.
                            // 타입 프로퍼티, 인스턴스 프로퍼티 라고 명명

    func a_(){
        @SmallNumber var a : Int    // local (within method)
//        @SmallNumber(wrappedValue: 10) var a : Int    // local (within method)
        a = 20
        print(a)
    }
}

func someFunction() {
//    @SmallNumber var myNumber: Int = 0 // local (within function)
    @SmallNumber var myNumber: Int // local (within function)

    var a = {
        @SmallNumber var mySecondNumber // local (within closure)
    }
    print(type(of: a))
    myNumber = 10
    // now myNumber is 10


    myNumber = 24
//     now myNumber is 12
}

someFunction()



/*
 *중요*
 Note
 Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier.
 Local constants and variables are never computed lazily.
 
 글로벌 변수 및 상수는 항상 lazily 하게 계산된다. lazy 저장변수와 같은 방식으로.....lazy 수정자 없이....
 따라서 lazy가 가지는 단점을 가지고 있다.
 
 lazy의 특성 중에 초기화가 한번만 이뤄진다고 장담할 수 없다는 점이 있었는데,
 이 또한 글로벌 변수에 적용이 되는지 의문인데....
 */

/*
 프로퍼티 래퍼를 로컬 저장변수에는 사용할 수 있지만,
 전역변수나, 계산변수(compute property) 에는 사용할 수 없다.
 */

// 그런데 막상 위의 코드를 실행하려고 하면, 에러가 뜨는데
// 막상 지역변수의 프로퍼티 래퍼 초기화 하는 부분을 실행하려고 하면
// 메서드에서 호출하거나 closure captures 'XXX' before it is declared 에러와 함께 실행이 되지 않는다.
// 래퍼가 디폴트 생성자를 호출하도록 함수에서 초기화 하는 부분을 넣지 않으면, 에러가 발생하지 않음

//MARK: Global and Local Variables -



//MARK: - Type Properties

//Type Properties
// 다른 언어에서 클래스 멤버 등으로 표현되는 녀석


// 전역변수와 마찬가지로 각 타입의 타입 프로퍼티는 하나만 존재하며, 변수 상수로 선언될 수 있다.
// 계산 프로퍼티일 경우 변수로 선언되어야 한다.

// static 키워드를 사용하여 정의하고,
// lazy modifier 없이 lazy initialize 된다.

struct SomeStructure_ {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class SomeSubClass : SomeClass{
    override class var overrideableComputedTypeProperty: Int{
        return 1000007
    }
}
// 특이할 만한 점은 클래스의 계산프로퍼티 한정으로 class라는 키워드로 정의할 수 있다는 것인데,
// class로 선언된 변수는 서브클래스가 override 할 수 있다.

//MARK: Type Properties -



//MARK: - Querying and Setting Type Properties

print(SomeStructure_.storedTypeProperty)
// Prints "Some value."
SomeStructure_.storedTypeProperty = "Another value."
print(SomeStructure_.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "10"


//MARK: Querying and Setting Type Properties -
