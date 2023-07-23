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
	  					<input size="38" name="code" class="btn btn-light" id="code" style="color:white; display: none;" maxlength="6" placeholder="please input code">
	  					<div class="valid-feedback">
	  						code is matching.
	  					</div>
	  					<div class="invalid-feedback">
	  						code is not matching.
	  					</div>
  					</div>
  					
					<div class="form-floating mb-3">
	  					<input name="nickname" type="text" class="form-control" id="nickname" placeholder="nickname">
	  					<label for="nickname">Nickname</label>
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
					
					<div id="languageSet1">
						<select name="language1" class="form-select" aria-label="Default select example">
							<option selected>Select language</option>
							<option value="korean">Korean</option>
							<option value="english">English</option>
							<option value="japanese">Japanese</option>
							<option value="polish">Polish</option>
						</select>
						<input class="form-check-input" type="radio" id="native1" value="native" name="level1">
						<label class="form-check-label" for="native1">native</label>
						<input class="form-check-input" type="radio" id="beginner1" value="beginner" name="level1">
						<label class="form-check-label" for="beginner1">beginner</label>
						<input class="form-check-input" type="radio" id="intermediate1" value="intermediate" name="level1">
						<label class="form-check-label" for="intermediate1">intermediate</label>
						<input class="form-check-input" type="radio" id="advanced1" value="advanced" name="level1">
						<label class="form-check-label" for="advanced1">advanced</label>
					</div>
					
					<div id="languageSet2" style="display: none;">
						<select name="language2" class="form-select" aria-label="Default select example">
							<option selected>Select language</option>
							<option value="korean">Korean</option>
							<option value="english">English</option>
							<option value="japanese">Japanese</option>
							<option value="polish">Polish</option>
						</select>
						<input class="form-check-input" type="radio" id="native2" value="native" name="level2">
						<label class="form-check-label" for="native2">native</label>
						<input class="form-check-input" type="radio" id="beginner2" value="beginner" name="level2">
						<label class="form-check-label" for="beginner2">beginner</label>
						<input class="form-check-input" type="radio" id="intermediate2" value="intermediate" name="level2">
						<label class="form-check-label" for="intermediate2">intermediate</label>
						<input class="form-check-input" type="radio" id="advanced2" value="advanced" name="level2">
						<label class="form-check-label" for="advanced2">advanced</label>
					</div>
					<div id="languageSet3" style="display: none;">
						<select name="language3" class="form-select" aria-label="Default select example">
							<option selected>Select language</option>
							<option value="korean">Korean</option>
							<option value="english">English</option>
							<option value="japanese">Japanese</option>
							<option value="polish">Polish</option>
						</select>
						<input class="form-check-input" type="radio" id="native3" value="native" name="level3">
						<label class="form-check-label" for="native3">native</label>
						<input class="form-check-input" type="radio" id="beginner3" value="beginner" name="level3">
						<label class="form-check-label" for="beginner3">beginner</label>
						<input class="form-check-input" type="radio" id="intermediate3" value="intermediate" name="level3">
						<label class="form-check-label" for="intermediate3">intermediate</label>
						<input class="form-check-input" type="radio" id="advanced3" value="advanced" name="level3">
						<label class="form-check-label" for="advanced3">advanced</label>
					</div>
					<div id="languageSet4" style="display: none;">
						<select name="language4" class="form-select" aria-label="Default select example">
							<option selected>Select language</option>
							<option value="korean">Korean</option>
							<option value="english">English</option>
							<option value="japanese">Japanese</option>
							<option value="polish">Polish</option>
						</select>
						<input class="form-check-input" type="radio" id="native4" value="native" name="level4">
						<label class="form-check-label" for="native4">native</label>
						<input class="form-check-input" type="radio" id="beginner4" value="beginner" name="level4">
						<label class="form-check-label" for="beginner4">beginner</label>
						<input class="form-check-input" type="radio" id="intermediate4" value="intermediate" name="level4">
						<label class="form-check-label" for="intermediate4">intermediate</label>
						<input class="form-check-input" type="radio" id="advanced4" value="advanced" name="level4">
						<label class="form-check-label" for="advanced4">advanced</label>
					</div>
					
				  	<div>
				  		<button id="addLanguage" type="button" class="btn btn-outline-secondary">+</button>
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
			success: function(data) {
				if(data == "valid email"){
					isEmailAvailable = true;
				}else if(data == "invalid email"){
					isEmailAvailable = false;
				}
				
				// 입력값이 없거나 유효한 이메일 형식이 아니거나 사용할 수 없는 이메일(중복)인 경우 invalid 추가
				if(inputEmail.trim() === "" || !isEmailValid || !isEmailAvailable) {
					thisElement.classList.remove("is-valid");
					thisElement.classList.add("is-invalid");
					disableButton();
				}else {
					thisElement.classList.remove("is-invalid");
					thisElement.classList.add("is-valid");
					enableButton();
				}
				
			} // success
		}); // ajax
	});
	
	// ============= 이메일 유효성 검사 및 중복확인 완료 후 이메일 인증번호 발송버튼 활성화 및 스타일 변경하는 함수 ============= //
	function enableButton() {
		let buttonElement = document.getElementById('sendCode');
		buttonElement.removeAttribute('disabled');
		buttonElement.classList.remove('btn-outline-secondary');
		buttonElement.classList.add('btn-info');
		buttonElement.style.color = 'white';
	}
	
	// ============= 이메일 유효성 검사 및 중복확인 완료 후 입력된 값을 변경하면 이메일 인증번호 발송버튼 비활성화 및 스타일 변경하는 함수 ============= //
	function disableButton() {
		let buttonElement = document.getElementById("sendCode");
		buttonElement.setAttribute("disabled", "true");
		buttonElement.classList.remove("btn-info");
		buttonElement.classList.add("btn-outline-secondary");
		buttonElement.style.color = "";
	}
	
	// ============= 활성화된 이메일 인증번호 발송 버튼 클릭 시 인증번호 발송 후 인증번호 입력창 보여주기 ============= //
	$("#sendCode").click(function() {
		var inputEmail = document.querySelector("#email").value;
		var formData = { email: inputEmail };
		$.ajax({
			type: "post",
			data: formData,
			url: "sendCode",
			success: function(data) {
				if(data != null){
					$("#code").slideDown();
				}
			}
		});
	});
	
	// ============= 인증번호 입력창에 값이 들어오면 그 값을 컨트롤러로 보내서 유효성 검사 ============= //
	$("#code").on("input", function() {
		var inputCode = this.value;
		
		// 사용자가 인증번호 입력하기 시작하면 invalid 추가
		if(inputCode.trim() === "") {
			this.classList.remove("is-valid");
			this.classList.add("is-invalid");
			return;
		}
		
		var formData = { code: inputCode };
		$.ajax({
			type: "post",
			data: formData,
			url: "isValidCode",
			dataType: "json",
			success: function(data) {
				let thisElement = document.querySelector("#code");
				if(data === true) {
					// 인증번호 검증 완료되면 valid  추가
					thisElement.classList.remove("is-invalid");
					thisElement.classList.add("is-valid");
					
					// email 및 code input 태그와 sendCode 버튼 비활성화
					$("#email").prop("readonly", true).css({"background-color": "#f0f0f0"});
					$("#code").prop("readonly", true);
					$("#sendCode").attr("disabled", "true").removeClass("btn-info").addClass("btn-outline-secondary").css("color", "");
				}else {
					thisElement.classList.remove("is-valid");
					thisElement.classList.add("is-invalid");
				}
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
	
	// ============= + 버튼 클릭하면 다음 languageSet 보여주기 ============= //
	let maxLanguageSet = 4;
	let countLanguageSet = 2;
	
	$("#addLanguage").on("click", function() {
		if(countLanguageSet <= maxLanguageSet) {
			document.getElementById("languageSet"+countLanguageSet).style.display = "block";
			countLanguageSet++;
		}
	});
	
	// ============= 첫번째 언어(language1, level1)까지 input 태그에 모든 값들이 입력되면 Sign Up 버튼 활성화 ============= //
	document.querySelector("#registerForm").addEventListener("input", checkFormValidity);
	function checkFormValidity() {
		var emailValue = document.getElementById("email").value;
		var codeValue = document.getElementById("code").value;
		var passwordValue = document.getElementById("password").value;
		var password2Value = document.getElementById("password2").value;
		var selectedLanguage = document.getElementsByName("language1")[0].value;
		var selectedLevel = document.querySelector('input[name="level1"]:checked');
		
		if(emailValue && codeValue && passwordValue && password2Value && selectedLanguage && selectedLevel) {
			document.getElementById("register").disabled = false;
		}else {
			document.getElementById("register").disabled = true;
		}		
	}
	
	// ============= Sign Up 클릭하면 폼 데이터 전송하여 회원가입 처리 ============= //
	$("#register").on("click", function() {
		var formData = $("#registerForm").serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "register",
			dataType: "text",
			success: function(data) {
				if(data == "register success") {
					alert("회원가입 완료!");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
	
	
}); // ready
</script>
























