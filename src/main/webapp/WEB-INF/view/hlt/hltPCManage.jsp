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
	
	$( "#date3" ).datepicker({
		format:"yyyy.mm.dd",
		autoclose:true
    });
	$( "#date4" ).datepicker({
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
			items : [],
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
			deleteNo(no){
				if(confirm("삭제하시겠습니까?")){
					var param = {
							no : no
					};
					
					
					var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
						console.log("여기왔나요? -2 ");
						lectListCallback(data); 
				 	}
					
					callAjax("/hlt/hltDeleteNo.do","post","json", true, param, resultCallback);
				};
				
			},
			updateNo(row){
		    	  console.log(row);
		    	  
		    	  
		    	  frealPopModal(row);
		    	  gfModalPop("#classvue");
		    	  
		    },
		   insertNo(row){
			   console.log(row);
			   
			   frealPopModal1(row);
			   gfModalPop("#classvue1");
		   }
		}
	})
};

// 강의 전체 목록 조회
function lectList() {
	console.log("여기왔나요? ");
	param='';
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		console.log("여기왔나요? -2 ");
		lectListCallback(data); 
 	}
 	callAjax("/hlt/hltManageList.do","post","json", true, param, resultCallback);
	
}

//강의 전체 목록 조회 콜백
function lectListCallback(data){
	console.log(data.result);
	lect.items=[];
	lect.items=data.result;
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
		console.log(data.result);
		lect.items=[];
		lect.items=data.result;;
	}
	
	callAjax("/hlt/hltManageList.do","post","json", true, param, resultCallback);
	console.log("여기왔나요? -4");
}

/* 공지사항 모달창(팝업) 실행  */
function fNoticeModal(no) {
	 
		fdetailModal(no); //번호로 -> 공지사항 상세 조회 팝업 띄우기

}


/*공지사항 상세 조회*/
function fdetailModal(no){
	 //alert("공지사항 상세 조회  ");
	 
	 var param = {no : no};
	 var resultCallback2 = function(data){
		 fdetailResult(data);
	 };
	 
	 callAjax("/hlt/detailClassList.do", "post", "json", true, param, resultCallback2);
	 //alert("공지사항 상세 조회  22");
}

/*  공지사항 상세 조회 -> 콜백함수   */
function fdetailResult(data){

	 //alert("공지사항 상세 조회  33");
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 console.log(data.result);
		 gfModalPop("#classvue");
		 
		// 모달에 정보 넣기 
		frealPopModal(data.result);
	 
	 }else{
		 alert(data.resultMsg);
	 }
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
							수업목록
						</div>
						<div class="lecture_listbox">
							<table id="lectInfo">
								<thead>
									<tr>
										<th>분류</th>
										<th>과목</th>
										<th>강사아이디</th>
										<th>날짜</th>
										<th>진도</th>
										<th>비고</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody id="classList">
									<template v-for="(row, index) in items" v-if="items.length">
										<tr>
											<td v-on:click="insertNo(row)">{{ row.category}}</td>
											<td v-on:click="insertNo(row)">{{ row.title }}</td>
											<td v-on:click="insertNo(row)">{{ row.loginID }}</td>
											<td v-on:click="insertNo(row)">{{ row.lecdate }}</td>
											<td v-on:click="insertNo(row)">{{ row.processrate }} %</td>
											<td v-on:click="insertNo(row)">{{ row.note }}</td>
											<td><button v-on:click="updateNo(row)">수정</button></td>
											<td><button v-on:click="deleteNo(row.no)">삭제</button></td>
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
				<strong>진도 입력하기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div>
					<div class="row" id="lec_info" style="margin-bottom:30px; height: 50px;">
						<div class="col-md-4" style="width:40%; padding-left:0px;">
							<h3>날짜</h3>
							<!-- <input type="text" id="lec_title" style="height: 25px;" v-model="lec_date">  -->
							<input type="text" id="date3" style="height: 25px;" v-model="lecdate">
						</div>
						<div class="col-md-4" style="width:40%;">
							<h3>분류</h3>
							<input type="text" id="lec_id" style="height: 25px;" v-model="category" readonly>
						</div>
						
					</div>
					<div class="col-md-4" style="width:40%; padding-left:0px;" id="lec_process1">
						<h3>진도</h3>
						<input type="text" id="lec_process1" style="height: 25px;" v-model="processrate">
					</div>
					<div class="col-md-4" style="width:40%;">
							<h3>강사</h3>
							<input type="text" id="lec_date2" style="height: 25px;" v-model="loginID" readonly>
						</div>
					<div id="lec_content" style="margin-top: 100px;">
						<h3>강의내용</h3>
						<textarea style="resize: none; width: 88%;" id="lec_note" v-model="note"></textarea>
					</div>
					
				</div>
				<div class="btn_areaC mt30">
					<a class="btnType gray" name="btn" v-on:click="updateBtn()"><span>수정</span></a>
					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<div id="classvue1" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="nt_novue" name="nt_novue">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>진도 입력하기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="classvue1">
					<div class="row" id="lec_info1" style="margin-bottom:30px; height: 50px;">
						<div class="col-md-4" style="width:40%; padding-left:0px;">
							<h3>날짜</h3>
							<!-- <input type="text" id="lec_title" style="height: 25px;" v-model="lec_date">  -->
							<input type="text" id="date4" style="height: 25px;" v-model="lecdate">
						</div>
						<div class="col-md-4" style="width:40%;">
							<h3>분류</h3>
							<input type="text" id="lec_id1" style="height: 25px;" v-model="category" readonly>
						</div>
						
					</div>
					<div class="col-md-4" style="width:40%; padding-left:0px;" id="lec_process1">
						<h3>진도</h3>
						<input type="text" id="lec_process" style="height: 25px;" v-model="processrate">
					</div>
					<div class="col-md-4" style="width:40%;">
							<h3>강사</h3>
							<input type="text" id="lec_date3" style="height: 25px;" v-model="loginID" readonly>
						</div>
					<div id="lec_content" style="margin-top: 100px;">
						<h3>강의내용</h3>
						<textarea style="resize: none; width: 88%;" id="lec_note" v-model="note"></textarea>
					</div>
					
				</div>
				<div class="btn_areaC mt30">
					<a class="btnType gray" name="btn" v-on:click="insertBtn()"><span>작성</span></a>
					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<script>
	ved = new Vue({
	    el: '#classvue',
	  data: {
		  category: '',
		  loginID: '',
		  lecdate: '',
		  note: '',
		  processrate: '',
		  no: ''
	       },
       methods : {
			updateBtn(){
				var param = {
					  category: this.category,
					  loginID: this.loginID,
					  lecdate: this.lecdate,
					  note: this.note,
					  processrate: this.processrate,
					  no: this.no,
					  seq: this.seq,
					  branch: "update"
					  
				}
				console.log(param);
				var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
					console.log("여기왔나요? -2 ");
					lectListCallback(data); 
					endFn();
					
			 	}
			 	callAjax("/hlt/hltModalList.do","post","json", true, param, resultCallback);
				
			}
	   }
	});
	ved1 = new Vue({
	    el: '#classvue1',
	  data: {
		  category: '',
		  loginID: '',
		  lecdate: '',
		  note: '',
		  processrate: '',
		  no: ''
	       },
       methods : {
			insertBtn(){
				var param = {
					  category: this.category,
					  loginID: this.loginID,
					  lecdate: this.lecdate,
					  note: this.note,
					  processrate: this.processrate,
					  no: this.no,
					  seq: this.seq,
					  branch: "insert"
					  
				}
				console.log(param);
				var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
					console.log("여기왔나요? -2 ");
					lectListCallback(data); 
					endFn();
					
			 	}
			 	callAjax("/hlt/hltModalList.do","post","json", true, param, resultCallback);
				
			}
	   }
	});
	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	function frealPopModal(object){
	     ved.category = object.category;
		 ved.loginID = object.loginID;
		 ved.lecdate = object.lecdate;
		 ved.note = object.note;
		 ved.processrate = object.processrate;
		 ved.no = object.no;
		 ved.seq = object.seq;
	}
	function frealPopModal1(object){
	     ved1.category = object.category;
		 ved1.loginID = object.loginID;
		 ved1.processrate = object.processrate;
		 ved1.no = object.no;
		 ved1.seq = object.seq;
	}
	function endFn(){
		  ved.category = '',
		  ved.loginID = '',
		  ved.lecdate = '',
		  ved.note = '',
		  ved.processrate = '',
		  ved.no = '',
		  ved1.category = '',
		  ved1.loginID = '',
		  ved1.lecdate = '',
		  ved1.note = '',
		  ved1.processrate = '',
		  ved1.no = ''
		$("#mask").hide();
		$("#classvue").hide();
		$("#classvue1").hide();
	}
	$("#date3").on('changeDate', function(){
		ved.lecdate = $("#date3").val();
	})
	$("#date4").on('changeDate', function(){
		ved1.lecdate = $("#date4").val();
	})
	</script>
</body>
</html>