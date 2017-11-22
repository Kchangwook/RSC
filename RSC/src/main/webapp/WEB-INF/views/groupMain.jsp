<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>RSC</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.default.css" id="theme-stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
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
			<!-- 그룹 메인 페이지  -->
			<div class="group-main">
			
				<!-- 그룹 정보 -->
				<div class="group-info">
					<div class="row">
						<div class="col-md-12">
							<div class="card w3-round-large">
								<table class="group-info-table">
									<tr>
										<td class="group-info-img" rowspan="4">
											<span class="group-info-img-span imgSpan">
												<img class="imgTag" src = "${pageContext.request.contextPath}/${requestScope.groupInfo.groupImg}">
											</span>
										</td>
										<td class="group-info-name">
											<a href="${pageContext.request.contextPath}/basic/group.do?groupNum=${requestScope.groupInfo.groupNum}">
												<b>${requestScope.groupInfo.groupName}</b>
											</a>
										</td>
									</tr>
									<tr>
										<td class="group-info-info">
											${requestScope.groupInfo.groupInfo}
										</td>
									</tr>
									<tr>
										<td class="group-info-interest">
											${requestScope.groupInfo.groupInterest}
										</td>
									</tr>
									<c:choose>
										<c:when test="${requestScope.groupLevel eq 'admin'}">
											<tr>
												<td class="group-info-btn">
													<a href="${pageContext.request.contextPath}/group/groupMember.do?groupNum=${requestScope.groupInfo.groupNum}">
														<button class="groupAdminBtn">회원 보기</button>
													</a>
													<a href="${pageContext.request.contextPath}/group/groupJoin.do?groupNum=${requestScope.groupInfo.groupNum}">
														<button class="groupAdminBtn">가입 승인</button>
													</a>
													<button class="groupAdminBtn" onclick="groupDelete('${requestScope.groupInfo.groupNum}','${requestScope.groupInfo.groupName}')">
														그룹 삭제
													</button>
												</td>
											</tr>
										</c:when>
										<c:when test="${requestScope.groupLevel eq 'visitor'}">
											<tr>
												<td class="group-info-btn">
													<button onclick="joinGroup('${requestScope.groupInfo.groupNum}','${requestScope.groupInfo.groupName}','${sessionScope.id}')">가입 요청</button>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									
									</c:choose>

								</table>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 그룹 글 작성 부분 -->
				<c:if test="${requestScope.groupLevel ne 'visitor' }">
					<div class="group-board">
						<div class="row">
							<div class="col-md-12">
								<div class="card w3-round-large">
									<form action="${pageContext.request.contextPath}/group/groupBoard.do" method="post" style="width: 100%">
										<div class="content">
											<textarea rows="5" name="boardContent"></textarea>
										</div>
										<div class="footer">
											<input type="hidden" name="memberId" value="${sessionScope.id}">
											<input type="hidden" name="groupNum" value="${requestScope.groupInfo.groupNum}">
											<input type="submit" value=글쓰기>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				
				<!-- 그룹 글 리스트 출력 부분 -->
				<div class="group-boardList">
					<c:forEach items="${requestScope.groupBoardList}" var="data">
						<div class="row">
							<!-- 글 작성 틀 -->
							<div class="col-md-12">
								<div class="card w3-round-large">
									<!-- 글 머리 : 사진, 닉네임 -->
									<div class="header">
										<span class="group-boardList-img-span imgSpan ">
											<img class="imgTag" src="${pageContext.request.contextPath}/${data.memberImg}">
										</span>
										<span>&nbsp;&nbsp;${data.memberNick}</span>
									</div>
	
									<!-- 글 내용 -->
									<div class="content">
										<span>
											<c:choose>
												<c:when test="${data.boardSingoFlag eq 0}">
													<a href="#" style="display:block;" data-toggle="modal" data-target="#groupBoardDetail" onclick="searchBoard('${data.boardNum}')">
														${data.boardContent}
													</a>
												</c:when>
												<c:otherwise>
													신고된 게시글 입니다.
												</c:otherwise>
											</c:choose> 

										</span>
									</div>
									<hr>
	
									<!-- 글 작성 시간 -->
									<div class="footer">
										<div class="time-tag">
											<i class="fa fa-clock-o"></i> <fmt:formatDate value="${data.boardTime}" pattern="yyyy년 M월 d일 H시 m분" />
										</div>
									</div>
									
								</div>
							</div>
							<br>
							<!--/글 작성 틀-->
						</div>
	
					</c:forEach>
				</div>
			</div>
		<!-- 본문 끝 부분 -->
		</div>
		
		<!-- footer 마지막 검은 박스 -->
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
	<div class="modal fade" id="groupBoardDetail" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<div class="col-md-12 padding">
					<!-- 글 머리 : 사진, 닉네임 -->
					<div class="header padding" style="float: left; width: 45%;">
						<span>
							<img id="profImg" src="${pageContext.request.contextPath}/resources/img/profile.jpg">
						</span>
						&nbsp;&nbsp;&nbsp;
						<span id="memberNick"></span>
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
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/groupAdmin.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/board-detail.js"></script>
</body>
</html>



