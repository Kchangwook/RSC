<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<!-- Tweaks for older IEs-->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.js"></script><![endif]-->

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/resources/css/friend.css">
</head>
<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<!-- 본문 부분 -->
		<div class="content-page">
		<div class="main-page2">
			<!-- 회원관리 메인페이지 -->
					
			<div class="row">
						<div class="col-md-12">
							<div class="card w3-round-large friend-info">
								<!-- 글 내용 -->
								<div class="content friend-content">
								<table>
									<tr>
									<td><img class = "friend-pfimg" src = "${pageContext.request.contextPath}/${friend.memberImg}"></td>
									</tr>
									<tr>
									<td><span class = "friend-name"><b>${friend.memberNick}</b></span></td>
									</tr>
									<tr>
									<td><span class = "friend-interest"><b>관심사</b></span></td>
									</tr>
									<tr>
									<td><span class = "friend-intercontent"><b>${friend.memberInterest}</b></span></td>
									</tr>
									<c:if test="${notFriend}">
									<tr>
									<td><button class = "friend-add" onclick = "addFriend('${friend.memberId}','${sessionScope.id}')"><b>친구 추가</b></button></td>
									</tr>
									</c:if>
								</table>
								</div>
							</div>
						</div>
			</div>
		
		<c:forEach items="${list}" var="data" begin = "0" end = "1">
					<div class="row">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img
										src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span>
									<span>&nbsp;&nbsp;${data.memberNick}</span>
								</div>

								<!-- 글 내용 -->
								<div class="content">
									<span> <a href="" style="display: block;"
										data-toggle="modal" data-target="#detailView"
										onclick="searchBoard(${data.boardNum})">
											${data.boardContent} </a>
									</span>
								</div>
								<hr>

								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i> ${data.boardTime}
									</div>
								</div>
							</div>
						</div>
						<br>
						<!--/글 작성 틀-->
					</div>

				</c:forEach>
			
		</div>
		<!-- 본문 끝 부분 -->
		</div>

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
		function addFriend(friend,member){
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					alert(resData);
				}
			}

			xhttp.open("GET", "requestFriend.do?memberId=" + member+"&friendId="+friend, true);
			xhttp.send();
		}
	</script>
</body>
</html>