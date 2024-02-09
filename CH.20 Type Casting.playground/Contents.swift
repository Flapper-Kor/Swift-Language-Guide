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
