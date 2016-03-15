<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
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
<div class="input">
<div class="input-top">
<c:out value="ログインID： ${ editUser.loginId }" /><br />
<c:out value="名前： ${ editUser.name }" /><br />
</div>
<div class="input-main">
<form action="edituser" name="createuser" method="post"><br />
	<input type="hidden" name="id" value="${ editUser.id }" />
	<input type="hidden" name="presentLoginId" value="${ editUser.loginId }" />
	<input type="hidden" name="presentName" value="${ editUser.name }" />
	<label for="loginId">ログインID</label>
	<input name="loginId" id="loginId" value="${ editUser.loginId }"  /><br />

	<label for="password">パスワード</label>
	<input type="password" name="password"  id="password" /><br />
	<label for="passwordConfirm">パスワード(確認)</label>
	<input type="password" name="passwordConfirm" id="passwordConfirm" /><br />
	<input type="hidden" name="presentPassword" value="${ editUser.password }" />

	<label for="name">名称</label>
	<input name="name" id="name" value="${ editUser.name }" /><br />

	<label for="branchId" >支店</label>
		<select name="branchId">
			<option value="0">選択してください</option>
			<option value="1">本社</option>
			<option value="2">支店A</option>
			<option value="3">支店B</option>
			<option value="4">支店C</option>
		</select>
	<label for="departmentId">部署・役職</label>
		<select name="departmentId">
			<option value="0">選択してください</option>
			<option value="1">人事総務部</option>
			<option value="2">情報セキュリティ部</option>
			<option value="3">店長</option>
			<option value="4">社員</option>
		</select>
		<span style="margin-right: 30px;"></span>
	<input id="registButton" type="submit" value="登録" /><br />
</form><br />

<form action="deleteuser" name="deleteuser" method="post"><br />
	<input type="hidden" name="id" value="${ editUser.id }">
	<input id="deleteButton" type="submit"  onClick="return confirm('ユーザーを削除しますか');" value="ユーザー削除"><br />
</form>
</div>
<div class="back"><a href="usermanager" class="back">戻る</a></div>

</div>
</div>
</body>
</html>