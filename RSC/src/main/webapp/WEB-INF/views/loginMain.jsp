<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 배열 또는 List, null 등에 데이터가 저장 되었는지 확인하기 위한 length() 사용을 위한 선언 -->
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<!-- Font Awesome CSS-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<!-- Custom icon font-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/fontastic.css">
<!-- Google fonts - Roboto -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
<!-- jQuery Circle-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/grasp_mobile_progress_circle-1.0.0.min.css">
<!-- Custom Scrollbar-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<!-- theme stylesheet-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
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
	<jsp:include page="nav.jsp" />

	<div class="page home-page">

		<!-- 헤더 include -->
		<jsp:include page="header.jsp" />

		<!-- 본문 부분 -->
		<div class="content-page">

			<!-- 로그인 메인페이지 -->
			<div class="main-page2">
				<div class="row">
					<!-- 글 작성 틀 -->
					<div class="col-md-12">
						<div class="card w3-round-large">

							<!-- 글 머리 : 사진, 닉네임 -->
							<div class="header">
								<span><img
									src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span>
								<span>&nbsp;&nbsp;${sessionScope.nick}</span>
							</div>

							<!-- 글 내용 -->
							<div class="content">
								<form name="write"
									action="${pageContext.request.contextPath}/board/addBoard.do"
									method="post" style="width: 100%">
									<textarea rows="5"
										style="width: 100%; resize: none; wrap: hard;"
										name="boardContent"></textarea>
									<br> <input type="hidden" name="memberId"
										value="${sessionScope.id}"> <br>
									<div align="right">
										<input type=submit class="btn btn-default btnOrange" value=글쓰기>
									</div>
								</form>
							</div>

						</div>
					</div>
					<!--/글 작성 틀-->
				</div>

				<div class="row">
					<!-- 등록된 글이 없을때 -->
					<c:if test="${empty boardList || fn:length(boardList) == 0 }">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">

								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img
										src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span>
									<span>&nbsp;&nbsp;${sessionScope.nick}</span>
								</div>

								<!-- 글 내용 -->
								<div class="content">글을 등록해 주세요</div>
								<div align="right"></div>
								<hr>

							</div>
						</div>
						<!--/글 작성 틀-->
					</c:if>
					<!-- /등록된 글이 없을때 -->
				</div>



				<!-- 로그인 후 글 불러오기 -->
				<c:forEach items="${requestScope.boardList}" var="data">
					<div class="row">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img
										src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span>
									<span>&nbsp;&nbsp;${data.memberNick}</span>
								</div>

								<!-- 글 내용 -->
								<div class="content">
									<span> <a href="" style="display: block;"
										data-toggle="modal" data-target="#detailView"
										onclick="searchBoard(${data.boardNum})">
											${data.boardContent} </a>
									</span>
								</div>
								<hr>

								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i> ${data.boardTime}
									</div>
								</div>
							</div>
						</div>
						<br>
						<!--/글 작성 틀-->
					</div>

				</c:forEach>
				<!-- /로그인 후 글 불러오기 -->


			</div>
			<!-- /로그인 메인 -->

		</div>
		<!-- 본문 끝 부분 -->

		<footer class="main-footer">
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-6">
						<p>KOSTA 161 RSC &copy; 2017</p>
					</div>
					<div class="col-sm-6 text-right">
						<p>마지막 문장</p>
					</div>
				</div>
			</div>
		</footer>

	</div>


	<!-- 글 상세보기 모달 -->
	<div class="modal fade" id="detailView" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<div class="col-md-12 padding">
					<!-- 글 머리 : 사진, 닉네임 -->
					<div class="header padding" style="float: left; width: 45%;">
						<span><img
							src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span>
						&nbsp;&nbsp;&nbsp;<span id="memberNick"> </span>
					</div>

					<!-- 글 조회수 -->
					<div class="cnt padding"
						style="line-height: 44px; float: right; width: 45%;" align="right">
						<span id="boardCnt"></span>
					</div>

					<div class="clear"></div>

					<!-- 글 내용 -->
					<div class="content col-md-12 padding">
						<span id="boardContent"> </span>
					</div>
					<hr>

					<!-- 글 작성 시간 -->
					<div class="footer">
						<div class="time-tag" style="float: left;">
							<i class="fa fa-clock-o"></i> &nbsp;&nbsp;&nbsp;<span
								id="boardTime"></span>
						</div>
					</div>
					<!-- 좋아요 카운트 수 -->
					<div class="likeCnt" align="right">
						<span id=boardLike>0</span>
					</div>
					<!-- /좋아요 카운트 수 -->

					<div class="clear"></div>

					<!-- 신고하기 버튼 -->
					<div class="singoBtn" align="left">
						<form class="form-inline" action="singo.do">
							<input type="submit" class="btn btn-default btnOrange"
								value="신고하기"> <input type="hidden" name="boardNum"
								value="${sessionScope.id}">
						</form>
					</div>
					<!-- /신고하기 버튼-->

					<!-- 좋아요 버튼 -->
					<div class="likeBtn" align="right">
						<form class="form-inline1" action="like.do">
							<input class="btn btn-default btnOrange" type="submit"
								width="75%" value="좋아요"> <input type="hidden"
								name="boardNum" value="${sessionScope.id}">
						</form>
					</div>
					<!-- /좋아요 버튼 -->

					<div class="clear"></div>

					<!-- 댓글 작성 틀 -->
					<div style="float: left; width: 75%;" align="left">
						<textarea id="replyContent" rows="1"
							style="width: 100%; resize: none; wrap: hard;"
							placeholder="댓글을 입력하세요" name="replyContent"></textarea>
					</div>
					<div style="float: right;" align="right">
						<button class="btn btn-default btnOrange" onclick="addReply()">작성완료</button>
						<input type="hidden" name="boardNum" id="boardNum" value="">
						<input type="hidden" name="memberId" id="memberId" value="">
					</div>
					<!-- /댓글 작성 틀 -->

				</div>
				<!--/글 작성 틀-->

				<!-- 댓글 내용 -->
				<div id="replyHTML"></div>
				<!-- /댓글 내용 -->


			</div>

		</div>
	</div>
	<!-- /글 상세보기 모달 -->

	<!-- Javascript files-->
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js">
		
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js">
		
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>

	<!-- 모달 비동기 스크립트 -->
	<script>
		function searchBoard(boardNum) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					console.log(resData);
					
					document.getElementById("memberNick").innerText = resData.board.memberNick;
					document.getElementById("boardContent").innerText = resData.board.boardContent;
					document.getElementById("boardTime").innerText = new Date(resData.board.boardTime).toUTCString();
					document.getElementById("boardCnt").innerText = "조회수 : " + resData.board.boardCnt;
					document.getElementById("boardNum").value = resData.board.boardNum;
					document.getElementById("memberId").value = resData.board.memberId;
					replyList(resData.reply);
					
					/* document.getElementById("memberNick").innerText = resData.memberNick;
					document.getElementById("boardContent").innerText = resData.boardContent;
					document.getElementById("boardTime").innerText = new Date(resData.boardTime).toUTCString();
					document.getElementById("boardCnt").innerText = "조회수 : " + resData.boardCnt;
					document.getElementById("boardNum").value = resData.boardNum;
					document.getElementById("memberId").value = resData.memberId;
					addReply(); */
					
				}
			}
			
			xhttp.open("POST", "${pageContext.request.contextPath}/board/searchBoard.do", true);
	        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("boardNum="+boardNum); 
			
		}
		
		function addReply(){
			var memberId = document.getElementById("memberId").value;
			var replyContent = document.getElementById("replyContent").value;
			var boardNum = document.getElementById("boardNum").value;

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					console.log(resData);
					replyList(resData);
				}
			}
			
			xhttp.open("POST", "${pageContext.request.contextPath}/reply/addReply.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("boardNum="+boardNum +"&memberId="+memberId+"&replyContent="+replyContent); 
			
		}
		
		function replyList(resData) {
			console.log(resData);
			
			var replyListHTML = '';
			
			if(resData.length == 0) {
				replyListHTML = 
				'<div class="content padding1">댓글을 등록해 주세요</div>' +
				'<div align="right"></div>';
			} else {
				for(i=0; i < resData.length; i++ ) {
					replyListHTML +=
						'<div class="row"> ' +
					'<div class="col-md-12"> ' +
						'<div class="w3-round-large padding col-md-12"">' +
// 							<!-- 글 머리 : 사진, 닉네임 -->
							'<div class="header" ' +
							'style="float: left;  width: 35%;"> ' +
								'<span><img '+
								'src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> ' +
								'<span>&nbsp;&nbsp;'+resData[i].memberNick +'</span>'+
							'</div>'+

// 							<!-- 글 내용 -->
							'<div class="content"'+
								'style="float: right; width: 55%;">'+
								'<span>'+ resData[i].replyContent +'</span>'+
							'</div>'+
							'<div class="clear"></div>'+
// 							<!-- 글 작성 시간 -->
							'<div class="footer" align="right">'+
								'<div class="time-tag">'+
									'<span><i class="fa fa-clock-o"></i>'+ resData[i].replyTime +'</span>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>'+
					'<br>'+
// 					<!--/글 작성 틀-->
				'</div>'
				}
			}
			
			document.getElementById("replyHTML").innerHTML = replyListHTML;
		}
	</script>


</body>
</html>