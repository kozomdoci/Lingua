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
				<div id="title">userInfo</div>
			
				<div class="form-floating mb-3">
  					<div class="form-control" id="email">${userInfo.email}</div>
  					<label for="email">Email</label>
				</div>
				<div class="form-floating mb-3">
  					<div class="form-control" id="nickname">${userInfo.nickname}</div>
  					<label for="nickname">Nickname</label>
				</div>
				<div class="form-floating mb-3" id="koreanDiv" style="display: none">
  					<div class="form-control" id="korean">${userInfo.korean}</div>
  					<label for="korean">korean</label>
				</div>
				<div class="form-floating mb-3" id="englishDiv" style="display: none">
  					<div class="form-control" id="english">${userInfo.english}</div>
  					<label for="english">English</label>
				</div>
				<div class="form-floating mb-3" id="japaneseDiv" style="display: none">
  					<div class="form-control" id="japanese">${userInfo.japanese}</div>
  					<label for="japanese">Japanese</label>
				</div>
				<div class="form-floating mb-3" id="polishDiv" style="display: none">
  					<div class="form-control" id="polish">${userInfo.polish}</div>
  					<label for="polish">Polish</label>
				</div>
				
				<div>
					<button id="logOut" type="button" class="btn btn-primary">Sign Out</button>
					<button id="modify" type="button" class="btn btn-info" style="color: white;">Edit Profile</button>
				</div>
				
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
	
	// ============= 로그아웃 버튼 클릭 시 컨트롤러에서 로그아웃 처리하고 성공하는 경우 경고창 보여주고 로그인 화면으로 이동 ============= //
	$("#logOut").on("click", function() {
		$.ajax({
			type: "post",
			url: "logOut",
			dataType: "text",
			success: function(data) {
				if(data == "logout success") {
					alert("Logout Success!");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
	
	//============= 회원정보 수정 버튼 클릭 시 회원정보 수정 화면으로 이동 ============= //
	$("#modify").on("click", function() {
		location.href = urlConverter("user/editUserInfo");
	});
	
}); // ready
</script>










