var a : Int = 0
let b = a += 2
// 대입 연산자는 값을 반환하지 않는다. 첫번째 대입 연산자가 값을 반환하지 않으므로,b의 값은 존재하지 않는다.

print(a, b)
print(b==nil)
// 근데 nil 은 아니다.






/**
 현재 삶의 상태를 나타내는 지표
 - case:
    - gotScrewed : 인생조짐
    -  soso           : 그저그럼
    -  fantastic     : 개좋음
 */
enum LifeStatement : Int {
    case gotScrewed = 0,
    soso,
    fantastic
}

extension LifeStatement : CaseIterable{
    static func GetLevelOfPercentage(statement : LifeStatement){
        
    }
    static func ToArray() -> Array<LifeStatement>{
        return LifeStatement.allCases.map {$0}
    }
    
    static func ToArray_Rawvalues() -> Array<Int>{
        // return array of the all rawvalues in the enum
        return LifeStatement.allCases.map {$0.rawValue}
    }
    
    static func ToDict() -> Dictionary<LifeStatement, Int>{
        return Dictionary(uniqueKeysWithValues: zip(LifeStatement.allCases.map {$0}, LifeStatement.allCases.map{$0.rawValue}))
    }
}
class MyLife{

    var age : Int
    
    init(age : Int){
        self.age = age
    }
    
    func GetStatement(playTime : Int, StudyTime : Int) -> LifeStatement {
        var myTimeSpended = self.age * 365 * 24
        
        if (playTime / myTimeSpended * 100 < 40){
            if(StudyTime / myTimeSpended * 100 > 50){
                return LifeStatement.fantastic
            }
            else{
                return LifeStatement.soso
            }
        }else{
            return LifeStatement.gotScrewed
        }
    }

}


print(MyLife(age: 30).GetStatement(playTime: 1000000, StudyTime: 1000000))
