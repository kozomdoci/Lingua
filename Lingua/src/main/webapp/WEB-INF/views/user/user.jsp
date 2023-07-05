<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>
	<style type="text/css">
		#container {
			display: grid;
			grid-template-areas:
				"top top top"
				"left main right"
				"bottom bottom bottom";
			grid-template-columns: auto 3fr auto;
			grid-template-rows: auto 3fr auto;
			grid-gap: 10px;
			min-height: 95vh;
		}
		
		#top    {	grid-area: top;		}
		#left   {	grid-area: left;	}
		#right  {	grid-area: right;	}
		#bottom {	grid-area: bottom;	}
		#main   {	grid-area: main;	}
	</style>
</head>
<body>
	<div id="container">
		<div id="top"><%@ include file="../module/top.jsp" %></div>
		<div id="left"><%@ include file="../module/left.jsp" %></div>
		<div id="right"><%@ include file="../module/right.jsp" %></div>
		<div id="bottom"><%@ include file="../module/bottom.jsp" %></div>
		<div id="main">user.jsp 입니다.</div>
	</div>
</body>
</html>





