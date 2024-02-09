/*
 Subscripts
 
 Access the elements of a collection.
 
 */

//MARK: - Subscript Syntax

class someClass{
    // declaration
    subscript(index: Int) -> Int {
        get {
            // Return an appropriate subscript value here.
            return index
        }
        set(newValue) {
            // Perform a suitable setting action here.
        }
    }
    
//     //read-only
//    subscript(index: Int) -> Int {
//        // Return an appropriate subscript value here.
//    }
}

// usage
var i = someClass()
print(i[0])




// example of a read-only subscript implementation
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"

//MARK: Subscript Syntax -



//MARK: - Subscript Usage

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/*
 Note
 Swift’s Dictionary type implements its key-value subscripting as a subscript that takes and returns an optional type. For the numberOfLegs dictionary above, the key-value subscript takes and returns a value of type Int?, or “optional int”. The Dictionary type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a nil value for that key.
 */
//MARK: Subscript Usage -



//MARK: - Subscript Options

// 일반 함수와 같이, input parameter 로 몇개든 가질 수 있고, 입력과 반환값 모두 어떤 타입으로든 가능하다.
// 단, inout parameter를 입력으로 사용할 수 없다.

// 또한 subscript(첨자) 는 필요한 만큼 가질 수 있다. 오버로드가 가능(subscript overloading)

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 10, columns: 10)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// let someValue = matrix[10, 10]
// This triggers an assert, because [10, 10] is outside of the matrix bounds.

//MARK: Subscript Options -



//MARK: - Type Subscripts

// using static for define type subscripts
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)

// subscript 는 데이터의 인덱싱은 아니지만 잘 쓰면 편리한 코딩을 할 수 있을 듯 하다.
// 인덱싱을 통해 얻는 장점(performance)을 얻기는 힘들다.

//MARK: Type Subscripts -
