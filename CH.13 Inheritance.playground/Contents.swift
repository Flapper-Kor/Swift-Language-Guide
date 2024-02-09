/*
 inheritance
 
 Subclass to add or override functionality.
 
 A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.
 
 상속은 클래스만이 가능함.
 
 composing the protocol 역시 비슷한 문법을 사용하지만, 상속이 아닌 구현이다. (like interface & implements)
 */

//MARK: - Defining a Base Class

/*
 Any class that doesn’t inherit from another class is known as a base class.
 
 Note
 Swift classes don’t inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

 // 위 말은 기본적으로 모든 클래스는 object 를 상속받는 자바류와 다르다는 것을 표현한 듯 한데 정확히 이해하지 못함.
 */

class Vehicle : CustomStringConvertible{
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

// You create a new instance of Vehicle with initializer syntax, which is written as a type name followed by empty parentheses:
let someVehicle = Vehicle()

print("Vehicle: \(someVehicle)")
// Vehicle: traveling at 0.0 miles per hour

//MARK: Defining a Base Class -



//MARK: - Subclassing

// syntax
//class subclass : superclass{
//
//}

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour


//Subclasses can themselves be subclassed.

// tandem : 두개의 의자를 가지고 있는 bicycle
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour

//MARK: Subclassing -



//MARK: - Overriding

//MARK: Accessing Superclass Methods, Properties, and Subscripts
/*
 Where this is appropriate, you access the superclass version of a method, property, or subscript by using the super prefix:
 
    1. An overridden method named someMethod() can call the superclass version of someMethod() by calling super.someMethod() within the overriding method implementation.
 
    2. An overridden property called someProperty can access the superclass version of someProperty as super.someProperty within the overriding getter or setter implementation.
 
    3. An overridden subscript for someIndex can access the superclass version of the same subscript as super[someIndex] from within the overriding subscript implementation.
 
    1. 메서드를 오버라이딩 할때 super.method() 를 오버라이딩 구현 내부에서 호출
    2. 프로퍼티의 getter, setter 내부에서 super.someproperty 를 사용.
    3. 서브스크립트 구현 내부에서 super[index] 호출
 */



//MARK: Overriding Methods
// 슈퍼클래스에 존재하는 특성을 (타입 메서드, 인스턴스 메서드, 타입 프로퍼티, 인스턴스 프로퍼티, 서브스크립드) 재정의 할 수 있는데 이를 오버라이딩이라고 한다.
// override 키워드를 사용하여 표시한다.

// 반드시 재정의 하지 않아도 되는 특성을 가진 것을 override 할 수 있으며,
// 반드시 재정의 해야 하는 특성은 superclass에서 required 키워드를 사용해 정의할 수 있다.
// 또 이러한 특성을 프로토콜로 따로 정의하여 구현하도록 하는것이 더욱 좋다.
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()
// Prints "Choo Choo"

//MARK: Overriding Properties
/*
 Note
 If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter, where someProperty is the name of the property you are overriding.
 
 // 속성을 재정의 할 경우, setter를 재정의 하면 무조건 getter도 재정의하여야 한다.
 // 만약 오버라이딩 하지 않고 싶을 경우, getter 내부에 super.property 를 리턴하여 pass through 시키면 된다.
 */

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

var someCar = Car()
print(someCar)

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3


//MARK: Overriding Property Observers
/*
 Note
 You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
 Note also that you can’t provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 
 상수 저장 프로퍼티와 read-only 저장 프로퍼티에는 옵저버를 추가할 수 없다.
 
 */

// 그렇다면 readonly프로퍼티를 setter를 추가하여 오버라이딩 한 후에 옵저버를 추가할 수는 있나.
// 일단 아래처럼 게터와 세터가 정의된 computed property의 경우에는
class superC{
    var _integer : Int = 0
    var integer: Int{
        get{ self._integer }
    }
    var increase: Int{
        get{
            self._integer += 1
            return self._integer
        }
        set{
            _integer += newValue
        }
    }
}

class subC : superC{
    override var increase: Int{
        didSet{
            print("didSet")
        }
    }
}

var subc = subC()

subc.increase = 4
print(subc.increase)

// 위의 경우는 ok

class superC_{
    var _integer : Int = 0
    var integer: Int{
        get{ self._integer }
    }
    var increase: Int{
        get{
            self._integer += 1
            return self._integer
        }
    }
}
class subC_ : superC_{
    // 이렇게 setter를 정의 하는 속성의 경우, didset willset 대신 setter에 관련 로직을 포함시키라고 프로퍼티 단원에서 말했다.
    // 참고 : https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties#Property-Observers
    
    override var increase: Int{
        set{
            _integer += newValue
        }
        get{
            super.increase
        }
//        didSet{ // error : 'didSet' cannot be provided together with a setter
//            print("didSet")
//        }
    }
    
//    override var increase:Int{  // error : Cannot observe read-only property 'increase'; it can't change
//        didSet{
//            print("didSet")
//        }
//    }
    
//    var increase:Int{  // error : 'increase' has already been overridden
//        didSet{
//            print("didSet")
//        }
//    }
}

//MARK: Overriding -



//MARK: - Preventing Overrides



// final 키워드를 사용하여 overriding 을 막을 수 있다.
// 이러한 final 키워드는 여러 언어에서 대상에 따라 의미가 다르곤 한데, 이를 좀 더 알아보면,
/*
 
 In Java
     1. final @ variable         : make it immutable, but if it is variable of instance, it's members are mutable
     2. final @ method           : make it can not be overridden
     3. final @ class            : make it can not be inherited
 
 In C++
     1. final @ virtual function : make it can not be overridden
     2. final @ class            : make it can not be inherited
 
 In Swift
    1. final @ property          : make it can not be overridden
    2. final @ method            : make it can not be overridden
    3. final @ class             : make it can not be inherited
 */

//MARK: Preventing Overrides -
