<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>RSC</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<!-- Bootstrap CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<!-- Font Awesome CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<!-- Custom icon font-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
<!-- Google fonts - Roboto -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
<!-- jQuery Circle-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/grasp_mobile_progress_circle-1.0.0.min.css">
<!-- Custom Scrollbar-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<!-- theme stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<!-- Favicon-->
<link rel="shortcut icon" href="favicon.png">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.chatButton {
    background-color: #F7921E; 
    color: white; 
    border: 2px solid #F7921E;
    width:120px;
    height:35px;
    border-radius: 10px;
    margin-left: 87%;
}

.chatButton:hover {
    background-color: white;
    color: #F7921E;
    border: 2px solid #F7921E;
}
.chatPeople{
	display: inline-block;
	font-size: 14pt;
	margin-left: 30px;
	position:relative;
	top: 5px;
	font-weight: bold;
	color: #b9b9b9;
}
div .chatImg{
	width:100px;
	height:100px;
	display: inline-block;
	margin-left: 20px;
	margin-top: 20px;
	border-radius: 100px;
}

.profImg{
	border-radius: 100px;
	width:100px;
}

.chatModal{
	width:450px;
}
.loginPresent{
	display: inline-block;
	margin-left: 70px;
	font-size: initial;
	cursor: pointer;
}
.chatRoom{
	height:140px;
}
.chatNicks{
	display:inline-block;
	font-size: 25pt;
	font-weight: bold;
	color: #b9b9b9;
	float:right;
	margin-top: 40px;
	width:500px;
}
.chatMemberProf{
	display:inline-block;
	font-size: 18pt;
	font-weight: bold;
	color: #b9b9b9;
	margin-left:50px;
}
#chatDiv{
	width:100%;
}
</style>
</head>

<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<!-- 본문 부분 -->
		<div class="content-page">

			<!-- 그룹관리 메인페이지 -->
			<div class="groupAdmin-page">
				<div class="row">
					<div class="col-md-12">
						<h3>채팅 목록</h3>
						<button class = "chatMake chatButton" data-toggle="modal" data-target="#chatModal" onclick = "moreMember()">
								<b>채팅방 만들기</b>
						</button>
					</div>
				</div>
			<c:forEach var="rooms" items="${requestScope.list}">	
			<div class="row" style = "margin-bottom: 0px;">
				<div id="chatDiv">
						<div class="col-md-12">
							<div class="card w3-round-large chatRoom" onclick = "goChat(${rooms.chatNum})">
								<!-- 글 내용 -->
								<div class="content">
									<div class = "chatMemberProf">
									<c:forEach var = "member" items = "${rooms.members}" varStatus = "state" begin = "0" end = "3">
										<img class = "chatImg" src = "${pageContext.request.contextPath}/${member.memberImg}">
									</c:forEach>
									</div>
									<div class = "chatNicks right">
										<c:forEach var = "member" items = "${rooms.members}" varStatus = "state" begin = "0" end = "3">
											<span>${member.memberNick}<c:if test = "${not state.last}">,</c:if><c:if test = "${fn:length(rooms.members)>4}">...</c:if></span>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
				</div>
			</div>
			</c:forEach>
		</div>
			
		</div>
		<!-- 본문 끝 부분 -->

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
		
		<!-- 현재 접속중인 친구 모달 -->
		<div class="modal fade" id="chatModal"role="dialog">
    	<div class="modal-dialog">
    		<div class="modal-content chatModal">
        		<div class="modal-header mod-head">
          			<h4 class="modal-title">접속중인 친구</h4>
        		</div>
				<div class="modal-body">
  						<div class="container">
  							<table>
  								<tbody id = "presentLogin">
  								
  								</tbody>
  								<tfoot>
  									<tr>
  										<td><button class = "chatButton" style = "width:100%;" onclick = "moreFriendsView(window.count = window.count + 2)">친구 더 보기</button></td>
  									</tr>
  									<tr>
  										<td><button class = "chatButton" style = "width:100%;" onclick = "makeRoom()">채팅방 만들기</button></td>
  									</tr>
  								</tfoot>
  							</table>
  							
  						</div>
				</div>
      		</div>
    	</div>
  	</div>
		
	</div>
	<!-- Javascript files-->
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script type="text/javascript">
	var cnt = 0;
	
	//친구 더 보기
	function moreFriendsView(count){
		
		var friendView = document.getElementsByClassName("friendView");
		count = count>= friendView.length? friendView.length:count;
		
		for (var i = 0; i < friendView.length; i++) {
			friendView[i].style.display = 'none';
		}
		
		for (var i = 0; i < cnt; i++) {
			friendView[i].style.display = '';
		}
		
		console.log("count: "+count);
		console.log("length: "+friendView.length);
		
	}

	//친구 목록 가져오기
	function friendList(resData){
		
		var friendHTML = '';
		
		if(resData.length == 0){
			friendHTML = '<tr><td><div class = "chatPeople">친구가 없습니다</div></td></tr>';
		}else{
			for(var i = 0;i<resData.length;i++){
				
				friendHTML += '<tr class = "friendView"><td><div class = "chatImg"><img class = "profImg" id = "profImg" src = "${pageContext.request.contextPath}/'+resData[i].memberImg+'">'
					+'</div><div class = "chatPeople">'+resData[i].memberNick+'</div>'+
					'<div class = "loginPresent"><i class="fa fa-circle loginPresent" style = "color:green" name = "loginPresent" onclick="selectPeople(this)"></i>'
					+'</div><hr></td></tr>';
					
			}
		}
		
		document.getElementById("presentLogin").innerHTML = friendHTML;
		
	}

	//채팅방 만들기
	function makeRoom(){
		
		if(confirm("이 멤버로 채팅방을 만드시겠습니까?")){
			//변수 초기화
			var people = document.getElementsByName("loginPresent");
			var roomPeople = new Array;
			var index = 0;
			
			for(var i = 0;i<people.length;i++){
				if(people[i].style.color == 'blue'){
					roomPeople[index] = people[i].parentNode.parentNode.childNodes[3].innerText;
					index++;
				}
			}
			
			//비동기 통신
 			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					alert(resData);
					location.reload();
				}
			}

			xhttp.open("POST", "makeRoom.do", true);
			xhttp.setRequestHeader('Content-type','application/json; charset=utf-8');
			xhttp.send(JSON.stringify({"people": roomPeople})); 
			
		}
		
	}
	
	//채팅 맴버 선택
	function selectPeople(icon){
		
		var color = icon.style.color;
		
		if(color == 'blue'){
			icon.style.color = 'green';
		}
		else if(color == 'green'){
			icon.style.color = 'blue';
		}
		
	}	
	
	//친구 추가하기
	function moreMember(){
		var address = document.getElementById("address").value;

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				friendList(resData);
				moreFriendsView(window.count);
				
			}
		}
		
		xhttp.open("GET", address+"/member/checkLogin.do", true);
		xhttp.send(); 
		
	}
	
	window.onload = function(){
		window.count = 2;	
	}
	
	function goChat(chatNum){
		location.href="${pageContext.request.contextPath}/chat/chatting.do?chatNum="+chatNum;
	}
	</script>
</body>
</html>