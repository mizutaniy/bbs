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
<div class="header" style="display:inline-flex">
	<a href="usermanager" class="botton">ユーザー管理</a>
	<span style="margin-right: 10px;"></span>
	<a href="home" class="botton">ホーム</a>
	<span style="margin-right: 10px;"></span>
	<a href="logout" class="botton">ログアウト</a>
</div>
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
<form action="edituser" name="createuser" method="post">
<div class="input-main">
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
				<c:forEach items="${ branchList }" var="branchList">
					<c:choose>
					<c:when test="${ editUser.branchId == branchList.id }">
					 	<option value="${ branchList.id }" selected>${ branchList.name }</option>
					 </c:when>
					 <c:otherwise>
					 	<option value="${ branchList.id }" >${ branchList.name }</option>
					 </c:otherwise>
					</c:choose>
				</c:forEach>
		</select>
	<label for="departmentId">部署・役職</label>
		<select name="departmentId">
				<c:forEach items="${ departmentList }" var="departmentList">
					<c:choose>
					<c:when test="${ editUser.departmentId == departmentList.id }">
					 	<option value="${ departmentList.id }" selected>${ departmentList.name }</option>
					 </c:when>
					 <c:otherwise>
					 	<option value="${ departmentList.id }" >${ departmentList.name }</option>
					 </c:otherwise>
					</c:choose>
				</c:forEach>
		</select>
</div>
<input id="registButton" type="submit" value="登録" />
</form>
<div class="delete_user">
<form action="deleteuser" name="deleteuser" method="post"><br />
	<input type="hidden" name="id" value="${ editUser.id }">
	<input id="deleteButton" type="submit"  onClick="return confirm('ユーザーを削除しますか');" value="ユーザー削除"><br />
</form>
</div>

</div>
</div>
</body>
</html>