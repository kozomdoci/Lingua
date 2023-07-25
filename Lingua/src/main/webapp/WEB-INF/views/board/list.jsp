<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>
		<%@ include file="../module/library.jsp" %>
</head>
<body>
	<div id="container">
	
		<div id="top"><%@ include file="../module/top.jsp" %></div>
		<div id="left"><%@ include file="../module/left.jsp" %></div>
		<div id="right"><%@ include file="../module/right.jsp" %></div>
		<div id="bottom"><%@ include file="../module/bottom.jsp" %></div>
		
		<div id="main">
		
			<section id="wideSection">
				<table>
					<colgroup>
						<col width="10%">
						<col width="30%">
						<col width="30%">
						<col width="30%">
					</colgroup>
					<tr>
						<th>No</th>
						<th>Title</th>
						<th>Written by</th>
						<th>Created</th>
					</tr>
					<c:set var="count" value="1"/>
					<c:forEach items="${boardList}" var="board">
						<tr>
							<td>${count}</td>
							<td>
								<a href="contentView?idBoard=${board.idBoard}&writer=${board.writer}">${board.title}</a>
							</td>
							<td>${board.writer}</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${board.created}"/>
							</td>
						</tr>
						<c:set var="count" value="${count+1}"></c:set>
					</c:forEach>
				</table>
			  	<div class="form-floating" style="text-align: right;">
				  	<button id="checkSession" type="button" class="btn btn-warning" style="color: white;">Write</button>
			  	</div>
			</section>
		</div>
		
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 글쓰기 버튼 클릭 시 로그인 세션 확인 (세션 있으면 write 로 이동) ============= //
	$("#checkSession").on("click", function() {
		$.ajax({
			type: "get",
			url: "checkSession",
			dataType: "text",
			success: function(data) {
				if(data == "session found"){
					location.href = urlConverter("board/write");
				}else {
					alert("Please login first.");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
}); // ready

</script>
<style>
	table {
		table-layout: fixed;
		width: 100%;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid #cccccc;
		padding: 5px;
		text-align: center;
	}
	th {
		background-color: #f0f0f0;
	}
</style>









