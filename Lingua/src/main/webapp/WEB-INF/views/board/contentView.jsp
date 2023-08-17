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
				<div id="title">contentView</div>
				<input type="hidden" name="idBoard" value="${board.idBoard}">
				<input type="hidden" name="writer" value="${board.writer}">
				
				<div class="mb-3">

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
				  	<button id="checkSession2" type="button" class="btn btn-outline-info" style="margin-right: 5px;">Comment</button>
				  	<button id="list" type="button" class="btn btn-outline-warning">Back to List</button>
			  	</div>
	  			
				<div id="div_comment" class="form-floating mb-3" style="margin-top:20px; display: none">
		  			<form id="commentForm">
		  				<input type="hidden" name="idBoard" value="${board.idBoard}">
		  				<input type="hidden" name="language" value="${board.language}">
		  				<input type="hidden" name="writer" value="${userInfo.email}">
		  				<input type="hidden" name=writer_nickname value="${userInfo.nickname}">
		  				
	  					<textarea name="content" class="form-control" id="content" rows="5" placeholder="Please write here your comments"></textarea>
	  					<button id="commentSave" type="button" class="btn btn-info" style="color: white;" style="margin-right: 5px">Save</button>
	  					<button id="cancelComment" type="button" class="btn btn-outline-info">Cancel</button>
					</form>
				</div>
	  			
	  			<div id="containerComment">
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
	var type = "${pageMaker.type}";
	var keyword = "${pageMaker.keyword}";
	
	// ============= 뒤로가기 버튼 클릭 시 목록으로 이동 (검색조건과 검색어도 같이 가져가기 추가 -> 즉 글보기 후에 목록이동하면 검색조건 그대로 살아 있음) ============= //
	$("#list").on("click", function() {
		location.href = urlConverter("board/list?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount+"&type="+type+"&keyword="+keyword);
	});

	// ============= 수정 버튼 클릭 시 idBoard 값을 가지고 컨트롤러로 이동 ============= //
	$("#edit").on("click", function() {
		location.href = urlConverter("board/edit?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount+"&type="+type+"&keyword="+keyword);
	});
	
	// ============= 삭제 버튼 클릭 시 idBoard 값을 가지고 컨트롤러로 이동 ============= //
	$("#deleteBoard").on("click", function() {
		if(confirm("Deleted post cannot be recovered. Would you like to proceed?") == true) {
			location.href = urlConverter("board/delete?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
		}
	});
	
	
	// ============= 댓글 버튼 클릭 시 session 있는지 확인한 후에 div_comment 에 댓글 입력 폼 추가 ============= //
	$("#checkSession2").on("click", function() {
		$.ajax({
			type: "get",
			url: "checkSession",
			dataType: "text",
			success: function(data) {
				if(data == "session found") {
					$("#div_comment").slideDown(300);
				}else {
					alert("Please login first.");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
	
	// ============= 취소 버튼 클릭 시 댓글 입력 폼을 보이지 않게 SlideUp ============= //
	$("#cancelComment").on("click", function() {
		$("#div_comment").slideUp(300);
	});
	
	// ============= 저장 버튼 클릭 시 입력값 유효성 검사 후 댓글 삽입처리(삽입 완료되면 해당 창 다시 로딩 - 이때 idBoard, pageNum, amount 모두 가져가기) ============= //
	$("#commentSave").on("click", function() {
		var formData = $("#commentForm").serialize();
		
		var commentContent = document.getElementsByName("content");
		if(commentContent) {
			$.ajax({
				type: "post",
				data: formData,
				url: "comment/writeComment",
				dataType: "text",
				success: function(data) {
					if(data == "comment insert success") {
						alert("Comment Successfully Saved!")
						location.href = urlConverter("board/contentView?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
					}else {
						alert("failed to save your comment");
					}
				}
			});
		}
	});
	
	
	// ============= 해당 게시글과 연결된 댓글을 불러오는 메소드(각각 댓글의 작성자와 세션 비교하여 일치하면 수정/삭제 버튼 보여주기) ============= //
	
	// 메소드 호출부
	callComments();
	
	// 날짜의 출력 형태 변환을 위한 메소드 정의부
	// 컨트롤러로부터 전달받은 객체(XML)의 아이템(CommentDto)의 날짜 요소(created, modified)를 정수로 변환한 후 아래 메소드 호출하여 YYYY-MM-DD 형태로 변환
	function formatTimestampToDateString(timestamp) {
		var date = new Date(timestamp);
		var year = date.getFullYear();
		var month = String(date.getMonth()+1).padStart(2, '0');
		var day = String(date.getDate()).padStart(2, '0');
		
		return year + "-" + month + "-" + day;
	}
	
	// 조건에 맞는 댓글을 호출하기 위한 메소드 정의부 (컨트롤러부터 전달받은 객체의 정보를 조작하여 지정한 위치의 div에 HTML 로 추가)
	function callComments() {
		$.ajax({
			type: "get",
			url: "comment/listComment?idBoard="+idBoard,
			success: function(data) {
				var comments = data.getElementsByTagName("item");
				
				var CommentContent = "<h6>&nbsp;Comments : " + comments.length + "</h6>"
				
				for(var i=0; i<comments.length; i++) {
					var comment = comments[i];
					
					var idComment = comment.getElementsByTagName("idComment")[0].textContent;
					
					var content = comment.getElementsByTagName("content")[0].textContent;
					var writer_nickname = comment.getElementsByTagName("writer_nickname")[0].textContent;

					var createdTimestamp = parseInt(comment.getElementsByTagName("created")[0].textContent);
					var modifiedTimestamp = parseInt(comment.getElementsByTagName("modified")[0].textContent);
					var created = formatTimestampToDateString(createdTimestamp);
					var modified = formatTimestampToDateString(modifiedTimestamp);
					
					// 각 댓글의 작성자 이메일을 세션의 이메일과 비교하여 참/거짓 판별 => 하단 if 절에서 참이면 수정/삭제 버튼 보여주고 거짓이면 보여주지 않기
					var emailOfCommentWriter = comment.getElementsByTagName("writer")[0].textContent;
					var isCurrentUserCommentAuthor = (emailFromSession === emailOfCommentWriter);
					
					CommentContent += "<div class='contentOneLine'>"
					
					CommentContent += "<div class='form-floating mb-3 half-size-50' id='textAreaDiv'" + i + ">";
					CommentContent += "<form id='editCommentForm'>";
					CommentContent += "<input type='hidden' name='idComment' value='" + idComment + "'>";
					CommentContent += "<textarea name='content' type='text' class='form-control contentComment' rows='10' placeholder='content' readonly>"+content+"</textarea>";
					CommentContent += "<label for='contentComment'></label>";
					CommentContent += "</form></div>";
					
					CommentContent += "<div class='form-floating mb-3 half-size-20'>";
					CommentContent += "<input name='writer_nickname' value='" + writer_nickname + "' type='text' class='form-control' id='writer_nickname' placeholder='writer_nickname' readonly>";
					CommentContent += "<label for='writer_nickname'>Written by</label></div>";
					
					CommentContent += "<div class='form-floating mb-3 half-size-15'>";
					CommentContent += "<input name='created' value='" + created + "' type='text' class='form-control' id='created' placeholder='created' readonly>";
					CommentContent += "<label for='created'>Created on</label></div>";
					
					
					CommentContent += "<div class='form-floating mb-3 half-size-15'>";
					CommentContent += "<input name='modified' value='" + modified + "' type='text' class='form-control' id='modified' placeholder='modified' readonly>";
					
					if(isCurrentUserCommentAuthor) {
				        CommentContent += "<button id='editComment' class='editComment btn btn-outline-primary' style='margin-top: 60px'>Edit Comment</button>";
				        CommentContent += "<button id='deleteComment' class='deleteComment btn btn-outline-danger' style='margin-top: 5px'>Delete Comment</button>";
					}else {
				        CommentContent += "<button id='editComment' class='editComment btn btn-outline-primary' style='margin-top: 60px; display: none'>Edit Comment</button>";
				        CommentContent += "<button id='deleteComment' class='deleteComment btn btn-outline-danger' style='margin-top: 5px; display: none'>Delete Comment</button>";
					}
					CommentContent += "<label for='modified'>Modified on</label></div>";
					
					
					CommentContent += "</div>"
				}
				
				$("#containerComment").html(CommentContent);
			}
		});
	}
	
	
	// ============= 댓글 수정 ============= //
	
	// editComment 와 deleteComment 버튼은 동적으로 추가되는 요소이기 때문에 이벤트 위임(Event Delegation) 을 사용하여 접근할 수 있음
	// 이벤트 위임(Event Delegation) : 정적인 부모 요소에 이벤트 리스너를 추가하고, 특정 자식 요소들의 이벤트를 캡처하는 방법
	$("#containerComment").on("click", ".editComment", function() {
		console.log("editcomment is clicked");
		
		// Fine the textarea relative to the clicked "editComment" button and set the "readonly" attribute to false
		var textarea = $(this).closest(".contentOneLine").find(".contentComment");
		textarea.prop("readonly", false);
		
		// Edit 버튼의 클래스를 saveChanges 로 변경하고 버튼 이름을 Save Changes 로 변경
		$(this).removeClass("editComment").addClass("saveChanges");
		$(this).html("Save Changes");
		
	});
	
	
	// 수정된 댓글 입력 후 Save Changes 버튼 클릭하면 수정된 내용을 데이터베이스로 전달하여 수정처리
	$("#containerComment").on("click", ".saveChanges", function() {
		console.log("saveChanges is clicked");
		
		var editCommentButton = $(this);
		
		// Find the editCommentForm relative to the clicked "editComment" button and get the form data from the found editCommentForm
		var editCommentForm = $(this).closest(".contentOneLine").find("#editCommentForm");
		var formData = editCommentForm.serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "comment/editComment",
			dataType: "text",
			success: function(data) {
				// 댓글 수정이 성공적으로 완료되면 textarea 를 다시 읽기전용으로 변경
				if(data == "comment update success") {
					alert("Change saved for your comment!");
					location.href = urlConverter("board/contentView?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
				}
			}
		});
	});
	
	
	// ============= 댓글 삭제 ============= //
	$("#containerComment").on("click", ".deleteComment", function() {
		console.log("deleteComment is clicked");
		
		if(confirm("Deleted comment cannot be recovered. Would you like to proceed?") == true) {
			
			var editCommentForm = $(this).closest(".contentOneLine").find("#editCommentForm");
			var formData = editCommentForm.serialize();
			
			$.ajax({
				type: "post",
				data: formData,
				url: "comment/deleteComment",
				dataType: "text",
				success: function(data) {
					if(data == "comment delete success") {
						alert("Comment Deleted Successfully!")
						location.href = urlConverter("board/contentView?idBoard="+idBoard+"&pageNum="+pageNum+"&amount="+amount);
					}else {
						alert("failed to delete your comment");
					}
				}
			});
		}
	});
	
	

	
}); // ready

</script>

<style>
    input,
    textarea {
        width: 100%;
    }

    .contentOneLine {
        display: flex;
        gap: 10px;
    }

    .form-floating.mb-3.half-size-50 {
        flex: 1;
        max-width: 50%;
    }

    .form-floating.mb-3.half-size-20 {
        flex: 1;
        max-width: 20%;
    }

    .form-floating.mb-3.half-size-15 {
        flex: 1;
        max-width: 15%;
    }
    #contentComment {
    	height: 200px;
    }
</style>




