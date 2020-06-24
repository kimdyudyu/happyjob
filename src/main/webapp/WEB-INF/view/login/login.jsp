<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/admin/login.css" />

<!-- 달력 -->
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script> -->

<!-- <link rel="stylesheet" href="./jquery-ui-1.12.1/jquery-ui.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="./jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script> -->

<!-- 우편번호 조회 -->

<style type="text/css">

.abc{
	display : flex;
	grid-template-rows : repeat(7, 1ft);
	margin-right : 30px;
}

.content{
	overflow : auto;
}
.content::-webkit-scrollbar{
	width : 10px;
}
.content::-webkit-scrollbar-thumb {
	background-color: #2f3542;
}
.content::-webkit-scrollbar-track {
	background-color: grey;
}

</style>

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>

<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<jsp:include page="/WEB-INF/view/hla/hUserInfoVue.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		$("#confirm").hide();
		$("#loginRegister").hide();
		$("#loginEmail").hide();
		$("#loginPwd").hide();
		hUserInfoHeader();
		hUserInfoHeaderVue.Init("I");
		hUserInfoVueInit();
		hUserInfoFooter();
		totalInit();
		/* $("#btn_prelogin").click(function() {
			$("#EMP_ID").val("admin");
			$("#EMP_PWD").val("admin");
			fLoginProc();
		});

		$("#btn_prelogin1").click(function() {
			$("#EMP_ID").val("1234");
			$("#EMP_PWD").val("1234");
			fLoginProc();
		});

		$("#btn_prelogin2").click(function() {
			$("#EMP_ID").val("DigitalOne");
			$("#EMP_PWD").val("DigitalOne");
			fLoginProc();
		}); */

	});
	/* OnLoad Event */
	$(function() {
		// 쿠키값을 가져온다.
		var cookie_user_id = getCookie('EMP_ID');
		if (cookie_user_id != "") {
			$("#EMP_ID").val(cookie_user_id);
			$("#cb_saveId").attr("checked", true);
		}

		$("#EMP_ID").focus();

	});

	/* 회원가입 모달창 실행 */
	function fRegister() {
		// 모달 팝업
		gfModalPop("#layer1");
		
	}
	
	function fComp() {
		
		gfModalPop("#layer3");
	}

	/* 아이디/비밀번호 찾기 모달창 실행 */
	function findIdPwd() {

		// 모달 팝업
		gfModalPop("#layer2");
	}

	/* 회원가입  신규등록*/
	function fPopModalLsmCod(loginID) {
		var frm = $("#RegisterForm");
		if (loginID == null || loginID == "") { 
			frm.find("input[name=action]").val("I");

			gfModalPop("#layer1");
		}
	}
	
	/* 기업회원가입 신규등록 */
	function fPopModalcompCod(loginID) {
		var frm = $("#CompanyForm");
		if (loginID == null || loginID == "") {
			frm.find("input[name=action]").val("I");
			console.log("ppopop");
			hUserInfoHeader();
			hUserInfoHeaderVue.Init("I");
			hUserInfoVueInit();
			hUserInfoFooter();
			totalInit();
			hUserInfoVue.SetUserType("C");
			gfModalPop("#userInfoPopup");
		}
	}

	/* 회원 가입 저장 콜백함수 */
	function fSaveRegister(data) {

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();
		} else {
			alert(data.resultMsg);
			return false;
		}
	}
	
	/* 회원가입 validation */
	function RegisterVal(){
		
		/* 일반  validation */
		var rgname = $('#registerName').val();
		var rgid = $('#registerId').val();
		var rgpwd = $('#registerPwd').val();
		var rgemail = $('#Email').val();
		var rgdomain = $('#domainEmail').val();
		var rgsex = $('#sex').val();
		var rglevel = $('#level').val();
		var rgarea = $('#area').val();
		var rgtel1 = $('#tel1').val();
		var rgtel2 = $('#tel2').val();
		var rgtel3 = $('#tel3').val();
		var rgdate = $('#date').val();
		
		/* validation */
		if(rgname.length < 1) {
			alert("이름을 입력하세요.");
			$('#registerName').focus();
			return false;
		}
		
		if(rgid.length < 1) {
			alert("아이디를 입력하세요.");
			$('#registerId').focus();
			return false;
		}
		
		if(rgpwd.length < 1) {
			alert("비밀번호를 입력하세요.");
			$('#registerPwd').focus();
			return false;
		}
		
		if(rgemail.length < 1) {
			alert("이메일을 입력하세요.");
			$('#Email').focus();
			return false;
		}
		
		if(!rgdomain) {
			alert("도메인을 선택하세요.");
			$('#domainEmail').focus();
			return false;
		}
		
		if(!rgarea) {
			alert("지역을 선택해 주세요");
			$('#area').focus();
			return false;
		}
		
		if(!rgtel1) {
			alert("번호를 선택해 주세요");
			$('#tel1').focus();
			return false;
		}
		
		if(rgtel2.length < 1) {
			alert("번호를 입력해 주세요");
			$('#tel2').focus();
			return false;
		}
		
		if(rgtel3.length < 1) {
			alert("번호를 입력해 주세요");
			$('#tel3').focus();
			return false;
		}
		
		if(rgdate.length < 1){
			alert("생년월일 입력해 주세요");
			$('#date').focus();
			return false;
		}
		
		if(!rgsex){
			alert("성별을 입력해 주세요");
			$('#sex').focus();
			return false;
		}
		
		if(!rglevel){
			alert("등급을 입력해 주세요");
			$('#level').focus();
			return false;
		}
		
		return true;
		
	}
	
	/* 기업회원가입 validation */
	function compVal(){
		
		/* 기업 validation */
		var rgcompid = $('#compId').val();
		var rgcomppwd = $('#compPwd').val();
		var rgcomp_name = $('#comp_name').val();
		var rgmgr_name = $('#mgr_name').val();
		var rgmgr_tel1 = $('#mgr_tel1').val();
		var rgmgr_tel2 = $('#mgr_tel2').val();
		var rgmgr_tel3 = $('#mgr_tel3').val();
		var rgcompEmail = $('#compEmail').val();
		var rgcompDomain = $('#compDomain').val();
		var rgcompDate = $('#compDate').val();
		
		if(rgcompid.length < 1){
			alert("아이디를 입력해 주세요");
			$('#compId').focus();
			return false;
		}
		
		if(rgcomppwd.length < 1){
			alert("비밀번호를 입력해 주세요");
			$('#compPwd').focus();
			return false;
		}
		
		if(rgcomp_name.length < 1){
			alert("회사명을 입력해 주세요");
			$('#comp_name').focus();
			return false;
		}
		
		if(rgmgr_name.length < 1){
			alert("담당자명을 입력해 주세요");
			$('#mgr_name').focus();
			return false;
		}
		
		if(!rgmgr_tel1){
			alert("연락처을 입력해 주세요");
			$('#mgr_tel1').focus();
			return false;
		}
		
		if(rgmgr_tel2.length < 1){
			alert("연락처을 입력해 주세요");
			$('#mgr_tel2').focus();
			return false;
		}
		
		if(rgmgr_tel3.length < 1){
			alert("연락처을 입력해 주세요");
			$('#mgr_tel3').focus();
			return false;
		}
		
		if(rgcompEmail.length < 1){
			alert("이메일을 입력해 주세요");
			$('#compEmail').focus();
			return false;
		}
		
		if(!rgcompDomain){
			alert("도메인을 입력해 주세요");
			$('#compDomain').focus();
			return false;
		}
		
		if(!rgcompDate){
			alert("설립일을 입력해 주세요");
			$('#compDate').focus();
			return false;
		}
		
		return true;
		
	}

	/* 회원가입  완료*/
	function CompleteRegister() {
		
		/* validation 체크  */
  		if(!RegisterVal()){
			return;
		}
		
		/* 가입일자 */
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		
		if(dd<10) {
		    dd='0'+dd
		} 
		
		if(mm<10) {
		    mm='0'+mm
		} 
		
		today = yyyy+'/'+mm+'/'+dd;
		
		/* User Position 체크 여부 */
		
		var position = ""; 
		$("input[name=position]:checked").each(function(index) {
			position += $(this).val() + ",";
		});
		
		/* 협의 가능 체크 여부 */
		if($("input[name=consultyn]").is(":checked")){
			$("input[name=consult_yn]").val('Y');
		}
		else{
			$("input[name=consult_yn]").val('N');
		}
		
		var str = "";
		$("input[name=skillcheck]:checked").each(function(index) {
				str += $(this).val() + "/";
		});
		
		$("#skilldetail").val(str);
		$("#userPosition").val(position);
		$("#joinDate").val(today);
		
		var param = $("#RegisterForm").serialize();
		
		$.ajax({
			url : "/register.do",
			type : "post",
			dataType : "json",
			async : false,
			data : param,
			success : function(data) {
//				alert("회원 가입이 완료가 되었습니다");
//				gfCloseModal();
				fSaveRegister(data);
			}
		});
		
		/* callAjax("/register.do", "post", "json", true, param, resultCallback); */

	}
	
	function CompleteComp(){
		
		/* validation 체크  */
  		if(!compVal()){
			return;
		}
		
		var comp = $("#CompanyForm").serialize();
		
		$.ajax({
			url : "/comp.do",
			type : "post",
			dataType : "json",
			async : false,
			data : comp,
			success : function(data) {
//				alert("회원 가입이 완료가 되었습니다");
//				gfCloseModal();
				fSaveRegister(data);
			}
		});
		
		
	}
	
	/* test */
/* 	function CompleteTest(){
		
		var str = "";
		
		$("input:checkbox:checked").each(function(index) {
				str += $(this).val() + "/";
		})
		
		alert("str : " + str);
		
		var strArray = str.split('/');
		
		alert(strArray);
		
		for(var i in strArray){
			if(strArray[i] != ""){
				var real_qty = $
			}
		}

	} */

	/** 로그인 ID  체크 */
	function fCheckLgnId() {

		// validation 체크
		var lgn_id = $("#signForm").find("#lgn_id").val();
		if (lgn_id == "") {
			alert("아이디를 입력하세요.");
			$("#signForm").find("#lgn_id").focus();
			return;
		}

		if (!fChkId(lgn_id)) { //아이디 정규식 체크
			alert("아이디는 영문, 숫자를 포함한 7자리 이상 20자리 미만 입니다.");
			return;
		}

		// 로그인 아이디 조회
		var param = {
			lgn_id : lgn_id
		};
		var resultCallback = function(data) {
			fCheckLgnIdResult(data);
		};
		callAjax("/system/selectUsrMgr.do", "post", "json", true, param,
				resultCallback);
	}

	/** 로그인 ID 중복 체크 콜백 함수 */
	function fCheckLgnIdResult(data) {
		if (data.result == "SUCCESS") {
			$("#signForm").find("#idCheckFlag").val(data.isPossible);
			$("#signForm").find("#pwd").focus();
		}
	}

	/* 로그인 validation */
	function fValidateLogin() {

		var chk = checkNotEmpty([ [ "EMP_ID", "아이디를 입력해 주세요." ],
				[ "EMP_PWD", "비밀번호를 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/* 로그인 */
	function fLoginProc() {
		if ($("#cb_saveId").is(":checked")) { // 저장 체크시
			saveCookie('EMP_ID', $("#EMP_ID").val(), 7);
		} else { // 체크 해제시는 공백
			saveCookie('EMP_ID', "", 7);
		}

		// vaildation 체크
		if (!fValidateLogin()) {
			return;
		}

		var resultCallback = function(data) {
			fLoginProcResult(data);
		};

		callAjax("/loginProc.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	/* 로그인 결과 */
	function fLoginProcResult(data) {

		var lhost = data.serverName;

		if (data.result == "SUCCESS") {
			location.href = "${CTX_PATH}/dashboard/dashboard.do";
		} else {

			$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
					.dialog({
						modal : true,
						resizable : false,
						buttons : [ {
							text : "확인",
							click : function() {
								$(this).dialog("close");
								$("#EMP_ID").val("");
								$("#EMP_PWD").val("");
								$("#EMP_ID").focus();
							}
						} ]
					});
			$(".ui-dialog-titlebar").hide();
		}
	}

	/*이메일 기능  (아이디 있는지 없는지 체크)*/
	function SendEmail() {
		var data = {
			"email" : $("#emailText").val(),
			"data-code" : $("#emailText").attr("data-code")
		};

		$.ajax({
			url : "/registerFindId.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(flag) {
				if (flag != '1') {
					alert("해당 이메일로 인증번호를 전송하였습니다.");
					$("#authNumId").val(flag);
					$("#confirm").show();
				} else if (flag == '1') {
					alert("존재하지 않는 이메일 입니다.");
				} else if (flag.length < 1) {
					alert("이메일을 입력해주세요.");
				}
			}
		});
	}

	/* 이메일 기능 (비밀번호 기능)*/
	function SendPwdEmail() {
		
		var data = {
			email : $("#emailPwdText").val(),
			loginID : $("#emailIdText").val(),
			"data-code" : $("#emailPwdText").attr("data-code")

		};
		
		console.log(data);
		
		
		
		$.ajax({
			url : "/registerFindPwd.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(flag) {
				
				
				if (flag != '1') {
					alert("해당 이메일로 임시 비밀번호를 전송하였습니다.");
					$("#authNumPwd").val(flag);
					$("#loginPwd").show();
				} else if (flag.length < 1) {
					alert("이메일을 입력해주세요.");
				} else if (flag == '1') {
					alert("이메일이 틀렸습니다.");
				}
				pwdCheck();
			}
		});
	}
	
	function pwdCheck(){
		var email = $("#emailPwdText");
		
		if(email.length < 1){
			alert("이메일을 입력해주세요.");
		}
	}

	/* 이메일 인증 */
	function SendComplete() {
		var inputNum = $("#emailNum").val();
		var emailNum = $("#authNumId").val();
		if (inputNum.length < 1) {
			alert("인증번호를 입력해주세요.");
			return false;
		} else if (emailNum != inputNum) {
			alert("인증번호가 틀렸습니다.");
			return false;
		} else if (emailNum == inputNum) {
			alert("인증 되었습니다.");
			$("#authNumId").val('');

			// 아이디 메일 전송 함수호출
			findId();
		}
	}

	/* 이메일 비밀번호 인증 */
	function SendCompletePwd() {
		var inputPwd = $("#emailPwdNum").val();
		var emailPwdNum = $("#authNumPwd").val();
		if (inputPwd.length < 1) {
			alert("비밀번호를 입력해주세요.");
			return false;
		} else if (emailPwdNum != inputPwd) {
			alert("비밀번호가 틀렸습니다.");
			return false;
		} else if (emailPwdNum == inputPwd) {
			alert("비밀번호가 맞습니다.");
			$("#authNumPwd").val('');

			// 비밀번호 호출하는 함수
			findPwd();
		}
	}
	/* 아이디 뜨게 하는 */
	var findId = function() {
		var data = {
			"email" : $("#emailText").val()
		};
		$.ajax({
			url : '/findRegisterId.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				// 모달 or span 
				alert("귀하의 아이디는 : " + data + "입니다");
				gfCloseModal();
			}
		});
	}

	/* 비밀번호 뜨게 하는 창 */
	var findPwd = function() {
		var data = {
			"loginID" : $("#emailIdText").val(),
			"email" : $("#emailPwdText").val()
		};
		$.ajax({
			url : '/findRegisterPwd.do',
			type : 'post',
			data : data,
			dataType : 'text',
			async : false,
			success : function(data) {
				alert("귀하의 비밀번호는 : " + data + "입니다");
				gfCloseModal();
			}
		});
	}
	/* 비밀번호 찾기 아이디 체크 */
	  function CheckIdRegister(){
		var inputid = $("#emailIdText").val();
		var ckId = $("#ckIdcheck").val();
			if(inputid.length < 1){
				alert("가입하신 아이디를 입력해주세요.");
				return false;
			}else if(ckId != inputid){
				alert("가입하신 아이디가 맞지 않습니다.");
				return false;
			}else if(ckId == inputid){
				alert("가입하신 아이디가 맞습니다.");
				$("#ckIdcheck").val("");
				
				// 비번찾기에서 아이디 체크하는 창 (알림창)
				RegisterIdCheck();
			}
	}  
	
	/* 비밀번호 찾기에서 아이디 체크하는 창(가입된 아이디가 알람창으로) */
	function RegisterIdCheck(){
		var loginID = $("#emailIdText").val();

		
		var data = {
				"loginID" :loginID
		};
		console.log(data);
		
		$.ajax({
			url : "/registerIdCheck.do",
			type : "post",
			dataType : "json",
			async : false,
			data : data,
			success : function(data){
				if(loginID.length < 1){
					alert("아이디를 입력해주세요.");
				}
			
				else if (data.cnt > 0){
					
					alert("아이디가 존재합니다.");
				}else{
					alert("아이디가 존재하지 않습니다.");
				}
				
			}
			
		});
	}
	/* 아이디 찾기 버튼 클릭 이벤트 */
	function fSelectId() {

		gfModalPop("#layer2");
		$("#registerEmailId").show();
		$("#loginRegister").hide();
		$("#loginEmail").hide();
		$("#loginPwd").hide();

	}

	/* 비밀번호 찾기 버튼 클릭 이벤트 */
	function fSelectPwd() {

		$("#registerEmailId").hide();
		$("#confirm").hide();
		$("#loginRegister").show();
		$("#loginEmail").show();
		$("#loginPwd").hide();
		gfModalPop("#layer2");
	}

	/* 아이디 찾기 메일 인증하기 버튼 클릭 이벤트 */
	function fSelectIdOk() {
		$("#emailOk").on("click", function() {
			alert("인증이 완료 되었습니다.")
		});
	}

	/** ID 조회 */
	function fSelectData() {
		var resultCallback = function(data) {
			fSelectDataResult(data);
		};
		callAjax("/registerFindId.do", "post", "json", true, $("#modalForm")
				.serialize(), resultCallback);
	}

	/** PW 조회 */
	function fSelectDataPw() {
		var resultCallback = function(data) {
			fSelectDataResultPw(data);
		};

		callAjax("/registerFindPwd.do", "post", "json", true, $("#modalForm2")
				.serialize(), resultCallback);
	}

	/** pw 저장 */
	function fSaveData() {

		var resultCallback = function(data) {
			fSaveDataResult(data);
		};

		callAjax("/updateFindPw.do", "post", "json", true, $("#modalForm2")
				.serialize(), resultCallback);
	}

	/** 데이터 저장 콜백 함수 */
	function fSaveDataResult(data) {
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);
			location.href = "/login.do";
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}
	
	/* 생년월일 */
	$(function(){
	    $.datepicker.setDefaults($.datepicker.regional["ko"]);
	    $("#date").datepicker({
	        showOn: "both",
	        buttonImage: "images/calendar/calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "Select date"
	    });
	});
	
	/* 설립일 */
	$(function(){
	    $.datepicker.setDefaults($.datepicker.regional["ko"]);
	    $("#compDate").datepicker({
	        showOn: "both",
	        buttonImage: "images/calendar/calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "Select date"
	    });
	});
	
	/* 협의가능 여부 */
	/* $("#consult_yn").change(
		$(function(){
			if($("#consult_yn").is(":checked")) {
				$("YN").val('Y');
			}
			else{
				$("YN").val('N');
			}
		})
	); */
	
/* 	$(function(){      
		
		idCheck();
	    
	}); */

	function compidCheck() {
		
		var param = {	compId : $("#compId").val()};
		
		/*var resultCallback = function(data) {
			console.log("1111111111111111111111111111111111111111111111111111111111");
			alert("1111111111111111");
			
			checkingId(data);
			
			console.log("2222222222222222222222222222222222222222222222222222222222");
			alert("2222222222222222");
		}; */
		
		
		//callAjax("/login/checkId.do", "post", "json", true, param, resultCallback);
		
		$.ajax({
			url : "/compCheck.do",
			type : "post",
			dataType : "json",
			async : false,
			data : {"compId" : $("#compId").val()},
			success : function(data){
				
				var param = data.chkmsg;
				
				if(param == "Y") {
					alert("ID 가 중복 되었습니다.");
					
					return false;					
				} else {
					alert("사용가능 한  ID입니다.");
					
				}
				
				//if(param.loginId == $("#compId")){
				//	alert("중복된 아이디 입니다.");
				//}
				//else{
				//	$("#checkId").attr("value", "Y");
				//	alert("사용 가능한 아이디입니다.");
				//}
			}
		}); 
	}
	
	function useridCheck() {
		
		var param = {	registerId : $("#registerId").val()};
		
		$.ajax({
			url : "/userCheck.do",
			type : "post",
			dataType : "json",
			async : false,
			data : {"registerId" : $("#registerId").val()},
			success : function(data){
				
				var param = data.chkmsg;
				
				if(param == "Y") {
					alert("ID 가 중복 되었습니다.");
					
					return false;					
				}
				else {
					alert("사용가능 한  ID입니다.");
					
				}
			}
		}); 
	}
	
	/* function checkingId(data){
		
		alert("333333333333333333333333");
		
		var param = [];
		param = data.idCheck;
		
		console.log("==========================" + param);
		//alert(param);
		
		/* $('#loginID').val(param.loginId); */
		
		//if(idCheck.loginId != null){
		//	alert("중복된 아이디 입니다.");
		//}
		//else{
			/* $("#checkId").attr("value", "Y"); */
		//	alert("사용 가능한 아이디입니다.");
		//}
		
	
</script>
</head>
<body>
	<form id="myForm" action="" method="post">
		<div id="background_board">
			<div class="login_form" align="center">

				<fieldset>
					<legend>로그인</legend>
					<p class="id">
						<label for="user_id">아이디</label> <input type="text" id="EMP_ID"
							name="lgn_Id" placeholder="아이디"
							onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"
							style="ime-mode: inactive;" />
					</p>
					<p class="pw">
						<label for="user_pwd">비밀번호</label> <input type="password"
							id="EMP_PWD" name="pwd" placeholder="비밀번호"
							onfocus="this.placeholder=''; return true"
							onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
					</p>
					<p class="member_info" style="font-size: 15px">
						<input type="checkbox" id="cb_saveId" name=""
							onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}">
						<span class="id_save">ID저장</span> <br>
					</p>
					<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>Login</strong></a>
					<br>
					<!--  <button type="" id="btn_copjoin" onclick="location.href='/cop/officeReg.do' " style="background: none;font-size:110%;border: 0px;color: gray "><strong>[기업회원가입]</strong></button> -->
					<!--   <a class="btn_copjoin" href="#" ><strong>[기업회원가입]</strong></a>	 -->
					<a href="javascript:fLoginProc();" id="btn_prelogin"><strong>[관리자로그인]</strong></a>
					<a href="javascript:fLoginProc();" id="btn_prelogin2"><strong>[학생로그인]</strong></a>
					<a href="javascript:fPopModalLsmCod();" id="RegisterBtn" name="modal"><strong>[일반 회원가입]</strong></a>
					<a href="javascript:fPopModalcompCod();" id="compBtn" name="modal"><strong>[학생 회원가입]</strong></a>
					<a href="javascript:findIdPwd();"><strong>[아이디/비밀번호 찾기]</strong></a>
				</fieldset>
			</div>
		</div>
	</form>
	<!-- 모달팝업 -->
		
	<!-- 일반 회원가입 -->
	<form id="RegisterForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="skilldetail" id="skilldetail" value="">
		<input type="hidden" name="userPosition" id="userPosition" value="">
		<input type="hidden" name="joinDate" id="joinDate" value="">
		<div id="layer1" class="layerPop layerType2" style="width: 1400px; overflow:auto;">
			<dl>
				<dt>
					<strong>일반회원 가입</strong>
				</dt>
				<dd class="content" overflow:auto;>
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>

						<tbody>
						<h1>기본 정보</h1>
							<tr>
								<th scope="row" style="width:100px;">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="loginID" id="registerId" style="width:100px; height:20px;"/>
								<a href="javascript:useridCheck();" class="btnType blue" id="userCheck" name="btn"> <span>중복 체크</span></a></td>
								<th scope="row" style="width:100px;">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="passtxt" name="password" id="registerPwd" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">이름<span class="font_red">*</span></th>
								<td><input type="text" class="nmtxt" name="name" id="registerName" style="width:100px; height:20px;"/></td>
								<th scope="row" style="width:100px;">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mailtxt" name="email" id="Email" style="width:80px; height:20px;"/>
									@
									<input class="domaintxt" name="email_cop" id="domainEmail" list="emailselect" placeholder="직접입력/선택" style="width:100px; height:20px;"/>
									<datalist name="emailselect" id="emailselect" style="width:100px; height:22px;">
									    <option value="">이메일 선택</option>
									    <option value="naver.com">네이버</option>
									    <option value="gmail.com">구글</option>
									    <option value="daum.net">다음</option>
									</datalist>
								</td>
								<th scope="row" style="width:100px;">성별<span class="font_red">*</span></th>
								<td colspan="3">
									<select name="sex" id="sex" style="width:100px; height:22px;">
									    <option value="">성별 선택</option>
									    <option value="남자">남자</option>
									    <option value="여자">여자</option>
									</select>	
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:80px;">등급<span class="font_red">*</span></th>
								<td colspan="1">
									<select name="grade" id="level" style="width:100px; height:22px;">
									    <option value="">등급 선택</option>
									    <option value="초급">초급</option>
									    <option value="중급">중급</option>
									    <option value="고급">고급</option>
									    <option value="특급">특급</option>
									</select>
								</td>
								<th scope="row">참여 구분</th>
								<td>
									<p><input type="checkbox" id="si" name="position" value="SI"> <label for="siCheck">SI(상주프로젝트)</label></p>
									<p><input type="checkbox" id="sm" name="position" value="SM"> <label for="smCheck">SM(상주프로젝트)</label></p>
									<p><input type="checkbox" id="sol" name="position" value="SOLUTION"> <label for="solCheck">솔루션개발</label></p>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">생년 월일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="date" name="birthday" id="date" style="width:100px; height:20px;" data-date-format='yyyy-mm-dd' autocomplete=off/>
								</td>
								<th scope="row">거주 지역<span class="font_red">*</span></th>
								<td>
									<select name="area" id="area" style="width:100px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
								</td>
								<th scope="row" style="width:100px;">연락처<span class="font_red">*</span></th>
								<td>
									<select name="tel1" id="tel1" style="width:90px; height:22px;">
									    <option value="">번호 선택</option>
									    <option value="010">010</option>
									    <option value="011">011</option>
									    <option value="019">017</option>
									    <option value="017">019</option>
									</select>
									<input type="text" class="tel2" name="tel2" id="tel2" style="width:80px; height:20px;"/>
									<input type="text" class="tel3" name="tel3" id="tel3" style="width:80px; height:20px;"/>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						
						<tbody>
						<h1>경력 정보</h1>
							<tr>
								<th scope="row" style="width:100px;">제목</th>
								<td colspan="7">
									<input type="text" class="title" name="title" id="title" style="width:1180px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">희망 근무</th>
								<td colspan="1">
									<select name="comp_area1" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
									<select name="comp_area2" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
									<select name="comp_area3" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
								</td>
								<th scope="row" style="width:100px;">희망 연봉</th>
								<td colspan="2">
									<input type="text" class="price" name="salary" id="price" style="width:100px; height:20px;"/>
									<input type="checkbox" name="consultyn" id="consultyn" /> <label for="priceCheck">협의 가능</label>
									<input type="hidden" id="consult_yn" name="consult_yn" />
								</td>
							</tr>
							<tr>							
								<th scope="row" style="width:100px;">경력 기간</th>
								<td colspan="3">
									<select name="career_year" style="width:90px; height:22px;">
									    <option value="">경력 선택</option>
									    <option value="없음">없음</option>
									    <option value="1~3">1~3</option>
									    <option value="3~5">3~5</option>
									    <option value="5~10">5~10</option>
									    <option value="10~15">10~15</option>
									    <option value="15~20">15~20</option>
									    <option value="20+">20+</option>
									</select>
									<label> 년</label>
									<select name="career_mm" style="width:90px; height:22px;">
									    <option value="">경력 선택</option>
									    <option value="없음">없음</option>
									    <option value="1">1</option>
									    <option value="2">2</option>
									    <option value="3">3</option>
									    <option value="4">4</option>
									    <option value="5">5</option>
									    <option value="6">6</option>
									    <option value="7">7</option>
									    <option value="8">8</option>
									    <option value="9">9</option>
									    <option value="10">10</option>
									    <option value="11">11</option>
									    <option value="12">12</option>
									</select>
									<label> 개월</label>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">전문 기술</th>
								<td colspan="3">
									<div class="abc">
										<span>
											<label>Language</label>
											<p><input type="checkbox" name="skillcheck" id="as400Check" value="LAS400"> <label for="as400Check">AS400</label></p>
											<p><input type="checkbox" name="skillcheck" id="cCheck" value="LC"> <label for="cCheck">C</label></p>
											<p><input type="checkbox" name="skillcheck" id="cppCheck" value="LCpp"> <label for="cppCheck">C++</label></p>
											<p><input type="checkbox" name="skillcheck" id="csharpCheck" value="LCSharp"> <label for="csharpCheck">C#</label></p>
											<p><input type="checkbox" name="skillcheck" id="cobolCheck" value="LCOBOL"> <label for="cobolCheck">COBOL</label></p>
											<p><input type="checkbox" name="skillcheck" id="delphiCheck" value="LDelphi"> <label for="delphiCheck">Delphi</label></p>
											<p><input type="checkbox" name="skillcheck" id="javaCheck" value="LJAVA"> <label for="javaCheck">JAVA</label></p>
											<p><input type="checkbox" name="skillcheck" id="vbCheck" value="LVB"> <label for="vbCheck">VB</label></p>
											<p><input type="checkbox" name="skillcheck" id="vcCheck" value="LVC"> <label for="vcCheck">VC</label></p>
											<p><input type="checkbox" name="skillcheck" id="netCheck" value="Lnet"> <label for="netCheck">.net</label></p>
											<p><input type="checkbox" name="skillcheck" id="pythonCheck" value="Lpython"> <label for="pythonCheck">python</label></p>
											<p><input type="checkbox" name="skillcheck" id="powerCheck" value="LPower_Builder"> <label for="powerCheck">Power Builder</label></p>
											<p><input type="checkbox" name="skillcheck" id="rCheck" value="LR"> <label for="rCheck">R</label></p>
										</span>
										<span>
											<label>WEB</label>
											<p><input type="checkbox" name="skillcheck" id="aspCheck" value="WASP"> <label for="aspCheck">ASP</label></p>
											<p><input type="checkbox" name="skillcheck" id="jspCheck" value="WJSP"> <label for="jspCheck">JSP</label></p>
											<p><input type="checkbox" name="skillcheck" id="phpCheck" value="WPHP"> <label for="phpCheck">PHP</label></p>
											<p><input type="checkbox" name="skillcheck" id="xmlCheck" value="WXML"> <label for="xmlCheck">XML</label></p>
		 									<p><input type="checkbox" name="skillcheck" id="dhtmlCheck" value="WDHTML"> <label for="dhtmlCheck">DHTML</label></p>
											<p><input type="checkbox" name="skillcheck" id="miCheck" value="WmiPaltform"> <label for="miCheck">miPaltform</label></p>
											<p><input type="checkbox" name="skillcheck" id="xCheck" value="WxPaltform"> <label for="xCheck">xPaltform</label></p>
											<p><input type="checkbox" name="skillcheck" id="nexaCheck" value="WNexacro"> <label for="nexaCheck">Nexacro</label></p>
										</span>
										<span>
											<label>OS</label>
											<p><input type="checkbox" name="skillcheck" id="unixCheck" value="OUNIX"> <label for="unixCheck">UNIX</label></p>
											<p><input type="checkbox" name="skillcheck" id="linuxCheck" value="OLINUX"> <label for="linuxCheck">LINUX</label></p>
											<p><input type="checkbox" name="skillcheck" id="macCheck" value="OMAC"> <label for="macCheck">MAC</label></p>
											<p><input type="checkbox" name="skillcheck" id="mvcCheck" value="OMVC"> <label for="mvcCheck">MVC</label></p>
		 									<p><input type="checkbox" name="skillcheck" id="solCheck" value="OSOLARIS"> <label for="solCheck">SOLARIS</label></p>
											<p><input type="checkbox" name="skillcheck" id="winCheck" value="OWINDOWS"> <label for="winCheck">WINDOWS</label></p>
											<p><input type="checkbox" name="skillcheck" id="winServerCheck" value="OWINDIWS_SERVER"> <label for="winServerCheck">WINDIWS SERVER</label></p>
										</span>
										<span>
											<label>FrameWork</label>
											<p><input type="checkbox" name="skillcheck" id="springCheck" value="FSpring"> <label for="springCheck">Spring</label></p>
											<p><input type="checkbox" name="skillcheck" id="egovCheck" value="FeGov"> <label for="egovCheck">eGov</label></p>
											<p><input type="checkbox" name="skillcheck" id="strutsCheck" value="FStruts"> <label for="strutsCheck">Struts</label></p>
											<p><input type="checkbox" name="skillcheck" id="jqueryCheck" value="FjQuery"> <label for="jqueryCheck">jQuery</label></p>
										</span>
										<span>
											<label>DB</label>
											<p><input type="checkbox" name="skillcheck" id="accCheck" value="DAccess"> <label for="accCheck">Access</label></p>
											<p><input type="checkbox" name="skillcheck" id="db2Check" value="DDB2"> <label for="db2Check">DB2</label></p>
											<p><input type="checkbox" name="skillcheck" id="mixCheck" value="DInformix"> <label for="mixCheck">Informix</label></p>
											<p><input type="checkbox" name="skillcheck" id="orclCheck" value="DORACLE"> <label for="orclCheck">ORACLE</label></p>
											<p><input type="checkbox" name="skillcheck" id="msCheck" value="DMS_SQL"> <label for="msCheck">MS SQL</label></p>
											<p><input type="checkbox" name="skillcheck" id="myCheck" value="DMY_SQL"> <label for="myCheck">MY SQL</label></p>
											<p><input type="checkbox" name="skillcheck" id="sybaseCheck" value="DSybase"> <label for="sybaseCheck">Sybase</label></p>
											<p><input type="checkbox" name="skillcheck" id="mariaCheck" value="DMariaDB"> <label for="mariaCheck">MariaDB</label></p>
											<p><input type="checkbox" name="skillcheck" id="tibCheck" value="DTibero"> <label for="tibCheck">Tibero</label></p>
										</span>
										<span>
											<label>Network</label>
											<p><input type="checkbox" name="skillcheck" id="routerCheck" value="NCisco_Router"> <label for="routerCheck">Cisco Router</label></p>
											<p><input type="checkbox" name="skillcheck" id="swCheck" value="NCisco_SW"> <label for="swCheck">Cisco S/W</label></p>
											<p><input type="checkbox" name="skillcheck" id="corbaCheck" value="NCORBA"> <label for="corbaCheck">CORBA</label></p>
											<p><input type="checkbox" name="skillcheck" id="lanCheck" value="NLAN"> <label for="lanCheck">LAN</label></p>
											<p><input type="checkbox" name="skillcheck" id="iotCheck" value="Niot"> <label for="iotCheck">iot</label></p>
										</span>
										<span>
											<label>WebServer/WAS</label>
											<p><input type="checkbox" name="skillcheck" id="tomCheck" value="STomcat"> <label for="tomCheck">Tomcat</label></p>
											<p><input type="checkbox" name="skillcheck" id="jeusCheck" value="SJEUS"> <label for="jeusCheck">JEUS</label></p>
											<p><input type="checkbox" name="skillcheck" id="sphereCheck" value="SWebSphere"> <label for="sphereCheck">WebSphere</label></p>
											<p><input type="checkbox" name="skillcheck" id="logicCheck" value="SWebLogic"> <label for="logicCheck">WebLogic</label></p>
											<p><input type="checkbox" name="skillcheck" id="iisCheck" value="SIIS"> <label for="iisCheck">IIS</label></p>
											<p><input type="checkbox" name="skillcheck" id="jbossCheck" value="SJBoss"> <label for="jbossCheck">JBoss</label></p>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">추가기술</th>
								<td colspan="7">
									<input type="text" class="add" name="skill_add" id="add" style="width:800px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">경력내용</th>
								<td colspan="7">
									<input type="text" class="career" name="career_contents" id="career" style="width:1180px; height:50px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">특이사항</th>
								<td colspan="7">
									<input type="text" class="speciality" name="singular_facts" id="speciality" style="width:1180px; height:50px;"/>
								</td>
							</tr>
							
							<input type="hidden" name="user_type" value="D" />
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="javascript:CompleteRegister();" class="btnType blue"
							id="RegisterCom" name="btn"> <span>회원가입 완료</span></a> <a href=""
							class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	
	<!-- 기업 회원가입 -->
	<!-- <form id="CompanyForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<div id="layer3" class="layerPop layerType3" style="width: 1000px;">
			<dl>
				<dt>
					<strong>기업회원 가입</strong>
				</dt>
				<dd class="container">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row" style="width:100px;">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="loginID" id="compId" style="width:100px; height:20px;"/>
								<a href="javascript:compidCheck();" class="btnType blue" id="checkId" name="btn"> <span>중복 체크</span></a>

								</td>
								<th scope="row" style="width:100px;">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="passtxt" name="password" id="compPwd" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">회사명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="comp_name" id="comp_name" style="width:100px; height:20px;"/></td>
								<th scope="row" style="width:100px;">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mailtxt" name="email" id="compEmail" style="width:80px; height:20px;"/>
									@
									<input class="domaintxt" name="email_cop" id="compDomain" list="emailselect" placeholder="직접입력/선택" style="width:100px; height:20px;"/>
									<datalist name="emailselect" id="emailselect" style="width:100px; height:22px;">
									    <option value="">이메일 선택</option>
									    <option value="naver.com">네이버</option>
									    <option value="gmail.com">구글</option>
									    <option value="daum.net">다음</option>
									</datalist>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="mgr_name" id="mgr_name" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">설립일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="compDate" name="birthday" id="compDate" style="width:100px; height:20px;" data-date-format='yyyy-mm-dd' autocomplete=off/>
								</td>
								<th scope="row" style="width:100px;">연락처<span class="font_red">*</span></th>
								<td>
									<select name="mgr_tel1" id="mgr_tel1" style="width:90px; height:22px;">
									    <option value="">번호 선택</option>
									    <option value="010">010</option>
									    <option value="011">011</option>
									    <option value="019">017</option>
									    <option value="017">019</option>
									</select>
									<input type="text" class="midNum" name="mgr_tel2" id="mgr_tel2" style="width:80px; height:20px;"/>
									<input type="text" class="lastNum" name="mgr_tel3" id="mgr_tel3" style="width:80px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">회사소개</th>
								<td colspan="5">
									<input type="text" class="comp_info" name="comp_info" id="comp_info" style="width:900px; height:200px;"/>
								</td>
							</tr>
							<input type="hidden" name="user_type" value="C" />
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="javascript:CompleteComp();" class="btnType blue"
							id="RegisterCom" name="btn"> <span>회원가입 완료</span></a> <a href=""
							class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form> -->
	<jsp:include page="/WEB-INF/view/hla/hUserInfoFormat.jsp"></jsp:include>
	<!-- 아이디 비밀번호 찾기 모달 -->
	<form id="sendForm" action="" method="post">
		<input type="hidden" name="authNumId" id="authNumId" value="" /> 
		<input type="hidden" name="authNumPwd" id="authNumPwd" value="" />
		<input type="hidden" name="ckIdcheck" id="ckIdcheck" value=""/>
		<div id="layer2" class="layerPop layerType2" style="width: 750px;">
			<dl>
				<dt>
					<strong>아이디/비밀번호 찾기</strong>
				</dt>
				<dd>
					<div class="btn_areaC mt30">
						<a href="javascript:fSelectId();" class="btnType gray" id="findId"><span>아이디
								찾기</span></a> <a href="javascript:fSelectPwd();" class="btnType gray"
							id="findPwd"><span>비밀번호 찾기</span></a>
					</div>
				</dd>
				<dd class="content">

					<!-- 아이디/비밀번호 찾기 폼 -->
					<table class="row" id="findForm">
						<tbody>
							<tr>
								<td id="registerEmailId"><input type="text" id="emailText"
									data-code="I" placeholder="가입하신 이메일을 입력하세요" size="30"
									style="height: 30px;" /> <a href="javascript:SendEmail();"
									class="btnType blue" id="findIdSubmit"><span>이메일 전송</span></a></td>

								<td id="confirm"><input type="text" id="emailNum"
									placeholder="전송된 인증번호를 입력하세요" size="30" style="height: 30px;" />
									<a href="javascript:SendComplete();" class="btnType blue"
									id="sendMail"><span>인증하기</span></a></td>
							</tr>
						</tbody>
					</table>

					<table class="row" id="findPwdForm">
						<tbody>
							<tr>
								<td id="loginRegister"><input type="text" id="emailIdText"
									placeholder="가입하신 아이디를 입력하세요" size="30" style="height: 30px;" />
									<a href="javascript:RegisterIdCheck();" class="btnType blue" id=""><span>아이디 체크</span></a></td>

								<td id="loginEmail"><input type="text" id="emailPwdText"
									data-code="P" placeholder="가입하신 이메일을 입력하세요" size="30"
									style="height: 30px;" /> <a href="javascript:SendPwdEmail();"
									class="btnType blue" id=""><span>이메일 전송</span></a></td>

								<td id="loginPwd"><input type="text" id="emailPwdNum"
									data-code="P" placeholder="전송된 비밀번호를 입력하세요" size="30"
									style="height: 30px;" /> <a
									href="javascript:SendCompletePwd();" class="btnType blue"
									id="emailOk"><span>인증하기</span></a></td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="RegisterCom" name="btn"> <span>완료</span></a>
						<a href="" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>