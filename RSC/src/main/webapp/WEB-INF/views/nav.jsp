<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

	<!-- 사이드바 부분 -->
	<nav class="side-navbar">
		<div class="side-navbar-wrapper">
			<div
				class="sidenav-header d-flex align-items-center justify-content-center">
				<div class="sidenav-header-inner text-center">
					<img src="img/logo.png">
					<h2 class="h5 text-uppercase">Relation Social Community</h2>
				</div>
			</div>


			<div class="main-menu">
				<ul id="side-main-menu" class="side-menu list-unstyled">
					<li id="linkToGroup" onclick="loginCheck()"><a href="index.jsp"><i class="fa fa-users"></i><span>그룹</span></a></li>
					<li id="linkToFriend" onclick="loginCheck()"><a href="index.jsp"><i class="fa fa-user"></i><span>친구</span></a></li>
					<li id="linkToMyPage" onclick="loginCheck()"><a href="index.jsp"><i class="fa fa-user"></i><span>마이페이지</span></a></li>
					<li id="linkToChat" onclick="loginCheck()"><a href="index.jsp"><i class="fa fa-comments"></i><span>채팅</span></a></li>
					<li id="linkToRanChat" onclick="loginCheck()"><a href="index.jsp"><i class="fa fa-telegram"></i><span>랜덤채팅</span></a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<script>
		function loginCheck(){
			var sessionId = "${sessionScope.id}";
			if(sessionId!=""){
				document.getElementById("linkToGroup").innerHTML = '<a href="그룹페이지 링크"><i class="fa fa-users"></i><span>그룹</span></a>';
				document.getElementById("linkToFriend").innerHTML = '<a href="친구페이지 링크"><i class="fa fa-user"></i><span>그룹</span></a>';
				document.getElementById("linkToMyPage").innerHTML = '<a href="마이페이지 링크"><i class="fa fa-user"></i><span>그룹</span></a>';
				document.getElementById("linkToChat").innerHTML = '<a href="채팅페이지 링크"><i class="fa fa-comments"></i><span>그룹</span></a>';
				document.getElementById("linkToRanChat").innerHTML = '<a href="랜챗페이지 링크"><i class="fa fa-telegram"></i><span>그룹</span></a>';
			} else {
				alert("로그인 후 이용해주시기 바랍니다.");
			}
		}
	
	</script>
</body>
</html>