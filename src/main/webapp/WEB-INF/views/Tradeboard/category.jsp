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
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
/* 물품거래소 하위메뉴바(용품) slide*/
$(".menubar > ul > li").mouseover(function(){
    $(this).find(".sub").stop().slideDown(700);
});
$(".menubar > ul > li").mouseout(function(){
    $(this).find(".sub").stop().slideUp(800);
});

/* 하위메뉴바(url)에 따라 title 추가 */
$(document).ready(function() {
//url에서 itemClass 값을 추출
var url = new URLSearchParams(window.location.search);
var itemClass = url.get('itemClass');

//itemClass에 따라 텍스트 설정
var itemClassText = "";
switch(itemClass) {
    case "0":
        itemClassText = "전체";
        break;
    case "1":
        itemClassText = "의류";
        break;
    case "2":
        itemClassText = "라켓";
        break;
    case "3":
        itemClassText = "보호대";
        break;
    case "4":
        itemClassText = "신발";
        break;
    case "5":
        itemClassText = "기타";
        break;
    default:
        itemClassText = "";
}

//해당 itemClass가 일치하는 경우에 텍스트 추가
if (itemClassText) {
    $(".container2 h3").append('<span> &#10095; ' + itemClassText + '</span>');
}
});

</script>
</body>
</html>