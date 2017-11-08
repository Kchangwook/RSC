<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<header class="header">
		<nav class="navbar">
			<div class="container-fluid">
				<div class="navbar-holder d-flex align-items-center justify-content-between">
					<div class="navbar-header">
						<!-- header 목록 버튼 -->
						<a id="toggle-btn" href="#" class="menu-btn">
							<i class="icon-bars"> </i>
						</a>
					</div>
					
					<div>
						<input class="w3-input w3-round-large" type="text" placeholder="회원 또는 그룹 검색">
					</div>
					

					
					<ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
						<!-- 세션이 있는경우 -->
						<!-- 알림 아이콘 및 링크 -->
						<c:choose>
							<c:when test="${sessionScope.id ne null}">
								<!-- 알림 아이콘 및 링크 -->
								<li class="nav-item dropdown">
 									<a id="notifications" rel="nofollow" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link">
										<i class="fa fa-bell" onclick="viewAlertList()"></i>
									</a>
						
									<!-- 알림 목록 -->
									<ul aria-labelledby="notifications" class="dropdown-menu" id="viewAlert">
							
										<!-- 알림 틀 -->					
										<li>
											<a rel="nofollow" href="#" class="dropdown-item d-flex">
												<div class="msg-profile">
													<img src="${pageContext.request.contextPath}/resources/img/profile.jpg" alt="..." class="img-fluid rounded-circle">
												</div>
												<div class="msg-body">
													<h3 class="h5">관리자</h3>
													<span>게시물이 신고되었습니다</span>
													<small>1시간 전</small>
												</div>
											</a>
										</li>
										<!-- 알림틀 끝 -->
										
									</ul>
								</li>
						
								<!-- 회원가입  -->
								<li id="viewSignUp" class="nav-item">
									<a href="#" class="nav-link"  data-toggle="modal" data-target="#signUpModal">회원가입</a>
								</li>
						
								<!-- 로그인 -->
								<li id="viewSignIn" class="nav-item">
									<a href="#" class="nav-link"  data-toggle="modal" data-target="#signInModal">로그인</a>
								</li>
							</c:when>
						
							<c:otherwise> <!-- 로그인 완료시(세션 유지) -->
								<!-- 로그인 사용자  -->
								<li id="loginInfo" class="nav-item">
									<a href="#로그인후 메인페이지" class="nav-link">
										<img src="img/profile.jpg">
										이름
									</a>
								</li>
						
								<!-- 로그아웃 -->
								<li id="viewSignOut" class="nav-item">
									<a href="#로그아웃 링크" class="nav-link">로그아웃</a>
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
    		<div class="modal-content">
        		<div class="modal-header">
          			<h4 class="modal-title">회원 가입</h4>
        		</div>
				<div class="modal-body">
					<form action="">
					<!-- 회원가입 폼 작성 -->
					회원가입 폼
					</form>
				</div>
				<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">회원가입</button>
          			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        		</div>
      		</div>
    	</div>
  	</div>
				
	<!-- 로그인 모달 -->
  	<div class="modal fade" id="signInModal" role="dialog">
    	<div class="modal-dialog">
    		<div class="modal-content">
        		<div class="modal-header">
          			<h4 class="modal-title">로그인</h4>
        		</div>
        		<div class="modal-body">
        			<form>
        			<!-- 로그인 폼 작성 -->
        			로그인 폼
        			</form>
        		</div>
        		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">로그인</button>
          			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        		</div>
      		</div>
    	</div>
  	</div>


	<script>
	
	function viewAlertList() {
		var alertHtml = '';
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);

				for (i = 0; i < resData.length; i++) {
					alertHtml += '<li>' +
						'<a rel="nofollow" href="#" class="dropdown-item d-flex">' +
						'<div class="msg-profile">' +
						'<img src="resData[i].imgUrl" alt="..." class="img-fluid rounded-circle">' +
						'</div>' +
						'<div class="msg-body">' +
						'<h3 class="h5">${resData[i].nick}</h3>' +
						'<span>${resData[i].content}</span>' +
						'<small>${resData[i].time}</small>' +
						'</div>' +
						'</a>' +
						'</li>';
				}
				document.getElementById("viewAlert").innerHTML = alertHtml;
			}
		};

		xhttp.open("POST", "알림 가져올 경로", true);
		xhttp.send();
	}
	</script>

</body>
</html>