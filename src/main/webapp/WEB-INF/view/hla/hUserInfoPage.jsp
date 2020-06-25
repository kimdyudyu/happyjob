<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유저관리</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!--  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>-->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/hla/hUserInfoVue.jsp"></jsp:include>
<script type="text/javascript">


var pageSizeUserList = 5;
var pageBlockSizeUserList = 5;

var UserListVue;

$(function(){
	/*hUserInfoHeader();
	hUserInfoHeaderVue.Init("U");
	hUserInfoVueInit();
	hUserInfoFooter();
	totalInit();*/
	UserInfoFormInit();
	InitUserList();
	UserListVue.UserList();

});

function InitUserList() {
	
	UserListVue = new Vue({
		el: '#UserTableVue',
		data: {
				vFromDate 			: ''
			,	vToDate   			: ''
			,	vUserName			: ''
			,	vUserType	 		: '' // C 학생 , D 강사
			,	vUserDatas			: []
			,	vPageType			: ''
		}
  		,methods: {
  			Init : function()
  			{
  				this.vPageType = $("#calltype").val();
  				//alert(this.vPageType);
  			},
  			showDetail : function(loginID){
  				
  				gfModalPop("#userInfoPopup");
  			},
  			UserList : function(pageIndex)
  			{
  				pageIndex = pageIndex || 1;
				
				var param = {
							pageIndex 		: pageIndex
						,	pageSize 		: pageSizeUserList
						,	UserName		: this.vUserName
						,	fromDt   		: this.vFromDate
						,	toDt	 		: this.vToDate
						,	user_type		: this.vPageType
						//,	MsgKinds		: $('input[name="msgKinds"]:checked').val()
				}
				
				//console.log("여기왔나요? 1");
				var resultCallback = function(data) {
					UserInfoListCallback(data, pageIndex);
				};				
				
				callAjax("/hla/hUserInfoList.do", "post", "json", true, param, resultCallback);
  			},
  			UpdatePopup : function(Data)
  			{
  				
  				SetFormUseType("U");
  				hUserInfoVue.setUserData(Data);
  				gfModalPop("#userInfoPopup");
  			},
  			RegistTeacher : function()
  			{
  				SetFormUseType("I");
  				hUserInfoVue.SetUserType("D");
  				gfModalPop("#userInfoPopup");
  			}
  		}
	});
	
	UserListVue.Init();
	
	var fromDate = $("#fromDate").datepicker({ 
		dateFormat: 'yy-mm-dd'
	});
	  
	$("#fromDate").change(function() {
		//$("#userBirth").datepicker("option", "minDate", $(this).val());
		UserListVue.vFromDate = $("#fromDate").val();
	})
	
	var toDate = $("#toDate").datepicker({ 
		dateFormat: 'yy-mm-dd'
	});
	  
	$("#toDate").change(function() {
		UserListVue.vToDate = $("#toDate").val();
	})
}

function UserInfoListCallback(data, pageIndex)
{
	UserListVue.vUserDatas=[];
	UserListVue.vUserDatas=data.UserInfoList;		
	console.log(data);
	var SelectedCnt = data.SelectedCnt;
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(pageIndex, SelectedCnt, pageSizeUserList, pageBlockSizeUserList, 'UserListVue.UserList');
	//console.log("paginationHtml : " + paginationHtml);
	//alert(paginationHtml);
	$("#Pagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPage").val(pageIndex);
}




</script>
</head>

<body>
	<form id="UserInfoForm" action="" method="">
		<input type="hidden" id="currentPage" value="1">
		<input type="hidden" id="calltype" value="${calltype}">
		
		
		
		<div id="wrap_area">
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>	

				<li class="contents">
					<div class="content">						
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">인원 관리</a> <span class="btn_nav bold"> 유저관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<div class="UserTableVue" id="UserTableVue">
							<p class="conTitle">
								<span>인원 관리</span> 
								<template v-if=" vPageType === 'D' ">
									<span class="fr"> 
									<a class="btnType blue" style="cursor:pointer"  v-on:click="RegistTeacher()" >
									<span>신규 등록</span></a>
								</template>
								</span>
							</p>				    	
				   	 		<table class="col" >
				   	 			<caption>caption</caption>
				   	 			<tbody>        
									<tr style="" >
										<td>
											<span>이름 </span>
										</td>
										<td>
											<input id="UserName" style="height: 20px; width: 300px;" type="text" name="user_Name" size="20" v-model="vUserName" @keyup.enter="UserList()">
										</td>
										<td>
											<span> 일자 </span>
										</td>	
										<td>
											<input type="text" style="height: 20px; width: 110px;" class="txtInput" id="fromDate"  data-date-format='yyyy-mm-dd' autocomplete=off v-model="vFromDate">
										</td>	
										<td>
											<span><b>&nbsp; ~ &nbsp;</b></span>
										</td>							
										<td>
											<input type="text" style="height: 20px; width: 110px" class="txtInput" id="toDate" name="toDt" data-date-format='yyyy-mm-dd' autocomplete=off v-model="vToDate">
										</td>
										<td rowspan="2">
									    	<a style="cursor:pointer" class="btnType blue" v-on:click="UserList()" name="modal" id="SearchBtn" @keyup.enter=""><span>검색</span></a>
										</td>								
									</tr>
								</tbody>
							</table>					
							<div class="table-thead-box">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="15%">
										<col width="25%">
										<col width="25%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th class="th_info" >번호</th>
											<th class="th_info" >이름</th>
											<th class="th_info" >아이디</th>
											<th class="th_info" >전화번호</th>
											<th class="th_info" >가입일자</th>
											<th class="th_info" >수정</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(User, index) in vUserDatas">
											<tr>
												<!--  <td class="hidden">{{ Message.msg_code }}</td>-->
												<td>{{ index + 1}}</td>									
												<td>{{ User.name }}</td>
												<td>{{ User.loginID }}</td>
												<td>{{ User.tel1 + "-" +  User.tel2 + "-" + User.tel3 }}</td>	
												<td>{{ User.joinDate }}</td>
												<td><a style="cursor:pointer" class="btnType blue" @click="UpdatePopup(User)"><span>수정</span></td>
											</tr>													
										</template>
										</tbody>
									</table>	
								</div>	
								<div class="paging_area"  id="Pagination"> </div>		
							</div>
						</div>
					</li>	
				</ul>				
			</div>
		</div>
	</form>
	
	
	<jsp:include page="/WEB-INF/view/hla/hUserInfoFormat.jsp"></jsp:include>

</body>
</html>