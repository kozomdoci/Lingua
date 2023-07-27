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
				${board.language}<br>
					<label for="exampleFormControlSelect1" class="form-label">Language</label>
					<select name="language" class="form-select" id="exampleFormControlSelect1" aria-label="Default select example">
						<option value="korean">Korean</option>
						<option value="english">English</option>
						<option value="japanese">Japanese</option>
						<option value="polish">Polish</option>
					</select>
				</div>
				
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">Title</label>
					<input name="title" value="${board.title}" type="text" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
				</div>
				
				<div class="mb-3">
					<label for="exampleFormControlTextarea1" class="form-label">Content</label>
					<textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="10" readonly style="color:grey">${board.content}</textarea>
				</div>
				
				<div class="mb-3">
					<fmt:formatDate var="createdFmt" pattern="yyyy-MM-dd" value="${board.created}"/>
				  	<label for="exampleFormControlInput1" class="form-label">Uploaded on</label>
				  	<input name="created" value="${createdFmt}" type="text" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
				</div>
				
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">Written by</label>
					<input name="writer_nickname" value="${board.writer_nickname}" type="text" class="form-control" id="exampleFormControlInput1" readonly style="color:grey">
				</div>
				
			  	<div class="form-floating" style="display: flex; justify-content: flex-end;">
				  	<button id="deleteBoard" type="button" class="btn btn-danger" style="color: white; display: none;">Delete</button>
				  	<button id="edit" type="button" class="btn btn-warning" style="color: white; display: none">Edit</button>
				  	<button id="comment" type="button" class="btn btn-outline-info" style="margin-right: 5px">Comment</button>
				  	<button id="list" type="button" class="btn btn-outline-warning">Back to List</button>
			  	</div>
	  			
	  			<div id="containerComment">
	  				
	  			</div>
	  			
				<div id="div_comment" class="form-floating mb-3" style="margin-top:20px; display: none">
  					<input name="content" type="text" class="form-control" id="content" placeholder="content">
  					<label for="content">Comment</label>
				</div>
			  	
			</section>
		</div>
		
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 선택된 게시글의 language 값을 평가하여 해당하는 곳에 selected 추가, 해당하지 않는 option 은 모두 보이지 않도록 설정 ============= //
	var language = "${board.language}";
	
	var selectElement = document.getElementById("exampleFormControlSelect1");
	var options = selectElement.options;
	
	for(var i=0; i<options.length; i++) {
		if(options[i].value === language) {
			options[i].selected = true;
			options[i].style.display = "block";
		}else {
			options[i].style.display = "none";
		}
	}
	
	// ============= 현재 로그인된 사용자의 이메일 주소와 선택한 게시글의 작성자 이메일 주소가 같은 경우에만 Edit, Delete 버튼 보여주기 ============= //
	var emailFromSession = "${userInfo.email}";
	var emailOfWriter = "${board.writer}";
	
	if(emailFromSession == emailOfWriter) {
		$("#edit").css({"display":"block", "margin-right":"5px"});
		$("#deleteBoard").css({"display":"block", "margin-right":"5px"});
	}
	
	
	// ============= 수정, 삭제, 뒤로가기 버튼 클릭 시 전달해주기 위한 파라미터 셋팅(페이징 처리 추가 => 원래 페이지로 이동하기) ============= //
// 	var idBoard = "${board.idBoard}";
	var idBoard = "${pageMaker.idBoard}";
	var pageNum = "${pageMaker.pageNum}";
	var amount = "${pageMaker.amount}";
	
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동 ============= //
	$("#list").on("click", function() {
		location.href = urlConverter("board/list?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
	});

	// ============= 수정 버튼 클릭 시 idBoard 값을 가지고 컨트롤러로 이동 ============= //
	$("#edit").on("click", function() {
		location.href = urlConverter("board/edit?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
	});
	
	// ============= 삭제 버튼 클릭 시 idBoard 값을 가지고 컨트롤러로 이동 ============= //
	$("#deleteBoard").on("click", function() {
		alert("Deleted post cannot be recovered. Would you like to proceed?");
		location.href = urlConverter("board/delete?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
	});
	
	
	
	
	
	
	
	
	// ============= 댓글 버튼 클릭 시 div_comment 에 댓글 입력 폼 추가 ============= //
	$("#comment").on("click", function() {
		$("#div_comment").slideDown(300);
	});
	
	
}); // ready

</script>
<style>
	input, textarea {
		width: 100%
	}
</style>




