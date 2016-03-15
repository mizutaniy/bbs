<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/style.css" rel="stylesheet" type="text/css">
<title>掲示板システム</title>
</head>
<body>
<div class="main-contents">

<div class="header" style="display:inline-flex">
	<a href="createuser" class="botton">ユーザー新規登録</a>
	<span style="margin-right: 10px;"></span>
	<a href="home" class="botton">ホーム</a>
</div><br />
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
<div class="userlists">
		<table border="1" style="table-layout: auto;" class="table">
			<tr>
				<th>ログインID</th>
				<th>名前</th>
				<th>支店</th>
				<th>部署・役職</th>
				<th>編集</th>
				<th>ステータス</th>
			</tr>
			<c:forEach items="${ userlists }" var="userlist">
			<tr>
				<td>${ userlist.loginId }</td>
				<td>${ userlist.name }</td>
				<td>${ userlist.branchName }</td>
				<td>${ userlist.departmentName }</td>
				<td>
					<form action="edituser" method="get"><br />
						<input type="hidden" name="userId" value="${ userlist.id }" />
						<input id="submitButton" type="submit" value="編集"><br />
					</form>
				</td>
				<td>
				<c:if test="${ userlist.status  == 0 }">
					<form action="usermanager" method="post"><br />
						<input type="hidden" name="userId" value="${ userlist.id }" />
						<input type="hidden" name="status" value="1" />
						<input id="submitButton" type="submit" onClick="return confirm('ユーザーを停止しますか');" value="停止"><br />
					</form>
				</c:if>
				<c:if test="${ userlist.status == 1 }">
					<c:out value="停止中" />
					<form action="usermanager" method="post"><br />
						<input type="hidden" name="userId" value="${ userlist.id }" />
						<input type="hidden" name="status" value="0" />
						<input id="submitButton" type="submit" onClick="return confirm('ユーザーを復活しますか');" value="復活"><br />
					</form>
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
</div>

</div>
</body>
</html>