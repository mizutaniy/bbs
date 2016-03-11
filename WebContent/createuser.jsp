<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="ConnectedSelect.js"></script>

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
<form action="createuser" name="createuser" method="post"><br />
	<label for="login_id">ログインID</label>
	<input name="login_id" id="login_id"  /><br />

	<label for="password">パスワード</label>
	<input type="password" name="password" id="password" /><br />
	<label for="passwordConfirm">パスワード(確認)</label>
	<input type="password" name="passwordConfirm" id="passwordConfirm" /><br />

	<label for="name">名称</label>
	<input name="name" id="name" /><br />

	<label for="branch_id" >支店</label>
	<select id="branch_id" name="branch_id">
	<option value="0">選択してください</option>
		<c:forEach items="${ branchList }" var="branchList">
			<option value="${ branchList.id }">${ branchList.name }</option>
		</c:forEach>
	</select>

	<label for="department_id">部署・役職</label>
	<select id="department_id" name="department_id" disabled="disabled">
			<option value="0">選択してください</option>
				<c:forEach items="${ departmentList }" var="departmentList">
					<option value="${ departmentList.id }" class="p1">${ departmentList.name }</option>
				</c:forEach>
		</select>
	<input type="submit" onClick="check()" value="登録" /><br />
</form>
	<a href="usermanager">戻る</a>
</div>

</body>
</html>