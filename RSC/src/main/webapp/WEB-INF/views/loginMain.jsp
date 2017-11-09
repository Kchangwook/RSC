<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>LoginMain</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<div>
<form name="write" action="../board/add.do" method="post">
	<textarea rows="5" cols="120" name="boardContent">
	
	</textarea>
	<input type="text" name="memberId">
	<input type=submit value=글쓰기> 
</form>

</div>
</body>
</html>