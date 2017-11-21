<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

			<!-- 비로그인 메인페이지 -->
			<div class="main-page">
				<!-- 일간 TOP -->
				일간 TOP
				<div class="row">
					<c:forEach var = "item" items = "${map.day}" begin="0" end="2" step="1">
						<!-- 글 작성 틀 -->
						<div class="col-md-4">
							<div class="card w3-round-large">
	
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img src="${pageContext.request.contextPath}/${item.memberImg}"></span> <span>&nbsp;&nbsp;${item.memberNick}</span>
								</div>
	
								<!-- 글 내용 -->
								<div class="content">
									<span>
										<a href="#" style="display: block;"data-toggle="modal" data-target="#detailView" onclick="searchBoard(${item.boardNum})">${item.boardContent}</a>
									</span>
								</div>
								<hr>
	
								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i>
										<fmt:formatDate value="${item.boardTime }"
											pattern="yyyy년 M월 d일 H시 m분 s초" />

									</div>
								</div>
							</div>
						</div>
						<!--/글 작성 틀-->
					</c:forEach>
				</div> <!--/일간 TOP -->

				<!-- 주간 TOP -->
				주간 TOP
				<div class="row">
					<c:forEach var = "item" items = "${map.week}" begin="0" end="2" step="1">
						<!-- 글 작성 틀 -->
						<div class="col-md-4">
							<div class="card w3-round-large">
	
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img src="${pageContext.request.contextPath}/${item.memberImg}"></span> <span>&nbsp;&nbsp;${item.memberNick}</span>
								</div>
	
								<!-- 글 내용 -->
								<div class="content">
									<span>
										<a href="#" style="display: block;"data-toggle="modal" data-target="#detailView" onclick="searchBoard(${item.boardNum})">${item.boardContent}</a>
									</span>
								</div>
								<hr>
	
								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i>
										<fmt:formatDate value="${item.boardTime }"
											pattern="yyyy년 M월 d일 H시 m분 s초" />

									</div>
								</div>
							</div>
						</div>
						<!--/글 작성 틀-->
					</c:forEach>
				</div> <!--/주간 TOP -->

				<!-- 월간 TOP -->
				월간 TOP
				<div class="row">
					<c:forEach var = "item" items = "${map.month}" begin="0" end="2" step="1">
						<!-- 글 작성 틀 -->
						<div class="col-md-4">
							<div class="card w3-round-large">
	
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span><img src="${pageContext.request.contextPath}/${item.memberImg}"></span> <span>&nbsp;&nbsp;${item.memberNick}</span>
								</div>
	
								<!-- 글 내용 -->
								<div class="content">
									<span>
										<a href="#" style="display: block;"data-toggle="modal" data-target="#detailView" onclick="searchBoard(${item.boardNum})">${item.boardContent}</a>
									</span>
								</div>
								<hr>
	
								<!-- 글 작성 시간 -->
								<div class="footer">
									<div class="time-tag">
										<i class="fa fa-clock-o"></i>
										<fmt:formatDate value="${item.boardTime }"
											pattern="yyyy년 M월 d일 H시 m분 s초" />

									</div>
								</div>
							</div>
						</div>
					<!--/글 작성 틀-->
					</c:forEach>
				</div> <!--/월간 TOP -->
				
			</div> <!-- /비로그인 메인 -->
			
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

					<!-- 좋아요 카운트 수 -->
					<div class="likeCnt" align="right">
						<span id=boardLike></span>
					</div>
					<!-- /좋아요 카운트 수 -->

					<div class="clear"></div>
					
					<!-- 글 작성 시간 -->
					<div class="footer">
						<div class="time-tag" style="float: left;">
							<i class="fa fa-clock-o"></i> &nbsp;&nbsp;&nbsp;<span
								id="boardTime"></span>
						</div>
					</div>
					
					<!-- 좋아요 버튼 -->
					<div class="likeBtn" align="right">
						<i class="fa fa-thumbs-up btn btn-default btnOrange" style="float: right;"></i>
						<input type="hidden" name="boardNum" id="boardNum" value="">
					</div>
					<!-- /좋아요 버튼 -->
					
					<!-- 좋아요 버튼 -->
					<div class="likeBtn" align="right">
						<i class="fa fa-thumbs-down btn btn-default btnOrange" style="float: right;"></i>
						<input type="hidden" name="boardNum" id="boardNum" value="">
					</div>
					<!-- /좋아요 버튼 -->

					<div class="clear"></div>

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
								action="${pageContext.request.contextPath}/singo/addReplySingo.do" >
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
	<script src="${pageContext.request.contextPath}/resources/js/board-detail.js"></script>

</body>
</html>