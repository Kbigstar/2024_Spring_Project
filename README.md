# FullCalendar API를 활용한 일정관리 홈페이지

- **Front-End**: HTML, CSS, JavaScript, jQuery
- **Back-End**: Spring, Flask

<br>

## 구현 목표
 - **FullCalendar를 사용하여 회원들의 일정을 데이터베이스에 저장하고 관리하며, ChatGPT를 통합하여 회원들이 여가 시간에 대한 일정 추천을 받거나 다양한 질문에 대한 답변을 제공할 수 있도록 구현. 이 프로젝트는 사용자 경험을 향상시키고, 스마트한 일정 관리와 개인화된 추천 서비스를 제공하는 것을 목표로 합니다.**

<br>

## 구현 기능
### FullCalendar 이벤트 처리:
 - **FullCalendar 라이브러리를 통합하여 사용자 인터페이스 구현.**
 - **사용자가 일정을 추가, 수정, 삭제할 수 있는 기능을 구현하였으며, 이러한 이벤트는 즉시   · 데이터베이스에 반영될 수 있도록 구현.**
 - **Ajax와 같은 비동기 통신 방식을 사용하여 일정 데이터를 동적으로 처리**
### DB 구축 및 연동:
 - **Oracle 데이터베이스를 설계하고, JDBC를 통해 Spring 애플리케이션과 연동했습니다.**
  - **회원 정보와 일정 데이터를 효율적으로 관리하기 위해 관계형 데이터베이스 스키마를 설계 및 구현.**

### 로그인 / 회원가입 시스템 구축:
 - **Spring Security를 사용하여 비밀번호의 보안을 강화.**
### ChatGPT API를 활용한 채팅 서비스:
 - **OpenAI의 ChatGPT API를 통합하여 사용자가 일정 추천을 받거나 질문에 대한 답변을 실시간으로 받을 수 있는 채팅 서비스를 개발.**
 - **ChatGPT와의 원활한 통신을 위해 python Flask RESTful API를 설계하고, 이를 통해 사용자의 요청을 처리하고 응답을 제공했습니다.**
 - **회원들의 여가 시간을 분석하고, 맞춤형 일정을 추천할 수 있도록 자연어 처리 기능 구현.**

<br>

## 느낀점 및 보완사항
### FullCalendar API 사용
- **API를 사용하면서 일정을 등록할때 일반적으로 ex)시작일자 : 2024.05.05 / 종료일자 : 2024.05.06 이라고 할 때, API에서는 종료일자가 2024.05.07 과 같이 사용.. endDate가 항상 독점적이고, 날짜 범위가 끝나는 시간이 다음 날 0시를 의미하기 때문이라고 함.. 어느 API이건 사용할 때는 Docs를 잘 참고하자..**

### 코드 리팩토링
- **코드를 짜면서 반복되는 기능들을 함수로 만들어서 하면 코드의 길이가 줄어들고 가독성이 개선될 부분이 많이 있었는데 해당 부분을 고려하지 않고 만들어서 가면 갈 수록 코드의 가독성이 떨어져 작업이 힘들었다.. 추후에 코드 리팩토링을 통해 가독성을 개선이 필요함..**

    

<br>
<hr>
<br>    
   
## 메인화면
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/1cd77ab0-2802-4a30-a210-6723af843cef" alt="main">
</p>
<br>
<hr>
<br>

## 캘린더 화면
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/4aefeb08-98a7-4ec7-a9c9-4ad4559a860b" alt="calendarView">
</p>
<br>
<hr>
<br>

### 일정등록
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/560f709c-1d2d-4d7d-b1bd-9092b52b5e64" alt="create_plan1">
</p>
<br>
<hr>
<br>

- **수정 / 삭제 Modal** 
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/6bbda281-69ff-4ee7-9775-93873e93cef5" alt="edit_plan1">
</p>
<br>
<hr>
<br>

- **일정 수정** 
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/409dae46-6b6a-4c70-861d-53971d3739d9" alt="edit_plan2">
</p>
<br>
<hr>
<br>

- **하루 종일 Event 처리**
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/c38e2008-3088-4d21-b245-def51c5aaaf2" alt="schedule planner with blue and yellow sections, time slots, and labels for different activities and breaks">
</p>
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/32ced0cc-1447-47c4-8cdb-dcb9210f81bc" alt="detailed daily planner with time slots, categories for tasks, breaks, and goals, and color-coded sections">
</p>
<br>
<hr>
<br>

- **일정 추천**
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/7c912795-cf3e-4527-9b52-dd3c9d381bf8" alt="recommendation plan with sections for morning, afternoon, and evening activities, and space for notes">
</p>

<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/1547aca3-63e9-4bd6-b94d-f18bd42012b0" alt="recommendation plan with time slots, activities, and goals for different parts of the day">
</p>
<br>
<hr>
<br>

- **세부 일정 추천**
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/8a3d30fc-5313-4ed8-9f2b-52cad1b943cc" alt="detailed recommendation plan with categorized sections for tasks, goals, and priorities">
</p>

<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/f3379140-4d78-46b2-88d1-8cdfd1689e05" alt="detailed recommendation plan with time slots, task categories, and spaces for notes and priorities">
</p>
<br>
<hr>
<br>


- **ChatGPT 채팅서비스**
<p align="center">
  <img src="https://github.com/Kbigstar/2024_Spring_Project/assets/93638178/1ebeff55-96b7-4354-8026-447be87d27e2" alt="chatGPT chat interface showing a conversation with a user, displaying text input and response sections">
</p>

