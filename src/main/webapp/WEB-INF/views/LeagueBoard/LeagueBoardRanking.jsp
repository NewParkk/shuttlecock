<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그 순위</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/css/mainstyle.css">
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
    <h1>리그 순위</h1>
	</div>

      <table>
        <thead>
            <tr>
                <th>유저</th>
                <th>승</th>
                <th>패</th>
                <th>승점</th>
                <th>승률</th>
            </tr>
        </thead>
        <tbody>
            <!-- 사용자의 리그 랭킹 정보를 표시합니다. -->
            <c:forEach items="${leagueRankingList}" var="user">
                <tr>
                	<td>${user.username}</td>
                    <td>${user.wincount}</td>
                    <td>${user.losecount}</td>
                    <td>${user.wincount - user.losecount}</td>
                    <td>${(user.wincount/(user.wincount + user.losecount))*100}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>





</body>
</html>