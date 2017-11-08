<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

						<!-- 알림 아이콘 및 링크 -->
						<li class="nav-item dropdown">
<!-- 					<a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link">
							<i class="fa fa-bell"></i>
						
							<span class="badge badge-warning">
								알림 갯수 2
							</span>
							</a>  이 부분 주석 해제하면 알림 아이콘--> 
						
						<!-- 알림 목록 -->
						<ul aria-labelledby="notifications" class="dropdown-menu">
						
							<!-- 알림 틀 -->					
							<li>
								<a rel="nofollow" href="#" class="dropdown-item d-flex">
									<div class="msg-profile">
										<img src="${pageContext.request.contextPath}/resources/img/profile.jpg" alt="..." class="img-fluid rounded-circle">
									</div>
									<div class="msg-body">
										<h3 class="h5">이름</h3>
										<span>새 게시물 업로드</span>
										<small>3분 전</small>
									</div>
								</a>
							</li>
							
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
								
							</ul>
						</li>
						
						<!-- 회원가입  -->
						<li class="nav-item"><a href="login.html"
							class="nav-link logout">회원가입</a>
						</li>
						
						<!-- 로그인 -->
						<li class="nav-item"><a href="login.html"
							class="nav-link logout">로그인</a>
						</li>
						
					</ul>
				</div>
			</div>
		</nav>
	</header>

</body>
</html>