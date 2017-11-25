<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<!-- 본문 부분 -->
		<div class="content-page">
			<!-- 채팅 페이지  -->
			<div class="chatting-main">
				<input type="hidden" id="chatNum" value="${requestScope.chatNum}">
				<input type="hidden" id="recentMessageNum" value="${requestScope.recentMessageNum}">
				<div class="row">
					<div class="col-md-12">
						<div id="chatDiv" >
							<c:forEach items="${requestScope.messageList}" var="data">
								<c:choose>
									<c:when test="${data.memberId eq sessionScope.id}">
										<table class="chatSendTable">
											<tr>
												<td class="tdNick">${data.memberNick}</td>
												<td class="tdImg" rowspan="3">
													<img src="${pageContext.request.contextPath}/${data.memberImg}">
												</td>
											</tr>
											<tr>
												<td class="tdContent">
													<p class="pSendContent">${data.messageContent}</p>
												</td>
											</tr>
											<tr>
												<td class="tdTime">
													<fmt:formatDate value="${data.messageSendingTime}" pattern="yyyy년 M월 d일 H시 m분" />
												</td>
											</tr>
										</table>
									</c:when>
									<c:otherwise>
										<table class="chatReceiveTable">
											<tr>
												<td class="tdImg" rowspan="3">
													<img src="${pageContext.request.contextPath}/${data.memberImg}">
												</td>
												<td class="tdNick">${data.memberNick}</td>
											</tr>
											<tr>
												<td class="tdContent">
													<p class="pReceiveContent">${data.messageContent}</p>
												</td>
											</tr>
											<tr>
												<td class="tdTime">
													<fmt:formatDate value="${data.messageSendingTime}" pattern="yyyy년 M월 d일 H시 m분" />
												</td>
											</tr>
										</table>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
						
						<!-- 채팅 참가자 목록 -->
						<div id="chatMemberDiv">
							<div class="chatMemberTitle">
								<h5 style="font-weight:800;">채팅 참가자</h5>
							</div>
							<div class="chatMemberInOut">
								<!-- 초대하기/나가기 버튼 -->
								<button onclick="inviteFriend()" data-toggle="modal" data-target="#friendListModal" title="초대하기">
									<i class="fa fa-user-plus"></i>
								</button>
								<button onclick="goOutChat('${requestScope.chatNum}','${sessionScope.id}')" title="나가기">
									<i class="fa fa-sign-out"></i>
								</button>
							</div>
							<table id="chatMemberTable">
								<c:forEach items="${requestScope.memberList}" var="data">
									<tr onclick="goFriendPage('${data.memberId}','${data.memberNick}')">
										<td class="chatMembertdImg">
											<img src="${pageContext.request.contextPath}/${data.memberImg}">
										</td>
										<td class="chatMembertdNick">
											${data.memberNick}
										</td>
										<td>
											<c:choose>
												<c:when test="${data.memberPresentLogin eq 1 }">
													<i class="fa fa-circle" style="color:#BCE55C" title="온라인"></i>
												</c:when>
												<c:otherwise>
													<i class="fa fa-circle" style="color:#FF5A5A" title="오프라인"></i>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<!-- 채팅 입력 버튼 -->
						<div id="chatInput">
							<input id="chatMsg" type="text" placeholder="메시지를 입력하세요." onkeypress="if(event.keyCode==13) {sendMsg();}">
							<button id= "chatBtn" onclick="sendMsg()" title="전송">
								<i class="fa fa-paper-plane"></i>
							</button>
						</div>
						<i class="fa fa-refresh" onclick="refresh()" style="color:green; cursor:pointer;"></i>
					</div>
				</div>
			</div>
		<!-- 본문 끝 부분 -->
		</div>
		
		
		<!-- footer 마지막 검은 박스 -->
		<footer class="main-footer">
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-6">
						<p>KOSTA 161 RSC &copy; 2017</p>
					</div>
					<div class="col-sm-6 text-right">
						<p>
							마지막 문장
						</p>
					</div>
				</div>
			</div>
		</footer>
	</div>

	<!-- 초대하기 모달 -->
	<div class="modal fade" id="friendListModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4>친구 목록</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div id="friendListDIv">
						<table id="friendListTable">

						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" onclick="inviteCheckedFriend('${requestScope.chatNum}')" data-dismiss="modal">초대하기</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Javascript files-->
	
	<script>
		function scrollDown(){
			var chatDivScroll = document.getElementById("chatDiv"); 
			if (chatDivScroll.scrollHeight > 0) {
				chatDivScroll.scrollTop = chatDivScroll.scrollHeight;
			}
		}
		scrollDown();
	
		function sendMsg(){
			var memberId = document.getElementById("sessionId").value;
			var chatNum = document.getElementById("chatNum").value;
			var chatMsg = document.getElementById("chatMsg").value;
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					document.getElementById("chatMsg").value='';
				}
			}
			xhttp.open("POST", "${pageContext.request.contextPath}/chat/sendingMsg.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("chatNum="+chatNum+"&memberId="+memberId+"&messageContent="+chatMsg); 
		}
		
		/* 전송한 메시지  */
		function makeSendMsgBox(message){
			var chatDiv = document.getElementById("chatDiv");
			
			var chatSendTable = document.createElement("table");
			chatSendTable.className = "chatSendTable";
			
			var chatSendTr1 = document.createElement("tr");
			
			var chatSendTdNick = document.createElement("td");
			chatSendTdNick.className = "tdNick";
			chatSendTdNick.textContent = message.memberNick;
			
			var chatSendTdImg = document.createElement("td");
			chatSendTdImg.className = "tdImg";
			chatSendTdImg.setAttribute("rowspan","3");
			
			var chatSendTdImgTag = document.createElement("img");
			chatSendTdImgTag.setAttribute("src","${pageContext.request.contextPath}/"+message.memberImg);
			
			chatSendTdImg.appendChild(chatSendTdImgTag);
			
			chatSendTr1.appendChild(chatSendTdNick);
			chatSendTr1.appendChild(chatSendTdImg);
			
			var chatSendTr2 = document.createElement("tr");
			
			var chatSendTdContent = document.createElement("td");
			chatSendTdContent.className = "tdContent";
			
			var chatSendPContent = document.createElement("p");
			chatSendPContent.className = "pSendContent";
			chatSendPContent.textContent = message.messageContent;
			
			chatSendTdContent.appendChild(chatSendPContent);
			chatSendTr2.appendChild(chatSendTdContent);
			
			var chatSendTr3 = document.createElement("tr");
			
			var chatSendTdTime = document.createElement("td");
			chatSendTdTime.className = "tdTime";
			var chatSendTdTimeText = new Date(message.messageSendingTime).getFullYear() + '년 '
										+ (new Date(message.messageSendingTime).getMonth() + 1) + '월 '
										+ new Date(message.messageSendingTime).getDate() + '일 '
										+ new Date(message.messageSendingTime).getHours() + '시 '
										+ new Date(message.messageSendingTime).getMinutes() + '분';
			chatSendTdTime.textContent = chatSendTdTimeText; // 시간 textContent 삽입
			
			chatSendTr3.appendChild(chatSendTdTime);
			
			chatSendTable.appendChild(chatSendTr1);
			chatSendTable.appendChild(chatSendTr2);
			chatSendTable.appendChild(chatSendTr3);
			
			chatDiv.appendChild(chatSendTable);
		}
		
		/* 받은 메시지  */
		function makeReceiveMsgBox(message){
			var chatDiv = document.getElementById("chatDiv");
			
			var chatReceiveTable = document.createElement("table");
			chatReceiveTable.className = "chatReceiveTable";
			
			// 첫번째 열
			var chatReceiveTr1 = document.createElement("tr");
			
			var chatReceiveTdImg = document.createElement("td");
			chatReceiveTdImg.className = "tdImg";
			chatReceiveTdImg.setAttribute("rowspan","3");
			
			var chatReceiveTdImgTag = document.createElement("img");
			chatReceiveTdImgTag.setAttribute("src","${pageContext.request.contextPath}/"+message.memberImg);
			
			chatReceiveTdImg.appendChild(chatReceiveTdImgTag);
			
			var chatReceiveTdNick = document.createElement("td");
			chatReceiveTdNick.className = "tdNick";
			chatReceiveTdNick.textContent = message.memberNick;
			
			chatReceiveTr1.appendChild(chatReceiveTdImg); 
			chatReceiveTr1.appendChild(chatReceiveTdNick);
			
			// 두번째 열
			var chatReceiveTr2 = document.createElement("tr");
			
			var chatReceiveTdContent = document.createElement("td");
			chatReceiveTdContent.className = "tdContent";
			
			var chatReceivePContent = document.createElement("p");
			chatReceivePContent.className = "pReceiveContent";
			chatReceivePContent.textContent = message.messageContent;
			
			chatReceiveTdContent.appendChild(chatReceivePContent); // p를 td 자식으로
			chatReceiveTr2.appendChild(chatReceiveTdContent); // td를 tr1 자식으로
			
			// 마지막 열
			var chatReceiveTr3 = document.createElement("tr");
			
			var chatReceiveTdTime = document.createElement("td");
			chatReceiveTdTime.className = "tdTime";
			var chatReceiveTdTimeText = new Date(message.messageSendingTime).getFullYear() + '년 '
										+ (new Date(message.messageSendingTime).getMonth() + 1) + '월 '
										+ new Date(message.messageSendingTime).getDate() + '일 '
										+ new Date(message.messageSendingTime).getHours() + '시 '
										+ new Date(message.messageSendingTime).getMinutes() + '분';
			chatReceiveTdTime.textContent = chatReceiveTdTimeText; // 시간 textContent 삽입
			
			chatReceiveTr3.appendChild(chatReceiveTdTime); // td(time)를 tr3 자식으로
			
			chatReceiveTable.appendChild(chatReceiveTr1);
			chatReceiveTable.appendChild(chatReceiveTr2);
			chatReceiveTable.appendChild(chatReceiveTr3);
			
			chatDiv.appendChild(chatReceiveTable);
		}

		/* 메시지 갱신 */
		function updateChatTable(){
			var chatNum = document.getElementById("chatNum").value;
			var recentMessageNum = document.getElementById("recentMessageNum").value;
			var sessionId = document.getElementById("sessionId").value;
			
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData = JSON.parse(resData);
					
					for(i=0;i<resData.length;i++){
						if(resData[i].memberId==sessionId){
							makeSendMsgBox(resData[i]);
						} else {
							makeReceiveMsgBox(resData[i]);
						}
						scrollDown();
						if(i==resData.length-1){
							document.getElementById("recentMessageNum").value = resData[i].messageNum;
						}
					}
					
				}
			}
			xhttp.open("POST", "${pageContext.request.contextPath}/chat/recentMsg.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("chatNum="+chatNum+"&messageNum="+recentMessageNum);
		};
		
		/* 메시지 갱신 버튼 */
		function refresh(){
			updateChatTable();
		}
		
		/* 채팅방 나가기 */
		function goOutChat(chatNum, memberId, memberNick){
			if(confirm("채팅방을 나가시겠습니까?\n\n(채팅방을 나갈 경우 대화 내용이 모두 삭제됩니다)")){
				location.href="${pageContext.request.contextPath}/chat/goOutChat.do?chatNum="+chatNum+"&memberId="+memberId;
			} else {
				return false;	
			}
		}
		
		/* 초대할 친구 목록 가져오기 */
		function inviteFriend(){
			var memberId = document.getElementById("sessionId").value;
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData = JSON.parse(resData);
					makeFriendList(resData);
				}
			}
			xhttp.open("POST", "${pageContext.request.contextPath}/chat/getFriendList.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("memberId=" + memberId);
		};
		
		/* 친구초대 modal에 친구 리스트 만들기 */
		function makeFriendList(friendList){
			var friendListTable = document.getElementById("friendListTable");
			friendListTable.innerHTML = "";
			var alreadyMemberNick = document.getElementsByClassName("chatMembertdNick");
			
			for( i=0 ; i<friendList.length ; i++ ){
				var friendListTr = document.createElement("tr");
				friendListTr.setAttribute("onclick","check('tr"+friendList[i].memberId+"')");
				
				var friendListTdCheckBox = document.createElement("td");
				var friendListCheckBox = document.createElement("input");
				friendListCheckBox.setAttribute("type","checkbox");
				friendListCheckBox.setAttribute("id","tr"+friendList[i].memberId);
				friendListCheckBox.setAttribute("value",friendList[i].memberId);
				friendListCheckBox.setAttribute("name","checkedFriendList");
				
				for(j=0 ; j<alreadyMemberNick.length ; j++){
					if(friendList[i].memberNick == alreadyMemberNick[j].textContent.trim()){
						friendListCheckBox.setAttribute("disabled","disabled");
					}
				}
				
				friendListTdCheckBox.appendChild(friendListCheckBox);
				friendListTdCheckBox.className = "tdCheck";
				
				var friendListTdImg = document.createElement("td");
				var friendListImg = document.createElement("img");
				friendListImg.setAttribute("src","${pageContext.request.contextPath}/"+friendList[i].memberImg);
				friendListTdImg.appendChild(friendListImg);
				friendListTdImg.className = "tdImg";
				
				var friendListTdNick = document.createElement("td");
				friendListTdNick.textContent = friendList[i].memberNick;
				
				var friendListTdLogin = document.createElement("td");
				var friendListLoginIcon = document.createElement("i");
				friendListLoginIcon.className = "fa fa-circle";
				if(friendListTdLogin==1){
					friendListLoginIcon.style.color = "#BCE55C";
				} else {
					friendListLoginIcon.style.color = "#FF5A5A";
				}
				friendListTdLogin.appendChild(friendListLoginIcon);
				
				friendListTr.appendChild(friendListTdCheckBox);
				friendListTr.appendChild(friendListTdImg);
				friendListTr.appendChild(friendListTdNick);
				friendListTr.appendChild(friendListTdLogin);
				
				friendListTable.appendChild(friendListTr);
			}
		}
		
		/* 선택된 친구 초대 */
		function inviteCheckedFriend(chatNum){
			var checkedFriendCheckBox = document.getElementsByName("checkedFriendList");
			var checkedFriendArr = [];
			var checkedFriendStr = "";
			for(i=0 ; i<checkedFriendCheckBox.length ; i++){
				if(checkedFriendCheckBox[i].checked){
					checkedFriendArr.push(checkedFriendCheckBox[i].value);
				}
			}
			
			if(checkedFriendArr.length != 0){
				for(i=0 ; i<checkedFriendArr.length ; i++){
					checkedFriendStr += checkedFriendArr[i];
					if(i != checkedFriendArr.length-1){
						checkedFriendStr += ",";
					}
				}
				location.href="${pageContext.request.contextPath}/chat/invite.do?chatNum="+chatNum+"&inviteList="+checkedFriendStr;
			} else {
				alert("초대할 친구를 선택해주세요.");
				inviteFriend();
			}
		}
		
		/* 친구 선택시 checkbox checked 설정/취소 */
		function check(trFriendId){
			if(!document.getElementById(trFriendId).disabled){
				if(!document.getElementById(trFriendId).checked){
					document.getElementById(trFriendId).checked = "checked";
				} else {
					document.getElementById(trFriendId).checked = "";
				}
			}
		};
		
		/* 마이/친구 페이지로 이동 */
		function goFriendPage(memberId, memberNick){
			var myId = document.getElementById("sessionId").value;
			if(memberId==myId){
				if(confirm("마이페이지로 이동하시겠습니까?")){
					location.href = "${pageContext.request.contextPath}/board/myBoards.do";
				} else {
					return false;
				}
			} else {
				if(confirm(memberNick+"님의 페이지로 이동하시겠습니까?")){
					location.href = "${pageContext.request.contextPath}/friend/getFriendInfo.do?friendId="+memberId;
				} else {
					return false;
				}
			}
		}


		

		
/*  		setInterval(	
 				function(){ 
					updateChatTable();
				}, 5000); */

	</script>
	
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>

</body>
</html>



