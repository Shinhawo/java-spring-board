<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<%@ include file="layouts/top.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


     <div class="main-content">
        <div class="row">
           <div class="col-lg-12">
				<div class="panel panel-default" >
					<div class="panel-heading">
						<h1>User Register</h1>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body" style="padding-top: 30px;">
						
						<form role="form" action="/userRegister" method="post">
							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
							<div class="form-group">
								<label>이름</label> <input class="form-control" name='userName' placeholder="이름을 입력하세요" autocomplete="off">
								<div id="name-error-text" class="alert"></div>
							</div>
							
							<div class="form-group">
								<label>아이디</label> <input maxlength="12" class="form-control" name='userid' placeholder="영문,숫자 조합(8~12자)" autocomplete="off">
								<button id="btnUserIdConfirm" type="button" class="button gray-line small w75px ml08" style="margin-top: 5px;">중복확인<!--중복확인--></button>
                                <div id="id-error-text" class="alert"></div>	
							</div>
							
							<div class="form-group">
								<label>비밀번호</label> <input class="form-control" name='userpw' maxlength="16" type="password" placeholder="영문 대 소문자,숫자 8자~16자" >
								<div id="password-error-text" class="alert"></div>
							</div>
							
							<div class="form-group">	
								<label for="userRepw">비밀번호 확인</label> 
								<input class="form-control"  minlength="" maxlength="16" id="userRepw" name="repassword" type="password" placeholder="비밀번호를 확인하세요." />
                                    <!--영문,숫자,특수기호 중 2가지 이상 조합-->
                                <div id="re-password-error-text" class="alert"></div>
							</div>
							
							<div class="form-group">
								<label>이메일</label> <input class="form-control" name='userEmail' id="userEmail" maxlength="50" placeholder="name@example.com" autocomplete="off"/>
								<button id="btnCheckMail" type="button" class="button gray-line small w75px ml08" style="display: block; margin-top: 5px;">중복체크</button>
								<!-- 인증번호 요청 -->
                                <button id="btnAuthMail" type="button" class="button gray-line small w75px ml08" style="display: none; margin-top: 5px;">인증번호</button>
								<div id="email-error-text" class="alert"></div>
							</div>
							
							<!-- 인증번호 -->
                            <div id="auth-number" class="form-group" style="display: none;">
                                <div class="line col">
                                    <input id="userAuth" name="code" maxlength="8" type="text" class="form-control" placeholder="인증번호를 입력하세요" autocomplete="off">
                                </div>
                                <div id="mail-check-warn" class="alert"></div>
                                <button id="btnConfirm" type="button" class="button gray-line small w75px ml08" style="margin-top: 5px;">인증하기</button>
                            </div>
							
							<button id="submitBtn" type="submit" class="btn btn-defult">Submit</button>						
							<button type="reset" class="btn btn-defult">Reset Button</button>
							
						</form>
						
					</div><!-- /.end panel-body -->
				</div><!-- /.end panel-body -->
			</div><!-- /.end panel -->
        </div>
    </div>
    
<script type="text/javascript">
	
	
	
	const $name = $("form input[name ='userName']");
	const $id = $("form input[name ='userid']");
	const $pw = $("form input[name ='userpw']");
	const $email = $("form input[name ='userEmail']");
	const $auth = $("#userAuth");
	
	var idCheck = false;
	var passwordCheck = false;
	var nameCheck = false;
	var emailCheck = false;
	var authCheck = false;
	
	// input 새로운 값 입력 시 기존 검증 결과 초기화
    $id.keyup(() => idCheck = false);
    $email.keyup(() => emailCheck = false);
    $auth.keyup(() => authCheck = false);
    
 	// 이메일 인증번호 요청 버튼 클릭 이벤트
    $("#btnAuthMail").click(() => sendNumber());
    // 인증번호 확인 클릭 이벤트
    $("#btnConfirm").click(() => checkNumber());
    
    // 아이디, 이메일 중복 확인 버튼 클릭 이벤트
    $("#btnUserIdConfirm").click(() => checkId());
    $("#btnCheckMail").click(() => checkEmail());
    
    
    $("input[name=userid]").keyup(() => {
        const $id = $("form input[name='userid']");
        const idReg = /^[a-zA-Z0-9]{3,10}$/;
        if (!idReg.test($id.val())) {
            $("#id-error-text").text("아이디는 영문, 숫자의 조합으로 3자~10자여야 합니다.").css('color', 'red');
            return false;
        } else {
            $("#id-error-text").text("올바른 아이디 형식입니다.").css('color', 'lightgreen');
            return true;
        }
    });
    
    // 이름 입력 이벤트
    $("input[name=userName]").keyup(() => {
        const namevalue = $name.val().trim();
        const korReg = /^[가-힣]+$/;

        if (namevalue.length < 2 || namevalue.includes(" ") || !korReg.test(namevalue)) {
            $("#name-error-text").text("이름은 두글자 이상 공백을 포함할 수 없고, 한글만 가능합니다.").css('color', 'red');
            nameCheck = false;
        } else {
            $("#name-error-text").text("");
            nameCheck = true;
        }
    });
    
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
            $("#password-error-text").text("올바른 비밀번호 형식입니다.").css('color', 'lightgreen');
        }

        if (!$repassword.val()) {
            $("#re-password-error-text").text("비밀번호를 확인해주세요.").css('color', 'red');
            passwordCheck = false;
        }

        if ($repassword.val() !== $password.val()) {
            $("#re-password-error-text").text("입력한 비밀번호가 일치하지 않습니다.").css('color', 'red');
            passwordCheck = false;
        } else {
            $("#re-password-error-text").text("비밀번호가 일치합니다.").css('color', 'lightgreen');
        }
    });
    
    // 이메일 입력 시 검증 이벤트
    $("input[name=userEmail]").keyup(() => {
        const $email = $("form input[name='userEmail']");
        const emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!$email.val()) {
            $("#email-error-text").text("이메일을 입력하세요.").css('color', 'red');
            $("#btnCheckMail").show();
            $("#btnAuthMail").hide();

            return false;
        } else if (!emailReg.test($email.val())) {
            $("#email-error-text").text("이메일 형식에 올바르지 않습니다.").css('color', 'red');
            $("#btnCheckMail").show();
            $("#btnAuthMail").hide();

            return false;
        } else {
            $("#email-error-text").text("올바른 이메일 형식입니다.").css('color', 'lightgreen');
            $("#btnCheckMail").show();
            if (!userClearedEmailField) {
                $("#btnAuthMail").hide();
                $("#btnCheckMail").show();
            } else {
                $("#btnCheckMail").hide();
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

        // 이름 입력 확인
        if (!nameCheck) {
            alert("이름을 확인하세요.");
            return false;
        }
        
        // 아이디 입력 및 중복 체크
        if (!idCheck) {
            alert("아이디를 확인하세요.");
            return false;
        }

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
    
    // id 중복 체크
    async function checkId() {
        const $id = $("form input[name='userid']");
        const idReg = /^[a-zA-Z0-9]{3,10}$/;
        if (!$id.val()) {
            alert('아이디를 입력해주세요!');
            idCheck = false;
            return;
        }
        if (!idReg.test($id.val())) {
            alert('아이디 형식에 맞지 않습니다.');
            idCheck = false;
            return;
        }
        // ES6 문법
        const checkId = await $.get("/auth/checkId", {userid: $id.val()});
        if (checkId) {
            alert("중복된 아이디입니다!");
            idCheck = false;
        } else {
            alert("사용할 수 있는 아이디입니다.");
            idCheck = true;
        }
        return checkId;
    }
 	
    
 	// email 중복 체크
    async function checkEmail() {
        const $email = $("form input[name='userEmail']");
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
        const checkEmail = await $.get("/auth/checkEmail", {userEmail: $email.val()});
        if (checkEmail) {
            alert("중복된 이메일 주소입니다.");
            emailCheck = false;
        } else {
        	alert("인증번호 버튼을 클릭해서 인증하세요.");
            $("#btnCheckMail").hide();
            $("#btnAuthMail").show();
            emailCheck = true;
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
			url : '<c:url value ="/auth/mailCheck?email="/>'+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
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

<script src="../resources/static/js/page/index.js"></script>

<%@ include file="layouts/bottom.jsp" %>