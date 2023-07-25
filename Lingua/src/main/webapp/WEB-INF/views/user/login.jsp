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
		
			<section id="narrowSection">
				<form id="loginForm" action="login" method="post">
				
					<div class="form-floating mb-3">
	  					<input name="email" type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
	  					<label for="floatingInput">Email address</label>
					</div>
					
					<div class="form-floating">
	  					<input name="password" type="password" class="form-control" id="floatingPassword" placeholder="Password">
	  					<label for="floatingPassword">Password</label>
					</div>
					
				  	<div class="form-floating">
					  	<button id="loginCheck" type="button" class="btn btn-primary">Sign In</button>
				  		<button id="registerPage" type="button" class="btn btn-info" style="color: white;">Sign Up</button>
				  		<button id="forgotPassword" type="button" class="btn btn-outline-info">forgot password</button>
				  	</div>
				  	
				</form>
			</section>
			
		</div>
		
	</div>
</body>
</html>
<script>

	//============= 패스워드 입력란에서 엔터키(keycode 13)를 누르면 로그인 버튼 클릭 ============= //
	$("input[name='password']").keydown(function (e) {
		if ( e.keyCode == 13) {
			$("#loginCheck").click();
		}
	});
	
	//============= 로그인 버튼 클릭 시 이메일/비밀번호 유효 여부 확인 후 로그인 처리 ============= //
	$("#loginCheck").click(function() {
		var formData = $("#loginForm").serialize();
		$.ajax({
			type: "post",
			data: formData,
			url: "login",
			success: function(data) {
				console.log(data);		// login success OR wrong password OR email not found
				// 전달되는 데이터(text) 에 따라서 분기처리 추가 작업 해야 함
				if(data == "login success") {
					alert("Login Success!");
					location.href = urlConverter("board/home");
				}else if(data == "wrong password") {
					alert("Wrong Password");
				}else {
					alert("No user Found");
				}
			}
		}); // ajax
	}); // Sign In Button
	
	//============= 회원가입 버튼 클릭 시 회원가입 화면으로 이동 ============= //
	$("#registerPage").click(function() {
		location.href = urlConverter("user/register");
	}); // Sign Up Button
	
	
	//============= 비밀번호 찾기 버튼 클릭 시 이메일 가입 여부 확인 후 임시비밀번호 발송 ============= //
	$("#forgotPassword").click(function() {
		var email = prompt("Enter your email address.");
		
		$.ajax({
			type: "post",
			data: { email: email},
			url: "forgotPassword",
			success: function(data) {
				if(data == "email found") {
					alert("A temporary password has been sent to the given email address");
				}else {
					alert("email address not found");
				}
			}
		});
	});
	
	
</script>




