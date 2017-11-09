<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 배열 또는 List, null 등에 데이터가 저장 되었는지 확인하기 위한 length() 사용을 위한 선언 -->
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

		<!-- 본문 부분 -->
		<div class="content-page">

			<!-- 로그인 메인페이지 -->
			<div class="main-page">
			<!-- 일간 TOP -->
				일간 TOP
				<div class="row">
					<!-- 글 작성 틀 -->
					<div class="col-md-4">
						<div class="card w3-round-large">

							<!-- 글 머리 : 사진, 닉네임 -->
							<div class="header">
								<span><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> <span>&nbsp;&nbsp;${data.memberId}</span>
							</div>

							<!-- 글 내용 -->
							<div class="content">
								<form name="write" action="${pageContext.request.contextPath}/board/add.do" method="post">
									<textarea rows="5" cols="120" name="boardContent">
		
									</textarea><br>
								<input type="hidden" name="memberId" value="${data.memberId}"> <br>
						<div align="right">
						<input type=submit value=글쓰기 ></div>
					</form>
					</div>
							<hr>

							<!-- 글 작성 시간 -->
							<div class="footer">
								<div class="time-tag">
									<i class="fa fa-clock-o"></i> 3분전
								</div>
							</div>
						</div>
					</div>
					<!--/글 작성 틀-->
				</div> 
				<!--/일간 TOP -->
			
					
				
				<!-- 일간 TOP -->
				일간 TOP
				<div class="row">
					<!-- 글 작성 틀 -->
					<div class="col-md-4">
						<div class="card w3-round-large">
	
							<!-- 글 머리 : 사진, 닉네임 -->
							<div class="header">
								<span><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> <span>&nbsp;&nbsp;정연</span>
							</div>

							<!-- 글 내용 -->
							<div class="content">동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화
								삼천리 화려강산 대한사람 대한으로 길이 보전하세</div>
							<hr>

							<!-- 글 작성 시간 -->
							<div class="footer">
								<div class="time-tag">
									<i class="fa fa-clock-o"></i> 3분전
								</div>
							</div>
						</div>
					</div>
					<!--/글 작성 틀-->
				</div> 
				<!--/일간 TOP -->

				<!-- 주간 TOP -->
				주간 TOP
				<div class="row">
						<!-- 글 작성 틀 -->
						<div class="col-md-4">
							<div class="card w3-round-large">
	
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> <span>&nbsp;&nbsp;정연</span>
								</div>
	
								<!-- 글 내용 -->
								<div class="content">동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화
									삼천리 화려강산 대한사람 대한으로 길이 보전하세</div>
								<hr>
	
								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i> 3분전
									</div>
								</div>
							</div>
						</div>
						<!--/글 작성 틀-->
				</div> <!--/주간 TOP -->

				<!-- 월간 TOP -->
				월간 TOP
				<div class="row">
						<!-- 글 작성 틀 -->
						<div class="col-md-4">
							<div class="card w3-round-large">
	
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> <span>&nbsp;&nbsp;정연</span>
								</div>
	
								<!-- 글 내용 -->
								<div class="content">동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화
									삼천리 화려강산 대한사람 대한으로 길이 보전하세</div>
								<hr>
	
								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i> 3분전
									</div>
								</div>
							</div>
						</div>
					<!--/글 작성 틀-->
				</div> <!--/월간 TOP -->
				
			</div> <!-- /로그인 메인 -->
			
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

</body>
</html>