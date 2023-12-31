<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>
	<%@ include file="../module/library.jsp" %>
	
<!-- content에 자신의 OAuth2.0 클라이언트ID -->
<meta name ="google-signin-client_id" content="--- to be filled with OAuth 2.0 clientId ---">

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
						<button id="kakaoLogin" class="btn btn-warning" type="button">Login with Kakao</button>
						<button id="naverIdLogin_loginButton" class="btn btn-success" type="button">Login with Naver</button>
						<button id="GgCustomLogin" class="btn btn-danger" type="button">Login with Google</button>
					</div>
				  	
				</form>
			</section>
			
		</div>
		
	</div>
</body>
</html>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
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
	
	window.Kakao.init("--- to be filled with API KEY for JavaScript ---");
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
							url: "apiEmailCheck",
							dataType: "json",
							success: function(data){
								if(data.exists) {
									// 해당 이메일 계정이 등록된 계정이면 바로 로그인 처리 후 홈화면
									location.href = urlConverter("board/home");
								}else {
									// 해당 이메일 계정이 등록되지 않은 계정이면 이메일 가지고 회원가입 화면
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
	
	
	//============= 네이버 간편 로그인 버튼 클릭 시 함수 호출 ============= //
	
	var naverLogin = new naver.LoginWithNaverId({
		clientId: "--- to be filled with Application clientId ---",							// 내 애플리케이션 정보의 clientId
		callbackUrl: "http://localhost:8181/lingua/user/login",		// 내 애플리케이션 API 설정의 Callback URL
		isPopup: false,
		callbackHandle: true
	});
	
	naverLogin.init();
	
	window.addEventListener('load', function() {
		naverLogin.getLoginStatus(function(status) {
			
			if(status){
				console.log("네이버 간편 로그인 성공 ===> " + status);
				
				var email = naverLogin.user.getEmail();
				console.log("해당 네이버 계정(즉 해당 이메일)로 우리 사이트에 가입되어 있는지 확인 ===>>> " + email);
				
				$.ajax({
					type: "get",
					data: { "email" : email },
					url: "apiEmailCheck",
					dataType: "json",
					success: function(data){
						if(data.exists) {
							// 해당 이메일 계정이 등록된 계정이면 바로 로그인 처리 후 홈화면
							location.href = urlConverter("board/home");
						}else {
							// 해당 이메일 계정이 등록되지 않은 계정이면 이메일 가지고 회원가입으로 이동
							location.href = urlConverter("user/register?email="+email);
						}
					} // ajax success
				}); // ajax
				
				naverLogout();
				
			}else {
				console.log("callback failed");
			}
		});
	});

	function naverLogout() {
		naverLogin.logout();
	}
	
	
	
	//============= 구글 간편 로그인 버튼 클릭 시 함수 호출 ============= //

	function init() {
		
		// 구글 API 라이브러리에서 auth2 모듈 (구글 인증 관리) 을 로드
		gapi.load('auth2', function() {
			
			// 초기화
			gapi.auth2.init();
			
			// 로그인 옵션을 설정하는 객체를 생성
			options = new gapi.auth2.SigninOptionsBuilder();
			
			// 사용자에게 구글 계정을 선택하라는 메시지를 표시
			options.setPrompt('select_account');
			
			// 로그인 시 요청할 OAuth 승인 권한을 설정 (이메일 주소 읽기 권한을 요청)
			options.setScope('email');
			
			// getAuthInstance() 함수 호출 -> 현재 사용자의 인증 인스턴스를 가져옴
			// attachClickHandler 함수 호출 -> 지정된 HTML 요소 (GgCustomLogin)를 클릭할 때 구글 로그인 팝업을 열도록 설정
			// 성공 시 콜백함수(onSignIn), 실패 시 콜백함수(onSignInFailure)
			gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
		})
	}

	// 로그인 성공 시 실행할 콜백 함수 정의
	function onSignIn(googleUser) {
		var access_token = googleUser.getAuthResponse().access_token;
		
		var profile = googleUser.getBasicProfile();
	    var email = profile.getEmail();
		console.log("email ===> " + email);
	    
		$.ajax({
			type: "get",
			data: { "email" : email },
			url: "apiEmailCheck",
			dataType: "json",
			success: function(data){
				if(data.exists) {
					// 해당 이메일 계정이 등록된 계정이면 바로 로그인 처리 후 홈화면
					location.href = urlConverter("board/home");
				}else {
					// 해당 이메일 계정이 등록되지 않은 계정이면 이메일 가지고 회원가입으로 이동
					location.href = urlConverter("user/register?email="+email);
				}
			} // ajax success
		}); // ajax
		
		google.Logout();
		
	} // onSignIn function
	
	
	// 로그인 실패 시 실행할 콜백 함수 정의
	function onSignInFailure(error) {
	    console.log(error);
	}

	// Google 로그아웃 함수 정의
	function googleLogout() {
	    var auth2 = gapi.auth2.getAuthInstance();
	    auth2.signOut().then(function() {
	        console.log('Google 로그아웃 완료.');
	    });
	}
	
	
</script>



