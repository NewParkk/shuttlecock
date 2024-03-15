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
                <th>User ID</th>
                <th>Username</th>
                <th>Win Count</th>
                <th>Lose Count</th>
            </tr>
        </thead>
        <tbody>
            <!-- 사용자의 리그 랭킹 정보를 표시합니다. -->
            <c:forEach items="${leagueRanking}" var="user">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.username}</td>
                    <td>${user.wincount}</td>
                    <td>${user.losecount}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>





</body>
</html>