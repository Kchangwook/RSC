<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>friend</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel = "stylesheet" href = "${pageContext.request.contextPath}/resources/css/friend.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
</head>
<body>
	<!-- 네비게이션 바 include -->
	<jsp:include page="nav.jsp"/>

	<div class="page home-page">
	
		<!-- 헤더 include -->
		<jsp:include page="header.jsp"/>

		<!-- 본문 부분 -->
		<div class="content-page">
		<div class="main-page2">
			<!-- 회원관리 메인페이지 -->
					
			<div class="row">
						<div class="col-md-12">
							<div class="card w3-round-large friend-info">
								<!-- 글 내용 -->
								<div class="content friend-content">
								<table>
									<tr>
										<td>
										<span class="friend-pfimg imgSpan">
											<img class = "imgTag" src = "${pageContext.request.contextPath}/${friend.memberImg}">
										</span>
										</td>
									</tr>
									<tr>
									<td><span class = "friend-name"><b>${friend.memberNick}</b></span></td>
									</tr>
									<tr>
									<td><span class = "friend-interest"><b>관심사</b></span></td>
									</tr>
									<tr>
									<td><span class = "friend-intercontent"><b>${friend.memberInterest}</b></span></td>
									</tr>
									<c:if test="${notFriend}">
									<tr>
									<td><button class = "friend-add" onclick = "addFriend('${friend.memberId}','${sessionScope.id}')"><b>친구 추가</b></button></td>
									</tr>
									</c:if>
								</table>
								</div>
							</div>
						</div>
			</div>
		<input type="hidden" id="friendId" name="friendId" value="${friend.memberId}">
		<!-- 로그인 후 게시글 불러오기 -->
			<div id="moreFriendView">	
				<c:forEach items="${list}" var="data"
					varStatus="status">

					<div class="row boardView">
						<!-- 글 작성 틀 -->
						<div class="col-md-12">
							<div class="card w3-round-large">
								<!-- 글 머리 : 사진, 닉네임 -->
								<div class="header">
									<span class="imgSpan"><img class="imgTag"
										src="${pageContext.request.contextPath}/${data.memberImg}"></span>
									<span>&nbsp;&nbsp;${data.memberNick}</span>
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
				</div>
				<button class="btn btn-default btnOrange"
					onclick="moreBoardFriend(window.cnt = window.cnt + 3);">게시글
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


	<!-- 글 상세보기 모달 -->
	<div class="modal fade" id="detailView" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<div class="col-md-12 padding">
					<!-- 글 머리 : 사진, 닉네임 -->
					<div class="header padding" style="float: left; width: 45%;">
						<span class="imgSpan"><img class="imgTag" id="profImg"></span>
						&nbsp;&nbsp;&nbsp;<span id="memberNick" style="font-weight:700;font-size:small;"> </span>
					</div>

					<!-- 글 조회수 -->
					<div class="cnt padding"
						style="line-height: 44px; float: right; width: 45%;" align="right">
						<span id="boardCnt"></span>
					</div>

					<div class="clear"></div>

					<!-- 글 내용 -->
					<div class="content col-md-12 padding">
						<img style="max-width: 100%" id="boardFileImg"
							src="${pageContext.request.contextPath}/${boardSrc}">
							<span id="boardContent"></span>
					</div>
					<hr>

					<!-- 글 작성 시간 -->
					<div class="footer">
						<div class="time-tag" style="float: left;">
							<i class="fa fa-clock-o">&nbsp;&nbsp;<span id="boardTime"></span></i>
							
						</div>
					</div>

					<div class="clear"></div>

					<!-- 글 신고하기 버튼 -->
					<div id="viewSingo" class="singoBtn" align="left">
						<img src="${pageContext.request.contextPath}/resources/img/siren.svg" onclick="boardSingo()"
						style="width:30px;height:30px;cursor:pointer;margin:0 5px;" title="신고하기">
					</div>
					<!-- /글 신고하기 버튼-->

					<!-- 좋아요 버튼 -->
					<div class="likeBtn" align="right">
						<!-- 좋아요 카운트 -->
						<div id=boardLike class="likeCnt" align="right" style="margin-top:3px;"></div>
						<!-- /좋아요 카운트 -->
						<div id="like">
							<!-- <span id=boardLike></span> -->
						</div>
						<input type="hidden" name="boardNum" id="boardNum" value="">
						<input type="hidden" name="memberId" id="memberId"
							value="${sessionScope.id}">
					</div>
					<!-- /좋아요 버튼 -->
					<div class="clear"></div>
					<div class="clear"></div>
					<hr>
					<div class="clear"></div>
					<div class="clear"></div>
					<!-- 댓글 작성 틀 -->
					<div style="float: left; width: 75%;" align="left">
						<textarea id="replyContent" rows="1"
							style="width: 109%; resize: none; wrap: hard; padding:3px;border-radius:4px;"
							placeholder="댓글을 입력하세요" name="replyContent"></textarea>
					</div>
					<div style="float: right;" align="right">
						<button style="padding:4px 10px;background-color:#F7921E;color:white;border-radius:4px;border:none;"
						onclick="addReply()">작성완료</button>
						<input type="hidden" name="boardNum" id="boardNum" value="">
						<input type="hidden" name="memberId" id="memberId"
							value="${sessionScope.id}">
					</div>
					<!-- /댓글 작성 틀 -->

				</div>
				<!--/글 작성 틀-->

				<!-- 댓글 내용 -->
				<div id="replyHTML" style="margin-bottom: -2%;"></div>
				<!-- /댓글 내용 -->
				<button class="btn btn-default btnOrange btn-margin"
					style="margin-bottom: 2%;border:none;"
					onclick="moreReplyView(window.cnt1 = window.cnt1 + 3);">댓글
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
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/board-detail.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
	<script type="text/javascript">
		function addFriend(friend,member){
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					alert(resData);
				}
			}

			xhttp.open("GET", "requestFriend.do?memberId=" + member+"&friendId="+friend, true);
			xhttp.send();
		}
	</script>
</body>
</html>