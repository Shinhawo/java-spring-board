<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- Reply Modal 추가 -->
     <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                 </div>
                 <div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" name="reply" value='New Reply!!!!' />
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<input class="form-control" name="replyer" value='replyer' readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>Reply Date</label>
						<input class="form-control" name="replyDate" value='' />
					</div>
                 </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-warning" id="modalModBtn">Modify</button>
                     <button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
                     <button type="button" class="btn btn-primary" id="modalRegisterBtn">Register</button>
                     <button type="button" class="btn btn-default" id="modalCloseBtn" data-dismiss="modal">Close</button>
                 </div>
             </div>
             <!-- /.modal-content -->
          </div>
       	<!-- /.modal-dialog -->
      </div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>	
	
<script type="text/javascript">
	$(document).ready(function(){
		
		console.log("================");
		console.log("JS TEST");
		
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum/10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0)
			}
			
			if(endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item "+active+"'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>"
			}
			
			for(var i = startNum ; i <= endNum; i++){
				
				var active = pageNum == i? "active" :"";
				
				str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>"
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		
		var bnoValue= '<c:out value="${board.bno}"/>';
		var replyUl = $(".chat");
		
		// 페이지 번호를 파라미터로 받고 만일 파라미터가 없는 경우 자동으로 1페이지가 되도록 설정
		showList(-1);
		function showList(page){
			
			console.log("show list : " + page);
			
			replyService.getList({bno:bnoValue,page: page|| 1}, function(replyCnt, list) {
				
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				console.log(list);
				
				if (page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";
				if(list == null || list.length == 0){
					replyUl.html("");
					return;				
				}
				for (var i = 0, len = list.length || 0; i < len; i++){
					str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str += "	<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "		<small class='pull-right text-muted'>"+replyService.displayTime(list[i].updateDate)+"</small></div>";
					str += "		<p>"+list[i].reply+"</p></div></li>";	
				}
				
				replyUl.html(str);
				
				showReplyPage(replyCnt);
			});
		}
		
		
		var modal = $("#myModal2");
		var modalInputReply = modal.find("input[name='reply']")
		var modalInputReplyer = modal.find("input[name='replyer']")
		var modalInputReplyDate = modal.find("input[name='replyDate']")
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		var replyer = null;
		
		<sec:authorize access="isAuthenticated()" > 
			replyer = '<sec:authentication property="principal.username"/>'
		</sec:authorize>
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";	
		
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$("#myModal2").modal("show");
		});

		// Ajax spring security header..
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
			
			replyService.add(reply, function(result) {
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1);
			});
		});
		
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer).attr("readonly", "readonly");
				modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$("#myModal2").modal("show");
			});
		});
		
		modalModBtn.on("click", function(e){
			
			var originalReplyer = modalInputReplyer.val();
			
			var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val(),
					replyer : originalReplyer
			};
			
			if(!replyer){
				alert("로그인후 수정이 가능합니다.")
				modal.modal("hide");
				return;
			}
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 수정이 가능합니다.")
				modal.modal("hide");
				return;
			}
			
			replyService.update(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
				console.log(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			var originalReplyer = modalInputReplyer.val();
			
			if(!replyer){
				alert("로그인후 삭제가 가능합니다.")
				modal.modal("hide");
				return;
			}
			
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.")
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		
		
		var result = '<c:out value="${result}"/>'
		var bno = $("#bno").val();		
		var operForm = $("#operForm");
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			
			if (result === '' || history.state ){
				return;
			}
			
			if (result === 'success') {
				$("#modal-body").html("게시글 " + bno + "번이 수정되었습니다.");
			}
			$("#myModal").modal("show");
			}
			
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
		
		(function() {
			
			var bno = '<c:out value="${board.bno}" />';
			
			$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
				
				console.log(arr);
				
				var str ="";
				
				$(arr).each(function(i, attach){
					
					//image type
					if(attach.fileType){
						var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_"+attach.uuid+ "_" +attach.fileName);
						
						var originPath = attach.uploadPath + "\\"+ attach.uuid+ "_" + attach.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g),"/");	
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					} else {
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
						str += "<span>"+attach.fileName+"</span><br/>";
						str += "<img src='/resources/static/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
				
			}); // end getJSON
			
			$(".uploadResult").on("click", "li", function(e) {
				
				console.log("view image");
				
				var liObj = $(this);
				
				var path = encodeURIComponent(liObj.data("path")+ "/" +liObj.data("uuid")+ "_" +liObj.data("filename"));
				
				if(liObj.data("type")){
					showImage(path.replace(new RegExp(/\\/g),"/"));
				} else {
					//download
					self.location="/download?fileName="+path
				}
				
			}); // click function end
			
			function showImage(fileCallPath){
				
				alert(fileCallPath);
				
				$(".bigPictureWrapper").css("display", "flex").show();
				
				$(".bigPicture")
				.html("<img src='/display?fileName="+fileCallPath+"'>")
				.animate({width: '100%', height: '100%'}, 1000);
			
			}// showImage end
			
			$(".bigPictureWrapper").on("click", function(e) {
				$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
				setTimeout(function() {
					$('.bigPictureWrapper').hide();
				}, 1000);
				
			}); // click end
			
		})();
	});	
</script>
<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
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
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
.bigPicture img {
  width:600px;
}
</style>

	<div class="row"  style="margin-top: 50px;">
	    <div class="col-lg-12">
	        <h1 class="page-header">Board Read</h1>
	    </div>
	    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default" >
			
				<div class="panel-heading">Board Read Page</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					
						<div class="form-group">
							<label>Bno</label> 
							<input class="form-control" name='bno' id="bno" value="<c:out value='${board.bno} '/>" readonly="readonly">
						</div>
		
						<div class="form-group">
							<label>Title</label> 
							<input class="form-control" name='title' value="<c:out value='${board.title} '/>" readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value='${board.content} '/></textarea>						
						</div>
						
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name='writer' value="<c:out value='${board.writer} '/>" readonly="readonly">
						</div>
						<!-- 
						<button data-oper="modify" 
								class="btn btn-defult"
								onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>' ">Modify</button>						
						<button data-oper="list" 
								class="btn btn-defult"
								onclick="location.href='/board/list' ">List</button>		
										
						 -->
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq board.writer }">
								<button data-oper="modify" class="btn btn-defult">Modify</button>						
							</c:if>
						</sec:authorize>
						
						<button data-oper="list" class="btn btn-defult">List</button>	
						
						<form id="operForm" action="/board/modify" method="get">
							<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'/>
							<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'/>
							<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'/>
							<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>'/>
							<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'/>
						</form>
					
						<!-- Modal 추가 -->
	                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                        <div class="modal-dialog">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	                                </div>
	                                <div class="modal-body" id="modal-body">
										처리가 완료되었습니다.
	                                </div>
	                                <div class="modal-footer">
	                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                                    <button type="button" class="btn btn-primary">Save changes</button>
	                                </div>
	                            </div>
	                            <!-- /.modal-content -->
	                        </div>
	                        <!-- /.modal-dialog -->
	                    </div>
	                    <!-- /.modal -->	
				</div>
				<!-- /.end panel-body -->
			</div>
			<!-- /.end panel-body -->
		</div>
		
		<div class="bigPictureWrapper">
			<div class="bigPicture">
			</div>
		</div>
		
		<div class="col-lg-12">
			 <div class="panel panel-default">
		      <div class="panel-heading">Files</div><!-- /.panel-heading -->
		      <div class="panel-body">
		        <div class='uploadResult'> 
		          <ul>
		          </ul>
		        </div>
		      </div><!--  end panel-body -->
		    </div><!--  end panel-body -->
		</div>
		<!-- /.end panel -->
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply
					<sec:authorize access="isAuthenticated()">
						<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
					</sec:authorize>
				</div>
				
				<div class="panel-body">
				
					<ul class="chat">
						<li class="left clearfix" data-rno='12'>
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong>
									<small class="pull-right text-muted">2024-02-28 00:47</small>
								</div>
								<p>Good job!</p>
							</div>
						</li>
					</ul>
				</div>
				
				<div class="panel-footer">
				</div>
		
			</div>
		</div>
		
	</div>
	<!-- /.row -->	
    
<script src="../resources/static/js/page/index.js"></script>

<%@ include file="../layouts/bottom.jsp" %>
















            
            	            
