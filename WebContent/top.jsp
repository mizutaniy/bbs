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
	<link type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/south-street/jquery-ui.css" rel="stylesheet" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/i18n/jquery.ui.datepicker-ja.min.js"></script>
	<title>掲示板システム</title>
</head>
<body>
<div class="main-contents">

<div class="header">
	<a href="createmessage">新規投稿</a>
	<a href="usermanager">ユーザー管理</a>
	<a href="logout">ログアウト</a>
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
		<div style="display:inline-flex">
        	<label >From:</label><input type="text" name="insert_from" id="insert_from" placeholder="クリックしてください" />
        </div>
        <div style="display:inline-flex">
        	<label >To:</label><input type="text" name="insert_to" id="insert_to" placeholder="クリックしてください" />
        </div>
		<input type="submit" value="抽出"><br />
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
			<div style="display:inline-flex" class="messagetop">
				<div class="title"><span class="title"><c:out value="タイトル：${ message.title }" /></span></div>
				<div class="category"><span class="category"><c:out value="カテゴリ：${ message.category }" /></span></div>
			</div>
			<div class="text"><span class="text"><c:out value="${ message.text }" /></span></div>
			<div style="display:inline-flex">
				<div class="name"><span class="name"><c:out value="投稿者：${ message.name }" /></span></div>
				<div class="date"><fmt:formatDate value="${ message.insertDate }" pattern="yyyy/MM/dd HH:mm:ss" /></div>
			</div>
		<div class="delete">
			<c:if test="${ branch_id == 1 && department_id == 2 || branch_id == message.branch_id && department_id == 3 }">
				<form action="deletemessage" method="post"><br />
					<input type="hidden" name="id" value="${ message.message_id }" />
					<input type="submit" value="削除"><br />
				</form>
			</c:if>
		</div>
		</div>
		<div class="comments">
			<c:forEach items="${ comments }" var="comment">
				<c:if test="${ message.message_id == comment.message_id }">
					<div class="comment">
						<div class="text"><span class="text"><c:out value="${ comment.text }" /></span></div>
						<div style="display:inline-flex">
							<div class="name"><span class="name"><c:out value="${ comment.name }" /></span></div>
							<div class="date"><fmt:formatDate value="${ comment.insertDate }" pattern="yyyy/MM/dd HH:mm:ss" /></div>
						</div>
					<div class="delete">
						<c:if test="${ branch_id == 1 && department_id == 2 || branch_id == comment.branch_id && department_id == 3 }">
							<form action="deletecomment" method="post"><br />
								<input type="hidden" name="id" value="${ comment.id }" />
								<input type="submit" value="削除"><br />
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
					<textarea name="text" cols="40" rows="2" id="text" maxlength="500" required></textarea>
					<input type="submit" value="投稿" /><br />
					<input type="hidden" name="message_id" value="${ message.message_id }">
				</form>
			</div><br />
	</div>
	</c:forEach>
</div>

</div>


<!-- スクリプト部分 -->
<script>
    $( function() {
        var dates = jQuery( '#insert_from, #insert_to' ) . datepicker( {
            showAnim: 'drop',
            changeMonth: true,
            numberOfMonths: 2,
            showCurrentAtPos: 1,
            dateFormat:"yy/mm/dd",
            onSelect: function( selectedDate ) {
                var option = this . id == 'insert_from' ? 'minDate' : 'maxDate',
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