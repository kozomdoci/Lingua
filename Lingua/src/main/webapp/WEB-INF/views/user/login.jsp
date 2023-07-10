<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		
			<section>
				<form id="loginForm" action="login" method="post">
				
			    	<div class="mb-3">
				    	<label for="exampleInputEmail1" class="form-label">Email address</label>
				    	<input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
				  	</div>
				  	
				  	<div class="mb-3">
				    	<label for="exampleInputPassword1" class="form-label">Password</label>
				    	<input name="password" type="password" class="form-control" id="exampleInputPassword1">
				  	</div>
				  	
				  	<div>
				  		<button id="loginCheck" type="button" class="btn btn-primary">Login</button>
				  	</div>
				  	
				</form>
			</section>
			
		</div>
	</div>
</body>
</html>
<script>

	// 패스워드 입력란에서 엔터키(keycode 13)를 누르면 로그인 버튼 클릭
	$("input[name='password']").keydown(function (e) {
		if ( e.keyCode == 13) {
			$("#loginCheck").click();
		}
	});
	
	$("#loginCheck").click(function() {
		var formData = $("#loginForm").serialize();
		$.ajax({
			type: "post",
			data: formData,
			url: "login",
			success: function(data) {
				console.log(data);
			}
		}); // ajax
	}); // login 버튼
</script>




