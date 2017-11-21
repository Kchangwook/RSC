<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="${pageContext.request.contextPath}/group/groupMember.do?groupNum=1">1.그룹원 보기</a><br>
		(1) 관리자 권한 부여<br>
		(2) 그룹원 강퇴<br>
		(3) 그룹원 페이지 상세보기<br><br>
<a href="">2.그룹 삭제</a><br>
		(1) modal로 알림(관리자들에게만)<br>
		(2) 투표를 DB에 기록<br>
		(3) 모두 투표시 과반수 이상이면 그룹 삭제<br><br>
<a href="${pageContext.request.contextPath}/group/groupJoin.do?groupNum=1">3.가입 승인</a><br>
		(1) 가입 신청자 목록 보여주기<br>
		(2) 거절 or 수락<br><br>
4.그룹 게시물 수정 또는 삭제



</body>
</html>