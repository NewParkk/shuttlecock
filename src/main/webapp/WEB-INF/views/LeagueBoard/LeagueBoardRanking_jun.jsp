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

.RankList {
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
	
	<div class ="RankList">
      <table border = "1">
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
            <!-- leagueRankingList에 있는 각 UserDTO의 정보를 테이블로 출력 -->
            <c:forEach items="${leagueRankingList}" var="user">
            	<c:if test="${user.wincount ne 0 or user.losecount ne 0}">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.wincount}</td>
                    <td>${user.losecount}</td>
                    <td>${user.wincount - user.losecount}</td>
                    <!-- 승률 계산 및 소수점 둘째 자리까지 표시 -->
                    <c:set var="winRatio" value="${(user.wincount * 1.0 / (user.wincount + user.losecount)) * 100}" />
                    <td><fmt:formatNumber value="${winRatio}"  pattern="###.##" />%</td>
                </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
	</div>




</body>
</html>