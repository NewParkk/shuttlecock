<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShuttleCock</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/main.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light main_navbar">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">ShuttleCock</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="<c:url value='/'/>">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="#">배드민턴이란?</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="#">영상/대회/기사</a>
						</li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
								커뮤니티 </a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<!-- <li><a class="dropdown-item" href="#">영상/대회/기사</a></li> -->
								<li><a class="dropdown-item"
									href="<c:url value ='/recruit/recruitList/'/>">모집게시판</a></li>
								<!-- <li><hr class="dropdown-divider"></li> -->
								<li><a class="dropdown-item"
									href="<c:url value ='/Freeboard/freeList'/>">자유게시판</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value ='/LeagueBoard'/>">리그게시판</a></li>
					</ul>
					<c:choose>
						<c:when test="${login!=null}">
							<div>
								<button type="button" class="btn btn-primary loginBtn">Logout</button>
							</div>
							<div>
								<button type="button" class="btn btn-primary mypageBtn">MyPage</button>
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<button type="button" class="btn btn-primary loginBtn">Login</button>
							</div>
							<div>
								<button type="button" class="btn btn-primary joinBtn">Join</button>
							</div>
						</c:otherwise>
					</c:choose>


				</div>
			</div>
		</nav>
	</header>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
<script>
	// 화면 상단 로그인 버튼 누를시 반응
	$(function() {
		$('.loginBtn').click(function() {
			location.href = '<c:url value="/login"/>';
		});
		$('.joinBtn').click(function() {
			location.href = '<c:url value="/join"/>';
		});
		$('.mypageBtn').click(function() {
			location.href = '<c:url value="/mypage"/>';
		});
	})
</script>
</html>