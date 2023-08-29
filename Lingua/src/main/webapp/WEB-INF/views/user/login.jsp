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
				  	
					<div class="d-grid gap-1" style="margin-top: 20px">
						<button id="googleLogin" class="btn btn-danger" type="button">Login with Google</button>
						<button id="kakaoLogin" class="btn btn-warning" type="button">Login with Kakao</button>
						<button id="naverLogin" class="btn btn-success" type="button">Login with Naver</button>
					</div>
				  	
				</form>
			</section>
			
		</div>
		
	</div>
</body>
</html>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
	
	//============= 카카오 간편 로그인 버튼 클릭 시 함수 호출 ============= //
	$("#kakaoLogin").click(function() {
		kakaoLogin();
	});
	
	window.Kakao.init("876cb96081b23cd6eb74496e599060a4");
	console.log("Kakao.initialized ??? " + Kakao.isInitialized());
	
	function kakaoLogin() {
		
		// 카카오 로그인 요청 (로그인 요청에 대한 옵션 객체를 매개변수로 받음)
		window.Kakao.Auth.login({
			
			// 로그인 성공 시 실행되는 콜백함수
			success: function(authObj) {
				
				// 로그인 성공 후 사용자 정보 조회를 위해 호출(요청에 대한 옵션 객체를 매개변수로 받음)
				window.Kakao.API.request({
					
					// 요청할 API 경로(현재 로그인한 사용자의 정보를 조회하는 API 경로)
					url: '/v2/user/me',
					
					// API 요청이 성공했을 때 실행되는 콜백 함수 (res 매개변수에 응답 데이터가 전달됨)
					success: res => {
						const kakao_account = res.kakao_account;
						console.log("카카오 간편 로그인 성공 ===> " + kakao_account.email);
						console.log("해당 카카오 계정(즉 해당 이메일)로 우리 사이트에 가입되어 있는지 확인 ===>>>");
						
						// ajax를 통해 서버에 HTTP GET 요청(사이트 가입 여부 확인)을 보내기
						$.ajax({
							type: "get",
							data: { "email" : kakao_account.email },
							url: "kakaoEmailCheck",
							dataType: "json",
							success: function(data){
								if(data.exists) {
									location.href = urlConverter("board/home");
								}else {
									location.href = urlConverter("user/register?email="+kakao_account.email);
								}
							} // ajax success
						}); // ajax
						
						kakaoLogout();
						
					} // API.request success (카카오 정보조회 성공)
				}); // API request (카카오 정보조회 시도)
				
			} // Auth.login success (카카오 로그인 성공)
		}); // Auth.login (카카오 로그인 시도)
		
	} // kakaoLogin function
	
	function kakaoLogout() {
		Kakao.API.request({
			url: '/v1/user/logout',
			success: function() {
				console.log("로그아웃 성공");
			}
		});
	}
	
</script>





