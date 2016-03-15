<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/style.css" rel="stylesheet" type="text/css">

  <title>ユーザー新規登録</title>
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
<c:out value="ユーザー新規登録" />
</div>
<div class="input-main">
<form action="createuser" name="createuser" method="post"><br />
	<label for="loginId">ログインID</label>
	<input name="loginId" id="loginId" value="${ inputData.loginId }" /><br />

	<label for="password">パスワード</label>
	<input type="password" name="password" id="password" /><br />
	<label for="passwordConfirm">パスワード(確認)</label>
	<input type="password" name="passwordConfirm" id="passwordConfirm" /><br />

	<label for="name">名称</label>
	<input name="name" id="name" value="${ inputData.name }" /><br />

	<label for="branchId" >支店</label>
		<select name="branchId">
			<option value="0">選択してください</option>
				<c:forEach items="${ branchList }" var="branchList">
					<option value="${ branchList.id }" >${ branchList.name }</option>
				</c:forEach>
		</select>
	<label for="departmentId">部署・役職</label>
		<select name="departmentId">
			<option value="0">選択してください</option>
				<c:forEach items="${ departmentList }" var="departmentList">
					<option value="${ departmentList.id }">${ departmentList.name }</option>
				</c:forEach>
		</select>
		<span style="margin-right: 80px;"></span>
	<input id="registButton" type="submit" value="登録" /><br />
</form>
</div>
<div class="back"><a href="usermanager" class="back">戻る</a></div>

</div>
</div>

</body>
</html>