<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
</head>

<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">

		<!-- 헤더 include -->
		<jsp:include page="header.jsp" />

		<!-- 본문 부분 -->
		<div class="content-page">
			<!-- 게시글관리 메인페이지 -->
			<div class="addAdmin-page">

				<div class="row">
					<div class="col-md-12">
						<h3>관리자 계정 추가</h3>
						<br>
					</div>
				</div>

				<div class="row">
					<div class="col-md-12">
						<div class="addAdminTable">
							<form action="addAdmin.do" method="POST">
								<span class="adminLabel">아이디</span>
								<span class="adminInput">
									<input class="w3-input" id="adminId" name="adminId" type="text" placeholder="아이디 입력" onblur="checkSameIdForAdmin()">
								</span><br>
								<span class="adminLabel">비밀번호</span>
								<span class="adminInput">
									<input class="w3-input" id="adminPw" name="adminPw"type="password" placeholder="비밀번호 입력">
								</span><br>
								<p>
									<span id="adminMsg" style="color:red"></span>
									<input type="submit" id="adminAddSubmit" value="생성">
								</p>
							</form>		
						</div>			
					</div>
				</div>
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
						<p>마지막 문장</p>
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
	<script	src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script>
	function checkSameIdForAdmin() {
		var id = document.getElementById("adminId").value;
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				if(resData=='아이디가 존재합니다.'){
					document.getElementById("adminAddSubmit").type="button";
				} else {
					document.getElementById("adminAddSubmit").type="submit";
				}
				document.getElementById("adminMsg").innerText = resData;
			}
		}

		xhttp.open("POST", "../join/checkId.do?id=" + id, true);
		xhttp.send();
	}
	</script>
</body>
</html>