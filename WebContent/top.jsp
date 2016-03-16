<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="./css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/south-street/jquery-ui.css" rel="stylesheet" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/i18n/jquery.ui.datepicker-ja.min.js"></script>
	<title>掲示板システム</title>
</head>
<body>
<div class="main-contents">
	<div class="header" style="display:inline-flex">
		<a href="createmessage" class="botton">新規投稿</a>
		<span style="margin-right: 10px;"></span>
		<a href="usermanager" class="botton">ユーザー管理</a>
		<span style="margin-right: 10px;"></span>
		<a href="logout" class="botton">ログアウト</a>
	</div><br />
	<div class="loginUser">
		<c:out value="ログイン中 ：${ user.name }" />
	</div>
	<div class="narrow">
		<div style="display:inline-flex">
		<form action="home" method="get"><br />
			<select name="category">
				<option value="">カテゴリー</option>
				<option value="">すべて表示</option>
				<c:forEach items="${ categories }" var="category">
					<option value="${ category.category }">${ category.category }</option>
				</c:forEach>
			</select>
			<span style="margin-right: 10px;"></span>
			<div style="display:inline-flex">
				<div style="display:inline-flex">
					<label >From:</label><input type="text" name="insertFrom" id="insertFrom" placeholder="クリックしてください" />
				 </div>
				 <span style="margin-right: 10px;"></span>
				 <div style="display:inline-flex">
        			<label >To:</label><input type="text" name="insertTo" id="insertTo" placeholder="クリックしてください" />
				 </div>
				<span style="margin-right: 10px;"></span>
				<input id="submitButton" type="submit" value="検索"><br />
			</div>
		</form>
	</div>
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

<div class="messages">
	<c:forEach items="${ messages }" var="message">
		<div class="view">
			<div class="message">
				<div class="messagetop">
					<div class="title"><span class="title"><c:out value="${ message.title }" /></span></div>
				</div>
				<div class="category"><span class="category"><c:out value="カテゴリー：${ message.category }" /></span></div>
				<div class="text"><span class="span">
					<c:forEach var="str" items="${fn:split(message.text,'
')}" ><c:out value="${str}" /><br></c:forEach>
				</span></div>
				<div class="messagebottom" style="display:inline-flex">
				<div class="name"><span class="span">
					<c:out value="${ message.branchName } （ ${ message.departmentName } ） / ${ message.name }" /></span></div>
				<span style="margin-right: 30px;"></span>
				<div class="date"><fmt:formatDate value="${ message.insertDate }" pattern="yyyy/MM/dd HH:mm:ss" /></div>
			</div>
		<div class="delete">
			<c:if test="${ branchId == 1 && departmentId == 2 || branchId == message.branchId && departmentId == 3 }">
				<form action="deletemessage" method="post"><br />
					<input type="hidden" name="id" value="${ message.messageId }" />
					<input id="submitButton" type="submit" value="削除"><br />
				</form>
			</c:if>
		</div>
		</div>
		<div class="comments">
			<c:forEach items="${ comments }" var="comment">
				<c:if test="${ message.messageId == comment.messageId }">
					<div class="comment">
						<div class="text"><span class="span">
						<c:forEach var="splitcomment" items="${fn:split(comment.text,'
')}" ><c:out value="${splitcomment}" /><br></c:forEach>
						</span></div>
						<div style="display:inline-flex">
							<div class="name"><span class="name">
							<c:out value=" ${ comment.branchName } （ ${ comment.departmentName } ） / ${ comment.name }" /></span></div>
							<span style="margin-right: 30px;"></span>
							<div class="date"><fmt:formatDate value="${ comment.insertDate }" pattern="yyyy/MM/dd HH:mm:ss" /></div>
						</div>
					<div class="delete">
						<c:if test="${ branchId == 1 && departmentId == 2 || branchId == comment.branchId && departmentId == 3 }">
							<form action="deletecomment" method="post"><br />
								<input type="hidden" name="id" value="${ comment.id }" />
								<input id="submitButton" type="submit" value="削除"><br />
							</form>
						</c:if>
					</div><br />
					</div>
				</c:if>
			</c:forEach>
		</div><br />
			<div class="createcomment">
				<form action="home" method="post"><br />
					<label for="text">コメント</label><br />
					<div style="display:inline-flex">
						<textarea name="text" cols="50" rows="3" id="text" wrap="hard"></textarea>
						<span style="margin-right: 10px;"></span>
						<input id="submitButton" type="submit" value="投稿" />
					</div>
					<input type="hidden" name="messageId" value="${ message.messageId }">
				</form>
			</div><br />
	</div>
	</c:forEach>
</div>

</div>


<!-- スクリプト部分 -->
<script>
    $( function() {
        var dates = jQuery( '#insertFrom, #insertTo' ) . datepicker( {
            showAnim: 'drop',
            changeMonth: true,
            numberOfMonths: 1,
            showCurrentAtPos: 0,
            dateFormat:"yy/mm/dd",
            minDate: new Date(2016, 3 - 1, 1),
            maxDate: '+0d',
            onSelect: function( selectedDate ) {
                var option = this . id == 'insertFrom' ? 'minDate' : 'maxDate',
                    instance = $( this ) . data( 'datepicker' ),
                    date = $ . datepicker . parseDate(
                        instance . settings . dateFormat ||
                        $ . datepicker . _defaults . dateFormat,
                        selectedDate, instance . settings );
                dates . not( this ) . datepicker( 'option', option, date );
            }
        } );
    } );
</script>
</body>
</html>