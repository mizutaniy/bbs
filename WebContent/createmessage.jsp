<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<title>新規投稿</title>
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
<div class="input">
<div class="input-top">
<c:out value="新規投稿" />
</div>
<div class="input-main">
<form action="createmessage" method="post"><br />
	<label for="title">件名</label>
	<input name="title" value="${ inputData.title }" id="title" size="40" /><br />

	<label for="text">本文</label>
	<textarea name="text" cols="50" rows="10" id="text" wrap="hard">${ inputData.text }</textarea><br />

	<label for="category">カテゴリー</label>
	<div style="display:inline-flex">
		<input name="category" value="${ inputData.category }" id="category" /><br />
		<span style="margin-right: 50px;"></span>
		<input id="submit_button" type="submit" value="登録" /><br />
	</div>
</form>
<div class="back"><a href="home" class="back">戻る</a></div>
</div>
</div>

</div>
</body>
</html>