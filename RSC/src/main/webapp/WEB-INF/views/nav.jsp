<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>

	<!-- 사이드바 부분 -->
	<nav class="side-navbar">
		<div class="side-navbar-wrapper">
			<div
				class="sidenav-header d-flex align-items-center justify-content-center">
				<div class="sidenav-header-inner text-center">
					<a href="${pageContext.request.contextPath}/index.html">
					<img src="${pageContext.request.contextPath}/resources/img/logo.png">&nbsp;&nbsp;&nbsp;
					<h2 class="h5 text-uppercase">Relation Social Community</h2></a>
				</div>
				<div class="sidenav-header-logo">
					<a href="${pageContext.request.contextPath}/index.html" class="brand-small text-center">
						<img src="${pageContext.request.contextPath}/resources/img/logo.png"><br>
						RSC
					</a>
				</div>
			</div>
			
			<div class="main-menu">
				<ul id="side-main-menu" class="side-menu list-unstyled">
					<c:choose>
						<c:when test="${sessionScope.level eq 'member'}"> <!-- 회원 로그인 시 -->
							<li>
								<a href="index.jsp	"><i class="fa fa-users"></i><span>그룹</span></a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-user"></i><span>친구</span></a>
							</li>
							<li>
								<a href="mypage.do?mypageMemberId=${ sessionScope.id }"><i class="fa fa-address-card-o"></i><span>mypage</span></a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-comments"></i><span>채팅</span></a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-telegram"></i><span>랜덤채팅</span></a>
							</li>
						</c:when>
						<c:when test="${sessionScope.level eq 'admin'}"> <!-- 관리자 로그인 시 -->
							<li>
								<a href="index.jsp">
  									<a href="${pageContext.request.contextPath}/admin/group.do"><i class="fa fa-users"></i><span>그룹 관리</span></a>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member.do">
									<i class="fa fa-user"></i><span>회원 관리</span>
								</a>
							</li>
							<li>
								<a href="index.jsp">
  									<i class="fa fa-file-text-o"></i><span>게시글 관리</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/singo.do">
									<i class="fa fa-ban"></i><span>신고</span>
								</a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-bullhorn"></i><span>공지</span></a>
							</li>
						</c:when>
						<c:when test="${sessionScope.level eq 'master'}"> <!-- 최상위관리자 로그인 시 -->
							<li>
								<a href="${pageContext.request.contextPath}/admin/group.do"><i class="fa fa-users"></i><span>그룹 관리</span></a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/member.do">
									<i class="fa fa-user"></i><span>회원 관리</span>
								</a>
							</li>
							<li>
								<a href="index.jsp">
  									<i class="fa fa-file-text-o"></i><span>게시글 관리</span>
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/admin/singo.do">
									<i class="fa fa-ban"></i><span>신고</span>
								</a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-bullhorn"></i><span>공지</span></a>
							</li>
							<li>
								<a href="index.jsp"><i class="fa fa-plus-square"></i><span>관리자 아이디 생성</span></a>
							</li>
						</c:when>
						<c:otherwise> <!-- 비로그인 시 -->
							<li>
								<a href="" onclick="blockAccess()"><i class="fa fa-users"></i><span>그룹</span></a>
							</li>
							<li>
								<a href="" onclick="blockAccess()"><i class="fa fa-user"></i><span>친구</span></a>
							</li>
							<li>
								<a href="" onclick="blockAccess()"><i class="fa fa-address-card-o"></i><span>마이페이지</span></a>
							</li>
							<li>
								<a href="" onclick="blockAccess()"><i class="fa fa-comments"></i><span>채팅</span></a>
							</li>
							<li>
								<a href="" onclick="blockAccess()"><i class="fa fa-telegram"></i><span>랜덤채팅</span></a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			
			
		</div>
	</nav>
	
	<script>
		function blockAccess(){
			alert("로그인 후 이용해주시기 바랍니다.");
			location.reload();
		}
	
	</script>
</body>
</html>