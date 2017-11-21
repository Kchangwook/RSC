<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
<!-- jQuery Circle-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/grasp_mobile_progress_circle-1.0.0.min.css">
<!-- Custom Scrollbar-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<!-- theme stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<!-- Favicon-->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
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

			<!-- 그룹회원 페이지 -->
			<div class="groupMember">
				<div class="row">
					<div class="col-md-12">
					그룹 정보 보여줄 부분
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h4 style="padding:4%">관리자</h4>
						<c:forEach items="${requestScope.groupMember.groupAdmin}" var="data">
							<div class="col-md-2">
								<div class="card w3-round-large">
									<div class="header">
										<img src="${pageContext.request.contextPath}/${data.memberImg}">
									</div>
									<div class="content">
										<a href="#관리자의 메인페이지 ${data.memberId}">${data.memberNick}</a>
									</div>
									<div class="footer">
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<div class="row">
					<div class="col-md-12">
						<h4 style="padding:4%">회원</h4>
						<c:forEach items="${requestScope.groupMember.groupMember}" var="data">
							<div class="col-md-2">
								<div class="card w3-round-large">
									<div class="header">
										<img src="${pageContext.request.contextPath}/${data.memberImg}">
									</div>
									<div class="content">
										<a href="#회원의 메인페이지 ${data.memberId}">
											${data.memberNick}
										</a>
									</div>
		
									<div class="footer">
										<span class="appoint" title="관리자 임명" onclick="appointAdmin('${data.memberId}','${data.memberNick}','${requestScope.group.groupNum}')">
  											<i class="fa fa-user fa-lg"></i>
  											<i class="fa fa-level-up fa-lg" style="color: rgba(247, 146, 30, 0.7);"></i>
										</span>
										<span class="expel" title="추방" onclick="expelMember('${data.memberId}','${data.memberNick}','${requestScope.group.groupNum}')">
											<i class="fa fa-times fa-lg" style="color:red;"></i>
										</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
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
	<script>
	function appointAdmin(memberId,memberNick,groupNum){
		if(confirm(memberNick+" 회원을 관리자로 임명하시겠습니까?")){
			location.href="appointAdmin.do?groupNum="+groupNum+"&memberId="+memberId;
		} else {
			return false;
		}
	}
	
	function expelMember(memberId,memberNick,groupNum){
		if(confirm(memberNick+" 회원을 그룹에서 추방하시겠습니까?")){
			location.href="expelMember.do?groupNum="+groupNum+"&memberId="+memberId;
		} else {
			return false;
		}
	}
	</script>

</body>
</html>