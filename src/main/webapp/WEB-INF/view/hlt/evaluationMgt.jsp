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
	

});
function init() {
	
	lect = new Vue({
		el : '#lecture_box',
		 component : {
			'lectInfo' : lectInfo
		}, 
		data : {
			lectList : [],
			studentList : [],
			search_name : '',
			test : '',
			selected : 'ALL',
			options : [
				{text : '전체', value : 'ALL'},
				{text : '과목', value : 'content'}
			           ]
		},
		
		methods : {
			showPerson: function(index, lec_seq){
				if(this.test == null || this.test == '') {
					 this.test = index+1;
					$('#showPerson_'+index).show();
					personInfo(lec_seq);
				} else if (this.test == index+1 ) {
					this.test = '';
					$('.hide_tr').hide();
				} else {
					this.test = index+1;
					$('.hide_tr').hide();
					$('#showPerson_'+index).show();
					 personInfo(lec_seq);
				}
			}
		}
	});
	ved = new Vue({
	    el: '#classvue',
	  data: {
		  items : []
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
 	callAjax("/hlt/evaluationList.do","post","text", true, param, resultCallback);
	
}

//강의 전체 목록 조회 콜백
function lectListCallback(data){
	$("#classList").empty();
	
	$("#classList").append(data);
}

function fSearchLec(){
	console.log("여기왔나요? -3");
	param={
		selected:lect.selected,
		keyword:lect.search_name,
		
		
	};
	
	function resultCallback(data){
		$("#classList").empty();
		
		$("#classList").append(data);
	}
	
	callAjax("/hlt/evaluationList.do","post","text", true, param, resultCallback);
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
	 
	 callAjax("/hlt/DetailSurveyList.do", "post", "json", true, param, resultCallback2);
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
		ved.items = [];
		ved.items = data.result;
		console.log(ved.data);
	 
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
							<span class="btn_nav bold">설문관리</span> 
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
										<th>강의시작일</th>
										<th>강의종료일</th>
										<th>평점</th>
										<th>정원</th>
									</tr>
								</thead>
								<tbody id="classList"></tbody>
							</table>
						</div>
					</div>	

				</div>	
				</li>
			</ul>
		</div>
	</div>
	<div id="classvue" class="layerPop layerType2" style="width: 400px;">

		<dl>
			<dt>
				<strong>강의 후기</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="survey">
					<div v-for="(row, index) in items">
					<div style="width:120px; display:inline-block; margin-bottom:10px;">
						<span>{{row.loginID}}</span>
						<span style="float:right; margin-right:30px;"> : </span>
					</div>
						<input type="text" v-model="row.survey" readonly/>
					</div>
				</div>
				<div class="btn_areaC mt30">

					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<script>
	
	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */

	
	</script>
</body>
</html>