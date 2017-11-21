<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>RSC</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
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
				<!-- 그룹 정보 -->
				<div class="group-info">
					<div class="row">
						<div class="col-md-12">
							<div class="card w3-round-large">
								<table class="group-info-table">
									<tr>
										<td class="group-info-img" rowspan="4">
											<span class="group-info-img-span imgSpan">
												<img class="imgTag" src = "${pageContext.request.contextPath}/${requestScope.groupInfo.groupImg}">
											</span>
										</td>
										<td class="group-info-name">
											<a href="${pageContext.request.contextPath}/basic/group.do?groupNum=${requestScope.groupInfo.groupNum}">
												<b>${requestScope.groupInfo.groupName}</b>
											</a>
										</td>
									</tr>
									<tr>
										<td class="group-info-info">
											${requestScope.groupInfo.groupInfo}
										</td>
									</tr>
									<tr>
										<td class="group-info-interest">
											${requestScope.groupInfo.groupInterest}
										</td>
									</tr>
									<tr>
										<td class="group-info-btn">
											<a href="${pageContext.request.contextPath}/group/groupMember.do?groupNum=${requestScope.groupInfo.groupNum}">
												<button>회원 보기</button>
											</a>
											<a href="${pageContext.request.contextPath}/group/groupJoin.do?groupNum=${requestScope.groupInfo.groupNum}">
												<button>가입 승인</button>
											</a>
											<button>그룹 삭제</button>
										</td>
									</tr>
								</table>
							</div>
						</div>
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
										<span class="appoint" title="관리자 임명" onclick="appointAdmin('${data.memberId}','${data.memberNick}','${requestScope.groupInfo.groupNum}')">
  											<i class="fa fa-user fa-lg"></i>
  											<i class="fa fa-level-up fa-lg" style="color: rgba(247, 146, 30, 0.7);"></i>
										</span>
										<span class="expel" title="추방" onclick="expelMember('${data.memberId}','${data.memberNick}','${requestScope.groupInfo.groupNum}')">
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
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
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