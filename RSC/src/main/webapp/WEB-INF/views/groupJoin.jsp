<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
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
			<div class="groupJoin">
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
											<label>그룹 정보</label><br>
											${requestScope.groupInfo.groupInfo}
										</td>
									</tr>
									<tr>
										<td class="group-info-interest">
											<label>관심사</label><br>
											${requestScope.groupInfo.groupInterest}
										</td>
									</tr>
									<c:choose>
										<c:when test="${requestScope.groupLevel eq 'admin'}">
											<tr>
												<td class="group-info-btn">
													<a href="${pageContext.request.contextPath}/group/groupMember.do?groupNum=${requestScope.groupInfo.groupNum}">
														<button>회원 보기</button>
													</a>
													<a href="${pageContext.request.contextPath}/group/groupJoin.do?groupNum=${requestScope.groupInfo.groupNum}">
														<button>가입 승인</button>
													</a>
													<button onclick="groupDelete('${requestScope.groupInfo.groupNum}','${requestScope.groupInfo.groupName}')">그룹 삭제</button>
												</td>
											</tr>
										</c:when>
										<c:when test="${requestScope.groupLevel eq 'visitor'}">
											<tr>
												<td class="group-info-btn">
													<button onclick="joinGroup('${requestScope.groupInfo.groupNum}','${requestScope.groupInfo.groupName}','${sessionScope.id}')">가입 요청</button>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									
									</c:choose>

								</table>
							</div>
						</div>
					</div>
				</div>

				<div class="row group-join">
					<div class="col-md-12">
						<h4 style="padding:4%">가입 희망 회원</h4>
						<c:forEach items="${requestScope.list}" var="data">
							<div class="col-md-2">
								<div class="card w3-round-large">
									<div class="header">
										<span class="imgSpan">
											<img class="imgTag" src="${pageContext.request.contextPath}/${data.memberImg}" onclick="memberPage('${data.memberId}')" style="cursor: pointer;">
										</span>
									</div>
									<div class="content">
										<p onclick="memberPage('${data.memberId}')" style="cursor: pointer;">${data.memberNick}</p>
									</div>
		
									<div class="footer">
										<span class="approve" title="가입 승인" onclick="approveJoin('${data.memberId}','${data.memberNick}','${requestScope.groupInfo.groupNum}')">
  											<i class="fa fa-plus-circle fa-lg" style="color: green;"></i>
										</span>
										<span class="reject" title="가입 거절" onclick="rejectJoin('${data.memberId}','${data.memberNick}','${requestScope.groupInfo.groupNum}')">
											<i class="fa fa-times-circle fa-lg" style="color:red;"></i>
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
	function approveJoin(memberId,memberNick,groupNum){
		if(confirm(memberNick+" 회원의 가입요청을 승인하시겠습니까?")){
			location.href="approveJoin.do?groupNum="+groupNum+"&memberId="+memberId;
		} else {
			return false;
		}
	}
	
	function rejectJoin(memberId,memberNick,groupNum){
		if(confirm(memberNick+" 회원의 가입요청을 거절하시겠습니까?")){
			location.href="rejectJoin.do?groupNum="+groupNum+"&memberId="+memberId;
		} else {
			return false;
		}
	}
	function memberPage(friendId){
		var sessionId = document.getElementById("sessionId").value;
		if(sessionId==friendId){
			location.href="${pageContext.request.contextPath}/board/myBoards.do?cnt=1";
		} else {
			location.href="${pageContext.request.contextPath}/friend/getFriendInfo.do?cnt=1&friendId="+friendId;
		}
	}
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/groupAdmin.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>

</body>
</html>