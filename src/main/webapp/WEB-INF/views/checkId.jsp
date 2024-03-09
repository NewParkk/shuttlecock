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
        padding: 10px 20px 10px 20px;
        margin: 20px auto;
        max-width: 400px;
    }
    h3 {
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
        font-size: 15px;
    }
    .container {
        text-align: center;
    }
   .container button {
        width: 100px;
        padding: 5px 10px 5px 10px;
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
    	width: 50%;
        padding: 10px; 
        height: 15px; 
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-top: 10px;
        margin-right: 10px;
    }
    .r-check{
    	display: flex;
    	justify-content: center;
    	margin-bottom: 5px;
    }
</style>
</head>
<body>
    <div class="container"> 
       <h3>아이디 중복 체크</h3>
       <hr>
       <p>
    	<c:choose>
	        <c:when test="${checkButton eq '사용'}">
	            ${message}
	        </c:when>
	        <c:otherwise>
	            <span style="color: red;">${message}</span> 
	        </c:otherwise>
    	</c:choose>
       </p>
       <c:choose>
        <c:when test="${checkButton eq '사용'}">
            <button type="button" onclick="useId('${userId}')">사용</button>
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
    <script type="text/javascript">
    	//체크 표시하기
	    function addSign() {
	        var checkResult = opener.document.getElementById('check-result');
	        checkResult.innerHTML = '&#10004;';
	    }
	    
    	//중복체크한 입력값을 기존 창의 입력란에 넣어주기
	    function useId(userId) {
	        opener.document.getElementById('userId').value = userId;
	        window.close();
	        
	        addSign();//체크 표시하기
	    }
	    
	</script>

</body>
</html>
