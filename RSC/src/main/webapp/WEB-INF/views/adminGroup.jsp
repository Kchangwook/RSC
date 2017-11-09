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

			<!-- 그룹관리 메인페이지 -->
			<div class="groupAdmin-page">
				<h3>그룹 관리</h3>
				<div class="row">
					<input type="text" placeholder="그룹 검색" style="width:50%"><button>검색</button>
				</div>

				
				<div class="row">
					<c:forEach items="${requestScope.allList}" var="group">
						<!-- 글 작성 틀 -->
						<div class="col-md-10">
							<div class="card w3-round-large">
								<!-- 글 내용 -->
								<div class="content">
									<table>
										<tr>
											<td class="groupImg" rowspan="3"><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></td>
											<td class="groupName" colspan="3">${group.groupName}</td>
											<td class="groupDelBtn"><span onclick="groupDelete('${group.groupNum}','${group.groupName}')">그룹삭제</span></td></tr>
										<tr>
											<td colspan="3">정보 : ${group.groupInfo}</td>
											<td></td>
										</tr>
										<tr>
											<td class="groupInterest">관심사 : ${group.groupInterest}</td>
											<td>공개여부 : ${group.groupInfoOpen}</td>
											<td>신고횟수 : ${group.groupSingoCnt}</td>
											<td></td>
										</tr>
									</table>
								
<%-- 									<img src="${pageContext.request.contextPath}/resources/img/profile.jpg">
									<div class="groupCard">
											${group.groupName}
									</div> --%>
								</div>
							</div>
						</div>
						<!--/글 작성 틀-->
					</c:forEach>
				</div> <!--/일간 TOP -->

			
				
			</div> <!-- /그룹관리 메인 -->
			
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
		function groupDelete(groupNum,groupName){
			if(confirm(groupName+' 그룹을 삭제하시겠습니까?')){
				console.log('삭제');
				goDelete(groupNum);
			} else {
				return;
			}
		}
		
		function goDelete(groupNum){
			location.href='http://localhost:10101/rcsTest/admin/groupDelete.do?groupNum='+groupNum;
		}
		
	</script>

</body>
</html>