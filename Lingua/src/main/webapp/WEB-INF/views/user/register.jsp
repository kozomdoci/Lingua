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
				<form id="registerForm" action="register" method="post">
				
					<div class="form-floating mb-3">
	  					<input name="email" type="email" class="form-control" id="email" placeholder="name@example.com">
	  					<label for="email">Email</label>
	  					<div class="valid-feedback">
	  						Email is valid.
	  					</div>
	  					<div class="invalid-feedback">
	  						Email is invalid.
	  					</div>
					</div>
  					<div class="form-floating mb-3">
	  					<button id="sendCode" type="button" class="btn btn-outline-secondary" disabled>send Code</button>
	  					<input size="40" name="code" class="btn btn-light" id="code" style="color:white; display: none;" maxlength="6" placeholder="please input code">
  					</div>
	  					
					<div class="form-floating mb-3">
	  					<input name="password" type="password" class="form-control" id="password" placeholder="Password">
	  					<label for="password">Password</label>
	  					<div class="valid-feedback">
	  						Password is valid.
	  					</div>
						<div class="invalid-feedback">
							Password is invalid. Password must be at least 8 characters with 1 upper case letter and 1 number.
						</div>
					</div>

					<div class="form-floating mb-3">
	  					<input name="password2" type="password" class="form-control" id="password2" placeholder="Password2">
	  					<label for="password2">Password Check</label>
	  					<div class="valid-feedback">
	  						Password is matching.
	  					</div>
						<div class="invalid-feedback">
							Password is not matching.
						</div>
					</div>

				  	<div>
				  		<button id="register" type="button" class="btn btn-outline-secondary" disabled>Sign Up</button>
				  	</div>
	
				</form>
			</section>
		
		</div>
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	// ============= 이메일 유효성 검사 ============= //
	let isEmailValid = false;
	let isEmailAvailable = false;
	let thisElement = document.querySelector("#email");
	thisElement.addEventListener("input", function() {
		let inputEmail = this.value;
		let emailRegex = /[\w\-\.]+\@[\w\-\.]+\.[\w\-\.]+/;
		isEmailValid = emailRegex.test(inputEmail);
		
		var formData = { email: inputEmail };
		$.ajax({
			type: "post",
			data: formData,
			url: "isEmailAvailable",
			dataType: "text",
			success: function(data) {
				if(data == "valid email"){
					isEmailAvailable = true;
				}else if(data == "invalid email"){
					isEmailAvailable = false;
				}
				
				if(isEmailValid && isEmailAvailable) {
					thisElement.classList.remove("is-invalid");
					thisElement.classList.add("is-valid");
					enableButton();
				}else {
					thisElement.classList.remove("is-valid");
					thisElement.classList.add("is-invalid");
				}
			}
		});
	});
	
	
	// ============= 이메일 유효성 검사 및 중복확인 완료 후 이메일 인증번호 발송버튼 활성화 및 스타일 변경 ============= //
	function enableButton() {
		let buttonElement = document.getElementById('sendCode');
		buttonElement.removeAttribute('disabled');
		buttonElement.classList.remove('btn-outline-secondary');
		buttonElement.classList.add('btn-info');
		buttonElement.style.color = 'white';
	}
	
	// ============= 활성화된 이메일 인증번호 발송 버튼 클릭 시 인증번호 발송 ============= //
	$("#sendCode").click(function() {
		var inputEmail = document.querySelector("#email").value;
		var formData = { email: inputEmail };
		$.ajax({
			type: "post",
			data: formData,
			url: "sendCode",
			dataType: "text",
			success: function(data) {
				if(data != null){
					
				}
				console.log(data);
			}
		});
		
	});
	
	
	
	// ============= 비밀번호 유효성 검사 ============= //
	
	// 비밀번호 유효성 여부를 변수로 만들고 초기값 false 부여
	let isPasswordValid = false;
	// id 가 password 인 요소를 선택하여 input 요소에 이벤트 추가
	document.querySelector("#password").addEventListener("input", function() {
		// 사용자가 입력한 비밀번호를 가져와서 변수에 저장
		let inputPassword = this.value;
		
		// 사용자가 입력한 비밀번호의 유효성 검증(8자 이상, 1개 이상의 대문자, 1개 이상의 숫자)
		let passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
		// 정규표현식 정리
		// ^ => the start of the string
		// (?=.*[A-Z]) => if there is at least one uppercase letter ([A-Z]) anywhere in the string
		// (?=.*\d) =>  if there is at least one digit (numeric character) anywhere in the string.
		// .{8,} => any character (.) for at least 8
		// $ => the end of the string
		
		isPasswordValid = passwordRegex.test(inputPassword);
		
		// 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
		if(isPasswordValid) {
			this.classList.remove("is-invalid");
			this.classList.add("is-valid");
		}else {
			this.classList.remove("is-valid");
			this.classList.add("is-invalid");
		}
	});
	
	
	// ============= 비밀번호 확인 유효성 검사 ============= //
	
	let isPasswordMatching = false;
	document.querySelector("#password2").addEventListener("input", function() {
		let inputPassword = document.querySelector("#password").value;
		let inputPassword2 = this.value;
		isPasswordMatching = inputPassword2 === inputPassword;
		
		if(isPasswordMatching) {
			this.classList.remove("is-invalid");
			this.classList.add("is-valid");
		}else {
			this.classList.remove("is-valid");
			this.classList.add("is-invalid");
		}
	});
	
});	
</script>
























