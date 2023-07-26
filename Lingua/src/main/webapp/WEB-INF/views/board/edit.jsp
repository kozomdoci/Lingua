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
				<div id="title">게시글 수정</div>
				
				<form id="editForm">
					<input type="hidden" name="idBoard" value="${board.idBoard}">
					
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">Title</label>
						<input name="title" value="${board.title}" type="text" class="form-control" id="titleId">
					</div>
					
					<div class="mb-3">
						<label for="exampleFormControlTextarea1" class="form-label">Content</label>
						<textarea name="content" class="form-control" id="contentId" rows="10">${board.content}</textarea>
					</div>
					
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">Written by</label>
						<input name="writer" value="${board.writer}" type="email" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
					</div>
				</form>
				
			  	<div class="form-floating" style="display: flex; justify-content: flex-end;">
				  	<button id="edit" type="button" class="btn btn-warning" style="color: white; margin-right: 5px">Save</button>
				  	<button id="contentView" type="button" class="btn btn-outline-warning">Back to Content</button>
			  	</div>
			  	
			</section>
		</div>
		
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동 ============= //
	$("#contentView").on("click", function() {
		location.href = urlConverter("board/contentView?idBoard="+${board.idBoard});
	});
	
	// ============= input 태그에 모든 값들이 입력되지 않으면 Save 버튼 비활성화 ============= //
	document.querySelector("#editForm").addEventListener("input", checkFormValidity);
	function checkFormValidity() {
		var titleValue = document.getElementById("titleId").value;
		var contentValue = document.getElementById("contentId").value;
		
		if(titleValue && contentValue) {
			document.getElementById("edit").disabled = false;
		}else {
			document.getElementById("edit").disabled = true;
		}
	}
	
	// ============= 게시글 수정 후 Save 버튼 클릭하면 폼 데이터 전송하여 업데이트 처리 ============= //
	var idBoard = "${board.idBoard}";
	
	$("#edit").on("click", function() {
		var formData = $("#editForm").serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "edit",
			dataType: "text",
			success: function(data) {
				if(data == "update success") {
					alert("Change Saved!");
					location.href = urlConverter("board/contentView?idBoard="+idBoard);
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




