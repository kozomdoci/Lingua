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
				<div id="title">게시글 작성</div>
				<form id="writeForm">
					<input type="hidden" name="writer" value="${userInfo.email}">
					
					<div class="mb-3">
						<label for="exampleFormControlSelect1" class="form-label">Language</label>
						<select name="language" class="form-select" id="exampleFormControlSelect1" aria-label="Default select example">
							<option selected>Select language</option>
							<option value="korean">Korean</option>
							<option value="english">English</option>
							<option value="japanese">Japanese</option>
							<option value="polish">Polish</option>
						</select>
					</div>
					
					<div class="mb-3">
					  <label for="exampleFormControlInput1" class="form-label">Title</label>
					  <input name="title" type="text" class="form-control" id="exampleFormControlInput1">
					</div>
					
					<div class="mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
					  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="10"></textarea>
					</div>
					
					<div class="mb-3">
					  <label for="exampleFormControlInput1" class="form-label">Written by</label>
					  <input name="writer_nickname" value="${userInfo.nickname}" type="email" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
					</div>
					
				</form>
				
			  	<div class="form-floating" style="text-align: right;">
				  	<button id="save" type="button" class="btn btn-warning" style="color: white;">Save</button>
				  	<button id="list" type="button" class="btn btn-outline-warning">Back to List</button>
			  	</div>
			  	
			</section>
		</div>
		
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동 ============= //
	$("#list").on("click", function() {
		location.href = urlConverter("board/list");
	});
	
	// ============= 글제목과 글내용 입력 후 저장 버튼 클릭 시 새 글 삽입처리 ============= //
	$("#save").on("click", function() {
		var formData = $("#writeForm").serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "write",
			dataType: "text",
			success: function(data) {
				if(data == "insert success") {
					alert("Successfully Saved!")
					location.href = urlConverter("board/list");
				}
			}
		});
	});
	
	
	
	
}); // ready

</script>
<style>
	input, textarea {
		width: 100%
	}
</style>




