<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래게시판</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 46%;
}

.whyBtn1 {
	margin-left: 69%;
}

.del-btn {
	margin-left: 95%
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}

.paging {
	margin-left: auto;
	margin-right: auto;
	display: table;
}

.whyBtn {
	margin-left: 80%;
	margin-top: 30px;
}

a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

a:active {
	text-decoration: none;
}
/*---검색버튼--- */
.search-wrap {
	overflow: hidden; /*부모요소에 히든 */
	margin-bottom: 20px;
}

.search-btn, .search-input, .search-select {
	float: right; /*우측 플로팅 */
}

.search-input {
	width: 140px;
}

#search-select {
	width: 80px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="category.jsp"%>
	<div class="mainTitle">
		<h1>거래게시판</h1>
	</div>
	<div class="container">
		<form action="/Tradeboard" method="get">
			<div class="search-wrap clearfix">
				<select id="category" name="category"
					style="width: 80px; margin-left: 54%">
					<option value="user_userId">작성자</option>
					<option value="title">제목</option>
					<option value="content">글내용</option>
				</select> <input id="searchKeyword" type="search" name="searchKeyword"
					placeholder="검색어를 입력해주세요."
					value="${pageInfo.pageRequest.searchKeyword}"> <input
					name="pageNum" type="hidden"
					value="${pageInfo.pageRequest.pageNum}"> <input
					name="amount" type="hidden" value="${pageInfo.pageRequest.amount}">
				<input name="region" type="hidden"
					value="${pageInfo.pageRequest.region}">
				<button class="btn btn-primary search-btn" type="submit"
					style="margin-right: 16%">검색</button>
			</div>
		</form>

		<table class="table" style="width: 70%; margin: 0 auto;">
			<thead>
				<tr>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=0">전체</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=1">서울</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=2">경기</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=3">충청</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=4">경상</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=5">전라</a></b>
					</span></th>
					<th scope="col" style="text-align: center;"><span
						style="font-size: 12pt;"> <b><a
								href="/Tradeboard?pageNum=1&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=6">강원</a></b>
					</span></th>
				</tr>
			</thead>
		</table>

		<!-- board list area -->
		<div id="board-list">
			<div class="container">
				<table class="table" style="width: 70%; margin: 0 auto;">
					<thead>
						<tr>
							<th scope="col" style="text-align: center;">글번호</th>
							<th scope="col" style="text-align: center;">제목</th>
							<th scope="col" style="text-align: center;">작성자</th>
							<th scope="col" style="text-align: center;">날짜</th>
							<th scope="col" style="text-align: center;">조회수</th>
							<th scope="col" style="text-align: center;">추천</th>
							<th scope="col" style="text-align: center;">거래여부</th>
						</tr>
					</thead>
					<c:forEach items="${tradeboardList}" var="tradeboard">
						<tbody>
							<tr>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${tradeboard.tradeboardId}</b>
										</span>
									</p>
								</td>
								<c:choose>
									<c:when test="${tradeboard.commentCount != 0}">
										<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b><a
												href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title} [${tradeboard.commentCount}]</a></b>
										</span>
									</p>
								</td>
									</c:when>
									<c:when test="${tradeboard.commentCount == 0}">
										<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b><a
												href="/Tradeboard/${tradeboard.tradeboardId}">${tradeboard.title}</a></b>
										</span>
									</p>
								</td>
									</c:when>
								</c:choose>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${tradeboard.userId}</b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b><fmt:formatDate
													value="${tradeboard.regdate}" pattern="yyyy-MM-dd HH:mm" /></b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${tradeboard.hit}</b>
										</span>
									</p>
								</td>
								<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>${tradeboard.like}</b>
										</span>
									</p>
								</td>
								<c:choose>
									<c:when test="${tradeboard.complete eq 1}">
										<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>판매완료</b>
										</span>
									</p>
								</td>
									</c:when>
									<c:when test="${tradeboard.complete eq 0}">
										<td bgcolor="">
									<p align="center">
										<span style="font-size: 12pt;"> <b>판매중</b>
										</span>
									</p>
								</td>
									</c:when>
								</c:choose>
							</tr>
						</tbody>
					</c:forEach>
				</table>
				<c:if test="${empty tradeboardList}">
					<div class="empty-post" style="text-align: center;">게시물이
						없습니다.</div>
				</c:if>
			</div>
		</div>
		<c:choose>
			<c:when test="${sessionScope.userId == null}">
				<button onclick="redirectToLoginPage()"
					class="btn btn-primary whyBtn">글쓰기</button>
			</c:when>
			<c:otherwise>
				<button onclick="redirectToInsertForm()"
					class="btn btn-primary whyBtn">글쓰기</button>
			</c:otherwise>
		</c:choose>
		<div id="pageBtn" style="margin: 10px;">
			<div class="row justify-content-center"
				style="display: flex; justify-content: center;">
				<div class="col-auto">
					<table class="page navigation">
						<c:choose>
							<c:when
								test="${empty pageInfo.pageRequest.searchKeyword || pageInfo.pageRequest.searchKeyword == ''}">
								<tr class="pagination">
									<c:if test="${pageInfo.prev}">
										<th class="page-item"><a class="page-link"
											aria-label="Previous"
											href="/Tradeboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}&region=${pageInfo.pageRequest.region}">Prev</a>
										</th>
									</c:if>
									<c:forEach var="num" begin="${pageInfo.startPage}"
										end="${pageInfo.endPage}">
										<th class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
											<a class="page-link" style="padding: 10px;"
											href="/Tradeboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}&region=${pageInfo.pageRequest.region}">${num}
										</a>
										</th>
									</c:forEach>
									<c:if test="${pageInfo.next}">
										<th class="page-item next"><a class="page-link"
											aria-label="next"
											href="/Tradeboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}&region=${pageInfo.pageRequest.region}">Next</a>
										</th>
									</c:if>
								</tr>
							</c:when>
							<c:when test="${pageInfo.pageRequest.searchKeyword != null}">
								<tr class="pagination">
									<c:if test="${pageInfo.prev}">
										<th class="page-item"><a class="page-link"
											aria-label="Previous"
											href="/Tradeboard?pageNum=${pageInfo.startPage - 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}">Prev</a>
										</th>
									</c:if>
									<c:forEach var="num" begin="${pageInfo.startPage}"
										end="${pageInfo.endPage}">
										<th class="page-item ${pageInfo.pageRequest.pageNum == num ? "active" : "" } ">
											<a class="page-link" style="padding: 10px;"
											href="/Tradeboard?pageNum=${num}&amount=${pageInfo.pageRequest.amount}
										&searchKeyword=${pageInfo.pageRequest.searchKeyword}
										&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}">${num}
										</a>
										</th>
									</c:forEach>
									<c:if test="${pageInfo.next}">
										<th class="page-item next"><a class="page-link"
											aria-label="next"
											href="/Tradeboard?pageNum=${pageInfo.endPage + 1}&amount=${pageInfo.pageRequest.amount}
													&searchKeyword=${pageInfo.pageRequest.searchKeyword}
													&category=${pageInfo.pageRequest.category}&region=${pageInfo.pageRequest.region}">Next</a>
										</th>
									</c:if>
								</tr>
							</c:when>
						</c:choose>
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
			window.location.href = "/Tradeboard/insert";
		}
		function redirectToLoginPage() {
			window.location.href = "/login";
		}
		function checkKeyword() {
			let mainForm = document.getElementById('mainForm');
			// 검색 시 항상 pageNum을 1로 설정
			mainForm.pageNum.value = 1;
			if (mainForm.searchKeyword.value === null
					|| mainForm.searchKeyword.value === '') {
				mainForm.searchKeyword.remove();
			}
		}
	</script>
</body>
</html>
