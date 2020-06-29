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


</script>
<body>
   <!-- 모달 배경 -->
   <div id="mask"></div>
   <div id="wrap_area">
      <div id="container">
         <ul>
            <li class="lnb">
               <!-- lnb 영역 --> <jsp:include
                  page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
            </li>
					<li class="contents">
          		     <!-- contents -->
					<div class="home_area">
               </div>
            <div id="lecture_box" >
	               <div class="lecture_searchbox">
	                  	<div class="lecture_selectbox">
	                  	</div>
	               </div>
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