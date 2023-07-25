<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html>
<head>
</head>
<body>
	<div id="head-wrapper">
		<h3>Lingua</h3>
		<h6>${userInfo.nickname}</h6>
		
		<div id="top-memu" align="right">
			<a class="menu-btn" id="board/home">
		    <button type="button" id="main" class="btn btn-outline-dark">Home</button>
		    </a>
			<a class="menu-btn" id="board/list">
		    <button type="button" id="board" class="btn btn-outline-dark">Board</button>
		    </a>
			<a class="menu-btn" id="user/userInfo">
		    <button type="button" id="userInfo" class="btn btn-outline-dark">My Info</button>
		    </a>
	    </div>
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
	
	h6 {
		font-size: 15px;
		color: purple;
	}
</style>




