<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>

</style>
	<div class="table-row" >
		<div class="row" style="margin-top: 50px;">
		    <div class="col-lg-12">
		        <h1 class="page-header">Tables</h1>
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
		    <div class="col-lg-12">
		        <div class="panel panel-default ">
		        	<div class="table-header d-flex justify-content-between" style="margin-bottom: 10px; margin-top: 10px;">
			            <div class="search-box ">
			            	<form id="searchForm" action="/board/list" method="get" >
			            		<select name='type' style=" font-size: 16px; padding: 5px; border-radius: 5px">
			            			<option value='' <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>--</option>
			            			<option value='T' <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
			            			<option value='C' <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>내용</option>
			            			<option value='W' <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
			            			<option value='TC' <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
			            			<option value='TW' <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
			            			<option value='CW' <c:out value="${pageMaker.cri.type eq 'CW' ? 'selected' : ''}"/>>내용 or 작성자</option>
			            			<option value='TCW' <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : ''}"/>>전체</option>
			            		</select>
								<input type="text" name="keyword" 
									   style="border-radius: 5px; height: 30px;"
									   value='<c:out value="${pageMaker.cri.keyword }"/>' />
								<input type="hidden" name="pageNum" 
									   value='<c:out value="${pageMaker.cri.pageNum }"/>' />            		
								<input type="hidden" name="amount" 
									   value='<c:out value="${pageMaker.cri.amount }"/>' />
								<button class="btn btn-default">Search</button>	            		
			            	</form>
			            </div>
			            
			            <div class="panel-heading"> Board List Page
			                <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
			            </div>
		        	</div>
		            <!-- /.panel-heading -->
		            <div class="panel-body" >
		                <table width="100%"  class="table table-striped table-bordered table-hover" >
		                    <thead style="background-color: #f2f2f2;">
		                        <tr >
		                            <th>#번호</th>
		                            <th>제목</th>
		                            <th>작성자</th>
		                            <th>작성일</th>
		                            <th>수정일</th>
		                        </tr>
		                    </thead>
		                    
		                    <c:forEach items="${list}" var="board">
		                    	<tr >
			                    	<td><c:out value="${board.bno} "/></td>
			                    	<!-- 
			                    	 <td><a href='/board/get?bno=<c:out value="${board.bno} "/>'><c:out value="${board.title} "/></a></td>
			                    	 -->
			                    	<td>
			                    		<a class="move" href='<c:out value="${board.bno }" />'>
			                    			<c:out value="${board.title} "/> 
			                    			<b>[	<c:out value="${board.replyCnt}" />	]</b>
			                    		</a>
			                    	</td>
		    	                	<td><c:out value="${board.writer} "/></td>
		                    		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
		                    		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
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
		                
	                	<form action="/board/list" method="get" id="actionForm">
	                		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
	                		<input type="hidden" name="amount" value="${pageMaker.cri.amount }" />
	                		<input type="hidden" name="type" value="${pageMaker.cri.type }" />
	                		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }" />
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
			e.preventDefault();
			
			searchForm.submit();
		});
	});	
</script>            
            
<script src="../resources/static/js/page/index.js"></script>

<%@ include file="../layouts/bottom.jsp" %>
