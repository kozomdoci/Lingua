<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
		
			<section id="wideSection">
				<table>
					<colgroup>
						<col width="5%">
						<col width="5%">
						<col width="15%">
						<col width="30%">
						<col width="25%">
						<col width="20%">
					</colgroup>
					<tr>
						<th>No</th>
						<th>Bno</th>
						<th>Language</th>
						<th>Title</th>
						<th>Written by</th>
						<th>Created</th>
					</tr>
					<c:set var="count" value="1"/>
					<c:forEach items="${boardList}" var="board">
						<tr>
							<td>${count}</td>
							<td>${board.idBoard}</td>
							<td>${board.language}</td>
							
							<td>
<!-- 								수정 전: 제목을 클릭하면 idBoard 값과 writer 값을 가지고 contentView 로 이동 -->
<%-- 							<a href="contentView?idBoard=${board.idBoard}&writer=${board.writer}">${board.title}</a> --%>

<!-- 								수정 후: 제목을 클릭하면 writer 값을 가지고 idBoard(게시글 번호) 로 이동 -->
<%-- 							<a class="move_link" href="${board.idBoard}&writer=${board.writer}">${board.title}</a> --%>

<!-- 								재 수정: 제목을 클릭하면 idBoard(게시글 번호) 로 이동 (쿼리스트링으로 보낼 writer 값은 하단의 자바스크립트에서 처리) -->
								<a class="move_link" href="${board.idBoard}">${board.title}</a>
							</td>
							
							<td>${board.writer_nickname}</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${board.created}"/>
							</td>
						</tr>
						<c:set var="count" value="${count+1}"></c:set>
					</c:forEach>
				</table>
				
				<div class="div_page">
					<ul>
					
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button">
<!-- 							Prev 버튼을 클릭하는 경우 현재 보이는 시작페이지-1 로 링크 연결		 ex> 11 - 1 = 10		ex> 21 - 1 = 20 -->
								<a href="${ pageMaker.startPage -1 }">
									[Prev]
								</a>
							</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button" ${pageMaker.cri.pageNum == num ? "style='background-color:yellow'" : "" }>
<!-- 							페이지 번호를 클릭하면 해당 번호로 링크 연결 -->
								<a href="${num}">
									[${num}]
								</a>
							</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button">
<!-- 							Next 버튼을 클릭하는 경우 현재 보이는 끝페이지+1 로 링크 연결			ex> 10 + 1 = 11			ex> 20 + 1 = 21 -->
								<a href="${ pageMaker.endPage +1 }">
									[Next]
								</a>
							</li>
						</c:if>
					</ul>
				</div>
				<form method="get" id="actionForm">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				</form>
				
			  	<div class="form-floating" style="text-align: right;">
				  	<button id="checkSession" type="button" class="btn btn-warning" style="color: white;">Write</button>
			  	</div>
			  	
			  	
			  	<div class="mb-3 d-flex">
			  		<form method="get" id="searchForm" class="d-flex">
			  			<select name="type" class="form-select me-2">
			  				<option value="" <c:out value="${ pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
			  				<option value="T" <c:out value="${ pageMaker.cri.type == 'T' ? 'selected' : '' }"/>>Title</option>
			  				<option value="C" <c:out value="${ pageMaker.cri.type == 'C' ? 'selected' : '' }"/>>Content</option>
			  				<option value="N" <c:out value="${ pageMaker.cri.type == 'N' ? 'selected' : '' }"/>>Nickname</option>
			  				<option value="E" <c:out value="${ pageMaker.cri.type == 'E' ? 'selected' : '' }"/>>Email</option>
			  				<option value="TC" <c:out value="${ pageMaker.cri.type == 'TC' ? 'selected' : '' }"/>>Title OR Content</option>
			  				<option value="NE" <c:out value="${ pageMaker.cri.type == 'NE' ? 'selected' : '' }"/>>Nickname OR Email </option>
			  			</select>
			  			<input type="text" class="form-control me-2" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
			  			<button type="button" class="btn btn-primary" style="color: white;">Search</button>
			  		</form>
			  	</div>
			  	
			</section>
		</div>
		
	</div>
</body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
$(document).ready(function() {
	
	var actionForm = $("#actionForm");
	
	// ============= 페이지 번호를 클릭 시 페이지 이동 처리 ============= //
	$(".paginate_button a").on("click", function(e) {
		// 기본동작(이벤트: 페이지 링크를 통해서 이동)을 막음
		e.preventDefault();
		
		// 예) 120번 게시글 보기 > 브라우저 뒤로가기 버튼 > 목록 > 페이지 이동하기 위해 다른 페이지 번호 클릭해도 > 또다시 120번이 나타나는 현상(URL에 &idBoard 누적되기 때문에 발생하는 버그)
		// actionForm 의 input 태그 중 name 속성이 idBoard 인 것의 값(value)을 변수에 저장, 변수가 null 이 아니면 idBoard 를 제거
		var idBoard = actionForm.find("input[name='idBoard']").val();
		if(idBoard != '') {
			actionForm.find("input[name='idBoard']").remove();
		}
		
		// 페이지 이동 없이 일단 콘솔에 출력해보기
		console.log("click~!!");
		
		// 페이지 이동 없이 일단 클릭한 페이지 번호를 콘솔에 출력해보기
		console.log("@_@ href ===> " + $(this).attr("href"));
		
		// pageNum 을 name 으로 가진 input 태그를 찾아서 => 그 값(value)를 클릭한 페이지 번호로 치환해주기 
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		// actionForm 을 submit 하여 링크 적용(페이지 번호를 클릭하면 list 로 이동)
		actionForm.attr("action", "list").submit();
	});
	
	// ============= 게시글 제목을 클릭 시 선택한 게시글 보기(contentView)로 이동할 때 pageNum, amount, idBoard, writer 값을 전달 처리 ============= //
	$(".move_link").on("click", function(e) {
		
		// 기본동작(이벤트: a태그의 링크, 즉 idBoard 로 이동)을 막고 콘솔에 찍히는 거 확인
		e.preventDefault();
		console.log("move_link~!!");
		
		// href 속성의 값(idBorad 와 쿼리스트링으로 보내는 writer)을 콘솔에 출력해보기
		// href 속성의 값(idBorad)을 콘솔에 출력해보기(재 수정)
		console.log("@_@ href ===> " + $(this).attr("href"));
		
		// 쿼리스트링으로 보내려던 writer 을 변수에 저장
		var targetWriter = "${board.writer}";
		
		// href 속성의 값(idBoard)를 변수에 저장
		var targetIdBoard = $(this).attr("href");
		
		// 예) 120번 게시글 보기 > 브라우저 뒤로가기 버튼 > 목록 > 115번 게시글 클릭해도 > 또다시 120번이 나타나는 현상(URL에 &idBoard 누적되기 때문에 발생하는 버그)
		// actionForm 의 input 태그 중 name 속성이 idBoard 인 것의 값(value)을 변수에 저장, 변수가 null 이 아니면 idBoard 를 제거
		var idBoard = actionForm.find("input[name='idBoard']").val();
		if(idBoard != '') {
			actionForm.find("input[name='idBoard']").remove();
		}
		
		// actionForm 에 pageNum 과 amount 만 아니라 idBoard 와 writer 도 함께 보내기 위해 append 으로 추가
		actionForm.append("<input type='hidden' name='idBoard' value='" + targetIdBoard + "'>");
		actionForm.append("<input type='hidden' name='writer' value='" + targetWriter + "'>");
		
		// actionForm 을 contentView 로 이동
		// 즉 이때 contentView 로 이동하면서 원래 가져가려던 idBoard, writer 값은 물론 pageNum, amount 값도 가져감
		actionForm.attr("action", "contentView").submit();
	});
	
	
	// ============= 글쓰기 버튼 클릭 시 로그인 세션 확인 (세션 있으면 write 로 이동) ============= //
	$("#checkSession").on("click", function() {
		var formData = $("#actionForm").serialize();
		
		$.ajax({
			type: "get",
			data: formData,
			url: "checkSession",
			dataType: "text",
			success: function(data) {
				if(data == "session found") {
					
					var pageNum = $("#actionForm input[name='pageNum']").val();
					var amount = $("#actionForm input[name='amount']").val();
					location.href = urlConverter("board/write?pageNum="+pageNum+"&amount="+amount);
				}else {
					alert("Please login first.");
					location.href = urlConverter("user/login");
				}
			}
		});
	});
	
	// ============= 검색 버튼을 클릭하면 폼 입력 태그를 submit ============= //
	var searchForm =$("#searchForm");
	
	$("#searchForm button").on("click", function() {
		
		// validation check
		if(!searchForm.find("option:selected").val()) {
			alert("Please choose search condition.");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("Please input keyword.");
			return false;
		}
		
		searchForm.attr("action", "list").submit();
	});
	
	
}); // ready

</script>
<style>
	table {
		table-layout: fixed;
		width: 100%;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid #cccccc;
		padding: 5px;
		text-align: center;
	}
	th {
		background-color: #f0f0f0;
	}
	.div_page ul {
		display: flex;
		list-style: none;
	}
	.div_page {
		display: flex;
		justify-content: center;
		margin-top: 20px;
	}
</style>









