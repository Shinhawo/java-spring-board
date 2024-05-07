<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


	<div class="row" style="margin-top: 50px;">
	    <div class="col-lg-12">
	        <h1 class="page-header">Board Register</h1>
	    </div><!-- /.col-lg-12 -->
	</div><!-- /.row -->
	
	<style>
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
		width: 100px;
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
	</style>
	
	<script>
		$(document).ready(function(e){
			
			var formObj = $("form[role='form']");
			
			$("button[type='submit']").on("click", function(e){
				
				const title = $("input[name = 'title']").val();
				const content = $("textarea[name = 'content']").val();
				
				e.preventDefault();

				if(title === '') {
			          alert("제목을 입력해주세요.");
			          return;
			    }

				if(content === ''){
					alert("내용을 입력해주세요.");
					return;
				}
				
				if(title !== '' && content !== ''){
				
					console.log("submit clicked");
					
					var str = "";
					
					$(".uploadResult ul li").each(function(i, obj) {
						
						var jobj = $(obj);
						console.dir(jobj);
						
						str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
						
					});
					
					formObj.append(str).submit();
					
				}
			});
			
			
			$("button[type='submit']").on("click", function(e){
				
				e.preventDefault();
				
				console.log("submit clicked");
			});
			
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
			
			// 섬네일
			function showUploadResult(uploadResultArr) {
				
				if(!uploadResultArr || uploadResultArr.length == 0){return; }
				
				var uploadUL = $(".uploadResult ul");
				
				var str ="";
				
				$(uploadResultArr).each(function(i, obj) {
					
					// image type
					if(obj.image) {
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_"+obj.uuid+ "_" +obj.fileName);
						
						str += "<li data-path='"+obj.uploadPath+"'"
						str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
						str += "><div>";
						str += "<span>"+obj.fileName+"</span>";
						str += "<button type='button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>";
						str += "<i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					} else {
						// str += "<li>"+obj.fileName+"</li>"
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/"+obj.uuid+ "_" +obj.fileName);
						
						var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li data-path='"+obj.uploadPath+"'"
						str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
						str += "><div>";
						str += "<span>"+obj.fileName+"</span>";
						str += "<button type='button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>";
						str += "<i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/static/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
						
					}
				});
			
				uploadUL.append(str);
			}
			
			
			//delete
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			$(".uploadResult").on("click", "button", function(e){
				
				console.log("delete file");
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type:type},
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
					
				});
			});
			
			
			$("input[type='file']").change(function(e){
				
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				for(var i = 0; i < files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size) ){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url:'/uploadAjaxAction',
					processData: false,
					contentType: false,
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data: formData,
					type: 'POST',
					dataType: 'json',
					success: function(result){
						console.log(result);
						showUploadResult(result); // 업로드 결과 처리 함수
					}
				});
			});
			
		});
	</script>
	

	<div class="row" >
		<div class="col-lg-12">
			<div class="panel panel-default" >
			
				<div class="panel-heading" >Board Register</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					
					<form role="form" action="/board/register" method="post">

						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">						

						<div class="form-group">
							<label>Title</label> <input class="form-control" name='title'>
						</div>
						
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content'></textarea>						
						</div>
						
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name='writer' value="<sec:authentication property='principal.member.userid'/>" readonly="readonly" >
						</div>
						<button type="submit" class="btn btn-defult">Submit</button>						
						<button type="reset" class="btn btn-defult">Reset Button</button>
						
					</form>
					
				</div><!-- /.end panel-body -->
			</div><!-- /.end panel-body -->
		</div><!-- /.end panel -->
	</div><!-- /.row -->	
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				
				<div class="panel-heading">File Attach</div>
				<!-- panel heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple/>
					</div>
				</div>
				
				<div class="uploadResult">
					<ul>
						
					</ul>
				</div>
			</div>
		</div>
	</div>
	            
<script src="../resources/static/js/page/index.js"></script>

<%@ include file="../layouts/bottom.jsp" %>