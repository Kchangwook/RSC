<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>RSC</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/grasp_mobile_progress_circle-1.0.0.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	#tdRadio{
		width: 50%;
	}
</style>
</head>

<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<div align="center">
					<h4>그룹 정보 수정</h4>
				</div>
				<input type = "hidden" name = "reqGroupInterest" id = "reqGroupInterest" value = "${requestScope.groupInfo.groupInterest}">
				<input type = "hidden" name = "reqGroupInfoOpen" id = "reqGroupInfoOpen" value = "${requestScope.groupInfo.groupInfoOpen}">
				<form action="${pageContext.request.contextPath}/group/groupInfoUpdate.do" name="groupUpdateForm" id="groupUpdateForm" method="POST" enctype="multipart/form-data" >
					<input type="hidden" name="groupNum" value="${requestScope.groupInfo.groupNum}">
					<div class="modal-body">
						<div class="container">
							<table>
								<tr>
									<td colspan='2'>
										<input type="text" id="groupName" name="groupName" value="${requestScope.groupInfo.groupName}" onblur="checkSameGroupName(this.value)">
									</td>
								</tr>
								<tr>
									<td colspan='2'>
										<input type="text" id="groupInfo" name="groupInfo" value="${requestScope.groupInfo.groupInfo}">
									</td>
								</tr>
								<tr>
									<td colspan='2'>
										<input type="text" id="groupImgSrc" name="groupImgSrc" width = "50%" value="${requestScope.groupInfo.groupImg}" disabled="disabled">
									</td>
								</tr>
								<tr>
									<td colspan='2' class="tdImgButton">
										<div class="filebox">
											<label for="groupImg">선택</label>
											<input type="file" id="groupImg" name="groupImg" accept="image/*" onChange="changeGroupImgSrc()">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan='2'><label><b>관심사</b></label></td>
								</tr>
								<tr>
									<td colspan = '2'>
										<input type="checkbox" name="groupInterest" value="운동">운동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
									<td class="tdRadio">
										<input type="radio" name="groupInfoOpen" value="1" checked>허용&nbsp;&nbsp;
										<input type="radio" name="groupInfoOpen" value="0">허용하지 않음
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<span id="groupUpdateMsg" style="width: 100%; color: red; text-align: left;"></span>
						<input type="button" class="btn btn-default btnOrange" onClick="checkGroupAllInfoInput()" value="수정">
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
	<script	src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script>
		//화면에 정보 표시하기
		window.onload = function(){
			
			var interest = document.getElementById("reqGroupInterest").value;
			var infoOpen = document.getElementById("reqGroupInfoOpen").value;
			var reqinterest = interest.split(',');
			
			var interests = document.getElementsByName("groupInterest");
			var info = document.getElementsByName("groupInfoOpen");
			
			var index = 0;
			
			for(var i = 0;i<interests.length;i++){
				
				if(interests[i].value == reqinterest[index]){
					interests[i].checked = true;
					index++;
				}
				
			}
			
			for(var i = 0;i<info.length;i++){
				if(info[i].value == infoOpen)
					info[i].checked = true;
			}
		}
	
		//이미지 src 변경 (보여주기)
		function changeGroupImgSrc() {
			document.getElementById("groupImgSrc").value = document.getElementById("groupImg").value;
		}
	
		// 필수 정보가 모두 입력되었는지 확인
		function checkGroupAllInfoInput() {
			
			var groupName = document.getElementById("groupName").value;
			var groupName = document.getElementById("groupInfo").value;
			var groupInterest = document.getElementsByName("groupInterest");
	
			var count = 0;
	
			for (var i = 0; i < groupInterest.length; i++){
				if (groupInterest[i].checked){
					count++;
				}
			}
	
			if (count == 0) {
				alert("관심사를 선택하세요");
				return false;
			} else {
				document.getElementById("groupUpdateForm").submit();
			}
			
		};
	
		// 동일한 그룹명이 있는지 확인
/* 		function checkSameGroupName(nick) {
			// var nick = document.getElementById("nick").value;
			var xhttp = new XMLHttpRequest();
	
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
	
					document.getElementById("groupUpdateMsg").innerText = resData;
				}
			}
	
			xhttp.open("GET", "" + nick, true);
			xhttp.send();
		} */
	</script>
</body>
</html>