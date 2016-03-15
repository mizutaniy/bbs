<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ログイン</title>
	<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="input-contents">
	<c:if test="${ not empty errorMessages }">
		<div class="errorMessages">
			<ul>
			<c:forEach items="${ errorMessages }" var="message">
				<li><c:out value="${ message }" />
			</c:forEach>
		</ul>
		<c:remove var="errorMessages" scope="session" />
		</div>
	</c:if>
	<div class="login">
		<form action="./" method="post"><br />
		<label for="loginId">ログインID</label>
		<input name="loginId" value="${ loginId }" id="login" /><br />

		<label for="password">パスワード</label>
		<input name="password" type="password" id="login" /><br />

		<input id="submitButton" type="submit" value="ログイン" /><br />
		</form>
	</div>

</div>
</body>
</html>
