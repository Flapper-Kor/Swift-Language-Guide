/*
 Concurrency
 
 Perform asynchronous operations. (비동기 동작을 수행하세요.)
 */

import Foundation

// 아래 함수는 갤러리 pseudo-code
/*
 listPhotos(inGallery: "Summer Vacation") { photoNames in
     let sortedNames = photoNames.sorted()
     let name = sortedNames[0]
     downloadPhoto(named: name) { photo in
         show(photo)
     }
 }
 */

//MARK: - Defining and Calling Asynchronous Functions

// 아래는 예제에서 간단하게 테스트 하기 쉽도록 Task.sleep을 사용하여 listPhotos 함수를 정의
func listPhotos(inGallery name: String) async -> [String] {
    print("start listPhotos")
    do{
        try await Task.sleep(until: .now + .seconds(0.2), clock: .continuous)
    }catch{
        print(error)
    }
    print("end listPhotos")
    return ["IMG001", "IMG99", "IMG0404"]
}

// 아래는 예제에서 간단하게 테스트 하기 쉽도록 Task.sleep을 사용하여 downloadPhoto 함수를 정의
func downloadPhoto(named: String) async -> String {
    print("start downloadPhoto")
    do{
        try await Task.sleep(until: .now + .seconds(0.2), clock: .continuous)
    }catch{
        print(error)
    }
    print("end downloadPhoto")
    return named
}

var gallery = Dictionary<String, Dictionary<String, Bool>>()

func show(_ photo : String){
    print(type(of: photo), photo)
}
func show(_ photo : [String]){
    print(type(of: photo), photo)
}
func add(_ photo: String, toGallery: String){
    if var gal = gallery[toGallery]{
        gal.updateValue(true, forKey: photo)
    }else{
        gallery[toGallery] = Dictionary<String, Bool>()
        gallery[toGallery]?.updateValue(true, forKey: photo)
    }
}
func remove(_ photo: String, fromGallery: String){
    gallery[fromGallery]?[photo] = nil
}

//MARK: 순차적으로 실행
let photoNames = await listPhotos(inGallery: "Summer Vacation") // 하나의 비동기 스레드를 생성, 응답대기

let sortedNames = photoNames.sorted() // 위 코드가 반환되고 나면 아래의 코드 순차 실행
let name = sortedNames[0]
print(name)
let photo = await downloadPhoto(named: name) // 하나의 비동기 스레드를 생성, 응답대기
show(photo)

let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]

add(firstPhoto, toGallery: "Road Trip")
// At this point, firstPhoto is temporarily in both galleries.
remove(firstPhoto, fromGallery: "Summer Vacation")

//MARK: 이 함수의 사이에 await 를 통한 중단지점이 포함되지 않을 것을 확실히 하기 위해 동기함수로 여러 함수를 묶어서 표현
func move(_ photoName: String, from source: String, to destination: String) {
    add(photoName, toGallery: destination)
    remove(photoName, fromGallery: source)
}

move(firstPhoto, from: "Summer Vacation", to: "Road Trip")
print(gallery)

//MARK: Defining and Calling Asynchronous Functions -



//MARK: - Asynchronous Sequences
/*
 한번에 전체 array를 반환하지 않고, element가 개별적으로 준비되는 대로 순차적으로 반환하도록
 for - in 구문과 await 를 묶어서 사용할 수 있다.
 */
import Foundation

let handle = FileHandle.standardInput

for try await line in handle.bytes.lines {
    print(line)
}
//MARK: Asynchronous Sequences -



//MARK: - Calling Asynchronous Functions in Parallel

// 아래와 같은 await 를 통한 스레트 생성은 순차적으로 수행되며 반환을 기다린다.
let firstPhoto_ = await downloadPhoto(named: photoNames[0])
let secondPhoto_ = await downloadPhoto(named: photoNames[1])
let thirdPhoto_ = await downloadPhoto(named: photoNames[2])

let photos_ = [firstPhoto_, secondPhoto_, thirdPhoto_]
show(photos_)

// 아래와 같이 async 키워드를 let 앞에 붙여서 병렬 호출하고,
print("병령 실행 시작")
async let firstPhoto__ = downloadPhoto(named: photoNames[0])
async let secondPhoto__ = downloadPhoto(named: photoNames[1])
async let thirdPhoto__ = downloadPhoto(named: photoNames[2])
print("병령 실행 종료")

// 상수를 사용하는 경우 문장 앞에 await 키워드를 붙여서 사용한다.
let photos__ = await [firstPhoto__, secondPhoto__, thirdPhoto__]; show(photos__) // 대입연산자를 사용하는 경우는 대입연산자 오른쪽 앞에
show(await firstPhoto__) // 함수의 매개변수로 사용하는 경우는 변수의 앞에 붙여도 되고
await show(firstPhoto__) // 함수의 매개변수로 사용하는 경우는 함수의 앞에 붙여도 되는 듯 하나 컴파일러 자동수정은 문장의 가장 앞에 붙이도록 고쳐준다.


// async 키워드는 let 과 함께만 사용할 수 있으며, 반환값이 없는 함수도 동일하게 병렬로 수행한다.
// 다만 호출 구문만 존재하고, await를 통한 대기 구문이 없는 경우, 프로그램이 먼저 종료될 경우 등의 상황에 대해 CancellationError 를 발생시킨다.
func async1() async{
    print("async 1 함수 시작")
    do{
        for i in 1...5{
            try await Task.sleep(until: .now + .seconds(0.2), clock: .continuous)
            print("async1 : ", i)
        }
    }catch{
        print(error)
    }
    print("async 1 함수 종료")
}
func async2() async{
    print("async 2 함수 시작")
    do{
        for i in 1...5{
            try await Task.sleep(until: .now + .seconds(0.2), clock: .continuous)
            print("async2 : ", i)
        }
    }catch{
        print(error)
    }
    print("async 2 함수 종료")
}
async let async1_: () = async1() // 호출 구문
async let async2_: () = async2() // 호출 구문

await async1_  // await 구문이 포함되지 않으면 CancellationError 가능성이 있다.
await async2_  // await 구문이 포함되지 않으면 CancellationError 가능성이 있다.

// 아래와 같이도 CancellationError를 방지할 수 있으나, 비동기 프로세스의 수행시간을 예측하는 것은 불가능한 경우가 많으므로,
// await 구문을 항상 세트로 사용하는 것이 좋을 듯.
//do{
//    try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
//}catch{
//    print(error)
//}

//MARK: Calling Asynchronous Functions in Parallel -



//MARK: - Tasks and Task Groups
// withTaskGroup 함수의 원형
// withTaskGroup(of: <#T##Sendable.Protocol#>, body: <#T##(inout TaskGroup<Sendable>) async -> GroupResult#>)

await withTaskGroup(of: String.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
//MARK: Tasks and Task Groups -



//MARK: - Unstructured Concurrency
/*
 구조화되지 않은 개별작업

 Task() 생성자 원형
 Task(operation: <#T##() async -> _#>)
 Task(priority: <#T##TaskPriority?#>, operation: <#T##() async -> _#>)

 Task.detached() 함수 원형
 Task.detached(operation: <#T##() async -> _#>)
 Task.detached(priority: <#T##TaskPriority?#>, operation: <#T##() async -> _#>)
 */

func addAsync(_ photo: String, toGallery: String) async {
    add(photo, toGallery: toGallery)
}

let newPhoto = await listPhotos(inGallery: "test")[1]
let taskHandle = Task {
    return await addAsync(newPhoto, toGallery: "Spring Adventures")
}
//let result: () = await taskHandle.value
await taskHandle.value

let newPhoto2 = await listPhotos(inGallery: "test")[2]
let taskHandle2 = Task.detached {
    return await addAsync(newPhoto2, toGallery: "Summer Adventures")
}
//let result2: () = await taskHandle2.value
await taskHandle2.value

print(gallery)

//MARK: Unstructured Concurrency -



//MARK: - Task Cancellation

/*
 작업취소는 셋 중 하나의 경우를 의미
     1. Throwing an error like CancellationError (캔슬레이션 에러 반환)
     2. Returning nil or an empty collection     (nil 또는 빈 컬렉션 반환)
     3. Returning the partially completed work   (부분적으로 완료된 작업 반환)
 */

var number = 0

func setnumber(num : Int){
    number = num
}

func funcAsync() async throws{
    for i in 1...100{
        do{
            print(i)
            setnumber(num: i)
            try await Task.sleep(until: .now + .seconds(0.2), clock: .continuous)
        }catch{
            print("funcAsync 작업 취소되었음 : ", Task.isCancelled, try Task.checkCancellation())
            throw error
        }
    }
}

var task = Task {
    do{
        try await funcAsync()
    }catch{
        print("task 작업 취소되었음 : ", Task.isCancelled, try Task.checkCancellation())
    }
}


// 2초 후 작업 취소
do{
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
}catch{
    print(error)
}

task.cancel()  // 작업 취소
//Task.cancel(task) // 작업 취소 이렇게 취소하면 iscancelation 프로퍼티가 정상적이지 않음

// 작업 취소의 확인
print("외부에서 확인 (task.isCancelled) : ", task.isCancelled)       // 작업 취소 확인 - property
//print("외부에서 확인 (try Task.checkCancellation()) : ", try Task.checkCancellation()) // 작업 취소 확인 - static func


// 정확한 사용법은 아래 참조
// https://developer.apple.com/documentation/swift/task/checkcancellation()

// 아래의 문서를 참조하면 알 수 있듯이
// Task에 전달되는 operation 클로저 내에서 사용한다.
// https://www.hackingwithswift.com/quick-start/concurrency/how-to-cancel-a-task




func getAverageTemperature() async {
    let fetchTask = Task { () -> Double in
        let url = URL(string: "https://hws.dev/readings.json")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if Task.isCancelled { print("작업 취소"); return 0 }

            let readings = try JSONDecoder().decode([Double].self, from: data)
            let sum = readings.reduce(0, +)
            return sum / Double(readings.count)
        } catch {
            print("catch 구문 - 작업 취소");
            print(Task.isCancelled)       // 작업 취소 확인 - property
            return 0
        }
    }

    fetchTask.cancel()

    let result = await fetchTask.value
    print("Average temperature: \(result)")
    print(fetchTask.isCancelled)
}

await getAverageTemperature()

//MARK: Task Cancellation -



//MARK: - Actors

// Actors let you safely share information between concurrent code. (동시성 코드간 안전한 정보교환 - 액터의 목적)
// 액터는 참조타입 - 클래스와 달리 한번에 하나의 task 만 변경 가능한 상태로 접근 가능

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max) // 액터의 프로퍼티에 접근할 때는 await 키워드를 사용
// Prints "25"

// 액터 내부에서 접근할 경우에는 await를 사용하지 않음
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
await logger.update(with: 29)
await logger.update(with: 30)
await logger.update(with: 28)
await logger.update(with: 25)

await print(logger.max)

//MARK: Actors -



//MARK: - Sendable Types

// A type that can be shared from one concurrency domain to another is known as a sendable type.
// You mark a type as being sendable by declaring conformance to the Sendable protocol.

// 다른 동시성 코드로 공유될 수 있는 타입을 전송가능 타입이라고 함.
// 프로토콜을 선언하여 표시 (작성할 코드는 없지만, 스위프트가 적용하는 의미론적 요구사항.
/*
 there are three ways for a type to be sendable (전송타입이 되기 위한 세가지 방법):
     1. The type is a value type, and its mutable state is made up of other sendable data — for example, a structure with stored properties that are sendable or an enumeration with associated values that are sendable.
        (변경가능한 값타입은 전송가능 ex) 전송가능한 저장 프로퍼티가 있는 구조체, 전송가능한 연관값이 있는 열거형)
     2. The type doesn’t have any mutable state, and its immutable state is made up of other sendable data — for example, a structure or class that has only read-only properties.
        (변경가능한 값을 가지지 않고, 변경불가의 다른 전송가능 개체로 이뤄진 타입 ex) 읽기전용 속성으로만 이뤄진 클래스나 구조체
     3. The type has code that ensures the safety of its mutable state, like a class that’s marked @MainActor or a class that serializes access to its properties on a particular thread or queue.
        (변경가능 값의 안정성을 보장할 수 있는 코드를 가지고 있는 경우 ex) @Main Actor 나 특정 스레드나 큐에서 직렬화된 접근을 제공하는 클래스)
 */


struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

//let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(from: reading)


// 전송불가능 객체의 명시적 선언
// 아래는 암시적으로 전송가능하지만, 확장을 통해 재정의/sendable 사용 불가하도록 막음
// 비동기적 도메인을 통해 전송하는 것이 안전하지 않은 POSIX 파일 디스크립터 인터페이스 같은 것을 이렇게 전송불가능 객체로 선언
struct NonsendableTemperatureReading {
    let measurement: Int
}
@available(*, unavailable)
extension NonsendableTemperatureReading: Sendable { }

//MARK: Sendable Types -
