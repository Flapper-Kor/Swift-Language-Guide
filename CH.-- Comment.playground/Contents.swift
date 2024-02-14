// 모두 접기 후 필요한 부분만 찾아볼 것

// 코드 접기 메뉴는 [Editor] - > [Code Folding]

// 단축키는 아래

// 단일 블럭              : [⌘ Command] + [⌥ Option] + [← or →]

// [method & function] : [⌘ Command] + [⌥ Option] + [⇧ Shift] + [← or →]

// [comment]           : [⌘ Command] + [⌃ Control] + [⇧ Shift] + [← or →]

// 이 문서는 퀵헬프 인스펙터를 켜서 확인할 것






// MARK: - Comment
/*
 일반적인 주석의 구문
     comment block : /* */
     comment line  : //
 
 
 comment annotation
     // MARK: 표시 - 탐색기에서 깃발로 표시
     // TODO: 할 일
     // FIXME: 고쳐야 할 부분
     // !!!: 경고
     // ???: 의문점
 
 위의 annotation 은 본문에 -으로 구분선을 표시할 수 있다. 블록
 이런 구분선은 Xcode IDE 에서 유효한 것이며, 블록을 접거나 특별한 기능은 없고, 다만 코드 탐색기 내에서 섹션을 구분지을 때 유용하다.
 여기서 말하는 코드 탐색기란 Xcode 화면의 툴바 바로 아래 있는 요소를 말하는 것이며, 문서 계층 맨 마지막의 요소에 표현 된다.
 아무것도 선택하지 않았다면 No selection 이라고 표현되는 부분을 클릭하여 탐색할 수 있다.
 위의 코멘트 어노테이션들은 각각의 아이콘과 함께 표현된다.
 
 //MARK: - 위 아래 구분선 추가 -

 //MARK: - 위에만 구분선 추가

 //MARK: 아래만 구분선 추가-
 */







// MARK: - quick help comment
/*
 퀵헬프 주석에 관한 정리
 stuct, property, class, function, enum 등의 앞에 미리 정의된 노테이션으로 퀵헬프 주석을 사용할 수 있다.
 
 이 주석 블록은 특정 양식을 준수하여 작성한 경우, IDE에서 해당 함수의 설명을 쉽게 살펴볼 수 있도록 도와준다.
 
 xcode 에서 퀵헬프 주석을 열람하는 법
    1. 해당 함수를 마우스로 클릭하여 팝업을 띄워 열람 (⌥+click)
    2. 해당 함수로 커서를 위치하여 퀵헬프 뷰를 통하여 열람
       퀵헬프 뷰를 활성화 하는 방법은                            (⌥option + ⌘commend + 3)
       퀵헬프 뷰가 포함된 inspector를 활성활 비활성화 하는 방법은     (⌥option + ⌘commend + 0)
 
 해당 문법은 다른 언어 편집기에서도 swift 확장을 사용하는 경우 이용할 수 있도록 도와준다.
 예를 들면 visual studio code 에 확장프로그램[swift]을 설치하고 문서를 열람 시 작성된 함수명에 마우스를 호버링할 경우 노출
 
 퀵헬프 주석은 Xcode 에서 Documentation 빌드를 사용하여 문서화 하는데 도움을 준다.
 
 아래의 퀵헬프 주석은 퀵헬프 인스펙터를 활성화 하여 놓고 확인하면 좋다.
 */






// MARK: - Basic
/*
 퀵헬프 주석의 사용
 
 주석은 아래의 두가지 방법으로 처리 가능하다.
     블록 처리 : /**
                  [이곳에 퀵헬프 정의]
               */
     한줄 처리 : /// [이곳에 퀵헬프 정의]
 
     기본적으로 개행에 관계 없이 가장 가까운 상단의 퀵헬프 주석을 참조한다.
     
     한줄 주석은 간단해서 사용하기 편리하지만, 퀵헬프 주석 사이에 개행이 발생한 경우 가장
     가까운 상단의 한 개의 주석만을 참조하기 때문에 블록 주석을 사용하는 것이 더 깔끔하다.
 
     퀵헬프 주석과 주석을 적용할 개체의 사이에 다른 주석이 있으면 동작하지 않는다.
 
 */
class Basic{
    
    // MARK: Positioning

    /**
     퀵헬프 주석은 서로 떨어져 있지 않은 가장 가까운 붙어있는 주석을 모두 표현함
     */
    
    /**
     제목
     
     떨어져 있는 경우 표시되지 않음
     */
    /**
     퀵헬프 주석이 서로 붙어있는 경우 동시에 표현함
     */
    func basic_position_1(){}
    
    /**
     퀵헬프 주석입니다 (노출되지 않음)
     */
    // 퀵헬프 주석과 함수 사이에 일반 주석이 포함되면 로드되지 않음
    func basic_position_2(){}
    
    // MARK: indent
    /*
     퀵헬프 블럭 내에서 들여쓰기를 할 수 있으나, 코드 블럭이나 특정 상황(-parameters 지시자) 등이 원하는 바와 다르게 동작할 수 있으니 주의해서 사용
    */
    func indent(){}
    
    // MARK: notations
    /*
     퀵헬프 주석에 사용되는 Notations
     
         Summary       : 첫번째 줄 (summary 내용은 xcode에서 자동완성 기능을 사용할 때, 해당 내용이 노출된다.)
                         빈 라인을 입력하여 끝났음을 알린다

         Discussion    : 두 번째 줄 이하로 특별한 notation이 없으면 discussion

         Accent        : ``` <#code#> ```, ```` <#code#>````
                         backquotes 3개, 혹은 4개로 코드를 감싼다.
                         별도의 코드를 삽입하거나 할 경우에 사용하면 좋다.
                         (맥에서 grave accent는 영문입력으로 바꾸고 ₩ 키를 누르면 된다.)
                         (임시로 영한입력 스왑의 단축키(option(⌥))를 사용하여 option(⌥) + ₩)로 입력이 가능하다.)
     
                         3개와 4개의 차이점은 현재기호의 들여쓰기 수준에서 시작되는 차이라고 한다.
     
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
         Throws         : - Throws: 반환되는 에러를 표현
     
     기본적으로 notation 의 순서대로 로드 되어 표현되지만,
     Parameter 와 Returns 는 Summary 다음의 최상단에 표현된다.
     */
    func notation(){}
    
    //MARK: example - Basic
    /**
     summary는 첫단락이며, 첫 단락은 Suggest 기능을 사용할 때 표현된다.
     
     두번째 단락부터는 discussion 섹션에 포함된다.
     
     세번째 단락도 마찬가지.
     
     > 노트의 제목은 콜론으로 표현한다.:
     > 노트의 제목과 노트 사이에는 들여쓰기가 필요하지 않다.
     >
     > 노트내 개행을 위해서는 빈 노테이션을 사용한다.
     
     >노트간 구분을 위해서는 빈라인을 사용한다.
     >
     >노트의 제목이 없다면 note 가 기본 제목이 된다.
     

         ```
         코드블럭은 이와 같다. 주의할 점은 들여쓰기이다.
             코드블럭 지시자는 일치해야 하며 (일치하지 않으면 코드블럭 종료되지 않음)
            코드 블럭 내의 문장에 대한 들여쓰기 수준은 기ㅕㅕㅕㅕㅕㅕㅕㅕㅕ,
             코드블럭 내에서 들여쓰기가 적용되려면, 기호 이상의 들여쓰기 수준이 요구된다.
             #include <stdio.h>
                  fileprivate func basic_comment() -> Int {
                      
                  }
            코드 블럭 자체의 문법 검사 요인은 없다.
         ```
     
     - Parameter void: 파라미터의 설명은 이곳에 작성한다. 예시를 위해 void라고 넣었지만 없으면 생략
                       - parameter : 노테이션 작성시 주의할 사항은 공백이다. 하이픈과 글자사이는 띄어쓰고, 콜론과 글자 사이는 띄어도 상관없다.
                    문장 사이의 엔터, 탭과 스페이스는 모두 단일 스페이스로 치환된다.
     
     - Returns: void
        여기에 설명을 추가한다. 주의할 점은 기호와 글자사이의 공백이다. 하이픈과 글자 사이는 띄어쓰고, 콜론과 글자 사이는 상관없다.
        문장사이에 엔터, 탭과 스페이스로 개행 및 들여쓰기를 할 수 있지만, 스페이스 한개로 실제 반영되진 않는다.
        뒤의 문장에서 __[⏎ ] [space] [tab]__ 은 모두 단일 스페이스로 치환된다. 다른 기호들을 추가할 때 원하는 바와 다를 수 있다. __ex) 리스트 생성 기호__
     
     파라미터 리턴 노테이션은 빈라인 개행을 한번 더 하게 되면 종료된다.
     기본적으로 모든 노테이션은 순서대로 표현되지만, -Parameter 와 -Returns 노테이션은 작성 순서에 상관없이 Discussion  상단에 위치한다.
     
     */
    func example() {}
    
    // MARK: - Callouts
    /**
     콜 아웃이라고 불리는 특정 노테이션을 사용하면 블록으로 감싸 강조하거나 하는 효과를 줄 수 있다.
     
     아래 나열된 미리 정의된 콜아웃을 사용해 한눈에 들어오는 정보를 나열할 수 있다.
     
     - Attention: 주의사항 (강조사항)
     - Author: 저자
     - Authors: 저자들
     - Bug: 버그
     - Complexity: 복잡도
     - Copyright: 저작권
     - Date: 날짜
     - Example: 예제 (플레이그라운드에서만 작동한다고 하는데 없어진듯)
     - Experiment: 실험
     - Important: 중요한 점
     - Invariant: 변형성
     - Note: 참고
     - Precondition: 전제 조건
     - Postcondition: 이후에 성립되어야 하는 조건
     - Remark: 주의
     - Requires: 요구사항
     - SeeAlso: 참고 (업데이트가 잘 안되어 있긴 한듯)
                [애플 가이드 문서](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/Attention.html)
     - Since: 생성된 때 (날짜, 버전, 운영체제 등)
     - Version: 버전
     - Warning: 경고


     이외에도 문서에 적용되어있지 않은걸 추가로 발견한 게 있다.
     - Tip: 이렇게 사용하세요....
     - todo: 해야 할 것
     */
    func callouts(){}
    
    // MARK: - 사용자 지정 노트
    /*
     사용자 지정 노트 사용은 아래와 같다. 마크다운의 인용구문과 비슷하게 블럭을 지어주는 역할을 한다.
     > 내용입력
     
     규칙은 다음과 같다.
     
        1. 노트간 구분을 위해서는 empty line 을 사용한다.
        2. 노트 내에서 개행을 위해서는 > 하나만 입력된 라인을 사용하여 개행한다.
        3. 기본적으로 note의 제목을 지정하지 않았을 경우 note 라고 표현되며, 사용자가 제목을 지정한 경우에는 지정된 제목으로 표현된다.
           노트의 제목은 콜록으로 최상단 라인에 표현한다.
           > [타이틀]:
     
     노트는 나열한 순서대로 표현되며,
     위에 나열한 코드 블럭 및 콜아웃들은 이 블럭과 함께 사용할 때 더욱 한눈에 직관적으로 한눈에 들어오게 그루핑하여 작성할 수 있다.
     스위프트 퀵헬프나 docc 에서 랜더링 하는 방식은 계속 변할 수 있겠으나, 작성일(2024.2월) 기준으로는 노트를 사용하여 콜아웃 및 코드블럭을 사용하는 것이 보기에 좋다.
     
     노트는 노트간 개행을 해야 한다는 점에서는 라인이 길어져 불편할 수 있으나, 콜아웃만으로 부족한 (개행 입력, 혹은 블럭 내 코드블럭 삽입) 등을 가능하게 해주므로
     간단한 한줄 정보(os 정보 혹은 날짜 등)은 콜아웃 만으로 기입하고, 세부적인 예시와 설명이 필요한 부분은 note블럭으로 작성을 하면 좋은 듯 하다.
     */
    /**
     > 제목을 입력하지 않으면 Note로 제목이 지정된다.
     > 내용은 여기에 입력
     >
     > 노트 내 개행을 위해서는 위와 같이 빈 노테이션 입력
     > 아래는 위의 콜아웃과 같은 이름을 가지고 노트를 생성함
     > 노트를 사용하면 콜아웃에 포함되지 않는 항목까지 같은 방식으로 나열할 수 있다.

     > Attention: 주의
     
     > Author: 저자
     
     > Authors: 저자들
     
     > Bug: 버그
     
     > Complexity: 복잡도
     
     > Copyright: 저작권
     
     > Date: 날짜
     
     > Example: 예제 (플레이그라운드에서만 작동한다고 하는데 없어진듯)
     
     > Experiment: 실험
     
     > Important: 중요
     
     > Invariant: 변하지 않는 값을 나열 (참조에 의한 호출의 경우에는 참조된 값을 가공하기 위함인데, 참조된 값의 불변성이 유지될 경우 사용)
     >                 스위프트에서는 inout 키워드를 사용하도록 명시되기 때문에 파라미터
     
     > Note: 참고
     
     > Precondition: 선조건
     
     > Postcondition: 후조건
     
     > Remark: 주의
     
     > Requires: 요구사항
     
     > SeeAlso: 참고 (업데이트가 잘 안되어 있긴 한듯)
                [애플 가이드 문서](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/Attention.html)
     
     > Since: 생성된 때 (날짜, 버전, 운영체제 등)
     
     > Version: 버전
     
     > Warning: 경고
     
     > Tip:
     > 아래와 같이 사용하세요
     > ```
     > basic_note()
     > ```
     >
     > iOS 17.0 에서 새로 도입되었기 때문에 [공식문서] 를 참조하세요
     >
     > 본 함수를 사용하는 것보다 공식 라이브러리의 함수를 사용하는 것이 장기적으로 좋습니다.
     >
     */
    func note(){}
    
}










// MARK: - QuikHelpCommentGuide
class QuickHelpCommentGuide{
    //MARK: 작성을 위한 Tip
    /**
     > Tip:
     > 쉬운 작성을 위해 다음 단계를 따라하면 된다.
     >
     > 1. 선언이 완료된 함수에 add documentation 명령 실행하여 자동완성되는 목록 생성
     >
     >    (단축키 혹은 메뉴는 아래와 같다)
     >    * [⌘Commend] + [⌥Option] + [/]
     >    * [Edit] -> [Structure] -> [add Doumentation]
     >    * 마우스 우클릭 -> add documentation 선택
     >
     > 2. 자동 완성된 퀵헬프 주석을 블럭 주석으로 변경한다.
     >
     > 3. 필요한 Documentation 항목을 다 채워넣었으면
     >     note로 작성할 목록들을 퀵주석 블럭을 생성하여 일단 내용을 채워 넣는다.
     >
     > ```
     > 코드블럭을 쉽게 적용하는 단축키는
     >      전체를 선택한 뒤
     >      [Caps Lock] + [`] 키를 반복 사용(3회)
     > 퀵헬프 가독성을 위해 좌우로 길지 않으면 좋다.
     > ```
     >
     > 4. 작성한 주석을 블록으로 노트로 만들고 싶은 경우
     >     첫 열을 다중행 선택하여 노트를 적용하고 싶은 > 를 삽입한다. 다중행 선택 방법은 아래와 같다.
     >     * [⌥ option] + 드래그
     >     * [⌃ control] + [⇧ shift] + [↓ or ↑ 커서이동]

     아래의 네가지는 색깔이 다른 녀석들이니, 유용하게 써먹자.
     - Experiment: []
     - Important: []
     - Warning: []
     - Tip: []
     
     가급적
     * Experiment
     * Important
     * Warning
     * Tip
     
     순서로 가장 앞에 배치하여, 퀵헬프 시 한눈에 들어오도록 한다.
     익숙해질 때까지 이 QickHelpCommentGuide class 를 Helper 그룹에 넣어서 관리하도록 하자.
     */
    func QickHelpCommentGuide(){}
    // MARK: template
    /**
     <#Summary#>
     
     <#Discussion#>
     
     > Usage:
     >
     >```
     >
     >```
     
     > Warning:
     >
     >```
     >
     >```
     
     > Warning:
     >
     >```
     >
     >```
     
     > Warning:
     >
     >```
     >
     >```
     
     > Tip:
     >
     >```
     >
     >```
     
     */
    func QuickhelpTemplete(){}
}










//MARK: - 실제 사용 예

import SwiftUI
extension Text {
    /**
     stroke Text and return some View.
     This function is simply calling the shadow function as many times as the parameter, linewidth.
     
     - Parameters:
       - color: Color for stroke
       - lineWidth: Stroke/shadow width ( greater than 0 ).
                    0 or a negative number returns itself as some View.
                    this function just calling the shadow() function as many times as the linewidth.
     - Returns: some View with stroke effect applied

     > Usage:
     >```
     > var body : some View {
     >    Text("hello").stroke(color: .black, lineWidth: 5)
     > }
     >```
     
     > Tip:
     > this method return some View, not Text
     > It should be called last.
     >
     > Use like below
     >```
     >  Text("Hello")
     >      .font(.system(size: 48))
     >      .foregroundColor(.white)
     >      .stroke(color: .black, lineWidth: 4)
     >```
     
     > Warning:
     > Don't Use like below
     >```
     > Text("Hello")
     >      .stroke(color: .black, lineWidth: 4)
     >      .font(.system(size: 48))
     >      .foregroundColor(.white)
     >```
     
     Important:
     View 전체에 적용할 속성은 나중에, Text에 적용할 속성은 먼저 적용
     
     - Author: Flapper
     */
    func stroke(color: Color, lineWidth: Int) -> some View {
        self.modifier(Stroked(color: color, lineWidth: lineWidth))
    }
    
    struct Stroked : ViewModifier{
        var color: Color
        var lineWidth: Int
        
        func body(content: Content) -> some View {
            applyShadow(content: AnyView(content), lineWidth: lineWidth)
        }
        
        func applyShadow(content:AnyView, lineWidth: Int)-> AnyView{
            if lineWidth <= 0{
                return content
            }else{
                return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
            }
        }
    }
}









// MARK: - playground markdown 문법

struct Markdown{
    /*
     플레이 그라운드에서는 별도로 마크다운 문법을 제공하며 이를 랜더링된 페이지로 보여줄 수도 있다.
     플레이 그라운드 마크다운 주석은 :(콜론)을 이용하며 기본 주석 양식에 콜론을 사용하여 표현한다.
     
     플레이그라운드에 작성된 마크업 주석을 렌더링 된 페이지로 보는 방법은 [Editor] -> [Show Rendered Markup] 이며
     
     일반 퀵주석에도 마크다운 문법을 적용하면,
     DocC를 사용한 문서 파일을 좀 더 예쁘게 꾸밀 수 있다.
     */

    // 아래의 방법은 주석은 playground 한정

    /*:
     # 안녕
     */


    // MARK: Format
    /**
     글자의 포멧을 다루는 방법은 마크다운 문법과 비슷하다. 강조는 **강조**,  __강조__, *이탤릭*, __이탤릭__, `코드 보이스`
     
     `string` is good
     코드보이스는 뭔지는 잘 모르겠다.
     */
    func basic_Format(){}
}
