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
				<div id="title">write</div>
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
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동(이때 페이지 번호 가져가기) ============= //
	$("#list").on("click", function() {
		location.href = urlConverter("board/list?pageNum="+pageNum+"&amount="+amount);
	});
	
	
	// ============= 입력 폼 유효성 검사하는 메소드 ============= //
	
	function checkFormValidity() {
		var selectedLanguageValue = document.getElementsByName("language")[0].value;
		var titleValue = document.getElementById("exampleFormControlInput1").value;
		var contentValue = document.getElementById("exampleFormControlTextarea1").value;
		
		if(selectedLanguageValue && titleValue && contentValue) {
			return true;
		}
		return false;
	}
	
	
	// ============= 저장 버튼 클릭 시 새 글 삽입처리 ============= //
	
	// @GetMapping("/write") => 에서 전달된 모델객체
	var pageNum = "${pageMaker.pageNum}";
	var amount = "${pageMaker.amount}";
	
	$("#save").on("click", function() {
		var formData = $("#writeForm").serialize();
		
		if(checkFormValidity()) {
			$.ajax({
				type: "post",
				data: formData,
				url: "write",
				dataType: "text",
				success: function(data) {
					if(data == "insert success") {
						alert("Successfully Saved!")
						location.href = urlConverter("board/list?pageNum="+pageNum+"&amount="+amount);
					}
				}
			});
		}else {
			alert("Please check if all fields are filled.");
		}
	});
	
	
	
}); // ready

</script>
<style>
	input, textarea {
		width: 100%
	}
</style>




