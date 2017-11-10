<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
<style>
.navbar{
	border-radius: 0;
}

.mod-head {
	background-color: #F7921E;
	color: white;
}

.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	color: #999; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #fdfdfd; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
	} 
	.filebox input[type="file"] 
	{ /* 파일 필드 숨기기 */ 
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0; 
	}
	.profile{
		text-align:center;
		border:1px solid #dfdfdf;
		color:#898989;
		width:120px;
		height:160px;
		align:center;
	}

</style>
</head>
<body>
	<header class="header">
		<nav class="navbar">
			<div class="container-fluid">
				<input type = "hidden" id = "msg" value = "${msg }">
				<input type = "hidden" id = "sessionId" value = "${id }">
				<input type = "hidden" id = "sessionLevel" value = "${level }">
				<div
					class="navbar-holder d-flex align-items-center justify-content-between">
					<div class="navbar-header">
						<!-- header 목록 버튼 -->
						<a id="toggle-btn" href="#" class="menu-btn"> <i
							class="icon-bars"> </i>
						</a>
					</div>

					<div>
						<input class="w3-input w3-round-large" type="text"
							placeholder="회원 또는 그룹 검색">
					</div>

					<ul
						class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
						<!-- 로그인 성공시 (세션이 있는 경우) -->
						<c:choose>
							<c:when test="${sessionScope.id ne null}">
								<!-- 알림 아이콘 및 링크 -->
								<li class="nav-item dropdown"><a id="notifications"
									rel="nofollow" href="#" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false" class="nav-link">
										<i class="fa fa-bell fa-2x" onclick="viewAlertList()"></i>
								</a> <!-- 알림 목록 -->
									<ul aria-labelledby="notifications" class="dropdown-menu"
										id="viewAlert">

										<!-- 알림 틀 -->
										<li><a rel="nofollow" href="#"
											class="dropdown-item d-flex">
												<div class="msg-profile">
													<img
														src="${pageContext.request.contextPath}/resources/img/profile.jpg"
														alt="..." class="img-fluid rounded-circle">
												</div>
												<div class="msg-body">
													<h3 class="h5">관리자</h3>
													<span>게시물이 신고되었습니다</span> <small>1시간 전</small>
												</div>
										</a></li>
										<!-- 알림틀 끝 -->

									</ul></li>

								<!-- 로그인 사용자  -->
								<li id="loginInfo" class="nav-item"><a href="#로그인후 메인페이지"
									class="nav-link"> <img src="img/profile.jpg"> 이름
								</a></li>

								<!-- 로그아웃 -->
								<li id="viewSignOut" class="nav-item"><a href="#로그아웃 링크"
									class="nav-link">로그아웃</a></li>


							</c:when>

							<c:otherwise>
								<!-- 비로그인 상태 -->

								<!-- 회원가입  -->
								<li id="viewSignUp" class="nav-item"><a href="#"
									class="nav-link" data-toggle="modal" data-target="#signUpModal">회원가입</a>
								</li>

								<!-- 로그인 -->
								<li id="viewSignIn" class="nav-item"><a href="#"
									class="nav-link" data-toggle="modal" data-target="#signInModal">로그인</a>
								</li>

							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
	</header>


	<!-- 회원가입 모달 -->
	<div class="modal fade" id="signUpModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content ">
				<div class="modal-header mod-head">
					<h4>회원 가입</h4>
				</div>
				<form action="join.do" id = "frm" method="POST">
					<div class="modal-body">
						<div class="container">
							<table>
								<tr>
									<td><input type="text" name="memberId" id="id"
										onblur="checkSameId()" placeholder="아이디"></td>
								</tr>
								<tr>
									<td><input type="password" id = "pwd" name="memberPw" placeholder="비밀번호"></td>
								</tr>
								<tr>
									<td><input type="text" name="memberNick" id="nick"
										onblur="checkSameNick()" placeholder="닉네임"></td>
								</tr>
								<tr>
									<td>
										<div class = "profile">
											<span style = "z-index: 4;margin-top: 70px;"><b>프로필 사진</b></span>
											<img src = "" id = "img" style = "z-index:2">
										</div>
									</td>
								</tr>
								<tr>
									<td class="tdImgButton">
									<div class="filebox">
										<label for="ex_file">선택</label>
										<input type="file" name = "memberImg" id="ex_file" accept=".jpg .gif .png">
									</div>
									</td>
								</tr>
								<tr>
									<td><label><b>관심사</b></label></td>
								</tr>
								<tr>
									<td><input type="checkbox" name="memberInterest" value="exercise">운동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="cooking">요리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="movie">영화&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="music">음악<br>
										<input type="checkbox" name="memberInterest" value="book">독서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="fashion">패션&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="game">게임&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="trip">여행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="etc">기타</td>
								</tr>
								<tr>
									<td><label><b>정보 공개</b></label></td>
								</tr>
								<tr>
									<td class="tdRadio"><input type="radio" name="memberInfoOpen"
										value="0" checked>허용</td>
									<td class="tdRadio"><input type="radio" name="memberInfoOpen"
										value="1">허용하지 않음</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<span id="msg" style="width: 100%; color: red; text-align: left;"></span>
						<input type="button" class="btn btn-default btnOrange" onclick="checkInfo()"
							value="회원가입">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 로그인 모달 -->
	<div class="modal fade" id="signInModal" role="dialog">
    	<div class="modal-dialog">
    		<div class="modal-content">
        		<form action="login.do" method="POST">
        		<div class="modal-header mod-head">
          			<h4 class="modal-title">로그인</h4>
        		</div>
				<div class="modal-body">
  						<div class="container">
  							<table>
  								<tr><td><input type="text" id = "loginId" name="memberId" placeholder = "아이디"></td></tr>
  								<tr><td><input type="password" id = "loginPwd" name="memberPw" placeholder = "비밀번호"></td></tr>
  							</table>
  						</div>
				</div>
				<div class="modal-footer">
          			<input type="submit" class="btn btn-default btnOrange" value="로그인">
          			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        		</div>
        		</form>
      		</div>
    	</div>
  	</div>


	<script>
	
		function getMessage(){
			
			var msg = document.getElementById("msg").value;
			var sessionId = document.getElementById("sessionId").value;
			var sessionLevel = document.getElementById("sessionLevel").value;
			
/* 			if(msg != "")
				alert(msg);
			if(sessionId != "")
				alert(sessionId);
			if(sessionLevel != "")
				alert(sessionLevel); */
			
		}
		
		window.onload = getMessage();
	
		//필수 정보가 모두 입력되었는지 확인
		function checkInfo(){
			
			var id = document.getElementById("id").value;
			var nick = document.getElementById("nick").value;
			var pwd = document.getElementById("pwd").value;
			
			if(id == ""){
				alert("아이디를 입력하세요");
				exit;
			}else if(pwd == ""){
				alert("비밀번호를 입력하세요");
				exit;
			}else if(nick == ""){
				alert("닉네임을 입력하세요");
				exit;
			}else{
				document.getElementById("frm").submit();
			}
			
			
		}
		
		//동일한 닉네임이 있는지 확인
		function checkSameNick() {
			var nick = document.getElementById("nick").value;
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					document.getElementById("msg").innerText = resData;
				}
			}

			xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
			xhttp.send();
		}
		
		//동일한 아이디가 있는지 확인
		function checkSameId() {
			var id = document.getElementById("id").value;
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					document.getElementById("msg").innerText = resData;
				}
			}

			xhttp.open("GET", "../join/checkId.do?id=" + id, true);
			xhttp.send();
		}

		
		//알림 모달
		function viewAlertList() {
		var alertHtml = '';
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);

				if (resData == null) {
					alertHtml += '<li>' +
					'<a rel="nofollow" href="#" class="dropdown-item d-flex">' +
					'<div class="msg-body">' +
					'<span>알림이 없습니다</span>' +
					'</div>' +
					'</a>' +
					'</li>';
				} else {
					for (i = 0; i < resData.length; i++) {
						if (resData[i].noticeType == 1) {
							alertHtml += '<li>' +
							'<a rel="nofollow" href="#" class="dropdown-item d-flex">' +
							'<div class="msg-body">' +
							'<span>'+resData[i].noticeContent+'</span>' +
							'</div>' +
							'</a>' +
							'</li>';
						} else if (resData[i].noticeType == 2) {
							alertHtml += '<li>' +
							'<a rel="nofollow" href="#" class="dropdown-item d-flex">' +
							'<div class="msg-body">' +
							'<span>'+resData[i].noticeContent+'</span>' +
							'</div>' +
							'</a>' +
							'</li>';
						} else {
						alertHtml += '<li>' +
							'<a onClick="deleteNotice('+resData[i].noticeNum+')" class="dropdown-item d-flex">' +
							'<div class="msg-body">' +
							'<span>'+resData[i].noticeContent+'</span>' +
							'</div>' +
							'</a>' +
							'</li>';
						
						}
					}
				}
				document.getElementById("viewAlert").innerHTML = alertHtml;
			}
		};

		xhttp.open("POST", "../notice/searchById.do?memberId="+'${sessionScope.id}', true);
		xhttp.send();
	}
		
	function deleteNotice(noticeNum) {
		 
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
			}
		}
		
		xhttp.open("POST", "../notice/deleteByNoticeNum.do?noticeNum="+noticeNum, true);
		xhttp.send(); 
	}
	</script>

</body>
</html>