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
            <a href="/Tradeboard?itemClass=0" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">전체</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard?itemClass=1" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">의류</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard?itemClass=2" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">라켓</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard?itemClass=3" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">보호대</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard?itemClass=4" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">신발</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/Tradeboard?itemClass=5" style="text-decoration: none; color: #333; font-weight: bold; font-size: 16px; display: block; padding: 8px 16px; border-radius: 5px; transition: background-color 0.3s;">기타</a>
        </li>
    </ul>
</aside>

</body>
</html>