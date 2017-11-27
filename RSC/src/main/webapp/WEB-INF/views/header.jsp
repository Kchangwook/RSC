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
	#searchMemberAndGroup {
		width : 100%;
	}
	.searchIcon{
		width:3%;	
	}

</style>
</head>
<body>
	<header class="header">
		<nav class="navbar">
			<div class="container-fluid">
				<input type = "hidden" id = "msg" value = "${param.msg}">
				<div class="navbar-holder d-flex align-items-center justify-content-between">
					<div class="navbar-header">
						<!-- header 목록 버튼 -->
						<a id="toggle-btn" href="#" class="menu-btn"> <i
							class="icon-bars"> </i>
						</a>
					</div>
					<input type = "hidden" id = "address" value = "${pageContext.request.contextPath}">

					<ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
						<!-- 로그인 성공시 (세션이 있는 경우) -->
						<c:choose>
							<c:when test="${sessionScope.id ne null}">
								<!-- 회원 또는 그룹 검색 -->
								<li class="nav-item dropdown"><input id="notifications"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" class="w3-input w3-round-large nav-link"
									type="text" onInput="searchMemberAndGroup(this.value)"
									placeholder="회원 또는 그룹 검색">
									<ul aria-labelledby="notifications"
										class="dropdown-menu round-large" id="searchMemberAndGroup">
										<li><a rel="nofollow" href="#"
											class="dropdown-item d-flex"> <span>검색어를 입력하세요</span>
										</a></li>
									</ul>
								</li>&nbsp;&nbsp;&nbsp;
								<!-- 로그인 사용자  -->
								<li id="loginInfo" class="nav-item">
									<a href="${pageContext.request.contextPath}/board/readBoard.do?cnt=1" class="nav-link">
									<span class="imgSpan">
										<img class="imgTag" src="${pageContext.request.contextPath}/${imgSrc}">
									</span>
									<c:choose>
										<c:when test="${sessionScope.nick eq null}">
											${sessionScope.id}
										</c:when>
										<c:otherwise>
											${sessionScope.nick}
										</c:otherwise>
									
									</c:choose>
								</a></li>
							
								<!-- 알림 아이콘 및 링크 -->
								<li class="nav-item dropdown">
								<a id="notifications" rel="nofollow" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link">
									<i class="fa fa-bell fa-2x" onclick="viewAlertList()">
										<input type = "hidden" id = "noticeMemberId" value = "${ sessionScope.id }">
										<input type = "hidden" id = "sessionId" value = "${ sessionScope.id }">
									</i>
								</a> <!-- 알림 목록 -->
									<ul aria-labelledby="notifications" class="dropdown-menu" id="viewAlert">
									</ul>
								</li>

								<!-- 로그아웃 -->
								<li id="viewSignOut" class="nav-item">
								<a href="${pageContext.request.contextPath}/basic/logout.do" class="nav-link">로그아웃</a></li>


							</c:when>

							<c:otherwise>
								<!-- 비로그인 상태 -->

								<!-- 회원가입  -->
								<li id="viewSignUp" class="nav-item"><a href="#"
									class="nav-link" data-toggle="modal" onclick = "clearContent()" data-target="#signUpModal">회원가입</a>
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
				<form action="join.do" name = "frm" id = "frm" method="post" enctype="multipart/form-data">
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
										<input type="text" width = "50px" name="imgSrc" id="imgSrc" placeholder="이미지" disabled="disabled">
									</td>
								</tr>
								<tr>
									<td class="tdImgButton">
									<div class="filebox">
										<label for="memberImg">선택</label>
										<input type="file" name = "memberImg" id="memberImg" accept="image/*" onchange="changeSrc()">
									</div>
									</td>
								</tr>
								<tr>
									<td><label><b>관심사</b></label></td>
								</tr>
								<tr>
									<td><input type="checkbox" name="memberInterest" value="운동">운동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="요리">요리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="영화">영화&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="음악">음악<br>
										<input type="checkbox" name="memberInterest" value="독서">독서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="패션">패션&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="게임">게임&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="여행">여행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="memberInterest" value="기타">기타</td>
								</tr>
								<tr>
									<td><label><b>정보 공개</b></label></td>
								</tr>
								<tr>
									<td class="tdRadio"><input type="radio" name="memberInfoOpen"
										value="1" checked>허용</td>
									<td class="tdRadio"><input type="radio" name="memberInfoOpen"
										value="0">허용하지 않음</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<span id="join_msg" style="width: 100%; color: red; text-align: left;"></span>
						<input type="button" class="btn btn-default btnOrange" onclick="checkInfo()" value="회원가입">
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
  								<tr><td><input type="text" id = "loginId" name="loginId" placeholder = "아이디"></td></tr>
  								<tr><td><input type="password" id = "loginPwd" name="loginPwd" placeholder = "비밀번호"></td></tr>
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
<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/header.js"></script>
<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
</body>
</html>