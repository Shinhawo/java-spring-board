<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>

</style>
	<div class="table-row" >
		<div class="row" style="margin-top: 50px; margin-bottom: 10px;">
		    <div class="col-lg-12">
		        <h1 class="page-header d-flex justify-content-center ">My Reply</h1>
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
		    <div class="col-lg-12">
		        <div class="panel panel-default ">
		        	
		            <!-- /.panel-heading -->
		            <div class="d-flex justify-content-between">
			            <div class="d-flex justify-content-start">
			            	<p style="margin-right: 5px;">전체선택</p>
			            	<input type="checkbox" name="allDelete" style="margin-top:-17px; ">
			            </div>
			            <div >
			            	<button type="submit"
										data-oper="remove" 
										class="btn btn-light"
										style="margin-top:-5px;">삭제</button>	
			            </div>
		            </div>
		            <div class="panel-body" style="margin-top:-10px;">
		                <table width="100%"  class="table table-striped table-bordered table-hover" >
		                    <thead style="background-color: #f2f2f2;">
		                        <tr >
		                            <th class="d-flex justify-content-center align-items-center"><h5>reply</h5></th>
		                        </tr>
		                    </thead>
		                    
		                    <c:forEach items="${replyList}" var="reply">
		                    	<tr >
			                    	<td style="padding-top:15px; padding-bottom:15px; border-bottom: 1px solid black; border-bottom-color: #DCDCDC;">
										<div class="d-flex justify-content-start">
											<div class="checkbox" style="padding-right: 10px;">
												<input type="checkbox" name="deleteCheck"/> 
											</div>
											<div class="replyInfo">
												<div>
													<strong class="primary-font"><c:out value="${reply.reply} "/></strong>
												</div>
												<div>
													<small class="pull-right text-muted"><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.updateDate}"/></small>
												</div>
												<div>
													<a class="move" href='<c:out value="${reply.bno}" />'>
				                    					<c:out value="${reply.board.title}"/> 
				                    				</a> <c:out value="${reply.board.writer} "/>
				                    			</div>									
											</div>
										</div>
			                    	</td>
		                    	</tr>
		                    </c:forEach>
		                </table>
		                <!-- /.table-responsive -->
		                
		                <div >
		                	<div class="pull-right">
	                        <ul class="pagination  d-flex justify-content-center">
	                        <c:if test="${pageMaker.prev}">
	                          <li class="paginate_button previous" aria-label="Previous">
	                            <a class="page-link" href="${pageMaker.startPage - 1 }">
	                              <span aria-hidden="true">&laquo;</span>
	                              <span class="sr-only">Previous</span>
	                            </a>
	                          </li>
	                         </c:if>
	                         
	                         <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	                			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : "" }" >
	                				<a class="page-link" href="${num }" style="margin-left: 5px;">${num }</a>
	                			</li>
	                		 </c:forEach>
	                         
	                        
	                          <c:if test="${pageMaker.next }">
	                			<li class="paginate_button next">
	                				<a class="page-link" href="${pageMaker.endPage + 1 }" aria-label="Next" style="margin-left: 5px;">
	                				  <span aria-hidden="true">&raquo;</span>
		                              <span class="sr-only">Next</span>
		                            </a>
	                			</li>
	                		  </c:if>
	                         
	                        </ul>
		                
	                	<form action="/user/myReply" method="get" id="actionForm">
	                		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
	                		<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
	                		<input type="hidden" name="userid" value="${pageContext.request.userPrincipal.name}" />
	                	</form>
	                </div>
		                <!-- end Pagination -->
		                
		                <!-- Modal 추가 -->
	                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                        <div class="modal-dialog">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <h4 class="modal-title" id="myModalLabel">
	                                    
	                                    </h4>
	                                </div>
	                                <div class="modal-body">
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
		            <!-- /.panel-body -->
		        </div>
		        <!-- /.panel -->
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		
		 $('[name="allDelete"]').change(function(){
	            var isChecked = $(this).is(':checked');
	            // 모든 개별 삭제 체크박스 상태 변경
	            $('[name="deleteCheck"]').prop('checked', isChecked);
	        });
		
		
		// addFlashAttribute()를 통해 일회성으로만 데이터를 사용할 수 있음을 보여주는 예시
		var result = '<c:out value="${result}"/>'
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			
			if (result === '' || history.state ){
				return;
			}
			
			if (result === 'success' || history.state ){
				$(".modal-title").html("게시글 삭제 완료")
				$(".modal-body").html("게시글이 삭제되었습니다.");
			}
			
			if (parseInt(result) > 0) {
				$(".modal-title").html("게시글 등록 완료")
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function(){
			self.location = "/board/register";
		})
		
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {
			
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click", function(e) {
			
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno', value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e) {
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요.");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.attr("action", "/user/mypost");
			e.preventDefault();
			
			searchForm.submit();
		});
	});	
</script>            
            
<script src="../resources/static/js/page/index.js"></script>

<%@ include file="../layouts/bottom.jsp" %>
