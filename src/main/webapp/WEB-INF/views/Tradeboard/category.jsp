<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#aside {
        position: fixed;
        top: 50%; /* 조절하여 원하는 위치에 맞게 설정하세요 */
        left: 10px; /* 조절하여 원하는 위치에 맞게 설정하세요 */
        transform: translateY(-50%);
        background-color: #f4f4f4;
        padding: 10px;
        border-radius: 5px;
    }
</style>
<body>

<aside id="aside" style="background-color: #f4f4f4; padding: 10px;">
    <ul style="list-style-type: none; padding: 0;">
        <li style="margin-bottom: 10px;">
            <a href="" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">자유게시판</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">모임게시판</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">거래게시판</a>
        </li>
    </ul>
</aside>

</body>
</html>