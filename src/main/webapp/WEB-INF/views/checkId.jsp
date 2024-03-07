<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>아이디 중복 체크</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
    }
    .container {
        background-color: #ffffff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 10px 20px 20px 10px;
        margin: 20px auto;
        max-width: 400px;
    }
    h2 {
        text-align: center;
        color: #333333;
    }
    hr {
        border: 1px solid #cccccc;
        margin-bottom: 20px;
    }
    p {
        text-align: center;
        color: #333333;
        font-size: 18px;
    }
    .container {
        text-align: center;
    }
   .container button {
        width: 100px;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #555;
        color: #fff;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }
    .container input{
    	width: 100%;
        padding: 10px; 
        height: 28px; 
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-top: 10px;
        margin-right: 10px;
    }
    .r-check{
    	display: flex;
    }
</style>
</head>
<body>
    <div class="container"> 
       <h2>아이디 중복 체크</h2>
       <hr>
       <p>${message}</p>
       <c:choose>
        <c:when test="${checkButton eq '사용'}">
            <button type="button" onclick="useId()">사용</button>
        </c:when>
        <c:otherwise>
             <form action="/checkId" method="get">
             	<div class="r-check">
	                <input type="text" id="userId" name="userId" value="${userId}" >
	                <button type="submit">확인</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
    </div>
</body>
</html>