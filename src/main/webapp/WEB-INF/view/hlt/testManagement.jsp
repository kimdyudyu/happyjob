<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>잡코리아 dashboard</title>
<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
.clickable-rows {
	tbody tr td 
	{ 
		cursor:pointer;
	}

.el-table__expanded-cell {
	cursor: default;
}
.teacherliston{
	background-color:#fff; border:1px solid #bebebe; color:#000; !important
	}

</style>
<script type="text/javascript">

// 페이징 설정 
var PageSize = 5;   // 화면에 뿌릴 데이터 수 
//var noticePageSizevue = 5;
var pageBlockSize = 5;		// 블럭으로 잡히는 페이징처리 수

var courseVue;
var courseVueList;
var testVue;
var questionVue;
var infoVue;
var questBox;
var existStatus;
var testMain;
var testRe;
var endDate;

//var isM = isMobile();
var isM = false;
var popperProps = {
		  popperOptions: {
		    modifiers: {
		      preventOverflow: {
		        padding: 20
		      }
		    },
		    onUpdate: function (data) {
		      console.log(JSON.stringify(data.attributes))
		    }
		  }
		};
		

$(document).ready(function(){
	
	init();
	//현재 진행중인 강의 목록 불러오기
	getCourseList();
	
	//selectNoticeListvue();
});


function init() {
	courseVue = new Vue({
		 el: '#searcharea',  
         data: {
        	    stitle: ''
            }
	});
	
	courseVueList = new Vue({
		el : "#vuetable",
		data : {
			items: []
		},
		methods: {
			rowClicked : function(item) {
		    	
		       getTestResultList(item);
		        
		      }
		}
	});
	
	testVue = new Vue({
		el : "#testList",
		data : {
			items : []
		},
		methods : {
			testResultF:function(item){
				
				infoVue.no=item.no;
				infoVue.re = (item.status=="본시험") ? "main":"re";
				
				questBox=[];
				$('#saveQuestion').text("저장");
				
				$('#makingQuestionList').empty();
				
				var listV;
				if(item.status == "본시험"){ //본시험 click
					
					alert("mainClick");
					
					if(!isEmpty(testMain)){	
						listV= testMain;
					} 
				}else{ //재시험 click
					
					alert("reClick");
					
					if(!isEmpty(testRe)){
						listV =	testRe;
					}
				}
				var tag;
				
				if(!isEmpty(listV)){
					questBox = listV;
					
					console.log("listV : ",listV);
					$.each(listV,function(index,item){
						tag+=
							"<tr id="+item.seq+" class='questionList'><td>"+item.seq+"</td>"
							 +"<td>"+item.problem+"</td><td>"+item.answer+"</td>"
							 +"<td>"+item.answer1+"</td><td>"+item.answer2+"</td>"
							 +"<td>"+item.answer3+"</td><td>"+item.answer4+"</td></tr>"
					});	
					//console.log(tag);
					$('#makingQuestionList').append(tag);
					$('#saveQuestion').text("수정");
				}
				
				$("input[name='inputTxtQuestions']").val("");
				gfModalPop("#questionForm");
	
			}
		}
	
	});

	questionVue = new Vue({
		el : "#makingQuestion",
		data : {
			seq : '' ,
			problem : '',
			answer : '',
			answer1 : '',
			answer2 : '',
			answer3 : '',
			answer4 : ''
 		},
		methods : {
			questionAdd : function(){
				
				checkQuetionVal();
			},
 			questionDelete : function(){
 				deleteVal();
 			}
		}
	});

	infoVue ={};
	questBox=[];
	testMain=[];
	testRe=[];
	existStatus={
		main :"",
		re : ""
	}
	
	
	$(document).on("click",".questionList",function(){
		var seq =  $(this).attr('id');
		$('.questionList').css('backgroundColor','');
		$('.questionList').removeClass("clickOn");
		
		$(this).css('backgroundColor','#B2EBF4');
		$(this).addClass("clickOn");
		
		questBox.forEach(function(item){
				if(seq == item.seq){
					questionVue.seq = item.seq;
					questionVue.problem = item.problem;
					questionVue.answer = item.answer;
					questionVue.answer1 = item.answer1;
					questionVue.answer2 = item.answer2;
					questionVue.answer3 = item.answer3;
					questionVue.answer4 = item.answer4;
					return false;
				}
				
		});
		
	});
	
	$('#cancleButton').on('click',function(){
		gfCloseModal();
	});
	
	
	$('#saveQuestion').on('click',function(){
		
		console.log("infoVue :::  ",infoVue);
	
		//수정일 경우 기간이 지나면 수정 불가
		//대상자수가 1명이라도 있으면 수정 불가
		var status = $("#saveQuestion").text();
		
		var endDateArr = endDate.split('-');
	    var endCompare = new Date(endDateArr[0], Number(endDateArr[1])-1, endDateArr[2]);
		
	    

	    var today = new Date();   
	    var year = today.getFullYear(); 
	    var month = today.getMonth() + 1;  
	    var date = today.getDate();  
	   	
	    var startCompare = new Date(year,Number(month)-1,date);
	    console.log("------------------------------------------------------");
	    console.log("startCompare :: ! ",startCompare.getTime());
	    console.log("endCompare :: ! ",endCompare.getTime());
	    console.log("-------------------------------------------------------");
	    
	    var param = JSON.stringify(questBox);
	    console.log("param:::: !! ",param);
	    
	    var resultCallbackQuestion = function(data){
			if(data.result =="success") {
				alert("등록 성공");
				getCourseList();
			}
			else if(data.result=="modifysuccess") {
				alert("수정성공");
				getCourseList();
			}
			
			else{
				alert("Error");
			}
	    	
			gfCloseModal();
		};		
		console.log("existStatus ????? :   ");
		console.log(existStatus);
		if(isEmpty(questBox)){
			alert("문제가 등록되지 않았습니다");
			return false;
		}
		/*else if(status=="수정" && (startCompare.getTime()>endCompare.getTime())){
			alert("종료된 강의 입니다 ");
			gfCloseModal();
			return false;
		}*/
		
	
		else if((status=="수정" && infoVue.re=="main" && !isEmpty(existStatus.main))){
			alert("본시험 응시인원이 있습니다 ");
			return false;
		}else if((status=="수정" && infoVue.re=="re" && !isEmpty(existStatus.re))){
			alert("재시험 응시인원이 있습니다 ");
			return false;
		}else{
			var url = (status=="수정") ? 
					"/hlt/modifyQuesions.do" 
					:"/hlt/saveQuesions.do"
			$.ajax({
	        	url: url,
	        	type: 'POST',
	        	data: param,
	        	dataType : 'json',
	        	contentType : "application/json; charset=UTF-8",
	        	async: true,
	        	success: function(returnData){
	        		alert(JSON.stringify(returnData));
	        	
	        		resultCallbackQuestion(returnData);
	        	},
	    	});
		
		}
	});
}


//현재 진행중인 강의 목록 불러오기
function getCourseList(currentPage){
	
	currentPage = currentPage || 1;  	
	var stitle = $("#stitle").val();
	courseVue.stitle = stitle
	var param = {
			currentPage : currentPage ,
			pageSize : PageSize,
			title :  stitle
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		getCourseListResult(data, currentPage); 
	}
	
	callAjax("/hlt/getCourseList.do","post","json", true, param, resultCallback);
	
}


 function getCourseListResult(data, currentPage){
	 	console.log("data :  ",data.list);
		var paginationHtml = 
			getPaginationHtml(data.currentPage, data.totalCountList,
							data.pageSize,pageBlockSize, 'getCourseList');
		
		$("#pagingnavi2").empty().append(paginationHtml);
		
		courseVueList.items=data.list;
		
		console.log("////////////////////////////////////////////////");
		console.log(courseVueList.items);
 }
 
 function getTestResultList(item){
		endDate = item.enddate;
		var no = item.no;
		var param = {
			//	currentPage : currentPage ,
			//	pageSize : PageSize,
				no : no
		}
		
		var resultCallback = function(data){  
			getTestListResult(data); 
		}
		
		callAjax("/hlt/getTestResult.do","post","json", true, param, resultCallback);

 }
 
 function getTestListResult(data){
	console.log("data : ",data)
	 existStatus.main=data.resultMain;
	 existStatus.re=data.resultRe;
	 
	 testMain = data.listDetail;
	 testRe = data.listDetailR;
	 
	 testVue.items = data.list;
	 
	 console.log("testMain", testMain);
	 console.log("testRe", testRe);
	 
	 gfModalPop("#testresultList");
 }
 function checkQuetionVal(){
	 var seq = questionVue.seq;
	 var problem = questionVue.problem;
	 var answer = questionVue.answer;
	 var answer1 =questionVue.answer1;
	 var answer2 =questionVue.answer2;
	 var answer3=questionVue.answer3;
	 var answer4 =questionVue.answer4;
	 
	 	
	 var flag = true;
	 
	 $.each(questBox,function(index,item){
			 if(item.seq==seq) {
				 flag = false;
			 };
	 });
	 
	 if(!flag) {
		 alert("중복된 문제 번호 입니다 .");
		 return false;
	 }

	 if(isEmpty(seq) 
			 || isEmpty(problem) 
			 || isEmpty(answer)
	 		 || isEmpty(answer1)
	 		 ||	isEmpty(answer2)
	 		 || isEmpty(answer3)
	 		 || isEmpty(answer4)){
		 alert("빠짐없이 입력해주세요 ! ");
		 return false;
	 }
	else{
		 var obj = {
			 no : infoVue.no,
			 re : infoVue.re,
			 seq : seq,
			 problem : problem,
			 answer : answer,
			 answer1 : answer1,
			 answer2 : answer2,
			 answer3 : answer3,
			 answer4 : answer4,
			
		}
		
		 questBox.push(obj);
		 	
		 console.log("questBox ???????  ",questBox);
		 $('#makingQuestionList').append("<tr id="+seq+" class='questionList'><td>"+seq+"</td>"
		 +"<td>"+problem+"</td><td>"+answer+"</td>"
		 +"<td>"+answer1+"</td><td>"+answer2+"</td>"
		 +"<td>"+answer3+"</td><td>"+answer4+"</td></tr>");
		
	 }
 }
 
 function deleteVal(){
	 var seq = $('.clickOn').attr('id');
	 var idx;
	 $.each(questBox,function(index,item){
		if(item.seq==seq) idx=index;
	 }); 
	 questBox.splice(idx,1);
	 
	 $('.clickOn').remove();
 }

</script>

</head>
<body>
	
	<div id="wrap_area">
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="#"
								class="btn_set refresh">새로고침</a>
						</p>


<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
                   <div id="searcharea">
                                       제목 : <input id="stitle" name="stitle"  v-model="stitle" placeholder="제목 검색조건">
                             <a href="javascript:getCourseList();" id="btn_prelogin2" >
                             <strong>조회</strong>
                           </a>	
                       
                   </div>
                

						<input type="hidden" id="currentPage" value="1"> 
						<input type="hidden" id="currentPagevue" value="1">
			
						<div id="">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">
									</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuetable" class="col2 mb10"
											style="width: 1000px;">
											<colgroup>
												<col width="350px">
												<col width="550px">
											</colgroup>
											<thead>
												<tr>
													<th>과정명</th>
													<th>기간</th>
												</tr>
											</thead>
											<tbody>
												<template v-for="(item, index) in items" v-if="items.length">
												<tr @click="rowClicked(item)">
													<td>{{item.title}}</td>
													<td>{{item.startdate}} ~ {{item.enddate}}</td>

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
						</div>
						<div class="paging_area" id="pagingnavi2"></div>
					</div>
				</li>
			</ul>

		</div>
	</div>
	
	<!-- 개발자 상세보기 모달팝업 -->
	<jsp:include page="/WEB-INF/view/hlt/testresultList.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/hlt/questionForm.jsp"></jsp:include>

	
</body>
</html>