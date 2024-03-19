<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vertical Card Layout</title>
<style>
.card-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
}

.card {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: 10px;
	width: 300px;
	max-width: 80%;
}

.card img {
	width: 100%;
	border-radius: 8px;
	margin-bottom: 10px;
}

.card h2 {
	margin-top: 0;
	margin-bottom: 10px;
}

.card p {
	margin-top: 0;
}
</style>
</head>
<body>

	<div class="card-container">
		<div class="card">
			<span>이름</span> <span>이미지</span> <span>승</span>
		</div>

		<div class="card">
			<p>This is a sample description for Card 2.</p>
		</div>

		<div class="card">
			<p>This is a sample description for Card 2.</p>
		</div>
	</div>

</body>
</html>
