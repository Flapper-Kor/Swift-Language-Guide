/*
 Type Casting
 Determine a value’s runtime type and give it more specific type information.
 
 타입 캐스팅
 Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.
 Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.
 
 Type Casting is....
    타입을 확인, 혹은 다른 서브클래스/슈퍼클래스로 취급
    스위프트에서 is로 타입을 확인. as 로 타입을 다른 타입로 취급
    특정 프로토콜을 따르는지 확인하기 위해서도 사용 가능
 */

//MARK: - Defining a Class Hierarchy for Type Casting
// 상속관계에 있는 클래스 정의

class MediaItem: CustomStringConvertible {
    var name: String
    var description: String{
        get{
            return "name : \(self.name)"
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    override var description: String{
        get{
            return "Movie: \(self.name), dir. \(self.director)"
        }
    }
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
    
}

class Song: MediaItem {
    var artist: String
    override var description: String{
        get{
            return "Song: \(self.name), by \(self.artist)"
        }
    }
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// the type of "library" is inferred to be [MediaItem]
print(type(of: library), library)



//MARK: - Checking Type
//Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it’s not.
/*
 타입 체크는 기본적으로
 해당 인스턴스가 특정 타입인지를 알아보기 위해서 사용한다.
 앞에는 타입을 체크할 인스턴스, 뒤에는 체크할 타입명 : <#instance#> is <#Type#> 형태를 사용한다.
 */

library[0] is Movie // true
library[0] is Song  // false

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"


// MARK: 두 인스턴스의 타입 비교 (meta type)
/*
 두 인스턴스의 타입 비교를 위해서는 type(of: 인스턴스) 함수를 사용한다.
 type(of: ) 함수는 해당 인스턴스의 메타 타입을 반환한다.
 
 메타타입은 타입 속성 및 함수 (static) 및 인스턴스 속성 및 함수 를 동시에 사용할 수 있는 상위의 타입 개념이다.
 type(of: ) 의 리턴 값은 메타 타입을 반환하지만, 메타타입 타입명 그 자체를 의미하는 것이 아니고,
 메타타입 인스턴스를 반환하기 때문에, is 연산자의 앞에 존재할 수 있다.
 
 Movie is Song                         // 사용할 수 없음
 type(of:<#instance of Movie#>) is Movie   // 사용 가능
 
 하지만 결과는 의도와 다를 수 있다. 아래를 참조
 
 type(of: library[0]) is Movie                            // false
 type(of: library[0]) is Movie.Type                      // true
 
 따라서 이와 같은 특성을 활용하여 type(of:)함수의 반환 값을 사용하면 두 인스턴스의 메타타입을 비교하여, 두 인스턴스의 타입을 비교할 수 있다.
 */

type(of: library[0]) is Movie                            // false
type(of: library[0]) is Movie.Type                      // true


// 따라서 두 인스턴스의 타입을 비교하기 위해서는 아래와 같이 하면 된다.
type(of: library[0]) == type(of: library[1])


// MARK: 메타 타입의 사용
/*
 인스턴스에 type(of:)를 적용할 경우에는 해당 인스턴스의 메타타입을 반환하지만
 이 반환값은 메타타입명 자체를 의미할 수는 없기 때문에, 아래와 같은 사용은 불가하다.
 */

// movie_a 는 static 메서드와 인스턴스 메서트를 동시에 사용할 수 있는 메타타입의 인스턴스가 생성
var movie_instance : Movie = Movie(name: "E.T.", director: "Steven Allan Spielberg")

// movie_b 는 메타 타입 인스턴스를 생성
//var movie_meta : Movie.Type = type(of: movie_instance)
var movie_meta : Movie.Type
movie_meta = type(of: movie_instance)

// 아래의 경우는 불가능
// var movie_c : type(of:Movie)
// var movie_meta = Movie.Type()

// 아래와 같이 비교해 볼 수 있다.
type(of: movie_instance) == type(of: movie_meta)
print(type(of: movie_instance))
print(type(of: movie_meta))


// MARK: type(of: ) 의 중첩 사용 ( 컬렉션 에서의 사용 )
/*
 타입 of 함수를 중첩적으로 사용하게 되면, 해당 타입의 타입의 타입의....이런식으로 의미없는 개체가 생성되지만
 특정 상황에서 메타 타입 인스턴스에 중첩으로 type(of:) 함수를 사용하게 되면 해당 타입이 상속받은 타입을 가리킨다.
 컬렉션이 그 예인데, 서로 다른 타입을 담아내는 컬렉션에 담긴 하나의 인스턴스에 대해서 type(of:) 함수를 중첩 사용하게 되면
 상속받은 타입을 가리키는 경우가 있다.
 자세한 내용은 좀 더 알아봐야 할듯
 */


// 일반적인 type(of:) 함수의 동작
var movie_dictionary: [String : Movie] = [String : Movie]()
var movie_instance2 = Movie(name: "A.I", director: "Steven Allan Spielberg")

movie_dictionary["E.T."] = movie_instance
movie_dictionary["A.I."] = movie_instance2

print(type(of: movie_dictionary["E.T."]!))
print(type(of: type(of: movie_dictionary["A.I."]!)))

var movie_array = [Movie]()
movie_array.append(movie_instance)
movie_array.append(movie_instance2)

print(type(of: movie_array))
print(type(of: type(of: movie_array)))

// 서로 다른 타입을 담는 컬렉션
var contens_array = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
var contens_dict = [
    "E.T." : movie_instance,
    "A.I." : movie_instance2,
    "Citizen Kane" : Movie(name: "Citizen Kane", director: "Orson Welles"),
    "The One And Only" : Song(name: "The One And Only", artist: "Chesney Hawkes"),
    "Never Gonna Give You Up" : Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

print(type(of: contens_array[0]))
print(type(of: type(of: contens_array[0])))

print(type(of: contens_dict.first!.value))
print(type(of: type(of: contens_dict.first!.value)))

// 이러한 상황은 컬렉션의 타입이 부모클래스를 담는 것으로 지정되어 있기 때문에 나타나는 경우에만 사용할 수 있다.
// 좀더 자세한 내용은 알아봐야 할 듯 하지만, 알아볼 시간이 있을지...
print(type(of:contens_array))

//TODO: 컬렉션에서의 typeof함수

//MARK: - Downcasting
// 서브클래스로...
// you can try to downcast to the subclass type with a type cast operator (as? or as!).

// 아래의 경우에서는 item 은 Movie 클래스일수도 있고, Song 클래스 일수도 있기 때문에
// as? 와 옵셔널 바인딩을 사용
for item in library {
    if let movie = item as? Movie {
        print(movie)
    } else if let song = item as? Song {
        print(song)
    }
}

// Movie: Casablanca, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gonna Give You Up, by Rick Astley


/*
 Note
 Casting doesn’t actually modify the instance or change its values. The underlying instance remains the same; it’s simply treated and accessed as an instance of the type to which it has been cast.
 */

// 마찬가지로 upcating 또한 as 키워드로 동일하게 가능하지만, 공식문서에서는 굳이 다루지 않음
let oppenheimer = Movie(name: "Oppenheimer", director: "Christopher Edward Nolan")

// 아래 세 가지의 경우에서 upcasting 의 상속관계는 이미 컴파일러가 알고 있기 때문에
// ?, ! wrapping 과정을 거치지 않아도 된다.

let wrappedMedia = oppenheimer as? MediaItem
print(type(of: wrappedMedia), wrappedMedia)

let unwrappedMedia = oppenheimer as! MediaItem
print(type(of: unwrappedMedia), unwrappedMedia)

let media = oppenheimer as MediaItem
print(type(of: media), media)



//MARK: - Type Casting for Any and AnyObject
/*
 Swift provides two special types for working with nonspecific types:
    1. Any can represent an instance of any type at all, including function types.
    2. AnyObject can represent an instance of any class type. (클래스 인스턴스만을 표현)

Any ⊃ AnyObject
 */


var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

var thingsObj : [AnyObject] = []

//thingsObj.append(0) // error
//thingsObj.append(0.0) // error
//thingsObj.append(42) // error
//thingsObj.append(3.14159) // error
//thingsObj.append("hello") // error
//thingsObj.append((3.0, 5.0)) // error
thingsObj.append(Movie(name: "Ghostbusters", director: "Ivan Reitman")) // only instances of class are possible
thingsObj.append(Song(name: "Hey Jude", artist: "The Beatles")) // only instances of class are possible
class Greeting{
    var kor : String = "안녕하세요"
    var eng : String = "hi"
}
thingsObj.append(Greeting()) // only instances of class are possible
var greeting : Greeting? = Greeting()
thingsObj.append(greeting as AnyObject)

print(thingsObj)
//thingsObj.append({ (name: String) -> String in "Hello, \(name)" }) // error

print("switch all things ============================================================= ")
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
print("=============================================================================== ")

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael

/*
 Note
 The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.
 */

let optionalNumber: Int? = 3
things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning


print(type(of: things.last), things.last)
var s = things.popLast()
print(type(of: things.last), things.last)
things.popLast()
print(type(of: things.last), things.last)
things.popLast()
print(type(of: things.last), things.last)


print(type(of: things.last), things.last ?? "nil") // unwrap
things.popLast()
print(type(of: things.last), things.last!) // unwrap
things.popLast()
print(type(of: things.last), things.last as Any) // avoid warning
things.popLast()
print(type(of: things.last), things.last as Any)


//MARK: Type Casting for Any and AnyObject -
