<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html>
<head>
</head>
<body>
	<div id="head-wrapper">
		<h3>Lingua</h3>
		
		<div id="top-memu" align="right">
			<a class="menu-btn" id="board/home">
		    <button type="button" id="main" class="btn btn-outline-light">Home</button>
		    </a>
			<a class="menu-btn" id="board/list">
		    <button type="button" id="board" class="btn btn-outline-light">Board</button>
		    </a>
			<a class="menu-btn" id="user/userInfo">
		    <button type="button" id="userInfo" class="btn btn-outline-light">My Info</button>
		    </a>
	    </div>
	    
		<h6 id="userNickname">${userInfo.nickname}</h6>
    </div>
</body>
</html>
<script>
$(document).ready(function() {

	$(".menu-btn").click(function() {
		location.href = urlConverter($(this).attr("id"));
	});
	
}); // document
</script>

<style>
	a {
		text-decoration: none;
	}
	
	#userNickname {
		font-size: 15px;
		color: white;
	}
</style>




