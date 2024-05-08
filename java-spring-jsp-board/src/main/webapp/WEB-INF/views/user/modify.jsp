<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="row" style="margin-top: 50px;">
	<div class="col-lg-12">
	    <h1 class="page-header">Update Profile</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
  <div class="row">
      <div class="col-lg-12">
          <div class="panel panel-default">
              <div class="panel-heading">Update Profile Page</div>
              <!-- /.panel-heading -->
              <div class="panel-body">
              	<form role="form" action="/user/update" method="post"> <!-- action="/user/update" method="post" -->
              		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
              		<input type="hidden" name="oriEmail" value="${user.userEmail }" />
              	
              		<div class="form-group">
              			<label>Name</label>
              			<input class="form-control" name='userName' placeholder="이름을 입력하세요."
              			value='<c:out value="${user.userName }"/>' readonly>
               		<div id="name-error-text" class="alert"></div>
              		</div>
              		
              		<div class="form-group">
              			<label>Id</label>
              			<input class="form-control" name='userid' maxlength="12" placeholder="영문,숫자 조합(8~12자)"
              			value='<c:out value="${user.userid }"></c:out>' readonly>
                      	<div id="id-error-text" class="alert"></div>	
              		</div>
              		
              		
              		
              		<div class="form-group">
              			<label>Email</label>
              			<input class="form-control" name='userEmail' maxlength="50" placeholder="name@example.com">
               		<button id="btnCheckEmail" type="button" class="btn btn-xs pull-right btn-danger" style="display: block; margin-top: 10px;">중복체크</button>
               		<button id="btnAuthMail" type="button" class="btn btn-xs pull-right btn-info" style="display: none; margin-top: 10px; margin-right: 10px;">인증번호</button>
               		<div id="email-error-text" class="alert"></div>
              		</div>
              		
              		<!-- 인증번호 -->
                   <div id="auth-number" class="form-group" style="display: none;">
                       <div class="line col">
                           <input id="userAuth" name="code" maxlength="8" type="text" class="form-control" placeholder="인증번호를 입력하세요" autocomplete="off">
                       </div>
                       <button id="btnConfirm" type="button" class="btn btn-xs pull-right btn-info" style="margin-top: 10px;">인증하기</button>
                       <div id="mail-check-warn" class="alert"></div>
                   </div>
              		
              		
              		<div class="form-group">
              			<label>Password</label>
              			<input class="form-control" name='userpw' maxlength="16" type="password" placeholder="영문 대 소문자,숫자 8자~16자">
              			<div id="password-error-text" class="alert"></div>
              		</div>
              		
              		<div class="form-group">
              			<label>Check Password</label>
              			<input class="form-control" id="checkPw" name='repassword' type="password" minlength="" maxlength="16" type="repassword" placeholder="비밀번호를 확인하세요.">
              			<div id="re-password-error-text" class="alert"></div>
              		</div>
              		
             			<button type="submit" class="btn btn-warning">Update</button>
             			<a href="/board/list" class="btn btn-info">List</a>
             			<a id="" class="btn btn-xs pull-right btn-danger" style="margin-top: 10px;">Delete Account</a>
              	</form>
              </div>
              <!-- /.panel-body -->
          </div>
          <!-- /.panel -->
      </div>
      <!-- /.col-lg-6 -->
  </div>
  <!-- /.row -->

<%@include file="../layouts/bottom.jsp" %>

<script type="text/javascript">

	const $name = $("form input[name ='userName']");
	const $id = $("form input[name ='userid']");
	const $pw = $("form input[name ='userpw']");
	const $email = $("form input[name ='userEmail']");
	const $auth = $("#userAuth");
	
	let idCheck = false;
	let passwordCheck = false;
	let nameCheck = false;
	let emailCheck = false;
	let authCheck = false;
	
	// input 새로운 값 입력 시 기존 검증 결과 초기화
	//$id.keyup(() => idCheck = false);
	$email.keyup(() => emailCheck = false);
	$auth.keyup(() => authCheck = false);
	
	// 이메일 인증번호 요청 버튼 클릭 이벤트
	$("#btnAuthMail").click(() => sendNumber());
	// 인증번호 확인 클릭 이벤트
	$("#btnConfirm").click(() => checkNumber());
	
	// 아이디, 이메일 중복 확인 버튼 클릭 이벤트
	//$("#btnCheckId").click(() => checkId());
	$("#btnCheckEmail").click(() => checkEmail());
	
	// 비밀번호 입력 시 값 검증 이벤트
	$("input[name=userpw],input[name=repassword]").keyup(() => {
	    const $password = $("form input[name='userpw']");
	    const $repassword = $("form input[name='repassword']");
	    const pwdReg = /(?=.*[0-9])(?=.*[a-zA-Z])(?=\S+$).{8,16}/;
	
	    // 비밀번호랑 비밀번호 확인 둘다 따로따로 체크해서 해당하는 오류 메세지
	    // Validation check (길이, 특수 문자 포함 여부)
	    if (!$password.val()) {
	        $("#password-error-text").text("비밀번호를 입력해주세요.").css('color', 'red');
	        passwordCheck = false;
	        return;
	    } else if (!pwdReg.test($password.val())) {
	        $("#password-error-text").text("비밀번호는 8자~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.").css('color', 'red');
	        passwordCheck = false;
	        return;
	    } else {
	        $("#password-error-text").text("올바른 비밀번호 형식입니다.").css('color', 'green');
	    }
	
	    if (!$repassword.val()) {
	        $("#re-password-error-text").text("비밀번호를 확인해주세요.").css('color', 'red');
	        passwordCheck = false;
	    }
	
	    if ($repassword.val() !== $password.val()) {
	        $("#re-password-error-text").text("입력한 비밀번호가 일치하지 않습니다.").css('color', 'red');
	        passwordCheck = false;
	    } else {
	        $("#re-password-error-text").text("비밀번호가 일치합니다.").css('color', 'green');
	    }
	});
	
	// 이메일 입력 시 검증 이벤트
	$("input[name=userEmail]").keyup(() => {
	    const $email = $("form input[name='userEmail']");
	    const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	    if (!$email.val()) {
	        $("#email-error-text").text("이메일을 입력하세요.").css('color', 'red');
	        $("#btnCheckEmail").show();
	        $("#btnAuthMail").hide();
	
	        return false;
	    } else if (!emailReg.test($email.val())) {
	        $("#email-error-text").text("이메일 형식에 올바르지 않습니다.").css('color', 'red');
	        $("#btnCheckEmail").show();
	        $("#btnAuthMail").hide();
	
	        return false;
	    } else {
	        $("#email-error-text").text("올바른 이메일 형식입니다.").css('color', 'green');
	        $("#btnCheckMail").show();
	        if (!userClearedEmailField) {
	            $("#btnAuthMail").hide();
	            $("#btnCheckEmail").show();
	        } else {
	            $("#btnCheckEmail").hide();
	            $("#btnAuthMail").show();
	        }
	        return true;
	    }
	});
	
	// 변수를 추가하여 사용자가 이메일 입력 필드를 지웠는지 여부를 추적
	var userClearedEmailField = false;
	
	// 이메일 입력 필드의 값이 변경되었을 때 플래그를 설정
	$("input[name=userEmail]").on('input', function () {
	    userClearedEmailField = ($("form input[name='userEmail']").val().trim() === "");
	});
	
	
	// 가입하기 클릭 이벤트
	$("form").submit(function (e) {
	    e.preventDefault();
	
	    const $id = $("form input[name='userid']");
	    const $name = $("form input[name='userName']");
	    const $password = $("form input[name='userpw']");
	    const $email = $("form input[name='userEmail']");
	
	    // 비밀번호 입력 및 확인
	    if (!checkPwd()) {
	        alert("비밀번호를 확인해주세요.");
	        return false;
	    }
	
		    // 메일 체크
	    if (!emailCheck) {
	        alert("이메일을 확인해주세요.");
	        return false;
	    }
	    
	    if (!authCheck) {
	        alert("인증번호를 확인해주세요.");
	        return false;
	    } 
	    
	    // 검증 완료 후 form 전송
	    $(this)[0].submit();
	});
	
	// email 중복 체크
	async function checkEmail() {
	    const $email = $("form input[name='userEmail']");
	    const $oriEmail = $("form input[name='oriEmail']");
	    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	    if (!$email.val()) {
	        alert('이메일을 입력해주세요.');
	        emailCheck = false;
	        return;
	    }
	    if (!emailRegex.test($email.val())) {
	        alert("올바른 이메일 형식이 아닙니다. 다시 입력해주세요.");
	        emailCheck = false;
	        return;
	    }
	
	    if ($email.val() === $oriEmail.val()) {
	        // 이메일 값이 같을 때의 처리
	        alert("사용 가능한 이메일 주소입니다.");
	        alert("인증번호 버튼을 클릭해서 인증하세요.");
	        $("#btnCheckEmail").hide();
	        $("#btnAuthMail").show();
	        emailCheck = true;
	    } else {
	        const checkEmail = await $.get("/auth/checkEmail", {userEmail: $email.val()});
	        if (checkEmail) {
	            alert("중복된 이메일 주소입니다.");
	            emailCheck = false;
	        } else {
	            alert("인증번호 버튼을 클릭해서 인증하세요.");
	            $("#btnCheckEmail").hide();
	            $("#btnAuthMail").show();
	            emailCheck = true;
	        }
	    }
	}
	
		
	// 비밀번호, 비밀번호 확인 체크
	function checkPwd() {
	    const $password = $("form input[name='userpw']");
	    const $repassword = $("form input[name='repassword']");
	    const pwdReg = /(?=.*[0-9])(?=.*[a-zA-Z])(?=\S+$).{8,16}/;
	
	    if (!pwdReg.test($password.val())) {
	        alert('비밀번호 형식에 맞지 않습니다. 다시 입력해주세요.');
	        return false;
	    }
	
	    if (!$password.val()) {
	        alert('비밀번호를 입력해주세요.');
	        return false;
	    }
	
	    if (!$repassword.val()) {
	        alert('비밀번호를 확인해주세요');
	        return false;
	    }
	
	    // password 체크 확인
	    if ($repassword.val() !== $password.val()) {
	        alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
	        return false;
	    }
	    return true;
	}
	
		// 이메일 인증번호 요청
	async function sendNumber() {
		const email = $("input[name='userEmail']").val();
		console.log('완성된 이메일 : ' + email);
		const checkInput = $("#userAuth");
		
		$.ajax({
			type : 'get',
			url : '<c:url value ="/auth/mailUpdate?email="/>'+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code =data;
				alert('인증번호가 전송되었습니다.')
				
				$("#userEmail").prop("readonly", true);
	            $("#btnAuthMail").prop("disabled", true);
	            $("#auth-number").show();
			}			
		}); // end ajax
		
	}
	
	async function checkNumber(){
		const inputCode = $("#userAuth").val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			authCheck = true;
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$("#userAuth").prop("readonly", true);
	        $("#btnConfirm").prop("disabled", true);
	        $("#btnJoin").prop("disabled", false);
		}else{
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color','red');
		}
	} 

</script>