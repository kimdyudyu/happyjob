<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!--  include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 



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



<script type="text/javascript">


//페이징 설정 
var noticePageSize = 10;    	// 화면에 뿌릴 데이터 수 
var noticePageSizevue = 10;
var noticePageBlock = 10;		// 블럭으로 잡히는 페이징처리 수



var vm;
var svm;
var ved;
var user;

$(function(){
	init();
	getBoard();
});

function init() {
	

		 
		 
    vm = new Vue({
		  el: '#vuetable',
		  components: {
		    'bootstrap-table': BootstrapTable
		  },
		  data: {
		    items: [],
		    options: {
		    }			    
		  },
		  methods: {
		    
			  rowClicked(row) {
			        console.log("row : " + row);
			        
			        var str = "";
	                var tdArr = new Array();    // 배열 선언
	                    
	                
	                var tr = $(row);
	                var td = tr.children();
	                
	                td.each(function(i){
	                    tdArr.push(td.eq(i).text());
	                });
	                        
	                // fNoticeModal2(tdArr[1]);
	                
	                console.log("배열에 담긴 값 : "+tdArr[0]);
	                
	                // $('#lec_pl').val(tdArr[0]);
	                // gfModalPop("#layer1");
			        
			      },
			  	selectOne:function(projectId){
			  		supplyUser(projectId);
		  		}
			      , supportCancel:function(title){
			    	  alert(title);
			      }
			      
			  
		  }// method end
		  
		  
		});	// vm end
		
		

		   var dateFormat = "yy-mm-dd";
	       //시작일
	       fromDt = $("#fromDt").datepicker({ 
	      	 dateFormat: dateFormat,
	       }); 
	       toDt = $("#toDt").datepicker({ 
	      	 dateFormat: dateFormat,
	       });
	       
	       $("#fromDt").change(function() {
	      	 $("#toDt").datepicker("option", "minDate", $(this).val());
			 })
			 $("#toDt").change(function() {
	      	 $("#fromDt").datepicker("option", "maxDate", $(this).val());
			 })
			 
			 
			 
			 
		user = new Vue({
			  el: '#vuetable2',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: [],
			    options: {
			    }			    
			  },
			  methods: {
				  
				  
				  userInfo:function(loginId, skillAdd){
					  
					  // checkbox값 초기화
					  $('input[type=checkbox]').prop('checked',false);
					  
				  		
				  		
					  	// db값 
					  	var arrModel = skillAdd.split(",");
					  	
					  	console.log(":::::::::::::::::::::::::"+arrModel);
					  	
					  	
					  	// IFNULL로 null값일 떄 1로 해줬다
					  	if (arrModel == "없음") {
					  		goUserInfo(loginId);
					  	}
				  		
				  		// jsp단
				  		var skill = document.getElementsByName('skill_P');
				  		var size = document.getElementsByName("skill_P").length;
					  		
					  	//전문기술 체크박스
					  	  skill.forEach(function(item){
					  		arrModel.forEach(function(itemValue){
					  			
					  			var item_skill =item.value;
					  			var dbValue = itemValue
					  		
					  			if(item_skill == dbValue) {
					                item.checked=true;
					                return false;
					            }
					  		});
					      });
					  	goUserInfo(loginId);
			  		}// userInfo:function END
			  
			  
				  
			  }// method end		      
			});	
		
	 
		
		 
		 
};





//게시판
/////////////////////

function getBoard(currentPage) {
	currentPage = currentPage || 1;   // or
	
	var cID = $("#cID").val();
	
	var param = {
			currentPage : currentPage ,
			pageSize : noticePageSizevue,
			cID : cID
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		gridBoard(data, currentPage); 
	}
	
	callAjax("/jmyp/mypageC.do","post","json", true, param, resultCallback);
	
}

function gridBoard(data, currentPage) {
	 vm.items=[];
	 vm.items=data.getBoard;
	 

	 console.log(vm.items);
	 
	 // vm.items
	 
	 var totalCnt = data.totalCnt;  // qnaRealList() 에서보낸값
	 
	 var listnum = $("#tmpListNum").val();
	 
	 var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSizevue,noticePageBlock, 'getBoard');
	 
	 $("#pagingnavi2").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
	$("#currentPagevue").val(currentPage);
}




// user
///////////////////////

function supplyUser(projectId) {
	var param = {
			projectId : projectId
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		supplyUserCallback(data); 
	}
	
	callAjax("/jmyp/supplyList.do","post","json", true, param, resultCallback);
}


function supplyUserCallback(data) {
	user.items=[];
	user.items=data.getSupplyList;
	// console.log(JSON.stringify(data));
}





// search
/////////////////////

function mypageSearch(currentPage) {
	
	// supplyList 초기화
	$('#supplyList').empty();
	
	currentPage = currentPage || 1;   // or
	
	var fromDt = $('#fromDt').val();// 시작일
	var toDt = $('#toDt').val();// 끝
	var searchTxt = $('#searchTxt').val();// 회사명
	
	
	var cID = $("#cID").val();
	
	
	var param = {
			fromDt : fromDt
			, toDt : toDt
			, searchTxt : searchTxt
			, currentPage : currentPage 
			, pageSize : noticePageSizevue
			, cID: cID
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		search(data, currentPage); 
	}
	
	callAjax("/jmyp/searchC.do","post","json", true, param, resultCallback);
	
}


function search(data, currentPage) {
	vm.items=[];
 	vm.items=data.getBoard;
	 
	
	var totalCnt = data.totalCnt;  // qnaRealList() 에서보낸값 
	 var listnum = $("#tmpListNum").val();
	 
	var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSizevue,noticePageBlock, 'mypageSearch');
	 
   $("#pagingnavi2").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
  $("#currentPagevue").val(currentPage);
   
   
	// gfModalPop("#layer1");
	
}


// detail UserInfo





function goUserInfo(loginId) {
	
	
	 
	var param = {
			loginId : loginId
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		goUserInfoResult(data); 
	}
	
	callAjax("/jmyp/userInfoC.do","post","json", true, param, resultCallback);
	 

	gfModalPop("#layer1");
	
	
}

function goUserInfoResult(data) {
	var userInfo = data.userInfo;

	 // value 값으로 선택
	 $("#selectDb").val(userInfo.position).prop("selected", true);
	 $("#registerId").val(userInfo.loginId);
	 $("#registerName").val(userInfo.userName);
	 
	 $("#registerEmail").val(userInfo.email);
	 $("#registerEmail2").val(userInfo.emailCop);
	 $("#userSex").val(userInfo.userSex).prop("selected", true);
	 
	 
	 $("#date").val(userInfo.userBirthday);
	 $("#area").val(userInfo.area);
	 $("#tel1").val(userInfo.tel1);
	 $("#tel2").val(userInfo.tel2);
	 $("#tel3").val(userInfo.tel3);
	 $("#salary").val(userInfo.salary);
	 $("#title").val(userInfo.title);
	 $("#career").val(userInfo.careerYear+ "년" +userInfo.careerMm +"월");
	 
	 
	 
	 
	 
	 
	 
	 
	 
	
}


</script>
</head>
<body>

<input type="hidden" id="currentPage" value="1"> 
<input type="hidden" id="currentPagevue" value="1">


<c:out value="${ofcDvsCod}"/><c:set var="ofcDvsCod" value="<%=session.getAttribute(\"loginId\").toString()%>" />
<input type="hidden" id= "cID" value="<c:out value="${ofcDvsCod}"/>">


<div id="wrap_area">

	<h2 class="hidden">컨텐츠 영역</h2>
	<div id="container">
	<ul>
			
	<li class="lnb">
		<!-- lnb 영역 --> 
		<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
	</li>
	
	 
	 
	<!--  contents, start -->
	<li class="contents">
	
	
	
	<table style="height: 90px">
		<colgroup></colgroup>
		<colgroup></colgroup>
		<colgroup></colgroup>
		<colgroup></colgroup>
		<thead>
		</thead>
		<tbody>
			<tr style="">
			
				<td><span>프로젝트명     </span></td>
				<td>&nbsp;&nbsp;</td>
				<td colspan="4"><input type="text" style="height: 31px;"
					id="searchTxt" name="searchTxt" class="txtInput"> <span
					width="110" height="60" style="font-size: 120%"> 
				</span></td>
			
				<td><span><b>&nbsp &nbsp  &nbsp</b></span></td>
				<td><span>마감 일자: </span></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				
				<td><input type="text" style="height: 31px; width: 110px;"
					class="txtInput" id="fromDt" name="fromDt"></td>
					
				<td><span><b>&nbsp ~ &nbsp</b></span></td>
				
				<td><input type="text" style="height: 31px; width: 110px"
					class="txtInput" id="toDt" name="toDt"></td>
			
				<td><span><b>&nbsp &nbsp &nbsp</b></span></td>
				<td>
				<a href="javascript:mypageSearch()" class="btnType gray" id="btnSearch" name="btn">
				<span>검색</span></a>
				</td>
			</tr>
		</tbody>
	</table>
						
						
	<BR><BR>
	<div id="vuetable">
	
	<div class="bootstrap-table">
			<div class="fixed-table-toolbar">
				<div class="bs-bars pull-left"></div>
				<div class="columns columns-right btn-group pull-right">
				</div>
			</div>
			<div class="fixed-table-container" style="padding-bottom: 0px;">
				<div class="fixed-table-body">
	
					<table id="vuedatatable" class="col2 mb10"
						style="width: 1000px;">
						<colgroup>
							<col width="700px">
							<col width="120px">
							<col width="120px">
							<col width="220px">
						</colgroup>
						<thead>
							<tr>
								<th>프로젝트명</th>
								<th>마감일자</th>
								<th>지원자 수</th>
							</tr>
						</thead>
						<tbody>
							<!--  v-if, items의 데이터가 있을 떄만 뿌리곘다 -->
							<template>
							
							<tr v-for="(row, index) in items" v-if="items.length">
								<td v-on:click="selectOne( row.projectId )">{{ row.projectName }}</td>
								<td>{{row.receiveDead}}</td>
								<td>{{row.supplyCount}}</td>
							</tr>
							</template>
						</tbody>
					</table>
					<div>
						<div>
							<!-- <div class="clearfix" /> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="paging_area" id="pagingnavi2"></div>							 
					 
					 
	</div>		<!--  vuetable1 END -->

    	
	
		<div id="vuetable2">
		<div class="bootstrap-table">
				<div class="fixed-table-toolbar">
					<div class="bs-bars pull-left"></div>
					<div class="columns columns-right btn-group pull-right">
					</div>
				</div>
				<div class="fixed-table-container" style="padding-bottom: 0px;">
					<div class="fixed-table-body">
		
						<table id="vuedatatable" class="col2 mb10"
							style="width: 1000px;">
							<colgroup>
								<col width="700px">
								<col width="120px">
								<col width="120px">
								<col width="120px">
								<col width="220px">
							</colgroup>
							<thead>
								<tr>
									<th>성명</th>
									<th>제목</th>
									<th>희망지역</th>
									<th>등급</th>
									<th>전문기술</th>
								</tr>
							</thead>
							<tbody id ="supplyList">
								<template>
								 <tr v-for="(row, index) in items" v-if="items.length">
									<td v-on:click="userInfo( row.loginId, row.skillAdd )">{{ row.userName }}</td>
									<td>0</td>
									<td></td>
									<td></td>
									<td>{{row.skillAdd}}</td>
								</tr> 
								
								</template> 
							</tbody>
						</table>
						<div>
							<div>
								 <div class="clearfix" /> 
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- <div class="paging_area" id="pagingnavi2"></div>	 -->						 
						 
						 
		</div>		
	
	
	
					         

	</li> <!--  contents, end -->
	
	</ul>
	</div>
	
	
	
	
	
	<!-- 
		 ---------------------------------------------------------------------------------------------------------
	 -->
	 
	 
	 
	 
	 
	
	
	
</div>
		
<!--유저정보 상세보기 -->
<jsp:include page="/WEB-INF/view/jmyp/JmUserDetail.jsp"></jsp:include>

</body>
</html>