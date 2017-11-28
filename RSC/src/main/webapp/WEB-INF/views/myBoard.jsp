<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/my-board.css">
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


					<!-- 등록된 글이 없을때 -->
					<c:if test="${empty list}">
						<div class="row">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">

								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span class="imgSpan"><img class="imgTag"
										src="${pageContext.request.contextPath}/${member.memberImg}"></span>
									<span>&nbsp;&nbsp;${sessionScope.nick}</span>
								</div>

								<!-- 글 내용 -->
								<div class="content">작성된 글이 없습니다. 메인화면에서 글을 등록 해주세요</div>
								<div align="right"></div>
								<hr>

							</div>
						</div>
						<!--/글 작성 틀-->
						</div>
					</c:if>
				<!-- 게시글 불러오기 -->
				<!-- 로그인 후 게시글 불러오기 -->
				<c:forEach items="${requestScope.list}" var="data"
					varStatus="status">

					<div class="row boardView">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span class="imgSpan">
										<img class="imgTag" src="${pageContext.request.contextPath}/${data.memberImg}">
									</span>
									<span>&nbsp;&nbsp;${data.memberNick}</span>
									<span class = "board-modify"data-toggle="modal" data-target="#modifyView" onclick="modifyBoard(${data.boardNum})">수정</span>
									<span>/</span>
									<span class = "board-delete" onclick = "deleteBoard(${data.boardNum})">삭제</span>
								</div>

								<c:choose>
									<c:when test="${data.boardSingoFlag eq 0}">
										<!-- 글 내용 -->
										<div class="content">
											<span> <a href="" style="display: block;"
												data-toggle="modal" data-target="#detailView"
												onclick="searchBoard(${data.boardNum})">
													${data.boardContent} </a>
											</span>
										</div>
									</c:when>

									<c:when test="${data.boardSingoFlag eq 1}">
										<!-- 글 내용 -->
										<div class="content">
											<span> 본 게시글은 신고가 되었습니다 </span>
										</div>
									</c:when>
								</c:choose>
								<hr>

								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i>
										<fmt:formatDate value="${data.boardTime }"
											pattern="yyyy년 M월 d일 H시 m분 s초" />

									</div>
								</div>
							</div>
						</div>
						<br>
						<!-- /글 작성 틀 -->
					</div>

				</c:forEach>
				<button class="btn btn-default btnOrange"
					onclick="moreBoardView(window.cnt = window.cnt + 3);">게시글
					더보기</button>
				<!-- /로그인 후 게시글 불러오기 -->


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
						<!-- <p>마지막 문장</p> -->
					</div>
				</div>
			</div>
		</footer>

	</div>


	<!-- 글 수정하기 모달 -->
	<div class="modal fade" id="modifyView" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<form action="${pageContext.request.contextPath}/board/modifyBoard.do" name = "modFrm" id = "modFrm" method = "post">
				<div class="col-md-12 padding">
					<!-- 글 머리 : 사진, 닉네임 -->
					<div class="header padding" style="float: left; width: 45%;">
						<input type = "hidden" name = "modifyNum" id = "modifyNum">
						<span>
							<img id = "modifyImg">
						</span>
						<input type = "hidden" id = "modifyNum">
						&nbsp;&nbsp;&nbsp;<span id="modifyNick"></span>
					</div>

					<!-- 글 조회수 -->
					<div class="cnt padding"
						style="line-height: 44px; float: right; width: 45%;" align="right">
						<span id="modifyCnt"></span>
					</div>

					<div class="clear"></div>

					<!-- 글 내용 -->
					<div class="content col-md-12 padding">
						<textArea name = "modifyContent" id="modifyContent" rows="5" style = "width: 100%; resize: none; wrap: hard;overflow: hidden"> </textArea>
					</div>
					<hr>

					<!-- 글 작성 시간 -->
					<div class="footer">
						<div class="time-tag" style="float: left;">
							<i class="fa fa-clock-o"></i> &nbsp;&nbsp;&nbsp;<span
								id="modifyTime"></span>
						</div>
						<div id="modify">
							<button class = "btn btn-default btnOrange modifybtn" onclick = "modifyContent()">수정하기</button>
							<button class = "btn btn-default btnOrange cancelbtn" data-dismiss="modal">취소</button>
						</div>
					</div>

					<div class="clear"></div>

				</div>
				<!--/글 작성 틀-->

			</form>
			</div>
			
		</div>
	</div>
	<!-- /글 수정하기보기 모달 -->
	
		<!-- 글 상세보기 모달 -->
	<div class="modal fade" id="detailView" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<div class="col-md-12 padding">
					<!-- 글 머리 : 사진, 닉네임 -->
					<div class="header padding" style="float: left; width: 45%;">
						<span class="imgSpan"><img id = "profImg"></span>
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
						<span id=boardLike></span>
					</div>
					<!-- /좋아요 카운트 수 -->

					<div class="clear"></div>

					<!-- 글 신고하기 버튼 -->
					<div id="viewSingo" class="singoBtn" align="left">
						<a class="btn btn-default btnOrange" href="" data-toggle="modal"
							data-target="#singo"> 신고하기 </a>
					</div>
					<!-- /글 신고하기 버튼-->

					<!-- 글 신고하기 상세내용 -->
					<div class="modal fade" id="singo" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="col-md-12 padding">
									<div>신고 사유 :</div>
									<div class="clear"></div>
									<div>
										<form name="singo"
											action="${pageContext.request.contextPath}/singo/addBoardSingo.do">
											<textarea id="boardSingoReason" method="post" rows="1"
												style="width: 100%; resize: none; wrap: hard;"
												placeholder="이유가 뭐니" name="boardSingoReason"></textarea>
											<br> <input type="hidden" name="boardNum" id="boardNum"
												value="">
											<div align="right">
												<input type=submit class="btn btn-default btnOrange close"
													value=신고하기>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /글 신고하기 상세내용 -->

					<!-- 좋아요 버튼 -->
					<div class="likeBtn" align="right">
						<div id="like"></div>
						<input type="hidden" name="boardNum" id="boardNum" value="">
						<input type="hidden" name="memberId" id="memberId" value="">
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
				<button class="btn btn-default btnOrange"
					onclick="moreReplyView(window.cnt = window.cnt + 3);">댓글
					더보기</button>

			</div>

		</div>
	</div>
	<!-- /글 상세보기 모달 -->

	<!-- 댓글 신고하기 상세내용 -->
	<div class="modal fade" id="replySingo" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="col-md-12 padding">
					<div>신고 사유 :</div>
					<div class="clear"></div>
					<div>
						<form name="replySingo" method="post"
							action="${pageContext.request.contextPath}/singo/addReplySingo.do">
							<textarea id="replySingoReason" rows="1"
								style="width: 100%; resize: none; wrap: hard;"
								placeholder="이유가 뭐야" name="replySingoReason"></textarea>
							<br> <input type="hidden" name="replyNum" id="replyNum"
								value="">
							<div align="right">
								<input type=submit class="btn btn-default btnOrange close"
									value=신고하기>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /댓글 신고하기 상세내용 -->




	<!-- Javascript files-->
	<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"></script>
	<%-- <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script> --%>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>

	<!-- 모달 비동기 스크립트 -->
	<script src="${pageContext.request.contextPath}/resources/js/board-detail.js"></script>
	

	<!-- <fmt:formatDate value="${data.boardTime }" pattern="yyyy년 M월 d일 H시 m분 s초"/> -->
</body>
</html>