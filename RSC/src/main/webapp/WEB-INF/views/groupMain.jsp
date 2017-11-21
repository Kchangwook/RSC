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
			<!-- 그룹 메인 페이지  -->
			<div class="group-main">
			
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
				
				<!-- 그룹 글 작성 부분 -->
				<c:if test="${requestScope.groupLeve ne 'visitor' }">
					<div class="group-board">
						<div class="row">
							<div class="col-md-12">
								<div class="card w3-round-large">
									<form name="write" action="${pageContext.request.contextPath}/board/addBoard.do" method="post" style="width: 100%">
										<div class="header">
										
										</div>
										<div class="content">
											<textarea rows="5" style="width: 100%; resize: none; wrap: hard;" name="boardContent"></textarea>
										</div>
										<div class="footer">
											<input type="hidden" name="memberId" value="${sessionScope.id}">
											<input type=submit class="btn btn-default btnOrange" value=글쓰기>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				
				<!-- 그룹 글 리스트 출력 부분 -->
				<div class="group-boardList">
					<c:forEach items="${requestScope.groupBoardList}" var="data">
						<div class="row">
							<!-- 글 작성 틀 -->
							<div class="col-md-12">
								<div class="card w3-round-large">
									<!-- 글 머리 : 사진, 닉네임 -->
									<div class="header">
										<span class="group-boardList-img-span imgSpan ">
											<img class="imgTag" src="${pageContext.request.contextPath}/${data.memberImg}">
										</span>
										<span>&nbsp;&nbsp;${data.memberNick}</span>
									</div>
	
									<!-- 글 내용 -->
									<div class="content">
										<span> 
											<a href="#" style="display:block;" data-toggle="modal" data-target="#detailView" onclick="searchBoard(${data.boardNum})">
												${data.boardContent}
											</a>
										</span>
									</div>
									<hr>
	
									<!-- 글 작성 시간 -->
									<div class="footer">
										<div class="time-tag">
											<i class="fa fa-clock-o"></i> <fmt:formatDate value="${data.boardTime}" pattern="yyyy년 M월 d일 H시 m분" />
										</div>
									</div>
									
								</div>
							</div>
							<br>
							<!--/글 작성 틀-->
						</div>
	
					</c:forEach>
				</div>
			</div>
		<!-- 본문 끝 부분 -->
		</div>
		
		<!-- footer 마지막 검은 박스 -->
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
	function groupDelete(groupNum, groupName){
		if(confirm("확인 버튼을 누르실 경우 \n["+groupName+"] 그룹에 대한 삭제 요청 투표가 진행됩니다.\n계속 하시겠습니까?")){
			if(confirm("그룹 삭제 요청 투표를 진행합니다")){
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var resData = this.responseText;
						resData = JSON.parse(resData);
						if(resData==true){
							alert("투표 전송을 성공하였습니다.");
						} else {
							alert("투표 전송 중 오류가 발생하였습니다.");
						}
					}
				}
				xhttp.open("POST", "${pageContext.request.contextPath}/group/deleteGroupNotice.do", true);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send("groupNum="+groupNum+"&groupName="+groupName); 
			} else {
				alert("그룹 삭제 투표 요청이 취소 되었습니다.");
				return false;
			}
		} else {
			return false;
		}
	}
	
	function joinGroup(groupNum, groupName, memberId){
		if(confirm("'"+groupName+"' 그룹에 가입을 요청하시겠습니까?")){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData = JSON.parse(resData);
					if(resData==true){
						alert("가입 요청을 성공하였습니다.");
					} else {
						alert("가입 요청을 실패하였습니다.");
					}
				}
			}
			xhttp.open("POST", "${pageContext.request.contextPath}/group/joinGroup.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("groupNum="+groupNum+"&memberId="+memberId); 
		}
	}
	
	//deleteGroupNotice.do
	</script>
</body>
</html>



