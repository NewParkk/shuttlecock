<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디/비밀번호 찾기</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
    }
    .tab_content {
        overflow: hidden;
        background-color: #f1f1f1;
        width: 400px;
        border-radius: 5px;
        margin: 0 auto;
    }
    .tab_content label.find-label {
        background-color: inherit;
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 10px 2px 10px 2px;
        transition: 0.3s;
        border-radius: 5px;
        display: inline-block;
        text-align: center;
    }
    .tab_content label.find-label:hover {
        background-color: #ddd;
    }
    .tab_content input[type="radio"] {
        display: none;
    }
    .tab_content input[type="radio"]:checked + label {
        background-color: #555;
        color: white;
    }
    .form-container {
        max-width: 400px;
        margin: 42px auto; /* Adjusted margin to create space from top */
        padding: 20px 0 20px 0;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h3 {
        text-align: center; /* Center aligning h3 */
        color: #333;
        margin-top: 0; /* Removing default top margin */
    }
    form {
        margin-top: 20px;
    }
    label.find-label {
        display: inline-block;
        width: 30%;
        text-align: center;
    }
    .container {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    .container label {
        width: 20%;
        text-align: right;
        margin-right: 20px;
    }
    input[type="text"],
    input[type="email"] {
        width: calc(80% - 50px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }
    .button-container {
        text-align: center;
    }
    button[type="submit"] {
        width: 50%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #555;
        color: #fff;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 15px;
    }
    .message {
        text-align: center;
        margin-top: 20px;
        font-weight: bold;
    }
</style>
</head>
<body>

<div class="tab_content">
    <input type="radio" name="tabmenu" id="tab_id" checked>
    <label for="tab_id" class="find-label" onclick="openTab('findIdSearch')">아이디 찾기</label>
    <input type="radio" name="tabmenu" id="tab_pw">
    <label for="tab_pw" class="find-label" onclick="openTab('findPwSearch')">비밀번호 찾기</label>


    <div id="findIdSearch" class="form-container">
        <h3>아이디 찾기</h3>
        <form action="/findIdSearch" method="post">
            <div class="container">
                <label for="username">이름</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="container">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" required>
            </div>
            <div class="button-container">
                <button type="submit">아이디 찾기</button>
            </div>
            <div class="message" id="message">
			    <c:choose>
			        <c:when test="${not empty findUserId}">
			            회원님의 아이디는 [ ${findUserId} ]입니다.
			        </c:when>
			        <c:otherwise>
			            ${message}
			        </c:otherwise>
			    </c:choose>
			</div>
        </form>
    </div>

    <div id="findPwSearch" class="form-container" style="display: none;">
        <h3>비밀번호 찾기</h3>
        <form action="/findPwSearch" method="post">
            <div class="container">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="container">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" required>
            </div>
            <div class="button-container">
                <button type="submit">비밀번호 찾기</button>
            </div>
        </form>
    </div>
</div>
<script>
    function openTab(tabName) {
        var tabcontent = document.getElementsByClassName("form-container");
        for (var i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        document.getElementById(tabName).style.display = "block";
    }
</script>

</body>
</html>
