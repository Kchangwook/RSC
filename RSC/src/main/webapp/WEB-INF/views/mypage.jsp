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
<!-- Tweaks for older IEs-->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.js"></script><![endif]-->

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>

<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<div align="center">
					<h4>회원 정보 수정</h4>
				</div>
				<input type = "hidden" name = "reqInterest" id = "reqInterest" value = "${member.memberInterest}">
				<input type = "hidden" name = "reqOpenInfo" id = "reqOpenInfo" value = "${member.memberInfoOpen}">
				<form action="update.do" name = "frmMypage" id = "frmMypage" method="POST" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="container">
							<table>
								<tr>
									<td colspan='2'><input type="text" name = "myId" id="myId" readonly value="${ sessionScope.id }"></td>
								</tr>
								<tr>
									<td colspan='2'><input type="password" name = "myPw" id="myPw" placeholder="비밀번호"></td>
								</tr>
								<tr>
									<td colspan='2'><input type="text" name="myNick" id="myNick"
										onblur="checkSameNick(this.value)" placeholder="${ member.memberNick }"></td>
								</tr>
								<tr>
									<td colspan='2'>
										<input type="text" width = "50%" name="mypageSrc" id="mypageSrc" value="${ requestScope.member.memberImg }" disabled="disabled">
									</td>
									<%-- <td rowspan='2'>
										<input type="text" width = "30%" name="mypageSrc" id="mypageSrc" placeholder="${ requestScope.member.memberImg }" disabled="disabled">
									</td> --%>
									</tr>
								<tr>
									<td colspan='2' class="tdImgButton">
										<div class="filebox">
											<label for="mypageImg">선택</label>
											<input type="file" name = "mypageImg" id="mypageImg" accept="image/*" onChange="changeMypageSrc()">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan='2'><label><b>관심사</b></label></td>
								</tr>
								<tr>
									<td colspan = '2'>
										<input type="checkbox" name="myInterest" value="운동">운동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="요리">요리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="영화">영화&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="음악">음악<br>
										<input type="checkbox" name="myInterest" value="독서">독서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="패션">패션&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="게임">게임&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="여행">여행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="myInterest" value="기타">기타</td>
								</tr>
								<tr>
									<td colspan='2'><label><b>정보 공개</b></label></td>
								</tr>
								<tr>
									<td class="tdRadio">
									<input type="radio" name="myInfoOpen" width="50%" value="1" checked>허용&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="myInfoOpen" width="50%" value="0">허용하지 않음</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<span id="mypage_msg" style="width: 100%; color: red; text-align: left;"></span>
						<input type="button" class="btn btn-default btnOrange" onClick="checkMypageInfo()" value="수정">
						<button type="reset" class="btn btn-default">취소</button>
					</div>
				</form>
		
		
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
	<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/mypage.js"></script>
	<script>
		
	</script>
</body>
</html>