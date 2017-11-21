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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/favicon.png">
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
		
			<!-- 신고페이지 -->
			<div class="singoAdmin-page">
				<div class="row">
					<div class="col-md-12">	
						<h3>신고</h3><br>
						<div class="singoSelectDiv">
							<span class="singoSelectSpan">
								<select class="w3-select w3-border" onchange="getSingoList(this.value)">
									<option value="board" selected>게시글</option>
									<option value="reply">댓글</option>
									<option value="group">그룹</option>
								</select>
							</span>
							<button>선택</button>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">	
						<div id="singoList">
					
						</div>
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
	window.onload = function(){
		getSingoList('board');
	}
	
	function getSingoList(type){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData=JSON.parse(resData);
				newSingoList(type, resData);
			}
		}
		xhttp.open("POST", "singoList.do?type="+type, true);
		xhttp.send(); 
	}
	
	function newSingoList(type, resData){
		var singoListHTML = '';
		
		if(type=='board') {
			singoListHTML +=
				'<table class="w3-table w3-bordered w3-hoverable">'+
					'<thead><tr>'+
						'<th class="tdNum">신고 번호</th>'+
						'<th class="tdMemberId">작성자</th>'+
						'<th class="tdContent">내용</th>'+
						'<th class="tdReason">신고사유</th>'+
						'<th class="tdRestore"></th>'+
						'<th class="tdDelete"></th>'+
					'</tr></thead>';
			if(resData.length==0){
				singoListHTML +=
					'<tr>'+
						'<td colspan="6" style="text-align:center;">신고 내역이 없습니다.</td>'+
					'</tr>';
			} else {
				for(i=0 ; i<resData.length ; i++){
					singoListHTML +=
						'<tr>'+
							'<td>'+resData[i].boardSingoNum+'</td>'+
							'<td>'+resData[i].memberId+'</td>'+
							'<td>'+resData[i].boardContent+'</td>'+
							'<td>'+resData[i].boardSingoReason+'</td>'+
							'<td><Button class="restoreBtn" onclick="restoreSingoObj(\'board\',\''+resData[i].boardSingoNum+'\',\''+resData[i].boardNum+'\')">복원</Button></td>'+
							'<td><Button class="deleteBtn" onclick="deleteSingoObj(\'board\',\''+resData[i].boardSingoNum+'\',\''+resData[i].boardNum+'\')">삭제</Button></td>'+
						'</tr>';
				}
			}
			singoListHTML += '</table>';
			document.getElementById("singoList").innerHTML = singoListHTML;
		} else if (type == 'reply') {
			singoListHTML +=
				'<table class="w3-table w3-bordered w3-hoverable">'+
					'<thead><tr>'+
						'<th class="tdNum">신고 번호</th>'+
						'<th class="tdMemberId">작성자</th>'+
						'<th class="tdContent">내용</th>'+
						'<th class="tdReason">신고사유</th>'+
						'<th class="tdRestore"></th>'+
						'<th class="tdDelete"></th>'+
					'</tr></thead>';
			if(resData.length==0){
				singoListHTML +=
					'<tr>'+
						'<td colspan="6" style="text-align:center;">신고 내역이 없습니다.</td>'+
					'</tr>';
			} else {
				for(i=0 ; i<resData.length ; i++){
					singoListHTML +=
						'<tr>'+
							'<td>'+resData[i].replySingoNum+'</td>'+
							'<td>'+resData[i].memberId+'</td>'+
							'<td>'+resData[i].replyContent+'</td>'+
							'<td>'+resData[i].replySingoReason+'</td>'+
							'<td><Button class="restoreBtn" onclick="restoreSingoObj(\'reply\',\''+resData[i].replySingoNum+'\',\''+resData[i].replyNum+'\')">복원</Button></td>'+
							'<td><Button class="deleteBtn" onclick="deleteSingoObj(\'reply\',\''+resData[i].replySingoNum+'\',\''+resData[i].replyNum+'\')">삭제</Button></td>'+
						'</tr>';
				}
			}
			singoListHTML += '</table>';
			document.getElementById("singoList").innerHTML = singoListHTML;
			
			
		} else {
			singoListHTML +=
				'<table class="w3-table w3-bordered w3-hoverable">'+
					'<thead><tr>'+
						'<th class="tdGNum">신고 번호</th>'+
						'<th class="tdGName">그룹 이름</th>'+
						'<th class="tdGReason">신고 사유</th>'+
						'<th class="tdGSingoCnt">신고 횟수</th>'+
						'<th class="tdRestore"></th>'+
						'<th class="tdDelete"></th>'+
					'</tr></thead>';
			if(resData.length==0){
				singoListHTML +=
					'<tr>'+
						'<td colspan="6" style="text-align:center;">신고 내역이 없습니다.</td>'+
					'</tr>';
			} else {
				for(i=0 ; i<resData.length ; i++){
					singoListHTML +=
						'<tr>'+
							'<td>'+resData[i].groupSingoNum+'</td>'+
							'<td>'+resData[i].groupName+'</td>'+
							'<td>'+resData[i].groupSingoReason+'</td>'+
							'<td>'+(resData[i].groupSingoCnt>=5?"<b style=\"color:red\">"+resData[i].groupSingoCnt+"</b>":resData[i].groupSingoCnt)+'</td>'+
							'<td><Button class="restoreBtn" onclick="restoreSingoObj(\'group\',\''+resData[i].groupSingoNum+'\',\''+resData[i].groupNum+'\')">복원</Button></td>'+
							'<td><Button class="deleteBtn" onclick="deleteSingoObj(\'group\',\''+resData[i].groupSingoNum+'\',\''+resData[i].groupNum+'\')">삭제</Button></td>'+
						'</tr>';
				}
			}
			singoListHTML += '</table>';
			document.getElementById("singoList").innerHTML = singoListHTML;
		}
	}
	
	/* 신고된 객체 복원 */
	function restoreSingoObj(type,singoNum,num){
		if(confirm("복원 하시겠습니까?")){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					newSingoList(type, resData);
				}
			}
			xhttp.open("POST", "restoreSingo.do?type="+type+"&singoNum="+singoNum+"&num="+num, true);
			xhttp.send(); 
			return true;
		} else {
			return false;
		}
	}
	
	/* 신고된 객체 삭제 */
	function deleteSingoObj(type, singoNum, num){
		if(confirm("삭제 하시겠습니까?")){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					newSingoList(type, resData);
				}
			}
			xhttp.open("POST", "deleteSingo.do?type="+type+"&singoNum="+singoNum+"&num="+num, true);
			xhttp.send(); 
			return true;
		} else {
			return false;
		}
	}
	

	
	</script>

</body>
</html>