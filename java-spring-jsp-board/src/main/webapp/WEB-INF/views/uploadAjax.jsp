<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	.uploadResult {
	width: 100%;
	background-color: gray;
	}
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img {
		width: 20px;
	}
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	}
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	.bigPicture img {
	  width: 600px;
	}
		
</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<div class="bigPictureWrapper">
		<div class='bigPicture'>
		</div>
	</div>
	
	<div class="uploadDiv"> 
		<input type="file" name="uploadFile" multiple>
	</div>
		<button id="uploadBtn">Upload</button>
	
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>	
	
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" 
		crossorigin="anonymous"></script>
		
<script type="text/javascript">
	
	// 원본 이미지 보여주기
	// a태그에서 직접 showImage()를 호출할 수 있도록 $(document).ready() 밖에 작성
	function showImage(fileCallPath){
		//alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	$(document).ready(function() {
		
		// 파일의 확장자나 크기의 사전 처리
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB
		
		function checkExtension(fileName, fileSize){
			
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		// 목록 보여주기, 파일 아이콘, 이미지 섬네일
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			
			var str = '';
			
			$(uploadResultArr).each(function(i, obj) {
					
					if(!obj.image) {
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/"+obj.uuid+ "_" +obj.fileName);
						
						str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
							   "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
							   "<span data-file=\'"+fileCallPath+"\' data-type='file' > X </span>"+
						       "</div></li>";
					} else {
						// str += "<li>"+obj.fileName+"</li>"
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_"+obj.uuid+ "_" +obj.fileName);
						
						var originPath = obj.uploadPath + "\\"+ obj.uuid+ "_" + obj.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
						       "<img src='/display?fileName="+fileCallPath+"'></a>"+
						       "<span data-file=\'"+fileCallPath+"\' data-type='image' > X </span>"+
						       "</li>";
					}
				});
				uploadResult.append(str);
		}
		
		// 한번 클릭후 이미지 사라지게 하기
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width: "0%", height:"0%"}, 1000);
			setTimeout(() => {
				$(this).hide();
				}, 1000);
		});
		
		// x 클릭
		$(".uploadResult").on("click", "span", function(e){
			
			var clickedSpan = $(this); 
			
			var targetFile = clickedSpan.data("file");
			var type = clickedSpan.data("type");
			console.log(targetFile);
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
			    dataType: 'text',
			    type: 'POST',
			    	success: function(result){
			    		alert(result)
			    		clickedSpan.closest('li').remove();
			    	}
			});
		}); 
		
		
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e) {
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			console.log(files);
			
			// add File Dtata to formData
			for(var i = 0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				  url: '/uploadAjaxAction',
				  processData: false,
				  contentType: false,
				  data: formData,
				  	type: 'post',
				  	dataType: 'json',
					success : function(result) {
						console.log(result);
						
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());
					}
			});
		});
	});
</script>
</body>
</html>