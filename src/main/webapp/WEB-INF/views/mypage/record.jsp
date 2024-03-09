<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form>
  <select id="selectbox" name="selectbox" onchange="chageLangSelect()">
	  <option value="boardList"> 게시물</option>
	  <option value="likeList"> 좋아요</option>
	  <option value="commentList"> 댓글</option>
  </select>
  
	<div id="board" style="display:">
		<c:forEach items="${league}" var="legue">
				<b>${legue.title} ${legue.content}게시판</b>
		</c:forEach>
		<c:forEach items="${free}" var="free">
				<b>${free.title} ${free.content}게시판</b>
		</c:forEach>	
		<c:forEach items="${trade}" var="trade">
				<b>${trade.title} ${trade.content}게시판</b>
		</c:forEach>
		<c:forEach items="${recruit}" var="recruit">
				<b>${recruit.title} ${recruit.content}게시판</b>
		</c:forEach>
	</div>
	
	<div id="comment" style="display:none">
		<c:forEach items="${comment}" var="comment">
				<b>${comment.content}댓글</b>
		</c:forEach>
	</div>
	
	<div id="like" style="display:none">
		<c:forEach items="${like}" var="like">
				<b>${like.title} ${like.content} 좋아요</b>
		</c:forEach>
	</div>
</form>
	
<!-- 	//1. onchange 속성 select change 발생event -> function
	//2. function -> select -> selected -> test2 -> likeid -> div display / display:none -->
<script>
function chageLangSelect(){
    var langSelect  = document.getElementById("selectbox");
    
    var selectValue = langSelect.options[langSelect.selectedIndex].value;
    var board = document.getElementById("board").getAttribute('id');
 	var comment = document.getElementById("comment").getAttribute('id'); 
    var like = document.getElementById("like").getAttribute('id');
    
    console.log(selectValue);
    
  	if(selectValue == "boardList"){
    document.getElementById("board").style.display= "block";
 	document.getElementById("like").style.display= "none";
    document.getElementById("comment").style.display= "none"; 
 	
 	}else if(selectValue == "commentList"){
	    document.getElementById("comment").style.display= "block";
	 	document.getElementById("like").style.display= "none";
	    document.getElementById("board").style.display= "none";

 	}else if(selectValue == "likeList"){
	 	document.getElementById("like").style.display= "block";
	    document.getElementById("comment").style.display= "none";
	    document.getElementById("board").style.display= "none";
 	}else{
	 	document.getElementById("like").style.display= "none";
	    document.getElementById("comment").style.display= "none";
	    document.getElementById("board").style.display= "none";
 	} 
/*  	console.log( document.getElementById("board").style.display);
	console.log( document.getElementById("like").style.display);
	console.log( document.getElementById("comment").style.display);
 */  	
/*   	if(selectValue = "boardList"){
  		
  	    document.getElementById("board").style.display = "block";
  	 	document.getElementById("like").style.display = "none";
  	    document.getElementById("comment").style.display = "none"; 
  	}	
  	else if(selectValue = "commentList"){
		    document.getElementById("comment").style.display= "block";
		 	document.getElementById("like").style.display= "none";
		    document.getElementById("board").style.display= "none";

  	 }
  	else if(selectValue = "likeList"){
  		 	document.getElementById("like").style.display= "block";
  		    document.getElementById("comment").style.display= "none";
  		    document.getElementById("board").style.display= "none";
	 } */
  
	
/*    	if(selectValue != "commentList"){
	    document.getElementById("comment").style.display= "none";
 	    document.getElementById("board").style.display= "block";
	    document.getElementById("board").style.display= "block";
	} 
	
 	if(selectValue != "likeList"){
	    document.getElementById("like").style.display= "none";
  	    document.getElementById("board").style.display= "block";
	    document.getElementById("comment").style.display= "block";  
	}  
 	
 	if(selectValue != "boardList"){
 	    document.getElementById("board").style.display= "none";
  	 	document.getElementById("like").style.display= "block";
 	    document.getElementById("comment").style.display= "block";  
 	 	
 	} */ 
 	
/*   	if(selectValue = "commentList"){
	    document.getElementById("comment").style.display= "block";
	} 
	
 	if(selectValue = "likeList"){
	    document.getElementById("like").style.display= "block";
	}  
 	
 	if(selectValue = "boardList"){
 	    document.getElementById("board").style.display= "block";
 	}  */
 	
	
}
</script>
</body>
</html>