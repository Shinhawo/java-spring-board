<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


  	<div class="main-content">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12">
				<div class="col-md-4 col-md-offset-4">
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Logout Page</h3>
						</div>
						<div class="panel-body">
							<form role="form" method='post' action="/customLogout">
								<fieldset>
								
								<!-- Change this to a button or input when using this as a form -->
									<a class="btn btn-lg btn-success btn-block">Logout</a>
								</fieldset>
								<input type="hidden" name="${_csrf.parameterName}"
									   value="${_csrf.token}" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="layouts/bottom.jsp" %>

	<!-- jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>
	
	<script type="text/javascript">
	
		$(".btn-success").on("click", function(e){
			
			e.preventDefault();
			$("form").submit();
			
		});
	
	</script>


  <script src="../resources/static/js/page/index.js"></script>
=

