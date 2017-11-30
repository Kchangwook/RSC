<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/logo.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontastic.css">
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
											<label>그룹 정보</label><br>
											${requestScope.groupInfo.groupInfo}
										</td>
									</tr>
									<tr>
										<td class="group-info-interest">
											<label>관심사</label><br>
											${requestScope.groupInfo.groupInterest}
										</td>
									</tr>
									<c:choose>
										<c:when test="${requestScope.groupLevel eq 'admin' or sessionScope.level eq 'master' or sessionScope.level eq 'admin'}">
											<tr>
												<td class="group-info-btn">
													<a href="${pageContext.request.contextPath}/group/groupUpdate.do?groupNum=${requestScope.groupInfo.groupNum}&groupLevel=${requestScope.groupLevel}">
														<button class="groupAdminBtn">정보 수정</button>
													</a>
													<a href="${pageContext.request.contextPath}/group/groupMember.do?groupNum=${requestScope.groupInfo.groupNum}&groupLevel=${requestScope.groupLevel}">
														<button class="groupAdminBtn">회원 보기</button>
													</a>
													<a href="${pageContext.request.contextPath}/group/groupJoin.do?groupNum=${requestScope.groupInfo.groupNum}&groupLevel=${requestScope.groupLevel}">
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
													<button class="groupAdminBtn" onclick="joinGroup('${requestScope.groupInfo.groupNum}','${requestScope.groupInfo.groupName}','${sessionScope.id}')">
														가입 요청
													</button>
													<button class="groupAdminBtn" onclick="singoGroup('${requestScope.groupInfo.groupNum}')">
														그룹 신고
													</button>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<td class="group-info-btn">
													<button class="groupAdminBtn" onclick="singoGroup('${requestScope.groupInfo.groupNum}')">
														그룹 신고
													</button>
												</td>
											</tr>
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
									<form action="${pageContext.request.contextPath}/group/groupBoard.do" method="post" style="width: 100%" enctype="multipart/form-data">
										<div class="content">
											<textarea rows="5" name="boardContent" style="resize: none;"></textarea>
										</div>
										<div class="footer">
					
											<input type="hidden" name="memberId" value="${sessionScope.id}">
											<input type="hidden" name="groupNum" value="${requestScope.groupInfo.groupNum}">
					
											<input type="text" width="50%" name="boardSrc" id="boardSrc" placeholder="" disabled="disabled">
											<label for="boardFile">파일&nbsp;&nbsp;</label>
											<input type="file" name="boardFile" id="boardFile" accept="image/*" onchange="changeBoardSrc()" style="display: none;">
					
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
				<input type="hidden" id="groupLevel" value="${requestScope.groupLevel}">
				<input type="hidden" id="sessionLevel" value="${sessionScope.level}">
				<div id="moreView">
					<c:forEach items="${requestScope.groupBoardList}" var="data">
						<div class="row boardView">
							<!-- 글 작성 틀 -->
							<div class="col-md-12">
								<div class="card w3-round-large">
									<!-- 글 머리 : 사진, 닉네임 -->
									<div class="header">
										<span class="group-boardList-img-span imgSpan" onclick="memberPage('${data.memberId}')" style="cursor:pointer;">
											<img class="imgTag" src="${pageContext.request.contextPath}/${data.memberImg}">
										</span>
										<span onclick="memberPage('${data.memberId}')" style="cursor:pointer;">&nbsp;&nbsp;${data.memberNick}</span>
										<c:if test="${requestScope.groupLevel eq 'admin' or sessionScope.level eq 'master' or sessionScope.level eq 'admin'}">
												<span class = "board-modify"data-toggle="modal" data-target="#modifyView" onclick="modifyBoard(${data.boardNum})">
													수정
												</span>
												<span>&nbsp;/&nbsp;</span>
												<span class = "board-delete" onclick = "deleteBoard(${data.boardNum})">
													삭제
												</span>
										</c:if>
									</div>
	
									<!-- 글 내용 -->
									<div class="content">
										<span>
											<c:choose>
												<c:when test="${data.boardSingoFlag eq 0}">
													<a href="#" style="display:block;" data-toggle="modal" data-target="#groupBoardDetail" onclick="searchBoard('${data.boardNum}')">
														<c:if test="${data.boardFile ne ' '}">
															<img style="max-width: 100%; height:300px;" src="${pageContext.request.contextPath}/${data.boardFile}">
															<br><br>
														</c:if>
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
				<c:if test="${not empty requestScope.groupBoardList}">
					<input type="hidden" id="groupNum" value="${requestScope.groupInfo.groupNum}">
					<button class="btn btn-default btnOrange"
						onclick="moreGroupBoard(window.cnt = window.cnt + 3);">게시글 더보기</button>
				</c:if>
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
						<!-- <p>마지막 문장</p> -->
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
							src="${pageContext.request.contextPath}/${boardSrc}"> <span
							id="br"></span><span id="boardContent"> </span>
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
	
	<!-- 글 수정하기 모달 -->
	<div class="modal fade" id="modifyView" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 글 작성 틀 -->
				<form action="${pageContext.request.contextPath}/board/modifyGroupBoard.do" name = "modFrm" id = "modFrm" method = "post">
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
						<div id="modify" style="float:right;">
							<button class = "btn btn-default btnOrange modifybtn" onclick = "modifyContent()">수정하기</button>
							<button class = "btn btn-default btnOrange cancelbtn" data-dismiss="modal">취소</button>
						</div>
					</div>

					<div class="clear"></div>

				</div>
				<!--/글 작성 틀-->
				<input type="hidden" id="groupNum" name="groupNum" value="${requestScope.groupInfo.groupNum}">
				<input type="hidden" id="groupName" name="groupName" value="${requestScope.groupInfo.groupName}">
			</form>
			</div>
			
		</div>
	</div>
	<!-- /글 수정하기보기 모달 -->
	
	<!-- Javascript files-->
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
	<script src="${pageContext.request.contextPath}/resources/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-validation/jquery.validate.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/front.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/groupAdmin.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/roundedImage.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/group-board-detail.js"></script>
	
	<script>
	function memberPage(friendId){
		var sessionId = document.getElementById("sessionId").value;
		if(sessionId==friendId){
			location.href="${pageContext.request.contextPath}/board/myBoards.do?cnt=1";
		} else {
			location.href="${pageContext.request.contextPath}/friend/getFriendInfo.do?cnt=1&friendId="+friendId;
		}
	}
	</script>
</body>
</html>



