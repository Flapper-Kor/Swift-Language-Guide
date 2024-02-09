/*
 Initialization
 
 Set the initial values for a type’s stored properties and perform one-time setup.
 
 // 스위프트에서는 objective-c 와 다르게 이니셜라이저가 반환값을 가지지 않는다
 // 클래스의 인스턴스는 이니셜라이저와 함께 디이니셜라이저를 가질 수 있다.
 
 // keyword : init(), deinit()

 */


//MARK: - Setting Initial Values for Stored Properties

/*
 Note
 When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 
 디폴트 벨류를 설정하는 경우, 혹은 이니셜라이저에서 초기화 하는 경우 값은 프로퍼티 옵저버를 호출하지 않고, 바로 설정된다
 */

class testCls{
    var i :Int = 0{
        didSet{
            print("i : didSet 호출")
        }
        willSet{
            print("i : willSet 호출")
        }
    }
    
    var j : Int {
        didSet{
            print("j : didSet 호출")
        }
        willSet{
            print("j : willSet 호출")
        }
    }
    
    init(){
        print("디폴트 생성자 호출")
        self.j = 9 // 만약 이부분이 없으면, 아래 함수 호출은 컴파일 타임 에러
//        self.setValues()
    }
    func setValues(){
        self.j = 10
        self.i = 10
    }
}

testCls()
// 생성자에 바로 기입하지 않고, 메서드를 하나 더 사용해서 초기화 하는 경우 didSet, willSet을 호출하며,
// 사실 이는 초기화 후에 한번 더 값을 변경하는 과정이 된다.
// 초기화 과정 없이 setValues() function 을 호출하려고 하면 오류.
// 모든 변수를 초기화 하지 않고 self 를 사용했다는 에러를 뱉음
// self' used in method call 'setValues' before all stored properties are initialized

//MARK: Setting Initial Values for Stored Properties -




//MARK: - Initializers

// 인수가 없는 기본 이니셜라이저.
//
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"

//MARK: Initializers -



//MARK: - Default Property Values

struct Fahrenheit_ {
    var temperature = 32.0 // 변수의 선언과 동시에 값을 할당된 값을 default property value 라고 한다.
}
/*
 디폴트 값을 사용하는 것이
    좀 더 명확하고,
    타입추론을 사용할 수 있게 하고,
    이니셜라이저를 간결하게 만들어서 기본 이니셜라이저 및 상속을 더 쉽게 할 수 있다.
 */


//MARK: Default Property Values -



//MARK: - Customizing Initialization

//MARK: Initialization Parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0

//MARK: Parameter Names and Argument Labels
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//let veryGreen = Color(0.0, 1.0, 0.0) // error
// this reports a compile-time error - argument labels are required


// 아규먼트 레이블은 외부에서 바라보는 인자의 설명, 파라메터 네임은 함수 내부에서 사용될 변수명이다.
// argument label 을 정의하지 않으면 parameter name 이 argument label이 된다.

// argument label 을 생략하고 싶으면 _(underscore) 를 사용하여 값을 무시하는 방법을 택하면 된다.

//MARK: Initializer Parameters Without Argument Labels
extension Celsius {
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0

//MARK: Optional Property Types
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."


//MARK: Assigning Constant Properties During Initialization
/*
 Note
 For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.
 클래스 인스턴스에서 상수 값은 해당 속성을 정의한 클래스에서 반드시 초기화 되어야 한다. 서브클래스에서 수정될 수 없다.
 */
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"


//MARK: Default Initializers
class ShoppingListItem : CustomStringConvertible {
    var name: String?
    var quantity = 1
    var purchased = false
    
    var description: String{ // CustomStringConvertible 상속 받고 description 이름으로 속성을 정의하면
                             // print(instance) 호출할 때 print 함수는 인스턴스의 description 속성을 출력한다.
                             // toString() in swift
        """
        \(type(of: self)) {
            name      : \(String(describing: name))
            quantity  : \(quantity)
            purchased : \(purchased)
        }
        """
    }
}
var item = ShoppingListItem() // not memberwise
                                // struct 의 경우에는
                                // class & struct 챕터에서 확인했다 시피 memberwise initializer가 기본으로 생성된다.

print(item)



//MARK: Memberwise Initializers for Structure Types
struct ShoppingListItem_ : CustomStringConvertible {
    var name: String?
    var quantity = 1
    var purchased = false
    
    var description: String{ // CustomStringConvertible 상속 받고 description 이름으로 속성을 정의하면
                             // print(instance) 호출할 때 print 함수는 인스턴스의 description 속성을 출력한다.
                             // toString() in swift
        """
        \(type(of: self)) {
            name      : \(String(describing: name))
            quantity  : \(quantity)
            purchased : \(purchased)
        }
        """
    }
    
    init(){
        
    }
    init(name: String?, quantity: Int = 1, purchased: Bool = false){
        
    }
}

var item_ = ShoppingListItem_() // xcode의 자동완성(suggest) 기능을 통해서 사용 가능한 생성자를 확인해보면,
                                // 매개변수가 없는 생성자와 함께,
                                // 디폴트 값이 설정된 memberwise init 을 사용 가능함을 확인할 수 있다.

print(item_)

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"


let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"

//MARK: Initializer Delegation for Value Types

//Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

/*
 Note
 If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation. For more information, see Extensions.
 
 원래의 값타입 유형에서 모든 값을 초기화한 경우에, 확장에서 void 이니셜라이저와, memberwise 이니셜라이저를 사용할 수 있다. (델리게이션도 가능)
 */
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

var basicRect = Rect()
// basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)


/*
  위에서는 void 이니셜라이저와 memberwise 이니셜라이저를 직접 정의해서 추가 이니셜라이저에 델리게이션 해줬는데,
    1. void 이니셜라이저와 memberwise 이니셜라이저는 값타입 유형의 속성 전체를 초기화만 시키면 자동으로 생성된다는 점
    2. extension 에서는 추가적으로 이니셜라이저를 생성할 수 있다는 점
  두 가지 특성을 활용해서 더 간결하게 아래와 같이 사용할 수도 있다.
 
 이 예제는 위의 note 부분에 작성된 내용이며, extension 챕터에서도 확인가능하다.
 */

struct Rect_ {
    var origin = Point()
    var size = Size()
}

extension Rect_{
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

var basicRect_ = Rect_(center: Point(x: 1, y: 1), size: Size(width: 2, height: 2))
print(basicRect_)


//MARK: Customizing Initialization -



//MARK: - Class Inheritance and Initialization
// designated Inializer
// 사용자가 설계한 이니셜라이저로, 모든 [클래스]는 하나 이상의 이러한 이니셜라이저를 가져야 한다.
// convenience Initializer
// 편의를 위한 이니셜라이저로, 지정 이니셜라이저를 호출하여 값을 초기화 할 수 있으며,
// 필수적으로 가져야 하는 항목은 아니다.

// 여러 이니셜라이저를 가지지만 공통된 속성(패턴)들이 존재하는 경우,
// 편의 이니셜라이저로 지정이니셜라이저를 호출하여 사용할 수 있다.

// 예를 들면, 모든 값을 초기화하는 로직만 따로 빼고 싶은 경우,
// 이러한 초기화 구문을 함수로 정의하면 모든 값이 초기화되기 전에 메서드를 사용할 수 없으므로 불가능하고,
// 초기화를 nil 이든 뭐든 먼저 하고 나서 값을 초기화하게 된다면, 이 또한 의도(초기화 로직만 따로 빼는) 의미가 바랠 수 있는데
// 편의 이니셜라이저로 생성하여, 초기화하는 지정 이니셜라이저를 불러온다면,
// 이러한 구현을 할 수 있다.

// 편의 이니셜라이저의 상속에 관해서는 아래의 이니셜라이저 자동상속 항목을 참조.

//MARK: Designated Initializers and Convenience Initializers
// You don’t have to provide convenience initializers if your class doesn’t require them.
// 만약 required 라면 필수적으로 오버라이딩 필요
class Test_Required {
    var origin : Point
    var size : Size
    
    init(){
        self.origin = Point()
        self.size = Size()
    }
    
    required convenience init(size : Size = Size(width: 10, height: 10), origin : Point = Point(x: -5, y: -5)){
        
        self.init()     // correct
//        self()          // incorrect
    }
}

class Sub_Test_Required : Test_Required{
    
    init(size: Size){
        super.init()
        self.size = size
    }
    
    required convenience init(size : Size = Size(width: 10, height: 10), origin : Point = Point(x: -5, y: -5)){
//        fatalError("init(origin:) has not been implemented")
        self.init(size: size) // 자기 자신 클래스의 다른 이니셜라이저를 반드시 호출해야 하는 편의 이니셜라이저
    }
}

var test_required_instance = Sub_Test_Required(origin: Point())

var test = Sub_Test_Required(size: Size())
print(test.origin)

print(test_required_instance.origin)

//Syntax for Designated and Convenience Initializers
/*
     init(<#parameters#>) {
        <#statements#>
     }
 
     convenience init(<#parameters#>) {
        <#statements#>
     }
 */

//MARK: Initializer Delegation for Class Types
/*
 Rule 1
    A designated initializer must call a designated initializer from its immediate superclass.
 Rule 2
    A convenience initializer must call another initializer from the same class.
 Rule 3
    A convenience initializer must ultimately call a designated initializer.
 
 
 Note
 These rules don’t affect how users of your classes create instances of each class. Any initializer in the diagram above can be used to create a fully initialized instance of the class they belong to. The rules only affect how you write the implementation of the class’s initializers.
 
 */

//MARK: Two-Phase Initialization
// 1. 초기값 할당의 확인
// 2. 할당된 값을 변경할 것인지 확인

//Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:

// 컴파일러는 에러 없이 2단계 초기화를 수행하기 위해서 4가지의 안정성 검사를 수행한다.
/*
 Safety check 1
     A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
     As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.
 Safety check 2
    A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
 Safety check 3
    A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
 Safety check 4
    An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

 */

class Sub_Test_Required_ : Test_Required{
    var testInt : Int
    
    init(testInt : Int){
        
        /*
         rule 1
            must make sure that all of its own properties are initialized before it hands off up the chain.
         */
        
        self.testInt = testInt
        
        super.init() // 모든 값을 할당하면 없어도 암묵적으로 호출됨.
                     // 이니셜라이저에 값을 할당하는 부분만 존재하면.
                     // 암묵적으로 마지막에 자동으로 호출되지만.
                     // self에 대한 참조 등을 하게 된다면, 명시적으로 추가해줘야 함.
        
        /*
         rule 2
            designated initializer는 상속된 property 에 값을 할당하기 전에 superclass 의 이니셜라이저를 호출
            그러지 않으면 super.init()에 의해 덮어써짐.
         */
        
        self.origin = Point(x: 0, y: 0)
        self.size = Size(width: 20, height: 20)
//        super.init() // 만약 위치가 여기라면 에러를 띄움. 컴파일러 체크
        
        
    }
    
    required convenience init(size : Size = Size(width: 10, height: 10), origin : Point = Point(x: -5, y: -5)){
        /*
         rule 3
            편의 이니셜라이저는 어떠한 프로퍼티라도 값을 할당하기 전에 다른 생성자를 호출해야 한다.
            이니셜라이저에 의해 값이 덮어써지는 것을 막기 위해서
         */

        self.init(testInt: 3)
        self.origin = Point(x: 20, y: 20)
        self.testInt = 19
//        self.init(testInt: 3) // 만약 이 위치라면, 컴파일러는 에러를 띄움.
                              // error : 'self' used before 'self.init' call or assignment to 'self'
    }
    
    init(center : Int){
        
        /*
         rule 4
            모든 값이 초기화 되는 초기화의 1페이즈가 끝나기 전에는 self(인스턴스)에 관한 어떠한 것도 참조할 수 없다.
         */
        self.testInt = 20
        super.init()
        self.printTestInt()
    }
    
    func printTestInt(){
        // pass
    }
    //    init(size: Size){
//
//    }
//    required convenience init(origin: Point) {
////        fatalError("init(origin:) has not been implemented")
//        self.init(size: Size())  // 자기 자신 클래스의 다른 이니셜라이저를 반드시 호출해야 하는 편의 이니셜라이저
//    }
}
var sub_Test_Required_ =  Sub_Test_Required_(testInt: 1)
print(sub_Test_Required_.origin)
print(sub_Test_Required_.size)


/*
 Here’s how two-phase initialization plays out, based on the four safety checks above:
 Phase 1
 
     A designated or convenience initializer is called on a class.
     (지정이니셜라이저나 편의이니셜라이저가 호출됨.)
 
     Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
     (새로운 인스턴스의 메모리를 할당 - 할당만 되고 아직 메모리는 초기화 되지 않음.)
 
     A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
     (지정 이니셜라이저는 클래스에 정의된 속성들이 모두 초기화되었는지 확인. 이때 할당된 메모리가 초기화됨.)
 
     The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
     (지정 이니셜라이저는 슈퍼클래스의 속성들을 초기화하기 위해서 슈퍼클래스의 이니셜라이저를 호출)
 
     This continues up the class inheritance chain until the top of the chain is reached.
     (이 과정들이 상속관계에 있는 최상위 클래스에 도달할 때까지 계속 반복)
 
     Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
     (상속관계에 있는 최상위 클래스에 도달하면, 모든 저장 프로퍼티의 값들이 완전히 초기화되었다고 판단하여, 1페이즈가 끝남)
 
 Phase 2
 
     Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
     (상속 체인을 역행하면서 이니셜라이저에 값을 재설정 할 수 있음. 이때부터 self(속성, 매서드 등에 대한)에 대한 참조 가능
 
     Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
     (마지막으로 편의 이니셜라이저 self(인스턴스)를 참조할 수 있게 되고, 이를 수정할 수 있게 됨.)
 
 */


//MARK: Initializer Inheritance and Overriding
/*
 Note
 Superclass initializers are inherited in certain circumstances, but only when it’s safe and appropriate to do so. For more information, see Automatic Initializer Inheritance below.
 
  상속을 받게되면 이니셜라이저를 자동으로 상속받게 되는 objective-C 와 다르게 스위프트는 자동으로 상속받지 않는다.
  자동으로 이니셜라이저를 상속받는 것은 항상 그러는 것은 아니고 특정 상황을 만족해야 한다.
  바로 다음에 나오는 초기화구문 자동상속 참조.
 */


//
class superC{
    var i : Int = 0
    
    init(){
        
    }
    
    init(_ notInherited_Init: Int){
        self.i = notInherited_Init
    }
    
    convenience init(conv: Int){
        self.init(conv)
    }
}

class subC : superC{
//    override init(){ // 자동 생성된 이니셜라이저건, 사용자가 정의하였건, 동일한 이니셜라이저는 정의할 때 오버라이딩 하여야 함.
//        super.init()
//    }

//    convenience init(conv: Int){
//        self.init()
//        self.i = conv
//    }
}

var k = subC()
subC(conv: 10)


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// Bicycle: 2 wheel(s)


class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
        // 위에서 봤듯이 서브클래스의 모든 속성을 정의하기만 하면, 자동으로 디폴트 생성자를 호출해준다.
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver


//MARK: Automatic Initializer Inheritance

// 자동으로 슈퍼클래스의 이니셜라이저를 상속받기 위한 조건은 다음과 같다.

/*
 Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:
 
     Rule 1
        If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
     Rule 2
        If your subclass provides an implementation of all of its superclass designated initializers — either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition — then it automatically inherits all of the superclass convenience initializers.
 
 These rules apply even if your subclass adds further convenience initializers.
 
 서브클래스에서 새로 정의한 모든 속성들이 기본값을 가진다고 가정할 때,
    1. 이니셜라이저를 하나도 정의하지 않으면 모든 이니셜라이저를 상속받는다.
    2. 1번에 의해 정의했든, 서브클래스에서 직접 구현했건, 슈퍼클래스의 모든 이니셜라이저를 구현했으면, 모든 편의 이니셜라이저를 상속받는다.
 */


/*
 *중요*
 Note
 A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
 */

// 아래는 슈퍼 클래스의 지정 이니셜라이저를 서브클래스의 편의 이니셜라이저로 재정의 하는 예제
class superCls{
    var integer: Int
    init(){
        self.integer = 0
    }
    init(integer:Int){
        self.integer = integer
    }
    
    convenience init(string: String){
        self.init()
        print(string)
    }
}

class subCls:superCls {
    var string: String
    
    override init(){
        self.string = ""
        super.init()
    }
    
    override convenience init(integer:Int){
        self.init(integer: integer, string: "")
    }
    
    init(integer: Int = 0, string : String = ""){
        self.string = string
        super.init(integer: integer)
    }
    
    init(string: String){
        self.string = string
        super.init()
    }
}

print(subCls(string: "hi").string)


//MARK: Designated and Convenience Initializers in Action
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"
let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]"

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem__: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem__(),
    ShoppingListItem__(name: "Bacon"),
    ShoppingListItem__(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘

//MARK: Class Inheritance and Initialization -

//MARK: - Failable Initializers
/*
 외부 자원의 부재 등으로 인해 이니셜라이저가 실패할 수 있는데, 이러한 경우 옵셔널과 마찬가지로 init? 로 표기하여, 실패가능함을 표기하는 것이 도움이 된다.
 
 이렇게 표기된 이니셜라이저는 실패할 경우 nil 을 리턴한다.
 
 Note
 You can’t define a failable and a nonfailable initializer with the same parameter types and names.
 
 위의 노트 부분에 대한 예제를 작성해보면
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
//    init(species: String) { // error : Invalid redeclaration of 'init(species:)'
//        self.species = species
//    }
}


// 아래는 표준 초기화 구문 중 Int(exactly:) 를 사용하는 예제이다.
let wholeNumber: Double = 12345.0
let pi = 3.14159


if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"


let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int


if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}
// Prints "3.14159 conversion to Int doesn't maintain value"



let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal


if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"

let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal


if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}
// Prints "The anonymous creature couldn't be initialized"


//MARK: Failable Initializers for Enumerations

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."


if let unknownUnit = TemperatureUnit(symbol: "X") {} else {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."


//MARK: Failable Initializers for Enumerations with Raw Values
enum TemperatureUnit_: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}


let fahrenheitUnit_ = TemperatureUnit_(rawValue: "F")
if fahrenheitUnit_ != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."


let unknownUnit_ = TemperatureUnit_(rawValue: "X")
if fahrenheitUnit_ == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."


//MARK: Propagation of Initialization Failure

/*
 Note
 A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.
 */

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Prints "Item: sock, quantity: 2"

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// Prints "Unable to initialize zero shirts"


if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// Prints "Unable to initialize one unnamed product"


//MARK: Overriding a Failable Initializer
/*
 Note
 You can override a failable initializer with a nonfailable initializer but not the other way around.

 failure -> nonfailure (O)
 nonfailure -> failure (X)
 */
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//MARK: The init! Failable Initializer

//MARK: Failable Initializers -


//MARK: - Required Initializers


//MARK: Required Initializers -

//MARK: - Setting a Default Property Value with a Closure or Function

// syntax
class SomeClass {
    let someProperty: Int = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return 1
    }()
}

// usage
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

/*

 
 *주의*
 Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
 
 클로저를 통해 초기화 값을 초기화하는 경우, 클로저의 리턴값을 프로퍼티나 변수에 저장하기 위해 클로저의 실행 구문을 사용하는 것을 잊지말자.
 { some procedure ; return ;}()
 만약 소괄호를 생략하면 클로저 자체를 변수에 할당하는 것이 되어버린다.
 
 Note
 If you use a closure to initialize a property, remember that the rest of the instance hasn’t yet been initialized at the point that the closure is executed. This means that you can’t access any other property values from within your closure, even if those properties have default values. You also can’t use the implicit self property, or call any of the instance’s methods.
 
 클로저를 활용해 초기화 할때, 주의할 점은
 클로저가 완전히 끝나기 전에 초기화도 이뤄지지 않는다는 것.
 
 따라서 클로저 내에서 self 에 관련된 참조를 사용할 수 없다. (self, 프로퍼티, 메서드)
 */

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Prints "false"

//MARK: Setting a Default Property Value with a Closure or Function -



/*
 생성자 종합 정리
 
    프로퍼티 옵저버의 호출
    프로퍼티에 기본값을 설정하거나, 생성자에서 값을 할당하는 경우 프로퍼티 옵저버를 호출하지 않음
 
    자동 생성
    값 타입   : 모든 속성의 디폴트 값이 지정된 경우, void 생성자 및 memberwise 생성자 자동생성
    참조 타입  : 모든 속성의 디폴트 값이 지정된 경우, void 생성자 자동생성
 
    상속
    모든 프로퍼티의 기본값을 정의한 경우
    생성자를 생성하지 않은 서브클래스는 슈퍼클래스의 모든 생성자 자동으로 상속 (편의 생성자까지)
    슈퍼클래스의 모든 지정 생성자를 재정의한 서브클래스는 슈퍼클래스의 편의생성자 자동상속

    재정의
    슈퍼클래스의 지정생성자는 서브클래스의 편의생성자로 재정의 가능 (override 키워드 O)
    슈퍼클래스의 편의생성자는 서브클래스의 지정생성자로 정의 가능 (override 키워드 X)

    생성자 내부 로직의 순서
    1. 디폴트 값이 없는 모든 속성의 초기화
    2. 슈퍼클래스의 지정생성자의 호출(지정생성자인 경우), 현재클래스의 지정생성자 호출(편의생성자인 경우)
    3. 상속관계에 있는 프로퍼티 수정 및 기타 로직
 
    실패가능한 생성자는 일반 생성자로 오버라이딩 될 수 있다. 반대는 불가능하다.
    실패가능한 생성자는 실패가능한 서브 클래스의 생성자에 사용될 수 있다.
    이 때 nil을 반환하는 조건은 서브클래스에도 전이된다.
 
    rawValue를 사용하는 열거형은 같은 이름의 이니셜라이저를 정의하지 않는 한 자동으로 실패가능한 이니셜라이저 init?(rawValue:)를 생성한다.
    같은 이름으로 이니셜라이저를 따로 정의하는 경우에는 정의된 이니셜라이저를 사용하게된다.
 */

enum TemperatureUnit__: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

extension TemperatureUnit__{
    init(str : String){
        switch (str){
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            print("없는 값으로 초기화")
            self = .celsius
            return
        }
    }
}
extension TemperatureUnit__{
    init(rawValue: Character){
        switch (rawValue){
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            print("없는 값으로 초기화")
            self = .celsius
            return
        }
    }
}

TemperatureUnit__(rawValue: "L")


class TestObserver{
    var i :Int = 0{
        didSet{
            print("i : didSet 호출")
        }
        willSet{
            print("i : willSet 호출")
        }
    }
    
    var j : Int {
        didSet{
            print("j : didSet 호출")
        }
        willSet{
            print("j : willSet 호출")
        }
    }
    var k : Point {
        didSet{
            print("k : didSet 호출")
        }
        willSet{
            print("k : willSet 호출")
        }
    }
    
    convenience init(i: Int?, j: Int?){
        if let i, let j{
            print("i, j 로 포인트 생성하여 호출")
            self.init(i:i, j:j, k:Point(x: Double(i), y: Double(j)))
            self.i = 50
            self.j = 80
            self.k = Point(x: 0, y: 0)
        }else{
            print("디폴트 값을 가지는 memberwise 생성자 호출")
            self.init()
        }
    }
    
    init(i: Int = 0, j: Int = 0, k:Point = Point(x: 10, y: 10)){
        self.i = 0; self.j = j; self.k = k
    }
    
    func setValues(){
        self.j = 10
        self.i = 10
        self.k = Point(x: 10, y: 10)
    }
}

//TestObserver()
var i :Int? = 50
var j : Int? = 40

var obj = TestObserver(i: i, j: j)
print(obj.k)
//obj.setValues()



