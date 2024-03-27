<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
</head>
<body>

	<div class="aside">
		<div class="menubar">
			<ul>
				<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
				<li><a class="list" href="/Tradeboard">물품거래소</a></li>
			</ul>
		</div>
	</div>

</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/mainstyle.css">
<link rel="stylesheet" href="/css/aside.css">
<link rel="stylesheet" href="/css/free.css">
<style>
.menubar > ul > li > ul {
    display: none;
    witdh:90%;
}
.menubar > ul > li > ul > li a {
    display: block;
    padding: 10px;
    background-color: rgba(103, 141, 115, 0.1);
    text-align: center;
    border-bottom: 2px solid #8CB6AB;

}
.menubar > ul > li > ul > li a:hover {
    background-color: #405448;
    color:#fff;
}
</style>
</head>
<body>
	<!-- 물품거래소 하위메뉴 추가 및 픽토그램 추가 -->
	<div class="aside">
		<div class="menubar">
			<ul>
				<li><a class="list" href="/Freeboard/freeList">자유게시판</a></li>
				<li><a class="list" href="/Tradeboard">물품거래소</a>
					 <ul class="sub">
	                    <li><a class="item-div ${pageInfo.pageRequest.itemClass eq 0 ? 'active' : ''}" href="/Tradeboard?itemClass=0">전체</a></li>
						<li><a class="item-div ${pageInfo.pageRequest.itemClass eq 1 ? 'active' : ''}" href="/Tradeboard?itemClass=1">
						<img src="/img/clothes.png" width="30px" height="25px" style="margin-right:5px;">의류</a></li>
						<li><a class="item-div ${pageInfo.pageRequest.itemClass eq 2 ? 'active' : ''}" href="/Tradeboard?itemClass=2">
						<img src="/img/racket.png" width="30px" height="25px" style="margin-right:5px;">라켓</a></li>
                		<li><a class="item-div ${pageInfo.pageRequest.itemClass eq 3 ? 'active' : ''}" href="/Tradeboard?itemClass=3">
                		<img src="/img/guard.png" width="30px" height="25px" style="vertical-align: middle; margin-right:5px;">보호대</a></li>
            			<li><a class="item-div ${pageInfo.pageRequest.itemClass eq 4 ? 'active' : ''}" href="/Tradeboard?itemClass=4">
            			<img src="/img/shoes.png" width="30px" height="25px" style="vertical-align: middle; margin-right:5px;">신발</a></li>
            			<li><a class="item-div ${pageInfo.pageRequest.itemClass eq 5 ? 'active' : ''}" href="/Tradeboard?itemClass=5">기타</a></li>
                	</ul>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>