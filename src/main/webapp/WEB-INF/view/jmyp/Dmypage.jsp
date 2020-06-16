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


<script type="text/javascript">


//페이징 설정 
var noticePageSize = 10;    	// 화면에 뿌릴 데이터 수 
var noticePageSizevue = 10;
var noticePageBlock = 10;		// 블럭으로 잡히는 페이징처리 수

var vm;
var svm;
var ved;
var pDetailVue;


$(function(){
	init();
	getCommonCode();
	getBoard();
});

function init() {
	comcombo("areaCD", "areasel", "all", "53");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
	 //items = 넥사크로 dataSet과 같다.
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
	                
	                $('#lec_pl').val(tdArr[0]);
	                
	                gfModalPop("#layer1");
			        
			      },
			  	selectOne:function(projectId){
			  		// 프로젝트 상세보기
			  		

			  		goDetail(projectId);
			  		
			  		// $('#lec_pl').val(projectId);
			  		// gfModalPop("#layer1");
		  		}
			      , supportCancelVue:function(projectId, loginId){
			    	  // 지원 취소
			    	  // alert(loginId);
			    	  
			    	  supportCancel(projectId, loginId);
			      }
			      
			  
		  }// method end		      
		});	// vm end
	 
		
		pDetailVue = new Vue({
			el : "#detailtable_p",
			data : {
				P_loginID :'',
				p_begin :'',
				p_middle: '',
				p_high : '',
				p_special : '',
				p_notoDetail : '',
				p_option_order : '',
				p_singular_facts : '',
				p_searchareaDetail : '',
				p_searchjobDetail:'',
				p_searchindDetail : '',
				p_searchSWCD : '',
			},
			methods : {
				delete_pFunc : function(){
					
				}
			}
		});
		
		
		
	 
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
		 
		 
		 
};



//공통 코드 불러오기
function getCommonCode(){
	comcombo("areaCD","searcharea","all","");
	comcombo("JOBCD","searchjob","all","");
	comcombo("industryCD","searchind","all","");

	//상세보기 
	comcombo("areaCD","p_searchareaDetail","all","");
	comcombo("JOBCD","p_searchjobDetail","all","");
	comcombo("industryCD","p_searchindDetail","all","");
	comcombo("SWCD","p_searchSWCD","all","");
}




// 게시판
function getBoard(currentPage) {
	currentPage = currentPage || 1;   // or
	var dID = $("#dID").val();
	
	
	var param = {
			currentPage : currentPage ,
			pageSize : noticePageSizevue,
			dID : dID
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		gridBoard(data, currentPage); 
	}
	
	callAjax("/jmyp/mypageA.do","post","json", true, param, resultCallback);
	
}

function gridBoard(data, currentPage) {
	 vm.items=[];
	 vm.items=data.getBoard;
	 
	 console.log("vm.items : " + JSON.stringify(vm.items));
	 
	 //console.log(":::::::::::::::::::::::::::::::::::::::::::::::");
	 //console.log("data.getBoard : " + JSON.stringify(data.getBoard));
	 
	console.log(data.totalCnt + " : " + currentPage);
	 
	 var totalCnt = data.totalCnt;  // qnaRealList() 에서보낸값 
	 var listnum = $("#tmpListNum").val();
	 
 	var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSizevue,noticePageBlock, 'getBoard');
	 
    $("#pagingnavi2").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
   $("#currentPagevue").val(currentPage);
}



function mypageSearch(currentPage) {
	currentPage = currentPage || 1;   // or
	
	var fromDt = $('#fromDt').val();// 시작일
	var toDt = $('#toDt').val();// 끝
	var searchTxt = $('#searchTxt').val();// 회사명
	
	
	var dID = $("#dID").val();
	
	var param = {
			fromDt : fromDt
			, toDt : toDt
			, searchTxt : searchTxt
			, currentPage : currentPage 
			, pageSize : noticePageSizevue
			, dID : dID		
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		search(data, currentPage); 
	}
	
	callAjax("/jmyp/searchD.do","post","json", true, param, resultCallback);
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



function goDetail(projectId) {

	var param = {
			projectId : projectId
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		projectDetail(data); 
	}
	
	callAjax("/jmyp/projectDetailD.do","post","json", true, param, resultCallback);
}

function projectDetail(data) {
	
	var list = data.projectDetail
    
	
	
	
	var info = data.detailone;
    var user_skill = data.skill;
    var loginId = data.loginId;
    console.log("user_skill ",user_skill);
    
    
    

	//상세화면 다시 조회했을시 선택되어있는 항목 초기화
	$('input[type=checkbox]').prop('checked',false);
	

    // 여기서 값주는건 Vue로 값주네
    // pDetailVue.P_loginID =info.loginID;
    pDetailVue.P_loginID =info.project_name;
    pDetailVue.p_begin = info.low;
    pDetailVue.p_middle =info.middle;
    pDetailVue.p_high = info.high
    pDetailVue.p_special = info.special;
    pDetailVue.p_notoDetail = info.note
    pDetailVue.p_option_order = info.option_order;
    pDetailVue.p_singular_facts = info.notice;
    pDetailVue.p_searchareaDetail = info.area;
    pDetailVue.p_searchjobDetail = info.job;
    pDetailVue.p_searchindDetail = info.industry;
    pDetailVue.p_searchSWCD = info.position_ime;

    
    var skill = document.getElementsByName('skill_P');


    //전문기술 체크박스
    skill.forEach(function(item){
                                // 여기서 item은 controller에서 보낸 리스트값들

        user_skill.forEach(function(user_item){

            var user_skill = user_item.skillDetail;
            var item_skill =item.value;

            if(item_skill == user_skill) {
            	console.log("tutututu");
            	console.log(item_skill);
            	console.log(user_skill);
                item.checked=true;
                return false;
            }
        });

    });

    //근무기간
    $('#pService').val(info.work_fr_date);
    $('#pServiceEnd').val(info.work_to_date);

    //접수기간
    $('#pSign').val(info.receive_fr_date);
    $('#pSignEnd').val(info.receive_to_date);

    //면접형태
    if(info.tel_interview_yn) document.getElementById('telYn').checked = true;
    if(info.dr_interview_yn) document.getElementById('dictYn').checked = true;

    //장비지원여부
    if(info.device_yn) document.getElementById('support_p').checked = true;


    //식사제공여부
    if(info.meadl_yn) document.getElementById('mealSupport_p').checked = true;

    //숙박제공여부
    if(info.user_type =='D'){
        document.getElementById('delete_p').style.display = 'none';
        document.getElementById('modify_p').style.display = 'none';

    }

    
    
    
	gfModalPop("#noticeDetailvue_p");
	
	
	
}


function cancle() {
	gfCloseModal();
}



function supportCancel(projectId, loginId) {
	
	var param = {
			projectId : projectId	
			, loginId : loginId
	}
	
	var result = confirm("정말로 지원을 취소하시겠습니까??");
	if(result){

		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			supportCancelResult(data); 
		}
		
		callAjax("/jmyp/supplyDeleteD.do","post","json", true, param, resultCallback);
		
	}else{
	    alert("취소되었습니다.");
	}
}

function supportCancelResult(data) {
	console.log("삭제되었습니다.");
}

</script>
</head>
<body>

<input type="hidden" id="currentPage" value="1"> 
<input type="hidden" id="currentPagevue" value="1">

<c:out value="${ofcDvsCod}"/><c:set var="ofcDvsCod" value="<%=session.getAttribute(\"loginId\").toString()%>" />
<input type="hidden" id= "dID" value="<c:out value="${ofcDvsCod}"/>">

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
	
	
	
	<!-- 공통 콤보박스 !!!!! 안쓰니까 주석처리 -->
	<!-- <select id="areasel" name="areasel" style="width:300px;">   </select> -->
	
	
	<table style="height: 90px">
		<colgroup></colgroup>
		<colgroup></colgroup>
		<colgroup></colgroup>
		<colgroup></colgroup>
		<thead>
		</thead>
		<tbody>
			<tr style="">
				<td><span>회사명     </span></td>
				<td>&nbsp;&nbsp;</td>
				<td colspan="4"><input type="text" style="height: 31px;"
					id="searchTxt" name="searchTxt" class="txtInput"> <span
					width="110" height="60" style="font-size: 120%"> 
				</span></td>
			
				<td><span><b>&nbsp &nbsp  &nbsp</b></span></td>
				<td><span>지원 일자: </span></td>
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
								<th data-field="loginID">프로젝트명</th>
								<th data-field="write_date">회사명</th>
								<th data-field="write_date">지원일자</th>
								<th data-field="write_date">지원취소</th>
							</tr>
						</thead>
						<tbody>
							<!--  v-if, items의 데이터가 있을 떄만 뿌리곘다 -->
							<template>
							<tr v-for="(row, index) in items" v-if="items.length">
								<td v-on:click="selectOne( row.projectId )">{{ row.projectName }}</td>
								<td>{{row.compName}}</td>
								<td>{{row.applyDate}}</td>
								<td>
									<a v-on:click="supportCancelVue(row.projectId, row.loginId )" class="btnType blue" href=""><span>지원취소</span></a>
								</td>
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
	<div class="paging_area" id="pagingnavi2"></div>							 
					 
					 
	</div>			
					         

	</li> <!--  contents, end -->
	
	</ul>
	</div>
	
	
	
	
	
	<!-- 
		 ---------------------------------------------------------------------------------------------------------
	 -->
	 
	 
	
		
<!--프로젝트 상세보기 -->
<jsp:include page="/WEB-INF/view/jmyp/JmProjectDetail.jsp"></jsp:include>
						
</body>
</html>