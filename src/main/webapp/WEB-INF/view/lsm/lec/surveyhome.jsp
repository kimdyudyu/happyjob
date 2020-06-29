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
var totalScore=0;
var tdArr= [];
/*onload 이벤트*/
$(function(){
	console.log(" ++ 설문조사 홈");
	init();
	fgetLecList();
	
	$("#fsavesurvey").click(function (){
		 var one =Number($("input:radio[name='one']:checked").val());
			var two = Number($("input:radio[name='two']:checked").val());
			var three = Number($("input:radio[name='three']:checked").val());
			var four = Number($("input:radio[name='four']:checked").val());
			
			totalScore = (one + two + three + four)/4 ;
			totalScore.toFixed(2);
			console.log(tdArr[0]);
			console.log(totalScore);
			var param={
					totalScore : totalScore,
					no:tdArr[0]
			}

			
			var resultCallback = function(data) {
				
			
					alert("저장 성공했습니다.");
					location.reload();
				
			};
			callAjax("/manageC/savesurvey.do", "post", "json",true, param ,resultCallback);	
	
	 });
});

// 
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
	      },
	   
	      methods : {
				rowClicked(row){
	    		  console.log(row);
	    		  var str = "";
	              tdArr = new Array();    // 배열 선언
	                  
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
	              gfModalPop("#surveyvue");
	              var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
	                  console.log("여기왔나요? -2 ");
	                  frealPopModal(data.result); 
	                  gfModalPop("#surveyvue");
	                }             
	             //callAjax("/manageC/surveyModal.do","post","json", true, param, resultCallback);
	    	   },
				savesurvey:function(){
					//alert("저장!");
					fsaveSurvey();
				}
	      }
      });
};

	
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

</script>
</head>
<body>
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

            <div id="lecture_box" >
               <div class="lecture_searchbox">         
               </div>
               <div class="lecture_box" style="width:90%;">
                  <div class="lecture_tit_box">
                     					설문조사 목록
                  </div>
                  <div class="lecture_listbox">
                     <table id="lectInfo">
                        <thead>
                           <tr>
                          	<th>강의번호</th>
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
                            	 <td>{{ row.no }}</td>
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
   <div id="surveyvue" class="layerPop layerType2" style="width: 700px; hight: 1000px,">
      <dl>
         <dt>
            <strong>설문조사</strong>
         </dt>
         <dd class="content">
            <!-- s : 여기에 내용입력 -->
            <div id="surveyvue">
   					<table class="row" >
						<caption>caption</caption>
						<colgroup>
							<col width="200px">
							<col width="*">
							<col width="200px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
						</colgroup>
						<thead>
							<tr>
								<th rowspan="2" colspan="3">내용</th>
								<th colspan="5">선택</th>
							</tr>
							<tr>
								<th>1</th>
								<th>2</th>
								<th>3</th>
								<th>4</th>
								<th>5</th>
							</tr>
						</thead>
						 <tbody>
							<tr>
								<td colspan="3">
										<label for="one">시간이 잘 지켜졌습니까?</label>
								</td>
								<td>
									<input type="radio"  name="one"  value="1" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="one"   value="2" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="one"  value="3" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="one"  value="4" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="one"   value="5" v-model="picked">
								</td>
							</tr>
							<tr>
								<td colspan="3">
										<label for="two">학생들과의 소통을 잘하였습니까?</label>
								</td>
								<td>
									<input type="radio"  name="two"  value="1" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="two"  value="2" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="two"  value="3" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="two"   value="4" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="two"  value="5" v-model="picked">
								</td>
							</tr>
							<tr>
								<td colspan="3">
										<label for="three">시험의 난이도는 어땠습니까?</label>
								</td>
								<td>
									<input type="radio"   name="three"  value="1" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="three"  value="2" v-model="picked">
								</td>
								<td>
									<input type="radio"    name="three"  value="3" v-model="picked">
								</td>
								<td>
									<input type="radio"    name="three"   value="4" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="three"  value="5" v-model="picked">
								</td>
							</tr>
							<tr>
								<td colspan="3">
										<label for="four">내용 전달이  잘되었습니까?</label>
								</td>
								<td>
									<input type="radio"   name="four"   value="1" v-model="picked">
								</td>
								<td>
									<input type="radio"  name="four"   value="2" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="four"   value="3" v-model="picked">
								</td>
								<td>
									<input type="radio"   name="four"   value="4" v-model="picked">
								</td>
								<td>
									<input type="radio" id="one" value="5" v-model="picked">
								</td>
							</tr>			
						
							<tr style="border-top: solid;">
								<td colspan="8"><span>불평 불만 LEGO</span></td>
							</tr>
							<tr>
								<td colspan="8">
									<input type="text" style="width:100%; height:100%;" v-model="comment">
								</td>
							</tr>
						</tbody>
					</table>
					
						<div class="btn_areaC mt30">
					
					<!-- 	<a class="btnType blue"  id="fsavesurvey"><span>저장</span></a> -->
						<button class="btnType blue"  id="fsavesurvey">저장</button>
						<a href="" class="btnType gray" @click="cancel"><span>취소</span></a>
					</div>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	<script>
  
   /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
 function frealPopModal(object){
       var ratetotal = "/100";
        ved.lec_title = object.title;
     /*  ved.lec_teacher = object.loginID;
       ved.lec_date = object.lectdate;
       ved.lec_note = object.note;
       ved.lec_process = object.processrate + ratetotal;*/
   }
  
   </script>
</body>
</html>