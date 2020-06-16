<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>마이페이지</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->  

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>

.container{
	display : grid;
	grid-template-columns : 223px 1fr;
	/* margin : 0 auto; */
}

.menu{
	height : 700px;
}

.info{
	/* magin : 0 auto; */
}

.abc{
	display : flex;
	grid-template-rows : repeat(7, 1ft);
}

</style>


<script>

$(function(){      
	console.log('33333333333333333333333333333333333333333333333333333333333333');
	
	selectMyinfo();
    
    console.log('22222222222222222222222222222222222222222222222222222222222222');
    
});

function fSaveRegister(data) {

	if (data.result == "SUCCESS") {
		alert(data.resultMsg);
		gfCloseModal();
	} else {
		alert(data.resultMsg);
		return false;
	}
}

function selectMyinfo() {
	
	var param = {}
	
	var resultCallback = function(data) {
		//console.log("deletecallback? 2");
		selectResgisterCallback(data);
	};
	callAjax("/jmyp/selectRegister.do", "post", "json", true, param, resultCallback);
	
}

function selectResgisterCallback(data) {
	
	var param = [];
	param = data.myinfo;
	var user_skill = data.skill;
	
	console.log(data.myinfo);
	
	$('#loginID').val(param.loginID);
	$('#password').val(param.password);
	$('#name').val(param.name);
	$('#email').val(param.email);
	$('#email_cop').val(param.email_cop);
	$('#sex').val(param.sex);
	$('#grade').val(param.grade);
	$('#position').val(param.user_position);
	$('#area').val(param.area);
	$('#comp_area1').val(param.comp_area1);
	$('#comp_area2').val(param.comp_area2);
	$('#comp_area3').val(param.comp_area3);
	$('#tel1').val(param.tel1);
	$('#tel2').val(param.tel2);
	$('#tel3').val(param.tel3);
	$('#birthday').val(param.birthday);
	$('#title').val(param.title);
	$('#salary').val(param.salary);
	$('#consultyn').val(param.consult_yn);
	$('#career_contents').val(param.career_contents);
	$('#singular_facts').val(param.singular_facts);
	$('#skill_add').val(param.skill_add);
	$('#career_year').val(param.career_year);
	$('#career_mm').val(param.career_mm);
	
	var skill = document.getElementsByName('skillcheck');
	
	skill.forEach(function(item){
		
		item.checked=false;
		return false;
	});
	
	var skill_detail = param.skill_detail;
	
	var skill_arr = skill_detail.split('/');
	
	skill_arr.forEach(function(skill_dt){
		
		console.log(skill_dt);
		
		/* 언어 */
		if(skill_dt == 'AS400') {
			
			$('#as400Check').prop('checked', true);
			
		}
		
		if(skill_dt == 'C') {
			
			$('#cCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Cpp') {
			
			$('#cppCheck').prop('checked', true);
			
		}
		
		if(skill_dt == '#CSharp') {
			
			$('#csharpCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'COBOL') {
			
			$('#cobolCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Delphi') {
			
			$('#delphiCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'JAVA') {
			
			$('#javaCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'VB') {
			
			$('#vbCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'VC') {
			
			$('#vcCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'net') {
			
			$('#netCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'python') {
			
			$('#pythonCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Power_Builder') {
			
			$('#powerCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'R') {
			
			$('#rCheck').prop('checked', true);
			
		}
		
		/* 웹 */
		if(skill_dt == 'ASP') {
			
			$('#aspCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'JSP') {
			
			$('#jspCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'PHP') {
			
			$('#phpCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'XML') {
			
			$('#xmlCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'DHTML') {
			
			$('#dhtmlCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'miPaltform') {
			
			$('#miCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'xPaltform') {
			
			$('#xCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Nexacro') {
			
			$('#nexaCheck').prop('checked', true);
			
		}
		
		/* OS */
		if(skill_dt == 'UNIX') {
			
			$('#unixCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'LINUX') {
			
			$('#linuxCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'MAC') {
			
			$('#macCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'MVC') {
			
			$('#mvcCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'SOLARIS') {
			
			$('#solCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'WINDOWS') {
			
			$('#winCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'WINDIWS_SERVER') {
			
			$('#winServerCheck').prop('checked', true);
			
		}
		
		/* FrameWork */
		if(skill_dt == 'Spring') {
			
			$('#springCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'eGov') {
			
			$('#egovCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Struts') {
			
			$('#strutsCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'jQuery') {
			
			$('#jqueryCheck').prop('checked', true);
			
		}
		
		/* DB */
		if(skill_dt == 'Access') {
			
			$('#accCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'DB2') {
			
			$('#db2Check').prop('checked', true);
			
		}
		
		if(skill_dt == 'Informix') {
			
			$('#mixCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'ORACLE') {
			
			$('#orclCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'MS_SQL') {
			
			$('#msCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'MY_SQL') {
			
			$('#myCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Sybase') {
			
			$('#sybaseCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'MariaDB') {
			
			$('#mariaCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Tibero') {
			
			$('#tibCheck').prop('checked', true);
			
		}
		
		/* NetWork */
		if(skill_dt == 'Cisco_Router') {
			
			$('#routerCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'Cisco_SW') {
			
			$('#swCheck').prop('checked', true);
			
		}

		if(skill_dt == 'CORBA') {
			
			$('#corbaCheck').prop('checked', true);
			
		}

		if(skill_dt == 'LAN') {
			
			$('#lanCheck').prop('checked', true);
			
		}

		if(skill_dt == 'iot') {
			
			$('#iotCheck').prop('checked', true);
			
		}
		
		/* WebServer/WAS */
		if(skill_dt == 'Tomcat') {
			
			$('#tomCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'JEUS') {
			
			$('#jeusCheck').prop('checked', true);
			
		}

		if(skill_dt == 'WebSphere') {
			
			$('#sphereCheck').prop('checked', true);
			
		}

		if(skill_dt == 'WebLogic') {
			
			$('#logicCheck').prop('checked', true);
			
		}

		if(skill_dt == 'IIS') {
			
			$('#iisCheck').prop('checked', true);
			
		}
		
		if(skill_dt == 'JBoss') {
			
			$('#jbossCheck').prop('checked', true);
			
		}
		
	});
	
	/* 참여구분 */
	
	var position = document.getElementsByName('position');
	
	position.forEach(function(posi){
		
		posi.checked=false;
		return false;
	});
	
	var positionlist = param.user_position;
	
	var position_arr = positionlist.split(',');
	
	position_arr.forEach(function(position_check){
		
		if(position_check == 'SI'){
			$('#siposition').prop('checked', true);
		}
		
		if(position_check == 'SM'){
			$('#smposition').prop('checked', true);
		}
		
		if(position_check == 'SOLUTION'){
			$('#solposition').prop('checked', true);
		}
	});
	
	/* 협의 가능 여부 */
	var consult = document.getElementsByName('consultyn');
	
	consult.forEach(function(posi){
		
		posi.checked=false;
		return false;
	});
	
	var price = param.consult_yn
		
	if(price == 'Y'){
		$('#consultyn').prop('checked', true);
	}
	
}

function updateUser(){
	
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
	
	var param = $("#MyinfoForm").serialize();
	
	$.ajax({
		url : "/jmyp/userUpdate.do",
		type : "post",
		dataType : "json",
		async : false,
		data : param,
		success : function(data) {
//			alert("수정이 완료가 되었습니다.");
			fSaveRegister(data);
		}
	});
	
}

/* 생년월일 */
$(function(){
    $.datepicker.setDefaults($.datepicker.regional["ko"]);
    $("#birthday").datepicker({
        showOn: "both",
        buttonImage: "images/calendar/calendar.gif",
        buttonImageOnly: true,
        buttonText: "Select date"
    });
});

</script>

</head>
<body>
	<form id="MyinfoForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="skilldetail" id="skilldetail" value="">
		<input type="hidden" name="userPosition" id="userPosition" value="">
		<div class="container" id="layer1">
			<div class="menu">
				<li class="lnb">
				<!-- lnb 영역 --> 
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
			</div>
			<div class="info">
				<dl>
						<!-- <dt>
							<strong>일반회원 마이페이지</strong>
						</dt> -->
						
		 				<dd class="content">
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
										<td><input type="text" class="idtxt" name="loginID" id="loginID" style="width:100px; height:20px;" readonly/></td>
										<th scope="row" style="width:100px;">비밀번호 <span class="font_red">*</span></th>
										<td colspan="3"><input type="password" class="passtxt" name="password" id="password" style="width:100px; height:20px;"/></td>
									</tr>
									<tr>
										<th scope="row" style="width:100px;">이름<span class="font_red">*</span></th>
										<td><input type="text" class="nmtxt" name="name" id="name" style="width:100px; height:20px;"/></td>
										<th scope="row" style="width:100px;">이메일<span class="font_red">*</span></th>
										<td colspan="3">
											<input type="text" class="mailtxt" name="email" id="email" style="width:80px; height:20px;"/>
											@
											<input class="domaintxt" name="email_cop" id="email_cop" list="emailselect" placeholder="직접입력/선택" style="width:100px; height:20px;"/>
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
											<select name="grade" id="grade" style="width:100px; height:22px;">
											    <option value="">등급 선택</option>
											    <option value="초급">초급</option>
											    <option value="중급">중급</option>
											    <option value="고급">고급</option>
											    <option value="특급">특급</option>
											</select>
										</td>
										<th scope="row">참여 구분</th>
										<td>
											<p><input type="checkbox" id="siposition" name="position" value="SI"> <label for="siposition">SI(상주프로젝트)</label></p>
											<p><input type="checkbox" id="smposition" name="position" value="SM"> <label for="smposition">SM(상주프로젝트)</label></p>
											<p><input type="checkbox" id="solposition" name="position" value="SOLUTION"> <label for="solposition">솔루션개발</label></p>
										</td>
									</tr>
									<tr>
										<th scope="row" style="width:100px;">생년 월일<span class="font_red">*</span></th>
										<td>
											<input type="text" class="date" name="birthday" id="birthday" style="width:100px; height:20px;" data-date-format='yyyy-mm-dd' autocomplete=off/>
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
											<select name="comp_area1" id="comp_area1" style="width:90px; height:22px;">
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
											<select name="comp_area2" id="comp_area2" style="width:90px; height:22px;">
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
											<select name="comp_area3" id="comp_area3" style="width:90px; height:22px;">
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
											<input type="text" class="salary" name="salary" id="salary" style="width:100px; height:20px;"/>
											<input type="checkbox" name="consultyn" id="consultyn" /> <label for="priceCheck">협의 가능</label>
											<input type="hidden" id="consult_yn" name="consult_yn" />
										</td>
									</tr>
									<tr>							
										<th scope="row" style="width:100px;">경력 기간</th>
										<td colspan="3">
											<select name="career_year" id="career_year" style="width:90px; height:22px;">
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
											<select name="career_mm" id="career_mm" style="width:90px; height:22px;">
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
											<input type="text" class="add" name="skill_add" id="skill_add" style="width:800px; height:20px;"/>
										</td>
									</tr>
									<tr>
										<th scope="row" style="width:100px;">경력내용</th>
										<td colspan="7">
											<input type="text" class="career" name="career_contents" id="career_contents" style="width:1180px; height:50px;"/>
										</td>
									</tr>
									<tr>
										<th scope="row" style="width:100px;">특이사항</th>
										<td colspan="7">
											<input type="text" class="speciality" name="singular_facts" id="singular_facts" style="width:1180px; height:50px;"/>
										</td>
									</tr>
									
									<input type="hidden" name="user_type" value="D" />
								</tbody>
							</table>
		
							<div class="btn_areaC mt30">
								<a href="javascript:updateUser();" class="btnType blue"
									id="Update" name="Update"> <span>수정 완료</span></a> <a href=""
									class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
							</div>
						</dd>
					</dl>
			</div>	
		</div>
	</form>


</body>
</html>