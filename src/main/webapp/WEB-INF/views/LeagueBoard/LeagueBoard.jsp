<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그 게시판</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
.post-preview {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 10px;
	cursor: pointer;
	background-color: #f8f8f8;
	height: 100px;
	overflow: hidden;
}

.post-preview h3, .post-preview p {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.empty-post {
	text-align: center;
	color: #999;
}

#pagination {
	display: flex;
	justify-content: center;
	padding-top: 20px;
}

#pagination a {
	color: #007bff;
	text-decoration: none;
	padding: 5px 10px;
	border: 1px solid #ddd;
	margin: 0 2px;
}

#pagination a:hover {
	background-color: #f8f8f8;
}

#pagination span {
	padding: 5px 10px;
	border: 1px solid #ddd;
	margin: 0 2px;
	background-color: #007bff;
	color: white;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="category.jsp"%>
	<div class="container">
		<form action="/LeagueBoard/search" method="get">
			<select id="dropdown" name="dropdown">
				<option value="user_userId">작성자</option>
				<option value="title">제목</option>
			</select>
			<div class="input-group mb-3">
				<input id="searchKeyword" type="search" name="searchKeyword"
					placeholder="검색어를 입력해주세요."
					value="${pageInfo.pageRequest.searchKeyword}"> <input
					name="pageNum" type="hidden"
					value="${pageInfo.pageRequest.pageNum}"> <input
					name="amount" type="hidden" value="${pageInfo.pageRequest.amount}">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="submit">검색</button>
				</div>
			</div>
		</form>
		<!-- board list area -->
		<div id="board-list">
			<div class="container">
				<span style="font-size: 12pt; float: right; margin-bottom: 10px;">
				</span>
				<table class="board-table">
					<thead>
						<tr>
							<th scope="col" class="th-num">번호</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-user">작성자</th>
							<th scope="col" class="th-date">날짜</th>
							<!-- <th scope="col" class="th-count">조회수</th> -->
						</tr>
					</thead>
					<c:forEach items="${leagueboardList}" var="leagueboard">
						<tbody>
							<tr>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${leagueboard.leagueboardId}</b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b><a
												href="/LeagueBoard/${leagueboard.leagueboardId}">${leagueboard.title}</a></b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${leagueboard.user_userId}</b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b><fmt:formatDate
													value="${leagueboard.regdate}" pattern="yyyy-MM-dd HH:mm" /></b>
										</span>
									</p>
								</td>
								<%-- <td bgcolor="">
						            <p align="center">
						            	<span style="font-size:12pt;">
						             		<b>${leagueboard.hit}</b>
						             	</span>
						             </p>
						        </td> --%>
							</tr>
					</c:forEach>
					</tbody>
				</table>
				<c:if test="${leagueboardList == null}">
					<div class="empty-post">게시물이 없습니다.</div>
				</c:if>
			</div>
		</div>
		<%-- <c:choose>
			<c:when test="${sessionScope.userId == null}">
				<button onclick="redirectToLoginPage()">글쓰기</button>
			</c:when>
			<c:otherwise>
				<button onclick="redirectToInsertForm()">글쓰기</button>
			</c:otherwise>
		</c:choose> --%>
		<button onclick="redirectToInsertForm()">글쓰기</button>
		<div id="pageBtn" style="margin: 10px;">
			<div class="row justify-content-center"
				style="display: flex; justify-content: center;">
				<div class="col-auto">
					<table class="page navigation">
						<tr class="pagination">
							<c:if test="${pageInfo.prev}">
								<th class="page-item"><a class="page-link"
									aria-label="Previous"
									href="/LeagueBoard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Prev</a>
								</th>
							</c:if>
							<c:if test="${pageInfo.pageRequest.category == null}">
							<c:forEach var="num" begin="${pageInfo.startPage}"
								end="${pageInfo.endPage}">
								<th class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
									<a class="page-link" style="padding: 10px;"
									href="/LeagueBoard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
 													">${num}</a>
								</th>
							</c:forEach>
							</c:if>
							<c:if test="${pageInfo.pageRequest.category != null}">
							<c:forEach var="num" begin="${pageInfo.startPage}"
								end="${pageInfo.endPage}">
								<th class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
									<a class="page-link" style="padding: 10px;"
									href="/LeagueBoard/search?pageNum=${num}&amount=${pageInfo.pageRequest.amount}&searchKeyword=${pageInfo.pageRequest.searchKeyword}
									&dropdown=${pageInfo.pageRequest.category}
 													">${num}</a>
								</th>
							</c:forEach>
							</c:if>
							<c:if test="${pageInfo.next}">
								<th class="page-item next"><a class="page-link"
									aria-label="next"
									href="/LeagueBoard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}">Next</a>
								</th>
							</c:if>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		function redirectToInsertForm() {
			window.location.href = "/LeagueBoard/insert";
		}
		function redirectToLoginPage() {
			window.location.href = "/login";
		}
		function checkKeyword(){
			let mainForm = document.getElementById('mainForm');
			// 검색 시 항상 pageNum을 1로 설정
		    mainForm.pageNum.value = 1;
			if(mainForm.searchKeyword.value === null || mainForm.searchKeyword.value === ''){
				mainForm.searchKeyword.remove();
			}
		}    
	</script>
</body>
</html>
