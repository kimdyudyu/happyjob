<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.2/dist/vue.js"></script>
    <script src="https://unpkg.com/vue-router@3.0.1/dist/vue-router.js"></script>
<script type="text/javascript">

var lect;

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

/* onload 이벤트  */
$(function(){
   
   // 강의 리스트
   init();
   lectList();
   $( "#date1" ).datepicker({
      format:"yyyy.mm.dd",
      autoclose:true
    });
   $( "#date2" ).datepicker({
      format:"yyyy.mm.dd",
      autoclose:true
    });
});

function init() {
   lect = new Vue({
      el : '#lecture_box',
       component : {
         'lectInfo' : lectInfo
      }, 
      data : {
    	  lsmCodListModel : [],
         studentList : [],
         search_name : '',
         test : '',
         selected : 'ALL',
         options : [
            {text : '전체', value : 'ALL'},
            {text : '내용', value : 'content'}
                    ]
      },
      
      methods : {
			rowClicked(row){
    		  console.log(row);
    		  var str = "";
              var tdArr = new Array();    // 배열 선언
                  
              // 현재 클릭된 Row(<tr>)
              var tr = $(row);
              var td = tr.children();
              
              td.each(function(i){
                  tdArr.push(td.eq(i).text());
              });
              console.log(tdArr);
              var param = {
            		  title : tdArr[0],
            		  loginID : tdArr[1]
              }
              var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
                  console.log("여기왔나요? -2 ");
                  frealPopModal(data.result); 
                  gfModalPop("#classvue");
                }
              
              callAjax("/manageC/lsmModal.do","post","json", true, param, resultCallback);
    	   }
         }
      
   });
};

// 강의 전체 목록 조회
function lectList() {
   console.log("여기왔나요? ");
   param='';
   
   var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
      console.log("여기왔나요? -2 ");
      lectListCallback(data); 
    }
    callAjax("/manageC/lsmCodList.do","post","json", true, param, resultCallback);
}

//강의 전체 목록 조회 콜백
function lectListCallback(data){ 
   lect.lsmCodListModel = [];  
   lect.lsmCodListModel = data.lsmCodListModel;
   console.log(lect.lsmCodListModel);
}

function fSearchLec(){
   console.log("여기왔나요? -3");
   param={
      selected:lect.selected,
      keyword:lect.search_name,
      startdate:$("#date1").val(),
      enddate:$("#date2").val()
      
   };
   
   function resultCallback(data){
      $("#classList").empty();
      
      $("#classList").append(data);
   }
   
   callAjax("/hlt/hltClassList.do","post","text", true, param, resultCallback);
   console.log("여기왔나요? -4");
}




</script>
<body>
   <!-- 모달 배경 -->
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
                     수강목록/진도
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
                        	<template v-for="(row, index) in lsmCodListModel" >
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