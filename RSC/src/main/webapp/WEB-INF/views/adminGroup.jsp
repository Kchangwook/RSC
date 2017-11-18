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
				<div class="row">
					<div class="col-md-12">
						<h3>그룹 관리</h3><br>
					</div>
					<div class="groupSearchDiv">
						<span class="groupSearchSpan"><input id="groupNameInput" class="w3-input w3-border" type="text" placeholder="그룹명으로 검색" onkeypress="if(event.keyCode==13) {searchGroup();}"></span>
						<button class="searchBtn w3-border" onclick="searchGroup()">검색</button>
					</div>
				</div>
					
			<div class="row">
				<div id="newGroupListDiv">
					<c:forEach items="${requestScope.allList}" var="group">
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 내용 -->
								<div class="content">
									<table>
										<tr>
											<td class="groupImg" rowspan="3"><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></td>
											<td class="groupName" colspan="3"><a href="#">${group.groupName}</a></td>
											<td class="groupDelBtn"><span onclick="groupDelete('${group.groupNum}','${group.groupName}')">그룹삭제</span></td></tr>
										<tr>
											<td colspan="3">정보 : ${group.groupInfo}</td>
											<td></td>
										</tr>
										<tr>
											<td class="groupInterest">관심사 : ${group.groupInterest}</td>
											<td class="groupInfoOpen">정보공개 : 
											<c:choose>
												<c:when test="${group.groupInfoOpen eq '0'}">
													비공개
												</c:when>
												<c:otherwise>
													공개
												</c:otherwise>
											</c:choose>
											</td>
											<td>신고횟수 : ${group.groupSingoCnt}</td>
											<td></td>
										</tr>
									</table>
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
		function groupDelete(groupNum,groupName){
			if(confirm(groupName+' 그룹을 삭제하시겠습니까?')){
				location.href="groupDelete.do?groupNum="+groupNum;
				return true;
			} else {
				return false;
			}
		}
		
		function searchGroup(){
			var groupName = document.getElementById("groupNameInput").value;
			if(groupName==''){
				alert("검색어를 입력해주세요");
			} else {
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var resData = this.responseText;
						resData=JSON.parse(resData);
						newGroupList(resData,groupName);
					}
				}
				xhttp.open("POST", "searchGroup.do", true);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send("groupName="+groupName); 
			}
		}
		
		function newGroupList(resData,groupName){
			
			var groupListHTML = '';
			
			if(resData.length==0){
				groupListHTML =
					'<div class="col-md-12" style="text-align:center">'+
						'<h5>\''+groupName+'\'을 포함한 데이터가 존재하지 않습니다</h5>'+
					'</div>';
				
			} else {
				for(i=0 ; i < resData.length ; i++){
					groupListHTML += 
						'<div class="col-md-12">'+
							'<div class="card w3-round-large">'+
								'<div class="content">'+
									'<table>'+
										'<tr>'+
											'<td class="groupImg" rowspan="3"><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></td>'+
											'<td class="groupName" colspan="3">'+resData[i].groupName+'</td>'+
											'<td class="groupDelBtn"><span onclick="groupDelete("'+resData[i].groupNum+'","'+resData[i].groupName+')">그룹삭제</span></td>'+
										'</tr>'+
										'<tr>'+
											'<td colspan="3">정보 : '+resData[i].groupInfo+'</td>'+
											'<td></td>'+
										'</tr>'+
										'<tr>'+
											'<td class="groupInterest">관심사 : '+resData[i].groupInterest+'</td>'+
											'<td class="groupInfoOpen">정보공개 : '+(resData[i].groupInfoOpen==0?"비공개":"공개")+'</td>'+
											'<td>신고횟수 : '+resData[i].groupSingoCnt+'</td>'+
											'<td></td>'+
										'</tr>'+
									'</table>'+
								'</div>'+
							'</div>'+
						'</div>';
				}
			}

			document.getElementById("newGroupListDiv").innerHTML = groupListHTML;
		}
		
	</script>

</body>
</html>