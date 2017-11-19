<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
			<!-- 게시글관리 메인페이지 -->
			<div class="boardAdmin-page">
			
				<div class="row">
					<div class="col-md-12">
						<h3>게시글 관리</h3><br>
					</div>
					<div class="boardSearchDiv">
							<span class="boardSearchSpan">
								<input id="boardSearchInput" class="w3-input w3-border" type="text" placeholder="작성자 또는 내용으로 검색" onkeypress="if(event.keyCode==13) {searchBoardList();}">
							</span>
							<button class="searchBtn w3-border" onclick="searchBoardList()">검색</button>
					</div>
				</div>

				<div class="row">
					<div class="col-md-12">
						<div id="newBoardListDiv">
							<table class="w3-table w3-bordered w3-hoverable">
								<thead>
									<tr>
										<th class="tdType">구분</th>
										<th class="tdNum" onclick="orderBoardList(this.className)">번호<i class="fa fa-arrows-v" id="iconNum"></i></th>
										<th class="tdMemberId">작성자</th>
										<th class="tdContent">내용</th>
										<th class="tdTime" onclick="orderBoardList(this.className)">시간<i class="fa fa-arrow-down" id="iconTime"></i></th>
										<th class="tdSingo">신고</th>
										<th class="tdLike" onclick="orderBoardList(this.className)">좋아요<i class="fa fa-arrows-v" id="iconLike"></i></th>
										<th class="tdCount" onclick="orderBoardList(this.className)">조회수<i class="fa fa-arrows-v" id="iconCount"></i></th>
									</tr>
								</thead>
								<tbody id="boardBody">
									<c:forEach items="${requestScope.list}" var="data">
									<tr>
										<td>
											<c:choose>
												<c:when test="${data.groupNum eq 0}">
													개인
												</c:when>
												<c:otherwise>
													그룹
												</c:otherwise>
											</c:choose>
										</td>
										<td>${data.boardNum}</td>
										<td>${data.memberId}</td>
										<td>${data.boardContent}</td>
										<td>
											<fmt:formatDate value="${data.boardTime}" pattern="yyyy년 M월 d일 H시 m분" />
										</td>
										<td>
											<c:if test="${data.boardSingoFlag ne 0 }">
												O
											</c:if>
										</td>
										<td>${data.boardLike}</td>
										<td>${data.boardCnt}</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 부분 -->

		</div>
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
	
	<input type="hidden" id="hiddenNum" value="none">
	<input type="hidden" id="hiddenTime" value="desc">
	<input type="hidden" id="hiddenLike" value="none">
	<input type="hidden" id="hiddenCount" value="none">
	

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
	var orderArr = ["Num","Time","Like","Count"];
	var orderColumn = "board_time";
	var orderType = "desc";
	var boardIdContent = "";
	
	function searchBoardList(){
		boardIdContent = document.getElementById("boardSearchInput").value;
		if(boardIdContent==''){
			alert("검색어를 입력해주세요");
		} else {
			getNewBoardList();
		}
	}
	
	function orderBoardList(className){
		
		switch(className){
		case 'tdNum':
			setOrder(orderArr[0]);
			orderColumn="board_num";
			break;
		case 'tdTime':
			setOrder(orderArr[1]);
			orderColumn="board_time";
			break;
		case 'tdLike':
			setOrder(orderArr[2]);
			orderColumn="board_like";
			break;
		case 'tdCount':
			setOrder(orderArr[3]);
			orderColumn="board_cnt"
			break;
		}
		getNewBoardList();
	}
	
	function setOrder(column){
		if(document.getElementById("hidden"+column).value=="desc"){
			orderAsc(column);
			orderType="asc";
		} else if (document.getElementById("hidden"+column).value=="asc") {
			orderDesc(column);
			orderType="desc";
		} else {
			orderDesc(column);
			orderType="desc";
		}
	}
	
	function orderDesc(column){
		for(i=0 ; i<orderArr.length ; i++){
			if(orderArr[i]==column){
				document.getElementById("icon"+orderArr[i]).className="fa fa-arrow-down";
				document.getElementById("hidden"+orderArr[i]).value = "desc";
			}
			else {
				document.getElementById("icon"+orderArr[i]).className="fa fa-arrows-v";
				document.getElementById("hidden"+orderArr[i]).value = "none";
			}
		}
	}
	
	function orderAsc(column){
		for(i=0 ; i<orderArr.length ; i++){
			if(orderArr[i]==column){
				document.getElementById("icon"+orderArr[i]).className="fa fa-arrow-up";
				document.getElementById("hidden"+orderArr[i]).value = "asc";
			}
			else {
				document.getElementById("icon"+orderArr[i]).className="fa fa-arrows-v";
				document.getElementById("hidden"+orderArr[i]).value = "none";
			}
		}
	}
	
	function getNewBoardList(){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData=JSON.parse(resData);
				printNewBoardList(resData);
			}
		}
		xhttp.open("POST", "boardOrder.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("orderColumn="+orderColumn+"&orderType="+orderType+"&boardIdContent="+boardIdContent); 
	}
	
	function printNewBoardList(resData){
		var newBoardHTML = "";
		for (i=0 ; i<resData.length ; i++){
			newBoardHTML += 
				'<tr>'+
					'<td>'+(resData[i].groupNum=="0"?"개인":"그룹")+'</td>'+
					'<td>'+resData[i].boardNum+'</td>'+
					'<td>'+resData[i].memberId+'</td>'+
					'<td>'+resData[i].boardContent+'</td>'+
					'<td>'+
						new Date(resData[i].boardTime).getFullYear()+'년 '+
						(new Date(resData[i].boardTime).getMonth()+1)+'월 '+
						new Date(resData[i].boardTime).getDate()+'일 '+
						new Date(resData[i].boardTime).getHours()+'시 '+
						new Date(resData[i].boardTime).getMinutes()+'분'+
					'</td>'+
					'<td>'+(resData[i].boardSingoFlag=="0"?"":"O")+'</td>'+
					'<td>'+resData[i].boardLike+'</td>'+
					'<td>'+resData[i].boardCnt+'</td>'+
				'</tr>';
		}
		document.getElementById("boardBody").innerHTML = newBoardHTML;
	}
	

	

	</script>

</body>
</html>