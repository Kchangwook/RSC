<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>friendList</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href = "${pageContext.request.contextPath}/resources/css/friend-list.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
<style>
#groupButton {
	visibility:hidden;
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
					<div class="col-md-10">
						<h3>친구 목록</h3>
						<div class="col-md-10" align='right'>
							<input id="groupButton" class="btn btn-default btnOrange nav-link">
						</div>
					</div>
				</div>
					
			<div class="row friend-edge">
					<c:forEach items = "${list}" var="item">
						<div class="col-lg-5 friend-out">
							<div class="card w3-round-large firend-back">
								<!-- 글 내용 -->
								<div class="content friend-content" >
									<div>
										<span class="list-img imgSpan">
											<img class = "imgTag" src="${pageContext.request.contextPath}/${item.friendImg}" onclick = "showFriend('${item.friendId}')">
										</span>
									</div>
									<div class = "friend-name">
										<span><b>${item.friendNick}</b></span>
									</div>
									<div>
										<span class = "friend-close" onclick = "friendDelete('${item.memberId}','${item.friendId}')"><b>x</b></span>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
			</div>
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
						<!-- <p>마지막 문장</p> -->
					</div>
				</div>
			</div>
		</footer>
		
	</div>
	<!-- Javascript files-->
	<script type="text/javascript">
		function friendDelete(member,friend){
			
			var con = confirm('정말 삭제하시겠습니까?');
			
			if(con){
				location.href="delete.do?memberId="+member+"&friendId="+friend; 
			}
			
		}
		
		function showFriend(friend){
			
			location.href = "getFriendInfo.do?friendId="+friend;
			
		}
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
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