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
						<h3>그룹 목록</h3>
					</div>
					<div class="col-md-10" align='right'>
						<input type="button" class="btn btn-default btnOrange nav-link" data-toggle="modal" onclick = "clearContent()" data-target="#addGroupModal" value="그룹 새로 만들기">
						
					</div>
				</div>
					
			<div class="row friend-edge">
				<c:choose>
					<c:when test="${list ne null}">
					<c:forEach items = "${list}" var="item">
						<div class="col-lg-5 friend-out">
							<div class="card w3-round-large firend-back">
								<!-- 글 내용 -->
								<div class="content friend-content" >
									<div onclick = "showGroup('${item.groupNum}')">
										<div>
											<span class="list-img imgSpan">
												<img class = "imgTag" src="${pageContext.request.contextPath}/${item.groupImg}">
											</span>
										</div>
										<div class = "friend-name">
											<span><b>${item.groupName}</b></span>
										</div>
									</div>
									<div>
										<span class = "friend-close" onclick = "deleteGroup('${item.groupNum}','${sessionScope.id}')"><b>x</b></span>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
						가입한 그룹이 없습니다
					</c:otherwise>
				</c:choose>
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

	<!-- 그룹 생성 모달 -->
	<div class="modal fade" id="addGroupModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content ">
				<div class="modal-header mod-head">
					<h4>그룹 생성</h4>
				</div>
				<form action="addGroup.do" name="frmAddGroup" id="frmAddGroup"
					method="post" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="container">
							<table>
								<tr>
									<td colspan='2'><input type="text" width="50px"
										name="groupSrc" id="groupSrc" placeholder="이미지"
										disabled="disabled">
									</td>
								</tr>
								<tr>
									<td colspan='2' class="tdImgButton">
										<div class="filebox">
											<label for="groupImg">선택</label> <input type="file"
												name="groupImg" id="groupImg" accept="image/*"
												onchange="changeSrc()">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan='2'><input type="text" name="groupName"
										id="groupName" onblur="checkSameGroupName(this.value)" placeholder="그룹명">
									</td>
								</tr>
								<tr>
									<td colspan='2'><input type="text" name="groupInfo"
										id="groupInfo" placeholder="그룹 설명">
									</td>
								</tr>
								<tr>
									<td colspan='2'><label><b>관심사</b></label></td>
								</tr>
								<tr>
									<td colspan='2'><input type="checkbox"
										name="groupInterest" value="운동">운동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="요리">요리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="영화">영화&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="음악">음악<br>
										<input type="checkbox" name="groupInterest" value="독서">독서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="패션">패션&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="게임">게임&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="여행">여행&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="groupInterest" value="기타">기타</td>
								</tr>
								<tr>
									<td colspan='2'><label><b>정보 공개</b></label></td>
								</tr>
								<tr>
									<td class="tdRadio"><input type="radio"
										name="groupInfoOpen" value="1" checked>허용</td>
									<td class="tdRadio"><input type="radio"
										name="groupInfoOpen" value="0">허용하지 않음</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<span id="join_msg"
							style="width: 100%; color: red; text-align: left;"></span> <input
							type="button" class="btn btn-default btnOrange"
							onclick="checkInfo()" value="만들기">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Javascript files-->
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
	<script type="text/javascript">
		function deleteGroup(groupNum, memberId) {

			var con = confirm('정말 탈퇴하시겠습니까?');

			if (con) {
				location.href = "exitGroup.do?groupNum=" + groupNum
						+ "&memberId=" + memberId;
			}

		}

		function showGroup(groupNum) {

			location.href = "${pageContext.request.contextPath}/basic/group.do?groupNum=" + groupNum;

		}

		function addGroup(memberId) {
			location.href = "addGroup.do?memberId=" + memberId;
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	
	
</body>
</html>