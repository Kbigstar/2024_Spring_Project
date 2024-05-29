<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
	.faq_wrapper {
	    display: flex;
	    flex-direction: column;
	    justify-content: center; /* 세로 중앙 정렬 */
	    align-items: center; /* 가로 중앙 정렬 */
	    min-height: 600px; /* 최소 높이 설정 */
	    margin: 50px auto; /* 위아래 여백만 지정 */
	    border: 1px solid #ebeaec;
	    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
	    border-radius: 16px;
	    padding: 24px;
	    text-align: center;
	    width: 1000px;
	}
	.details-container {
	            text-align: center; /* 각 요소를 가운데 정렬하기 위함 */
	        }
	        details {
	            display: inline; /* details 요소를 인라인 블록으로 설정하여 가로로 배치 */
	            width: 500px;
	            max-width: 600px;
	            text-align: center;
	            margin: 0 auto; /* 가운데 정렬 */
	        }
	
	    details { margin:5px 0 10px; }
	    details > summary { background:#000; color:#fff; padding:10px; outline:0; border-radius:5px; cursor:pointer; transition:background 0.5s; text-align:left; box-shadow: 1px 1px 2px gray;}
	    details > summary::-webkit-details-marker { background:#000; color:#fff; background-size:contain; transform:rotate3d(0, 0, 1, 90deg); transition:transform 0.25s;}
	    details[open] > summary::-webkit-details-marker { transform:rotate3d(0, 0, 1, 180deg);}
	    details[open] > summary { background:#000;}
	    details[open] > summary ~ * { animation:reveal 0.5s;}
	    .tpt { background:#000; color:#fff; margin:5px 0 10px; padding:5px 10px; line-height:25px; border-radius:5px; box-shadow: 1px 1px 2px gray;}
	    
	    details[open] .tpt {
	    display: block;
	}
    
	span{
	    margin-bottom: 20px; font-weight: bold; font-size: 50px;
	}
	summary{
	    font-weight: bold; font-size: 20px;
	}
	
	.tpt{
	    font-weight: bold; font-size: 20px; height: 50px;  /* 가운데 정렬 */
	}

    @keyframes reveal {
        from { opacity:0; transform:translate3d(0, -30px, 0); }
        to { opacity:1; transform:translate3d(0, 0, 0); }
    }
    </style>
</head>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
	<!-- nav 영역 끝 -->
		      <div class="container-fluid" style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
        <div>
            <span style="font-size: 45px; font-weight: bold;">Calendar</span>
        </div>
	     <div class="faq_wrapper">
        <span> FAQ </span>
        <div class="details-container">
            <details >
                <summary >캘린더 사용방법</summary>
                <div class="tpt" >일정이 없는 칸을 누르고 캘린더를 채워보세요!</div>
            </details>
            <br>
            <br>
            <details >
                <summary >ChatGPT 사용방법</summary>
                <div class="tpt">추천 받고싶은 일정이나 간단한 질문을 해보세요!</div>
            </details>
            <br>
            <br>            
            <details >
                <summary>문의사항</summary>
                <div class="tpt" >127897@naver.com 으로 문의해주세요!</div>
            </details>
			<br>
            <br>
        </div>
    </div>
    </div>
</body>
</html>