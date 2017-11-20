<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
	<input type = "hidden" id = "contextPath" value = "${pageContext.request.contextPath}">

   <!-- 사이드바 부분 -->
   <nav class="side-navbar">
      <div class="side-navbar-wrapper">
         <div
            class="sidenav-header d-flex align-items-center justify-content-center">
            <div class="sidenav-header-inner text-center">
               <a href="${pageContext.request.contextPath}/index.html">
               <img src="${pageContext.request.contextPath}/resources/img/logo.png">&nbsp;&nbsp;&nbsp;
               <h2 class="h5 text-uppercase">Relation Social Community</h2></a>
            </div>
            <div class="sidenav-header-logo">
               <a href="${pageContext.request.contextPath}/index.html" class="brand-small text-center">
                  <img src="${pageContext.request.contextPath}/resources/img/logo.png"><br>
                  RSC
               </a>
            </div>
         </div>
         
         <div class="main-menu">
            <ul id="side-main-menu" class="side-menu list-unstyled">
               <c:choose>
                  <c:when test="${sessionScope.level eq 'member'}"> <!-- 회원 로그인 시 -->
                     <li>
                        <a href="${pageContext.request.contextPath}/board/readBoard.do"><i class="fa fa-address-card-o"></i><span>마이페이지</span></a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/friend/getList.do"><i class="fa fa-user"></i><span>친구</span></a>
                     </li>
                     <li>
                        <a href="#"><i class="fa fa-users"></i><span>그룹</span></a>
                     </li>
                     <li>
                        <a href="#"><i class="fa fa-comments"></i><span>채팅</span></a>
                     </li>
                     <li>
                        <a href="#"><i class="fa fa-telegram"></i><span>랜덤채팅</span></a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/basic/mypage.do?mypageMemberId=${ sessionScope.id }"><i class="fa fa-edit"></i><span>정보수정</span></a>
                     </li>
                  </c:when>
                  <c:when test="${sessionScope.level eq 'admin'}"> <!-- 관리자 로그인 시 -->
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/member.do">
                           <i class="fa fa-user"></i><span>회원 관리</span>
                        </a>
                     </li>
                     <li>
                          <a href="${pageContext.request.contextPath}/admin/group.do">
                             <i class="fa fa-users"></i><span>그룹 관리</span>
                          </a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/board.do">
                             <i class="fa fa-file-text-o"></i><span>게시글 관리</span>
                        </a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/singo.do">
                           <i class="fa fa-ban"></i><span>신고</span>
                        </a>
                     </li>
                     <li>
                        <a href="#alert" onclick="document.getElementById('noticeModal').style.display='block'"><i class="fa fa-bullhorn"></i><span>공지</span></a>
                     </li>
                  </c:when>
                  
                  <c:when test="${sessionScope.level eq 'master'}"> <!-- 최상위관리자 로그인 시 -->
                                          <li>
                        <a href="${pageContext.request.contextPath}/admin/member.do">
                           <i class="fa fa-user"></i><span>회원 관리</span>
                        </a>
                     </li>
                     <li>
                          <a href="${pageContext.request.contextPath}/admin/group.do">
                             <i class="fa fa-users"></i><span>그룹 관리</span>
                          </a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/board.do">
                             <i class="fa fa-file-text-o"></i><span>게시글 관리</span>
                        </a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/singo.do">
                           <i class="fa fa-ban"></i><span>신고</span>
                        </a>
                     </li>
                     <li>
                        <a href="#alert" onclick="document.getElementById('noticeModal').style.display='block'"><i class="fa fa-bullhorn"></i><span>공지</span></a>
                     </li>
                     <li>
                        <a href="${pageContext.request.contextPath}/admin/add.do"><i class="fa fa-plus-square"></i><span>관리자 아이디 생성</span></a>
                     </li>
                  </c:when>
                  <c:otherwise> <!-- 비로그인 시 -->
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-address-card-o"></i><span>마이페이지</span></a>
                     </li>
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-user"></i><span>친구</span></a>
                     </li>
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-users"></i><span>그룹</span></a>
                     </li>
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-comments"></i><span>채팅</span></a>
                     </li>
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-telegram"></i><span>랜덤채팅</span></a>
                     </li>
                     <li>
                        <a href="" onclick="blockAccess()"><i class="fa fa-edit"></i><span>정보수정</span></a>
                     </li>
                  </c:otherwise>
               </c:choose>
            </ul>
         </div>
      </div>
   </nav>
   
	<!-- 공지 모달 -->
	<div id="noticeModal" class="w3-modal">
		<div class="w3-modal-content w3-animate-left w3-card-4">
			<header class="w3-container">
				<h3>공지사항 및 알림</h3>
			</header>
			<div class="notice-content">
				<table>
					<tr>
						<td class="radioArea">
							<input type="radio" id="radioAllMember" name="checkTarget" value="allMember" onclick="viewSearchMemberInput(this.value)">전체<br><br>
							<input type="radio" id="radioSelectMember" name="checkTarget" value="selectMember" onclick="viewSearchMemberInput(this.value)">선택
						</td>
						<td class="searchMemberArea">
							<span id="searchMemberInput" style="display:none;">
								<input id="searchMemberInputText" type="text" placeholder="회원 ID 또는 닉네임 검색" oninput="searchNoticeMember(this.value)">
							</span>
							<div class="dropdown">
								<div class="dropdown-content" id="searchMemberDropdown">
								</div>
							</div>
							<div id="addedMember"></div>
						</td>
					</tr>
					<tr>
						<td class="noticeContentArea" colspan="2">
							<textarea rows="6" id="noticeContent" name="noticeContent" placeholder="전송할 메시지를 작성하세요."></textarea>
						</td>
					</tr>
					<tr>
						<td class="noticeBtnArea" colspan="2">
							<button id="sendAlertBtn" onclick="sendNotice()">전송</button>&nbsp;&nbsp;
							<button id="cancelAlertBtn" onclick="closeNoticeModal()">닫기</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	
	<script>
	
		function blockAccess(){
			alert("로그인 후 이용해주시기 바랍니다.");
			location.reload();
		}
		
	</script>
	<script type="text/javascript" src = "${pageContext.request.contextPath}/resources/js/navNotice.js"></script>
</body>
</html>