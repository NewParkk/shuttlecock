<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<script type="text/javascript"
	src="../resources/ckeditor/build/ckeditor.js"></script>
<head>
<style>
.mainTitle {
	text-align: center;
}

.whyBtn {
	margin-left: 46%;
}

h1 {
	padding-top: 30px;
	padding-bottom: 30px
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 -->
	<%@ include file="../include/header.jsp"%>

	<!-- 붙혀 넣는곳! -->

	<div class="mainTitle">
		<h1>자유게시판</h1>
	</div>
	<form action="<c:url value ='/Freeboard/insertFreeboard'/>"
		method="post" enctype="multipart/form-data">
		<div class="mb-3" style="width: 50%; margin: 0 auto;">
			<label for="exampleFormControlInput1" class="form-label">제목</label> <input
				type="text" class="form-control" name="title"
				id="exampleFormControlInput1">
		</div>
		<div class="mb-3" style="width: 50%; margin: 0 auto;">
			<label for="exampleFormControlInput1" class="form-label">작성자</label>
			<input type="text" class="form-control" name="user_userId"
				value="${login.userId}" id="exampleFormControlInput1">
		</div>
		<div class="mb-3" style="width: 50%; margin: 0 auto;">
			<label for="exampleFormControlTextarea1" class="form-label">내용</label>
			<textarea class="form-control " name="content" id="ckeditor" rows="6"></textarea>
		</div>
		<!-- MultipartFile -->

		<div class="mb-3" style="width: 50%; margin: 0 auto;">
			<!-- <label for="formFileMultiple" class="form-label"></label>
            <input class="form-control" type="file" id="formFileMultiple" name="file">
			<div class="file_input">
				<input type="text" readonly /> <label> 첨부파일 <input
					type="file" name="files" onchange="selectFile(this);" />
				</label>
			</div>
			<button type="button" onclick="removeFile(this);"
				class="btns del_btn">
				<span>삭제</span>
			</button>
			<button type="button" onclick="addFile();" class="btns fn_add_btn">
				<span>파일 추가</span>
			</button>
			-->
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<div class="file_list">
						<div>
							<div class="file_input">
								<input type="text" readonly /> <label> 첨부파일 <input
									type="file" name="files" onchange="selectFile(this);" />
								</label>
							</div>
							<button type="button" onclick="removeFile(this);"
								class="btns del_btn">
								<span>삭제</span>
							</button>
							<button type="button" onclick="addFile();"
								class="btns fn_add_btn">
								<span>파일 추가</span>
							</button>
						</div>
					</div>
				</td>
			</tr>
		</div>


		<button type="button" class="btn btn-primary whyBtn">글 작성</button>
		<button type="button" class="btn btn-primary CancleBtn">취
			&nbsp; 소</button>
	</form>

	<!-- 푸터 -->
	<%@include file="../include/footer.jsp"%>
</body>

<script>
	$(function() {
		$('.whyBtn').click(function() {
			$("form").submit();
		});

		CKEDITOR.replace('ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
			width : '100%',
			height : '400px',
			filebrowserUploadUrl : "fileupload.do"
		});
	});
	
    // 파일 삭제 처리용 익명 함수
    const removeFileId = (function() {
        const ids = [];
        return {
            add(attachmentfileId) {
                if (ids.includes(attachmentfileId)) {
                    return false;
                }
                ids.push(attachmentfileId);
            },
            getAll() {
                return ids;
            }
        }
    }());
	
	// 파일 선택
        // 파일 선택
    function selectFile(element, attachmentfileId) {

        const file = element.files[0];
        const filename = element.closest('.file_input').firstElementChild;

        // 1. 파일 선택 창에서 취소 버튼이 클릭된 경우
        if ( !file ) {
            filename.value = '';
            return false;
        }

        // 2. 파일 크기가 10MB를 초과하는 경우
        const fileSize = Math.floor(file.size / 1024 / 1024);
        if (fileSize > 10) {
            alert('10MB 이하의 파일로 업로드해 주세요.');
            filename.value = '';
            element.value = '';
            return false;
        }

        // 3. 파일명 지정
        filename.value = file.name;

        // 4. 삭제할 파일 id 추가
        if (attachmentfileId) {
            removeFileId.add(attachmentfileId);
        }
    }


    // 파일 추가
    function addFile() {
        const fileDiv = document.createElement('div');
        fileDiv.innerHTML =`
            <div class="file_input">
                <input type="text" readonly />
                <label> 첨부파일
                    <input type="file" name="files" onchange="selectFile(this);" />
                </label>
            </div>
            <button type="button" onclick="removeFile(this);" class="btns del_btn"><span>삭제</span></button>
        `;
        document.querySelector('.file_list').appendChild(fileDiv);
    }


    // 파일 삭제
    function removeFile(element, attachmentfileId) {
        
        // 1. 삭제할 파일 id 추가 
        if (attachmentfileId) {
            removeFileId.add(attachmentfileId);
        }
        
        // 2. 파일 영역 초기화 & 삭제
        const fileAddBtn = element.nextElementSibling;
        if (fileAddBtn) {
            const inputs = element.previousElementSibling.querySelectorAll('input');
            inputs.forEach(input => input.value = '')
            return false;
        }
        element.parentElement.remove();
    }
    
    window.onload = () => {
        renderPostInfo();

        findAllFile();
    }


    // 전체 파일 조회
    function findAllFile() {

        // 1. 신규 등록/수정 체크
        const freeboard = [[ ${freeboard}]];
        if ( !freeboard ) {
            return false;
        }

        // 2. API 호출
        const response = getJson(`/freeboard/${freeboard.freeboard_freeboardId}/files`);

        // 3. 로직 종료
        if ( !response.length ) {
            return false;
        }

        // 4. 업로드 영역 추가
        for (let i = 0, len = (response.length - 1); i < len; i++) {
            addFile();
        }

        // 5. 파일 선택 & 삭제 이벤트 재선언 & 파일명 세팅
        const filenameInputs = document.querySelectorAll('.file_list input[type="text"]');
        filenameInputs.forEach((input, i) => {
            const fileInput = input.nextElementSibling.firstElementChild;
            const fileRemoveBtn = input.parentElement.nextElementSibling;
            fileInput.setAttribute('onchange', `selectFile(this, ${response[i].attachmentfileId})`);
            fileRemoveBtn.setAttribute('onclick', `removeFile(this, ${response[i].attachmentfileId})`);
            input.value = response[i].fileOriginalName;
        })
    }
    
    // 파일 추가
    function addFile() {
        const fileDiv = document.createElement('div');
        fileDiv.innerHTML =`
            <div class="file_input">
                <input type="text" readonly />
                <label> 첨부파일
                    <input type="file" name="files" onchange="selectFile(this);" />
                </label>
            </div>
            <button type="button" onclick="removeFile(this);" class="btns del_btn"><span>삭제</span></button>
        `;
        document.querySelector('.file_list').appendChild(fileDiv);
    }
</script>
</html>