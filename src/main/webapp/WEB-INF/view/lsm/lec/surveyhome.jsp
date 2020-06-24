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


<script src="https://cdn.jsdelivr.net/npm/vue"></script>



<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script>
var lect;
var loginID="${sessionScope.loginID}";

var LecListVue;
var picks ='';
$(function(){
	
	console.log(" ++ 설문조사 홈");
	init();
	fgetLecList();
});

function init(){
	   lect = new Vue({
		      el : '#lecture_box',
		       component : {
		         'lectInfo' : lectInfo
		      }, 
		      data : {
		    	  LecListModel : [],
		    	  studentList : [],
		          search_name : '',
		          test : '',
		          selected : 'ALL',
		          options : [
		             {text : '전체', value : 'ALL'},
		             {text : '내용', value : 'content'}
		                     ]
	      }
	   })
}
	var eventBus = new Vue();		
	 Vue.component('radioboxC', { 
			template:
				'<tr style="text-align: -webkit-center;"  >'+
				'	<td colspan="3">{{rdata}} : {{pick}}</td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="1"  checked="checked" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="2" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="3" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="4" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="5" @change="sendscore"></td>'+
				'</tr>'
			,
			data:function(){
				return {
						pick:''
				}
			},
			props:['rdata','pickid'],
			methods:{
				sendscore:function(){
					
					console.log("target.id : "+event.target.id);
					var id= event.target.id;
					var score =this.pick;
					
					eventBus.$emit('sendeventscore',id,score);
				}
			}
			
		}); 

	



	
	
/*	LecListVue = new Vue({
		el:'#vuedatatable',
		data:{
			items:[],
			row:[]
		},
		methods:{
			dosurvey:function(row){
				this.row = row;
				qnaWritePopup("#layer1");
			}
		}
	});
*/	
/*
	doSurveyVue = new Vue({
		el:'#surveyModal',
		created :function(){
			eventBus.$on('sendeventscore',function(id,score){
				
				console.log("id : " +id);
				console.log("score : " +score);
				
				if(picks != ''){
					picks=picks.substring(0,picks.lastIndexOf('}'));
					picks +=',"'+id+'":'+score+'}';
				}else{
					picks +='{"'+id+'":'+score+'}';
				}
				
		
		
			});
		},
		data:{
			items:[
			       {"qst":"시간이 잘 지켜졌습니까?","id":"pick1"},
			       {"qst":"학생들과의 소통을 잘하였습니까?","id":"pick2"},
			       {"qst":"시험의 난이도는 어땠습니까?","id":"pick3"},
			       {"qst":"내용 전달이  잘되었습니까? ","id":"pick4"}
			       ],
			picks:'',
			comment:''
		},
		methods:{
			cancel:function(){
				gfCloseModal();
			},
			savesurvey:function(){
				//alert("저장!");
				fsaveSurvey();
			}
		}
	});
*/	


function fsaveSurvey(){
	var totalScore=0;
	console.log(picks);
	var obj = JSON.parse(picks);
	for(var k in obj){
		console.log("k :"+k+" value : " + obj[k]);
		totalScore+=obj[k];
	}
	//alert(totalScore);
	
	var param={
		lec_seq:LecListVue.row.lec_seq,
		comment:doSurveyVue.comment,
		totalScore:totalScore,
		enr_user:userid
	};

	
	var resultCallback = function(data) {
		alert("저장 "+data.msg);
		doSurveyVue.comment='';
		$("input[type=radio]").prop("checked",false);
		
		gfCloseModal();
		fgetLecList();
		
	};
	
	
	
	callAjax("/survey/savesurvey.do", "post", "json",true, param ,resultCallback);	
}
//강의 전체 목록 조회 콜백
function fgetLecListCallback(data){
	lect.LecListModel = [];
	console.log(data);
	console.log(data.LecListModel);
	lect.LecListModel = data.LecListModel;
	console.log(lect.LecListModel);
}
// 강의 목록 조회
function fgetLecList(){
	console.log("리스트 넘어온지 확인");
	param = '';
	
	var resultCallback = function(data){ // 데이터를 이 함수로 넘김
		console.log("콜백 확인");
		fgetLecListCallback(data);
	}
	callAjax("/manageC/LecList.do", "post", "json",true, param ,resultCallback);
}

function qnaWritePopup(id) {

	//var id = $(this).attr('href');
	//alert("asdf");  
	var maskHeight = $(document).height();
	var maskWidth = $(document).width();

	$('#mask').css({'width':maskWidth,'height':maskHeight});

	$('#mask').fadeIn(200);
	$('#mask').fadeTo("fast", 0.5);
	$('#wqna_title').focus();
	var winH = $(window).height();
	var winW = $(window).width();
	var scrollTop = $(window).scrollTop();

	$(id).css('top', "5px");
	$(id).css('left', winW/2-$(id).width()/2);

	$(".layerPop").hide();
	$(id).fadeIn(100); //페이드인 속도..숫자가 작으면 작을수록 빨라집니다.
}


</script>

Z`	`	
</head>
<body>
<div id="mask"></div>

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
               <div class="home_area">
                  <p class="Location">
                     <a href="#" class="btn_set home">메인으로</a> 
                     <span class="btn_nav bold">수강 인원 / 강의 목록</span> 
                     <a href="#"class="btn_set refresh">새로고침</a>
                  </p>
               </div>
               <h3 class="hidden">강의실 검색 영역</h3>
            <div id="lecture_box" >
               <div class="lecture_searchbox">
                  <div class="lecture_selectbox">
                     <select v-model="selected" >
                        <option v-for = "option in options" v-bind:value="option.value">
                           {{ option.text }}
                        </option>
                     </select>
                  </div>
                  <div class="lecture_serch_input" style="width:250px; margin-right:50px;">
                     <input type="text" name="room_search" v-model="search_name" placeholder="검색">
                  </div>
                  <!-- <div id="app1" style="display:inline-block;">
                    <datepicker @change="updateDate" v-once></datepicker>
                    <p>{{ date }}</p>
                  </div>
                  <div id="app2" style="display:inline-block;">
                    <datepicker @change="updateDate" v-once></datepicker>
                    <p>{{ date }}</p>
                  </div> -->
                  <div class="lecture_serch_input" style="width: 150px; margin-right:20px;">
                     <input type="text" id="date1">
                  </div>
                  <div class="lecture_serch_input" style="width: 150px; margin-right:10px;">
                     <input type="text" id="date2">
                  </div>
                  
                    
                  <div style="display: inline-block; margin-left:20px;">
                     <a class="btnType blue" href="javascript:fSearchLec();" name="search" id="searchBtn" style="width: 70px;"><span>검색</span></a>
                  </div>
                       
               </div>
               <!-- /.lecture_searchbox -->
               
               <div class="lecture_box" style="width:90%;">
                  <div class="lecture_tit_box">
                     					설문조사 목록
                  </div>
                  <div class="lecture_listbox">
                     <table id="lectInfo">
                        <thead>
                           <tr>
                              <th>과목명</th>
                              <th>강사</th>
                              <th>강의시작일</th>
                              <th>강의종료일</th>
                              <th>강의실</th>
                              <th>진도</th>
                           </tr>
                        </thead>
                        <tbody id="classList">
                        	<template v-for="(row, index) in LecListModel" >
                              <tr onclick="lect.rowClicked(this)">
                                 <td>{{ row.title }}</td>
                                 <td>{{ row.loginID }}</td>
                                 <td>{{ row.start_date }}</td>
                                 <td>{{ row.end_date }}</td>
                                 <td>{{ row.room }}</td>
								 <td>{{ row.processrate }}</td>
                              </tr>
                           </template>
                        </tbody>
                     </table>
                  </div>
               </div>   
            </div>   
            </li>
         </ul>
      </div>
   </div>
   <div id="classvue" class="layerPop layerType2" style="width: 600px;">
      <input type="hidden" id="nt_novue" name="nt_novue">
      <!-- 수정시 필요한 num 값을 넘김  -->

      <dl>
         <dt>
            <strong>수업내용 살펴보기</strong>
         </dt>
         <dd class="content">
            <!-- s : 여기에 내용입력 -->
            <div id="classvue">
               <div class="row" id="lec_info" style="margin-bottom:30px; height: 50px;">
                  <div class="col-md-4" style="width:25%; padding-left:0px;">
                     <h3>과목명</h3>
                     <input type="text" id="lec_title" style="height: 25px;" v-model="lec_title" readonly>
                  </div>
                  <div class="col-md-4" style="width:25%;">
                     <h3>강사</h3>
                     <input type="text" id="lec_teacher" style="height: 25px;" v-model="lec_teacher" readonly>
                  </div>
                  <div class="col-md-4" style="width:25%;">
                     <h3>강의시간</h3>
                     <input type="text" id="lec_startdate" style="height: 25px;" v-model="lec_date" readonly>
                  </div>
               </div>
               </div>
               <div id="lec_Room">
                <h3>강의내용</h3>
                  <textarea style="resize: none; width: 88%;" id="lec_room" v-model="lec_room" readonly></textarea>
               </div>
               <div id="lec_process">
                  <h3>진도</h3>
                  <input type="text" id="lec_process" style="height: 25px;" v-model="lec_process" readonly>
               </div>
                <div class="btn_areaC mt30">

               <a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
            </div>
            </div>
           
         </dd>

      </dl>
      <a href=""  class="closePop"><span class="hidden">닫기</span></a>
   </div>
   <script>
   ved = new Vue({
       el: '#classvue',  
     data: {
        lec_title: '',
        lec_teacher: '',
        lec_date: '',
        lec_room: '',
        lec_process: ''
          }
   });
   /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
   function frealPopModal(object){
       var ratetotal = "/100";
        ved.lec_title = object.title;
       ved.lec_teacher = object.loginID;
       ved.lec_date = object.lectdate;
       ved.lec_note = object.note;
       ved.lec_process = object.processrate + ratetotal;
   }
   
   
   </script>
</body>
</html>