<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="row" style="margin-top: 50px;">
	<div class="col-lg-12">
		<h1 class="page-header">User Profile</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">User Profile Page</div>
            <!-- /.panel-heading -->
            
            <div class="panel-body">
            	<input type="hidden" name="${_csrf.parameterName}" value="${csrf.token}" />
            	
            	<div class="form-group">
            		<label>Name</label>
            		<input class="form-control" name="userName"
            			   value='<c:out value="${user.userName}"/>' readonly="readonly"/>
            	</div>	
            	<div class="form-group">
            		<label>Id</label>
            		<input class="form-control" name="userid"
            			   value='<c:out value="${user.userid}"/>' readonly="readonly"/>
            	</div>	
            	<div class="form-group">
            		<label>Email</label>
            		<input class="form-control" name="userEmail"
            			   value='<c:out value="${user.userEmail}"/>' readonly="readonly"/>
            	</div>	
            	<div class="form-group">
              		<label>Registration Date</label>
                 	<input class="form-control" name='regDate'
                  		   value='<fmt:formatDate pattern="yyyy-MM-dd" value="${user.regDate }"/>' readonly="readonly">
                </div>
                
                <a href="/user/modify?userid=${user.userid }" class="btn btn-warning">Update</a>
                <a href="/board/list" class="btn btn-info">List</a>
            </div>
            <!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->



<script src="../resources/static/js/page/index.js"></script>

<%@ include file="../layouts/bottom.jsp" %>