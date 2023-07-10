<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html>
<head>
</head>
<body>
	<div id="head-wrapper">
		<p class="fw-bolder">Lingua</p>
		
		<div id="top-memu" align="right">
			<a class="menu-btn" id="main/home">
		    <button type="button" id="main" class="btn btn-light">Home</button>
		    </a>
			<a class="menu-btn" id="main/board">
		    <button type="button" id="board" class="btn btn-dark">Board</button>
		    </a>
			<a class="menu-btn" id="user/user">
		    <button type="button" id="account" class="btn btn-light">My Info</button>
		    </a>
			<a class="menu-btn" id="user/login">
		    <button type="button" id="login" class="btn btn-dark">Login</button>
		    </a>
	    </div>
    </div>
</body>
</html>
<script>
$(document).ready(function() {
	
	$(".menu-btn").click(function() {
		location.href = urlConverter( $(this).attr("id"));
	});
	
	function urlConverter(mappingURL) {
		var urlCheck = window.location.href;
		return "http://" + window.location.host + "/lingua/" + mappingURL;
	}
	
}); // document
</script>
<style>
	a {
		text-decoration: none;
	}
</style>




