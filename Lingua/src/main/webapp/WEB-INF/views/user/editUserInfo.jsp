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
				<div id="title">회원정보 수정</div>
				<form id="modifyInfoForm">
				
				<div class="form-floating mb-3">
  					<input name="email" class="form-control" id="email" value="${userInfo.email}" readonly style="color:grey">
  					<label for="email">Email</label>
				</div>
				<div class="form-floating mb-3">
  					<input name="nickname" class="form-control" id="nickname" value="${userInfo.nickname}">
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
				
				<div class="mb-3" id="koreanDiv" style="display: none">
					<div class="form-control">Korean</div>
					<input class="form-check-input" type="radio" id="native1" value="native" name="korean">
					<label class="form-check-label" for="native1">native</label>
					<input class="form-check-input" type="radio" id="beginner1" value="beginner" name="korean">
					<label class="form-check-label" for="beginner1">beginner</label>
					<input class="form-check-input" type="radio" id="intermediate1" value="intermediate" name="korean">
					<label class="form-check-label" for="intermediate1">intermediate</label>
					<input class="form-check-input" type="radio" id="advanced1" value="advanced" name="korean">
					<label class="form-check-label" for="advanced1">advanced</label>
				</div>
				<div class="mb-3" id="englishDiv" style="display: none">
					<div class="form-control">English</div>
					<input class="form-check-input" type="radio" id="native2" value="native" name="english">
					<label class="form-check-label" for="native2">native</label>
					<input class="form-check-input" type="radio" id="beginner2" value="beginner" name="english">
					<label class="form-check-label" for="beginner2">beginner</label>
					<input class="form-check-input" type="radio" id="intermediate2" value="intermediate" name="english">
					<label class="form-check-label" for="intermediate2">intermediate</label>
					<input class="form-check-input" type="radio" id="advanced2" value="advanced" name="english">
					<label class="form-check-label" for="advanced2">advanced</label>
				</div>
				<div class="mb-3" id="japaneseDiv" style="display: none">
					<div class="form-control">Japanese</div>
					<input class="form-check-input" type="radio" id="native3" value="native" name="japanese">
					<label class="form-check-label" for="native3">native</label>
					<input class="form-check-input" type="radio" id="beginner3" value="beginner" name="japanese">
					<label class="form-check-label" for="beginner3">beginner</label>
					<input class="form-check-input" type="radio" id="intermediate3" value="intermediate" name="japanese">
					<label class="form-check-label" for="intermediate3">intermediate</label>
					<input class="form-check-input" type="radio" id="advanced3" value="advanced" name="japanese">
					<label class="form-check-label" for="advanced3">advanced</label>
				</div>
				<div class="mb-3" id="polishDiv" style="display: none">
					<div class="form-control">Polish</div>
					<input class="form-check-input" type="radio" id="native4" value="native" name="polish">
					<label class="form-check-label" for="native4">native</label>
					<input class="form-check-input" type="radio" id="beginner4" value="beginner" name="polish">
					<label class="form-check-label" for="beginner4">beginner</label>
					<input class="form-check-input" type="radio" id="intermediate4" value="intermediate" name="polish">
					<label class="form-check-label" for="intermediate4">intermediate</label>
					<input class="form-check-input" type="radio" id="advanced4" value="advanced" name="polish">
					<label class="form-check-label" for="advanced4">advanced</label>
				</div>
				
			  	<div>
			  		<button id="addLanguage" type="button" class="btn btn-outline-secondary" style="display: none">+</button>
			  	</div>
				
				<div class="form-floating">
					<button id="proceedModify" type="button" class="btn btn-primary" disabled>Save Changes</button>
					<button id="delete" type="button" class="btn btn-info" style="color: white;">Delete Account</button>
						<button id="goBack" type="button" class="btn btn-outline-info">Cancel</button>
				</div>
				
				</form>
			</section>
		</div>

	</div>
</body>
</html>

<script>
$(document).ready(function() {
	
	// ============= 각 언어의 값(수준:native,beginner,intermediate,advanced OR null)을 가져와서 변수에 저장 ============= //
	var korean =  "${userInfo.korean}";
	var english = "${userInfo.english}";
	var japanese = "${userInfo.japanese}";
	var polish = "${userInfo.polish}";
	
	// ============= 각 언어가 null 이 아니면 해당 요소(div) 보여주기 ============= //
	if(korean)	{	$("#koreanDiv").css("display","block");		}
	if(english)	{	$("#englishDiv").css("display","block");	}
	if(japanese){	$("#japaneseDiv").css("display","block");	}
	if(polish)	{	$("#polishDiv").css("display","block");		}
	
	// ============= 각 언어의 값에 따라 라디오 버튼 checked 적용 ============= //
	$("input[name='korean'][value='" + korean + "']").prop("checked", true);
	$("input[name='english'][value='" + english + "']").prop("checked", true);
	$("input[name='japanese'][value='" + japanese + "']").prop("checked", true);
	$("input[name='polish'][value='" + polish + "']").prop("checked", true);
	
	
	// ============= + 버튼 클릭하면 다음 languageSet 보여주기 ============= //
// 	let maxLanguageSet = 4;
// 	let countLanguageSet = 0;
// 	if(korean){ countLanguageSet += 1 };
// 	if(english){ countLanguageSet += 1 };
// 	if(japanese){ countLanguageSet += 1 };
// 	if(polish){ countLanguageSet +=1 };
	
// 	if(countLanguageSet <= maxLanguageSet) {
// 		console.log("countLanguageSet : " +countLanguageSet);
// 		$("#maxLanguageSet").css("display","block");
// 	}
	
// 	$("#addLanguage").on("click", function() {
// 		if(countLanguageSet <= maxLanguageSet) {
// 			document.getElementById("languageSet"+countLanguageSet).style.display = "block";
// 			countLanguageSet++;
// 		}
// 	});
	
	// ============= 취소 버튼 클릭 시 뒤로가기 ============= //
	$("#goBack").on("click", function() {
		history.back();
	});
	
	// ============= 비밀번호 유효성 검사 ============= //
	let isPasswordValid = false;
	document.querySelector("#password").addEventListener("input", function() {
		let inputPassword = this.value;
		let passwordRegex = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
		isPasswordValid = passwordRegex.test(inputPassword);
		
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
	
	// ============= 비밀번호까지 input 태그에 모든 값들이 입력되면 Save Changes 버튼 활성화 ============= //
	document.querySelector("#modifyInfoForm").addEventListener("input", checkFormValidity);
	function checkFormValidity() {
		var emailValue = document.getElementById("email").value;
		var nicknameValue = document.getElementById("nickname").value;
		var passwordValue = document.getElementById("password").value;
		var password2Value = document.getElementById("password2").value;
		
		if(emailValue && nicknameValue && passwordValue && password2Value) {
			document.getElementById("proceedModify").disabled = false;
		}else {
			document.getElementById("proceedModify").disabled = true;
		}		
	}
	
	// ============= 회원정보 수정화면에서 저장 버튼 클릭 시 회원정보 수정 처리 후 회원정보 조회화면으로 이동 ============= //
	$("#proceedModify").on("click", function() {
		var formData = $("#modifyInfoForm").serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "editUserInfo",
			dataType: "text",
			success: function(data) {
				if(data == "update success"){
					alert("Update Success!");
					location.href = urlConverter("user/userInfo");
				}
			}
		});
	});
	
	
	// ============= 회원정보 수정화면에서 탈퇴 버튼 클릭 시 회원정보 탈퇴 처리 후 로그인 화면으로 이동 ============= //
	$("#delete").on("click", function() {
		alert("Deleted user account cannot be recovered. Would ou like to proceed?");
		var formData = $("#modifyInfoForm").serialize();
		
		$.ajax({
			type: "post",
			data: formData,
			url: "deleteUser",
			dataType: "text",
			success: function(data) {
				if(data == "delete success"){
					alert("Deleted Successfully!");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
	
	
}); // ready
</script>










