/*
 퀵헬프 주석에 관한 정리
 stuct, property, class, function, enum 등의 앞에 미리 정의된 노테이션으로 퀵헬프 주석을 사용할 수 있다.
 */

// MARK: - 퀵헬프 작성을 위한 주석처리
// 주석은 아래의 두가지 방법으로 처리 가능하다.
// 블록 처리 : /**
//              [이곳에 퀵헬프 정의]
//           */
// 한줄 처리 : /// [이곳에 퀵헬프 정의]



// MARK: - 퀵헬프 작성을 위한 노테이션
/*
 Summary       : 첫번째 줄

 Discussion    : 두 번째 줄 이하로 특별한 notation이 없으면 discussion

 Accent        : ``` <#code#> ```
                 grave accent 3개로 코드를 감싼다.
                 별도의 코드를 삽입하거나 할 경우에 사용하면 좋다.
                 (맥에서 grave accent는 영문입력으로 바꾸고 ₩ 키를 누르면 된다.)
                 (임시로 영한입력 스왑의 단축키(option(⌥))를 사용하여 option(⌥) + ₩)로 입력이 가능하다.)
 
 사용자 지정 노트  : > (mathmatical right angle bracket)
                 콜론 (:) 으로 제목을 지정할 수 있다.
                 줄바꿈은 다른 직각괄호를 추가하면 된다.

 Parameter     : 두가지 방법이 존재
                 방법 1)
                      - Parameter [A] : 설명 A
                      - Parameter [B] : 설명 B
                 방법 2)
                      - Parameters :
                          - [이름] : 이런식으로 사용.
 
                 두 가지 방법 동일하게 표현되며, 콜론의 사용에 주의할 것 :::
                 두 번째 방법 사용 시 들여쓰기 주의
                 탭으로 들여쓰기 하여 하위 파라미터 들을 정의할 것
                 (스페이스 한번 사용하여 틀여쓰기 하거나 들여쓰기 하지 않으면 적용되지 않음)
                 ( 스페이스는 두번 이상 사용 하여야 적용 )
 
 Returns        : - Returns: 설명을 여기에 추가
 */




//MARK: - 실제 사용 예

/**
 Produce a greeting.
 
 usage
 ```
 Hi()
 
 ```
 ```
 Hi(name: "slash")
 ```
 > Caution:
 default name is "creep". use the name if possible.
 > ```
 >  Hi(name: <#your name#>))
 > ```
 
 - Parameters:
     - name: your name.

 - Returns: Void
 */
func Hi(name : String? = "creep"){
    if let name = name{
        print("hi there, i'm \(name)")
    }else{
        print("hi there, i'm creep")
    }
}

Hi(name: "slash")
Hi()
