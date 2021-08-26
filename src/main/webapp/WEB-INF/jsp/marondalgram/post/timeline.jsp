<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>marondalgram  - timeline</title>
<!-- bootstrap CDN link -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
  <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/marondalgram/include/header.jsp" />
		<section class="timeline-section d-flex justify-content-center">
			<div class="create-timeline-box">
				<!--  포스트 입력 박스 -->
				<div class="create-post-box p-3 m-2 border rounded">
					<sapn class="title-text"><h5>New Posting</h5></span>
					<textarea class="form-control border-0 non-resize" rows="3" id="contentInput"></textarea>
					<div class="d-flex justify-content-between mt-2">
						<input type="file" accept="image/*" id="fileInput" class="d-none">
						<a href="#" id="imageUploadBtn"><i class="bi bi-file-earmark-image title-text"></i></a>
						<button type="button" class="btn btn-sm" id="saveBtn">업로드</button>
					</div>
				</div>
				<!--  포스트 입력 박스 -->
				
				<!-- 타임라인 -->
				<c:forEach var="post" items="${postList }" varStatus="status">
				<div class="timeline-box p-3 m-2 border rounded""> 
					<div class="d-flex justify-content-between ml-3 mr-2">
						<div class="title-text"><i class="bi bi-person-circle"></i> <b>${post.userName }</b></div>
						<div class="title-text"><i class="bi bi-three-dots"></i></div>
					</div>
					<div class="timeline-img-box mt-2 mx-2">
						<c:if test="${not empty post.imagePath }">
						<img class="image-thumbnail" src="${post.imagePath }" id="imagePath">
						</c:if>
					</div>
					<div class="post-content-box my-2 title-text">
						<div class="mx-3 mb-2 "> ${post.content } </div>
					</div>
					
					<div class="like-comment-box mt-2 mx-3">
						<!-- 좋아요 -->
						<div class="title-text pb-2"><i class="bi bi-suit-heart-fill"></i> 10개</div>
						<!-- /좋아요 -->
						<!-- 코멘트 출력 -->
						<div class="mt-2"> <span class="title-text"><b>아이디</b></span> 코멘트</div>
						<!-- /코멘트 출력 -->
						<!--  코멘트 입력 -->
						<div class="mt-2 d-flex input-group">
							<input type="text" class="commentBox form-control title-text border-0" placeholder="comment" id="commentInput-${post.id }"> 
							<button type="button" class="btn commentBtn" data-post-id="${post.id }">게시</button>
						</div>
						<!--  /코멘트 입력 -->
					</div>
				</div>
				</c:forEach>
				<!-- /타임라인-->
				
			</div>	
		</section>
		<c:import url="/WEB-INF/jsp/marondalgram/include/footer.jsp" />
	</div>
	<script>
	
	// 포스팅 저장
	 $(document).ready(function(){ 
		 
		 $("#saveBtn").on("click", function(){
		 let content = $("#contentInput").val().trim();
		 
		  if(content == null || content ==""){
			  alert("내용을 입력해주세요");
			  return;
		  }
		  // 사진 필수 밸리데이션
		  if($("#fileInput")[0].files.length == 0 ){
			  alert("파일을 선택해 주세요");
			  return;
		  }
		  
		  var formData = new FormData();
		  formData.append("content", content);
		  formData.append("file", $("#fileInput")[0].files[0]);
		  
		  $.ajax({
			  enctype:"multipart/form-data",//파일 업로드 필수
			  type:"POST",
			  url:"/marondalgram/post/create",
			  processData:false,//파일 업로드 필수
			  contentType:false,//파일 업로드 필수
			  data:formData,
			  success:function(data){
				  
				  if(data.result == "success"){
					  alert("포스팅 성공");
					  location.href="/marondalgram/post/timeline";
				  }else{
					  alert("포스팅 실패");
				  }
			  },
			  error:function(e){
				 alert("error"); 
			  }
		  });
		 
		 });
		 
		 
		 // 코멘트 저장
		 $(".commentBtn").on("click",function(){
			
			 var postId = $(this).data("post-id");
			 var comment = $("#commentInput-"+ postId).val().trim(); 

			 if(comment == null || comment ==""){
				 alert("코멘트를 입력하세요");
				 return;
			 }
			 
			 $.ajax({
				type:"get",
				url:"/marondalgram/post/comment/create",
				data:{"postId":postId, "content":comment},
				success:function(data){
					if(data.result == "success"){
						alert("코멘트 입력 성공");
						location.href="/marondalgram/post/timeline";
					}else{
						alert("코멘트 입력 실패");
					}
				},
				error:function(e){
					alert("코멘트 입력 실패");
				}
			 });
		 });
		 
		// 파일 인풋 이미지 클릭 이벤트
		 $("#imageUploadBtn").on("click",function(){
			 $("#fileInput").click();
		 });
		
	 });
	 
	</script>

</body>
</html>