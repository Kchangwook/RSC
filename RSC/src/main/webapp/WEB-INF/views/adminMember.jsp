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

			<!-- 회원관리 메인페이지 -->
			<div class="memberAdmin-page">
				<div class="row">
					<div class="col-md-12">
						<h3>회원 관리</h3><br>
					</div>
					<div class="memberSearchDiv">
						<span class="memberSearchSpan"><input id="memberInput" class="w3-input w3-border" type="text" placeholder="회원 ID 또는 닉네임으로 검색" onkeypress="if(event.keyCode==13) {searchMember();}"></span>
						<button class="searchBtn w3-border" onclick="searchMember()">검색</button>
					</div>
				</div>
					
			<div class="row">
				<div id="newMemberListDiv">
					<c:forEach items="${requestScope.allList}" var="member">
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 내용 -->
								<div class="content">
									<table>
										<tr>
											<td class="memberImg" rowspan="3"><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></td>
											<td class="memberName" colspan="3"><a href="#">${member.memberNick}</a></td>
											<td colspan="3"><b>ID</b> : ${member.memberId}</a></td>
											<td class="memberDelBtn"><span onclick="memberDelete('${member.memberId}','${member.memberNick}')">계정삭제</span></td></tr>
										<tr>
											<td colspan="3"><b>관심사</b> : ${member.memberInterest}</td>
											<td colspan="3"><b>정보공개</b> : 
											<c:choose>
												<c:when test="${member.memberInfoOpen eq '0'}">	
													비공개
												</c:when>
												<c:otherwise>
													공개
												</c:otherwise>
											</c:choose>
											</td>
											<td></td>
										</tr>
										<tr>
											<td colspan="3"><b>최근 로그인</b> : ${member.memberLogin}</td>
											<td colspan="3"><b>최근 로그아웃</b> : ${member.memberLogout}</td>
											<td>
											<c:choose>
												<c:when test="${member.memberPresentLogin eq '0'}">
													<i class="fa fa-circle" style="color:red; font-size: xx-small;"></i>&nbsp;오프라인
												</c:when>
												<c:otherwise>
													<i class="fa fa-circle" style="color:green; font-size:xx-small;"></i>&nbsp;온라인
												</c:otherwise>
											</c:choose>
											</td>
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
		function memberDelete(memberId,memberNick){
			if(confirm(memberNick+' 회원을 삭제하시겠습니까?')){
				location.href="memberDelete.do?memberId="+memberId;
				return true;
			} else {
				return false;
			}
		}

		
		function searchMember(){
			var memberIdName = document.getElementById("memberInput").value;
			if(memberIdName==''){
				alert("검색어를 입력해주세요");
			} else {
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var resData = this.responseText;
						resData=JSON.parse(resData);
						console.log(resData);
						newMemberList(resData,memberIdName);
					}
				}
				xhttp.open("POST", "searchMember.do?memberIdName="+memberIdName, true);
				xhttp.send(); 
			}
		}
		
		function newMemberList(resData,memberIdName){
			
			var memberListHTML = '';
			
			if(resData.length==0){
				memberListHTML =
					'<div class="col-md-10" style="text-align:center">'+
						'<h5>\''+memberIdName+'\'을 포함한 회원 데이터가 존재하지 않습니다</h5>'+
					'</div>';
				
			} else {
				for(i=0 ; i < resData.length ; i++){
					memberListHTML +=
					'<div class="col-md-12">'+
					'<div class="card w3-round-large">'+
					'<div class="content">'+
					'<table>'+
					'<tr>'+
					'<td class="memberImg" rowspan="3"><img src="${pageContext.request.contextPath}/resources/img/profile.jpg"></td>'+
					'<td class="memberName" colspan="3"><a href="#">'+resData[i].memberNick+'</a></td>'+
					'<td colspan="3"><b>ID</b> : '+resData[i].memberId+'</a></td>'+
					'<td class="memberDelBtn"><span onclick="memberDelete(\''+resData[i].memberId+'\',\''+resData[i].memberNick+'\')">계정삭제</span></td>'+
					'</tr>'+
					'<tr>'+
					'<td colspan="3"><b>관심사</b> : '+resData[i].memberInterest+'</td>'+
					'<td colspan="3"><b>정보공개</b> : '+(resData[i].memberInfoOpen==0?"비공개":"공개")+'</td>'+
					'<td></td>'+
					'</tr>'+
					'<tr>'+
					'<td colspan="3"><b>최근 로그인</b> : '+resData[i].memberLogin+'</td>'+
					'<td colspan="3"><b>최근 로그아웃</b> : '+resData[i].memberLogout+'</td>'+
					'<td>'+
					(resData[i].memberPresentLogin==0?"<i class=\"fa fa-circle\" style=\"color:red; font-size: xx-small;\"></i>&nbsp;오프라인":"<i class=\"fa fa-circle\" style=\"color:green; font-size: xx-small;\"></i>&nbsp;온라인")+
					'</td>'+
					'</tr>'+
					'</table>'+
					'</div>'+
					'</div>'+
					'</div>';
				}
			}
			document.getElementById("newMemberListDiv").innerHTML = memberListHTML;
		}
	</script>

</body>
</html>