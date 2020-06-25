<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>기업 마이페이지</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->  

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>

.container{
	display : grid;
	grid-template-columns : 223px 1fr;
	/* margin : 0 auto; */
}

</style>

<script>
	
$(function(){      
	
	selectCompinfo();
    
});

function fSaveComp(data) {

	if (data.result == "SUCCESS") {
		alert(data.resultMsg);
		gfCloseModal();
	} else {
		alert(data.resultMsg);
		return false;
	}
}

function selectCompinfo() {
	
	var param = {};
	
	var resultCallback = function(data) {
		//console.log("deletecallback? 2");
		selectCompCallback(data);
	};
	callAjax("/jmyp/selectComp.do", "post", "json", true, param, resultCallback);
	
}

function selectCompCallback(data) {
	
	var param = [];
	param = data.compinfo;
	
	console.log(param);
	
	$('#loginID').val(param.loginID);
	$('#password').val(param.password);
	$('#comp_name').val(param.comp_name);
	$('#email').val(param.email);
	$('#email_cop').val(param.email_cop);
	$('#mgr_tel1').val(param.mgr_tel1);
	$('#mgr_tel2').val(param.mgr_tel2);
	$('#mgr_tel3').val(param.mgr_tel3);
	$('#mgr_name').val(param.mgr_name);
	$('#birthday').val(param.birthday);
	$('#comp_info').val(param.comp_info);
	
}

function updateComp(){
	
	var param = $("#compinfoForm").serialize();
	
	$.ajax({
		url : "/jmyp/compUpdate.do",
		type : "post",
		dataType : "json",
		async : false,
		data : param,
		success : function(data) {
			fSaveComp(data);
		}
	});
	
}

/* 설립일 */
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
	<form id="compinfoForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<div class="container">
			<div class="menu">
				<li class="lnb">
				<!-- lnb 영역 --> 
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
			</div>
			<div class="info">
				<dl>
				<dt>
					<strong>기업회원 가입</strong>
				</dt>
				<dd>
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
							<tr>
								<th scope="row" style="width:100px;">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="loginID" id="loginID" style="width:100px; height:20px;" readonly/></td>
								<th scope="row" style="width:100px;">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="password" class="passtxt" name="password" id="password" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">회사명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="comp_name" id="comp_name" style="width:100px; height:20px;"/></td>
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
							</tr>
							<tr>
								<th scope="row" style="width:100px;">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="mgr_name" id="mgr_name" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">설립일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="compDate" name="birthday" id="birthday" style="width:100px; height:20px;" data-date-format='yyyy-mm-dd' autocomplete=off/>
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
						<a href="javascript:updateComp();" class="btnType blue"
							id="RegisterCom" name="btn"> <span>수정 완료</span></a> <a href=""
							class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
				</dl>
			</div>
		</div>
	</form>
</body>
</html>