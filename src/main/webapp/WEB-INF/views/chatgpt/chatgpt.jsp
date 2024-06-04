<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GPT</title>
<link href="css/chat.css" rel="stylesheet" />
</head>
<body>
    <!-- nav 영역 -->
    <jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
    <!-- nav 영역 끝 -->

    <div class="chat-container-wrapper">
        <div id="newChatButton">
            <!-- newChat을 오른쪽으로 이동 -->
            <button class="btn btn-primary"
                style="margin-top: 10px; background-color: #000; border-color: #000;"
                onclick="addRoom()">New Chat</button>
            <hr>
            <!-- 방 목록 출력 -->
            <c:forEach var="room" items="${roomList}">
                <div class="room">
                    <div class="room-name">
                    	${room.regDate.substring(0, 10)} 방${room.roomNo}
                        <input type="hidden" class="roomNo" value="${room.roomNo}" />
                        <button class="delete-room-button"
                            onclick="deleteRoom('${room.roomNo}')">X</button>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="chat-container">

            <div class="messages" id="messages">
                <!-- 채팅메세지 나오는 부분 -->
            </div>
            <div class="input-group">
                <input type="text" id="messageInput" placeholder="메시지를 입력하세요... (일정 추천은 캘린더에서!)">
                <button id="sendButton">전송</button>
            </div>
            <div class="input-group">
            </div>
        </div>
    </div>

    <script>
    let currentPlan;
    let calTitle;
    let calStartdt;
    let calEnddt;

    function addRoom() {
        // 방 목록의 각 방에 대한 정보를 가져옴
        const rooms = document.querySelectorAll('.room-name');
        let newRoomNo;

        // AJAX를 통해 서버에 새로운 방 추가 요청 보내기
        $.ajax({
            url: '/my/createRoom',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ memId: '${sessionScope.login.memId}' }),
            success: function(response) {
            	newRoomNo = response.roomNo; 
            	  // 새로운 방 이름
                const roomName = '방' + newRoomNo;
            	  
                // 새로운 방이 성공적으로 추가된 경우, 화면에도 새로운 방 추가
                const roomElement = document.createElement('div');
                roomElement.classList.add('room');

                const roomNameElement = document.createElement('div');
                roomNameElement.classList.add('room-name');
                roomNameElement.textContent = roomName;

             // 새로운 방 번호를 숨은 입력란에 추가
                const hiddenRoomNoInput = document.createElement('input');
                hiddenRoomNoInput.type = 'hidden';
                hiddenRoomNoInput.classList.add('roomNo');
                hiddenRoomNoInput.value = newRoomNo;
                roomNameElement.appendChild(hiddenRoomNoInput);

                const deleteButton = document.createElement('button');
                deleteButton.textContent = 'X';
                deleteButton.classList.add('delete-room-button');
                deleteButton.addEventListener('click', function() {
                	deleteRoom(newRoomNo);
                });
                roomNameElement.appendChild(deleteButton);

                roomElement.appendChild(roomNameElement);
                document.querySelector('hr').insertAdjacentElement('afterend', roomElement);
				
                // 방이 생성될 때 메시지 출력 부분 초기화
                const messagesContainer = document.getElementById('messages');
                messagesContainer.innerHTML = '';
                
                // 새로 생성된 방을 자동으로 선택
                fetchAndDisplayChatList(newRoomNo);
            },
            error: function(xhr, status, error) {
                console.error('Error creating new room:', error);
            }
        });
    }

    function deleteRoom(roomNo) {
        if (confirm('정말로 이 채팅방을 삭제하시겠습니까?')) {
            $.ajax({
                url: '/my/deleteRoom',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ roomNo: roomNo }),
                success: function(response) {
                	console.log('==============',response);
                    // 채팅방이 성공적으로 삭제된 경우, 화면에서 해당 채팅방을 제거
                    const roomElement = document.querySelector('.roomNo[value="'+roomNo+'"]');
                    if (roomElement) {
                        const parentRoom = roomElement.parentNode.parentNode;
                        parentRoom.remove();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('채팅방 삭제 실패:', error);
                }
            });
        }
    }

        const messagesContainer = document.getElementById('messages');
        const messageInput = document.getElementById('messageInput');
        const sendButton = document.getElementById('sendButton');

        function insertChatMsg(roomNo, message, memId) {
            var chatData = {
                "memId" : memId,
                "roomNo" : roomNo,
                "chatMsg" : message
            };

            $.ajax({
                url : '/my/sendMessage',
                type : 'POST',
                contentType : 'application/json',
                dataType : 'json',
                data : JSON.stringify(chatData),
                success : function(response) {
                    // 성공적으로 메시지를 전송한 경우 실행할 코드 추가
                    console.log('메시지 전송 성공');
                },
                error : function(xhr, status, error) {
                    // 메시지 전송 실패 시 실행할 코드 추가
                    console.error('메시지 전송 실패:', error);
                }
            });
        }
        
        function fetchChatList(roomNo) {
            $.ajax({
                url: '/my/chatListView',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ roomNo: roomNo }),
                success: function(data) {
                    console.log('Received chat list:', data);
                    // 받아온 채팅 데이터를 화면에 출력
                    data.forEach(chat => {
                        if (chat.memId != 'gpt') {
                            appendMessage('user-message', chat.chatMsg, true);
                        } else {
                            appendMessage('gpt-message', chat.chatMsg, false);
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching chat list:', error);
                }
            });
        }

        
     // GPT 응답을 서버로 전송하는 함수
        function sendGPTResponse(message) {
            const roomNo = document.querySelector('.roomNo').value;

            // 서버로 GPT 응답 전송
            insertChatMsg(roomNo, message, 'gpt'); // 이 부분은 사용자가 아닌 GPT임을 나타내는 'gpt'로 수정되어야 합니다.
        }

        function sendMessage() {
            const message = messageInput.value.trim();
            if (message === '')
                return;

            // 사용자 메시지를 화면에 추가
            appendMessage('user-message', message, true);

            const roomNo = document.querySelector('.roomNo').value;

            // 서버로 메시지 전송
            insertChatMsg(roomNo, message, '${sessionScope.login.memId}');

            // ChatGPT API에 요청을 보냄
            fetchChatResponse(message);

            // 입력 필드 초기화
            messageInput.value = '';

            // 화면을 항상 맨 아래로 스크롤
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        sendButton.addEventListener('click', sendMessage);

        messageInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        function fetchChatResponse(message) {
            const api_key = ""; // API KEY
            fetch('https://api.openai.com/v1/chat/completions', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + api_key // ChatGPT API Key
                },
                body: JSON.stringify({
                    model: 'gpt-3.5-turbo',
                    messages: [{
                        role: 'user',
                        content: message
                    }]
                })
            })
            .then(response => response.json())
            .then(data => {
                const chatResponse = data.choices[0].message.content;
                appendMessageWithTyping('gpt-message', chatResponse, false);
                // GPT 응답을 서버로 전송
                sendGPTResponse(chatResponse);
            })
            .catch(error => console.error('Error fetching chat response:', error));
        }

        function appendMessage(className, message, isUserMessage) {
            const messageElement = document.createElement('div');
            const contentElement = document.createElement('span');
            contentElement.textContent = message;
            contentElement.classList.add('message-content');
            messageElement.appendChild(contentElement);
            messageElement.classList.add(className);
            messagesContainer.appendChild(messageElement);

            if (isUserMessage) {
                const userLabel = document.createElement('div');
                userLabel.textContent = '${sessionScope.login.memNm}';
                userLabel.classList.add('user-message-label');       
                messageElement.prepend(userLabel);
            } else {
                const gptLabel = document.createElement('div');
                gptLabel.textContent = 'GPT';
                gptLabel.classList.add('gpt-message-label');
                messageElement.prepend(gptLabel);
            }
            
            // 새로운 메시지가 추가된 후 스크롤을 항상 맨 아래로 이동
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
        
        // GPT 답변 타이핑 효과 포함 함수
        function appendMessageWithTyping(className, message, isUserMessage) {
            const messageElement = document.createElement('div');
            messageElement.classList.add(className);

            const contentElement = document.createElement('span');
            contentElement.classList.add('message-content');
            messageElement.appendChild(contentElement);

            messagesContainer.appendChild(messageElement);

            let index = 0;

            function addCharacter() {
                if (index < message.length) {
                    contentElement.textContent += message.charAt(index);
                    index++;
                    setTimeout(addCharacter, 30); // 30ms 간격으로 문자를 추가합니다. 이 값을 조정하여 타이핑 속도를 조절할 수 있습니다.
                    messagesContainer.scrollTop = messagesContainer.scrollHeight;
                }
            }

            addCharacter();

            if (isUserMessage) {
                const userLabel = document.createElement('div');
                userLabel.textContent = '${sessionScope.login.memNm}';
                userLabel.classList.add('user-message-label');
                messageElement.prepend(userLabel);
            } else {
                const gptLabel = document.createElement('div');
                gptLabel.textContent = 'GPT';
                gptLabel.classList.add('gpt-message-label');
                messageElement.prepend(gptLabel);
            }

            // 스크롤을 항상 맨 아래로 이동
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        
        function fetchAndDisplayChatList(roomNo) {
            // 해당 방의 채팅 내역을 가져옴
            fetchChatList(roomNo);
        }

        // 방 목록의 각 방에 이벤트 리스너 추가
document.addEventListener("DOMContentLoaded", function() {
    // 클릭된 방 추적을 위한 변수
    let clickedRoomNo = null;

    // 방 목록의 각 방에 이벤트 리스너 추가
    document.querySelectorAll('.room-name').forEach(room => {
        room.addEventListener('click', function() {
            const roomNo = this.querySelector('.roomNo').value;
            // 이미 클릭된 방인지 확인
            if (clickedRoomNo !== roomNo) {
                // 클릭된 방 번호 업데이트
                clickedRoomNo = roomNo;
                // 메시지가 나오는 부분 초기화
                const messagesContainer = document.getElementById('messages');
                messagesContainer.innerHTML = '';
                // 해당 방의 채팅 내역을 가져와 화면에 표시
                fetchAndDisplayChatList(roomNo);
            }
        });
    });

    // 가장 큰 방 번호를 가진 방을 자동으로 선택
    const rooms = document.querySelectorAll('.room-name');
    let maxRoomNo = 0;
    rooms.forEach(room => {
        const roomNo = parseInt(room.querySelector('.roomNo').value);
        if (roomNo > maxRoomNo) {
            maxRoomNo = roomNo;
        }
    });
    clickedRoomNo = maxRoomNo; // 최대 방 번호의 방을 자동으로 선택
    // 초기화 후 해당 방의 채팅 내역을 가져와 화면에 표시
    const messagesContainer = document.getElementById('messages');
    messagesContainer.innerHTML = '';
    fetchAndDisplayChatList(maxRoomNo);
});

    </script>
</body>
</html>
