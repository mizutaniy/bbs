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
<div class="main-contents">

<c:if test="${ not empty errorMessages }">
	<div class="errorMessages">
		<ul>
			<c:forEach items="${ errorMessages }" var="message">
				<li><c:out value="${ message }" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="errorMessages" scope="session" />
</c:if>
<div class="login">
<form action="./" method="post"><br />
<div style="display:inline-flex">
	<label for="login_id">ログインID</label>
	<input name="login_id" id="login" /><br />
</div>
<div style="display:inline-flex">
	<label for="password">パスワード</label>
	<input name="password" type="password" id="login" /><br />
</div>
<input id="submit_button" type="submit" value="ログイン" /><br />
</form>
</div>

</div>
</body>
</html>
