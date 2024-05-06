<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="layouts/top.jsp" %>

    <div class="main-content">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12">
				<h1>Custom Login Page</h1>
				<h2><c:out value="${error}" /></h2>
				<h2><c:out value="${logout}" /></h2>
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                    
						<!-- 반드시 post 방식으로 /login 에 전송 -->
						<form role="form" method="post" action="/login">
                            <fieldset>
                                <img alt="카카오로그인" src="/resources/img/kakao_login_medium_narrow.png" onclick="loginWithKakao()" style="margin-bottom:10px;">
                                <div class="form-group">
                                    <input class="form-control" placeholder="userid" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                </div>
                                <div class="checkbox" style="text-align:left;">
                                    <label>
                                        <input name="remember-me" type="checkbox" value="Remember Me">Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a class="btn btn-lg btn-success btn-block">Sign In</a>
                                <a href="/userRegister" class="btn btn-lg btn-primary btn-block">Sign Up</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                        </form>
						
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<%@ include file="layouts/bottom.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>
    
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
    
    <script type="text/javascript">
    	
	    $(document).ready(function(){
	    	Kakao.init('c632e16ffcd30fc6203dd76a1da1ebd0');
	        Kakao.isInitialized();
	    });
	
	    function loginWithKakao() {
	        Kakao.Auth.authorize({ 
	        redirectUri: 'http://localhost:8080/kakao/callback' 
	        }); // 등록한 리다이렉트uri 입력
	    }
	    
	    $(".btn-success").on("click", function(e) {
	    	
	    	e.preventDefault();
	    	$("form").submit();
	    	
	    });
    </script>



  <script src="../resources/static/js/page/index.js"></script>
