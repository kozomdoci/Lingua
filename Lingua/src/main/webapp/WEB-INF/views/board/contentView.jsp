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
				<div id="title">게시글 보기</div>
				
				<input type="hidden" name="idBoard" value="${board.idBoard}">
				<input type="hidden" name="writer" value="${board.writer}">
				
				<div class="mb-3">
				  <label for="exampleFormControlInput1" class="form-label">Title</label>
				  <input name="title" value="${board.title}" type="text" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
				  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="10" readonly style="color:grey">${board.content}</textarea>
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlInput1" class="form-label">Written by</label>
				  <input name="writer" value="${board.writer}" type="email" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
				</div>
				
			  	<div class="form-floating" style="display: flex; justify-content: flex-end;">
				  	<button id="edit" type="button" class="btn btn-warning" style="color: white; display: none">Edit</button>
				  	<button id="list" type="button" class="btn btn-warning" style="color: white;">Back to List</button>
			  	</div>
			  	
			</section>
		</div>
		
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 현재 로그인된 사용자의 이메일 주소와 선택한 게시글의 작성자 이메일 주소가 같은 경우에만 Edit 버튼 보여주기 ============= //
	var emailFromSession = "${userInfo.email}";
	var emailOfWriter = "${board.writer}";
	
	if(emailFromSession == emailOfWriter) {
		$("#edit").css({"display":"block", "margin-right":"5px"});
	}
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동 ============= //
	$("#list").on("click", function() {
		location.href = urlConverter("board/list");
	});

	// ============= 수정 버튼 클릭 시 수정화면으로 이동 ============= //
	var idBoard = "${board.idBoard}";
	
	$("#edit").on("click", function() {
		var formData = {idBoard: idBoard}
		
		$.ajax({
			type: "get",
			data: formData,
			url: "edit",
			success: function(data) {
				console.log(data);
			}
		});
		
// 		location.href = urlConverter("board/edit");
	});
	
	
	
	
}); // ready

</script>
<style>
	input, textarea {
		width: 100%
	}
</style>




