<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
	#main-content {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; /* 화면 전체 높이에 맞게 설정 */
}

	.panel-heading,
	.panel-body {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    text-align: center;
	    flex-direction: column; 
	}
	
</style>

     <div class="row"  id="main-content">
            <div>
                <div class=" panel panel-default login-panel" >
                    <div class="panel-heading">
                        <h2 class="panel-title">Registration Completed!</h2>
                        <h3>가입을 축하합니다 :)</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="/customLogin" class="btn btn-lg btn-success btn-block">Sign In</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    
  	<script src="../resources/static/js/page/index.js"></script>

	<%@ include file="layouts/bottom.jsp" %>




