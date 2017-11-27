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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat-list.css">
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
				<div class="row" style = "margin-bottom: 0px;">
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
	<script src="${pageContext.request.contextPath}/resources/js/chat-list.js"></script>
</body>
</html>