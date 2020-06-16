<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Q&A</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">



// 페이징 설정 
var qnaPageSize = 10;    	// 화면에 뿌릴 데이터 수 
var qnaPageSizevue = 10;
var qnaPageBlock = 10;		// 블럭으로 잡히는 페이징처리 수

var vm;
var dqnaVue;

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
	// 자유게시판 리스트 뿌리기 함수 
	init();
	selectqnaListvue();
	btnEvent();
});

function btnEvent(){
	$('#btnSaveDtlCod').click(function(e){
		e.preventDefault();
		
		fSaveDtlCod();
	});
}

//상세코드 저장
function fSaveDtlCod(){
	// vaildation 체크 (유효성)
	if ( ! fValidateDtlCod() ) {
		return;
	}
	
	var resultCallback = function(data) {
		fSaveDtlCodResult(data);
	};
	
	callAjax("/jboard/saveComnDtlCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
}

/** 상세코드 저장 콜백 함수 */
function fSaveDtlCodResult(data) {
	
	// 목록 조회 페이지 번호
	var currentPage = "1";
	if ($("#action").val() != "I") {
		currentPage = $("#currentPageComnDtlCod").val();
	}
	
	if (data.result == "SUCCESS") {
		
		// 응답 메시지 출력
		alert(data.resultMsg);
		
		// 모달 닫기
		gfCloseModal();
		
		// 목록 조회

		selectqnaListvue();
	} else {
		// 오류 응답 메시지 출력
// 		console.log(data);
		alert(data.resultMsg);
	}
	
	// 입력폼 초기화
	fInitForm();
}

function fInitForm(){
	dqnaVue.loginID_vue='';
	dqnaVue.nt_title_vue='';
	dqnaVue.nt_note_vue='';

	$('#answer_id').val();
	$('#answer_title').val();
	$('#answer_note').val();
}

function init() {
	
    vm = new Vue({
		  el: '#vuetable',
		  components: {
		    'bootstrap-table': BootstrapTable
		  },
		  data: {
		    items: [],
		    options: {
		    	//  paginated:"paginated"
		    }			    
		  },
		  methods: {
			     
			    fdetailModal:function(wno){
			    	//alert(wno);
			    	fdetailModalpop(wno); 
				}  
		      }     
		});	  	
	
    /* 상세보기. */
	dqnaVue = new Vue({
		el :'#detailtable',
		 data :{
			 loginID_vue:'',
			 nt_title_vue:'',
			 nt_note_vue:'',
			 
		},
		methods : {
		},
		computed :{
        	   editor:function() {
         	    	 // alert( this.$refs.quillEditor.quill.getText());
         	        return this.$refs.quillEditor.quill;
         	      },
         	   	 mounted:function() {
           	      console.log('this is quill instance object', this.editor);
           	    }
		} 
	});	
/* 
	
	svm = new Vue({
        el: '#searcharea',  
      data: {
    	     searchkey: '',
    	     searchword: '',
    	     startdate: '',
   	         enddate: ''
            }
    });
	
	
	ved = new Vue({
                                el: '#editvue',  
                              data: {
                            	      loginID_vue: ''
                            	     ,write_date_vue: ''
                            	     ,nt_title_vue: ''
                            	     ,nt_note_vue: ''
                                   }
                 });
	 
	 //items = 넥사크로 dataSet과 같다.

    
        $("#vuedatatable tr").click(function(){  
        	var str = "";
            var tdArr = new Array();    // 배열 선언
                
            // 현재 클릭된 Row(<tr>)
            var tr = $(this);
            var td = tr.children();
            
            //console.log("td : " + td);
    	});    
     */
    	var dateFormat = "yy-mm-dd";
        //시작일
        $("#startdate").datepicker({ 
       	 dateFormat: dateFormat
        }); 
        $("#enddate").datepicker({ 
       	 dateFormat: dateFormat
        });
        $("#startdate").change(function() {
       	    $("#enddate").datepicker("option", "minDate", $(this).val());
    	});
    	
    	$("#enddate").change(function() {
       	 $("#startdate").datepicker("option", "maxDate", $(this).val());
    	});

};

//유효성체크
// function chkData(item, msg) {
// 	if($(item).val().replace(/\s/g,"")=="") {
// 		alert(msg + " 입력해 주세요.");
// 		$(item).val("");
// 		$(item).focus();
// 		return false;
// 	} else {
// 		return true;
// 	}
// }


//유효성체크 2
function fValidateDtlCod() {

	var chk = checkNotEmpty(
			[
					[ "answer_id", "작성자를 선택해 주세요." ]
				,	[ "answer_title", "제목을 입력해 주세요." ]
				,	[ "answer_note", "내용을 입력해 주세요" ]
			]
	);

	if (!chk) {
		return;
	}

	return true;
}

// function goPage(){
// 	if($("#searchkey").val()=="all"){
// 		$("#searchword").val("");
// 	}
// 	$("#myForm").attr({
// 		"method": "get",
// 		"action": "/jboard/qnaboard"
// 	});
// 	$("#myForm").submit();
// } 


/* 공지사항 리스트 불러오기  */
function selectqnaListvue(currentPage){
	
	currentPage = currentPage || 1;   // or		
	//svm.stitle = "55555555555";
	//console.log("selectqnaListvue currentPage : " + currentPage);
	var startdate = $("#startdate").val();
	var enddate = $("#enddate").val();
	var searchkey = $("#searchkey").val();
	var searchword = $("#searchword").val();
	
	var param = {
			currentPage : currentPage ,
			pageSize : qnaPageSizevue,
			startdate : startdate,
			enddate : enddate,
			searchkey : searchkey,
			searchword : searchword
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		gridinit(data,currentPage); 
	}
	
	callAjax("/jboard/qnaList.do","post","json", true, param, resultCallback);
	
}


/* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
function gridinit(data,currentPage){
	 //console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
	 //console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));
	 
	 vm.items=[];
	 vm.items=data.qnaList;
	 
	 console.log(data.totalCnt + " : " + currentPage);
	 
	// 리스트의 총 개수를 추출합니다. 
	 //var totalCnt = $data.find("#totalCnt").text();
	 var totalCnt = data.totalCnt;  // qnaRealList() 에서보낸값 
    //alert("totalCnt 찍어봄!! " + totalCnt);
	 
	 // * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
	 // function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
	 // 파라미터를 참조합시다. 
    //var list = $("#tmpList").val();
	 //var listnum = $("#tmpListNum").val();
    var pagingnavi = getPaginationHtml(currentPage, totalCnt, qnaPageSizevue,qnaPageBlock, 'selectqnaListvue');
	 
    //console.log("pagingnavi : " + pagingnavi);
	 // 비운다음에 다시 append 
    $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
    $("#currentPage").val(currentPage);
}


 /* 공지사항 모달창(팝업) 실행  */
 function fqnaModal(wno) {
	 
	 // 신규저장 하기 버튼 클릭시 (값이 null)
	 if(wno == null || wno==""){
		// Tranjection type 설정
		//alert("넘을 찍어보자!!!!!!" + wno);
		
		$("#action").val("I"); // insert 
		frealPopModal(wno); // 공지사항 초기화 
		
		//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
		gfModalPop("#qna");
		
	 }else{
		// Tranjection type 설정
		$("#action").val("U");  // update
		fdetailModal(wno); //번호로 -> 공지사항 상세 조회 팝업 띄우기
	 }

 }
 
 
 /*공지사항 상세 조회*/
 function fdetailModalpop(wno){
	 //alert("공지사항 상세 조회  ");
	 
	 var param = {wno : wno};
	 var resultCallback2 = function(data){
		 fdetailResult(data);
	 };
	 
	 callAjax("/jboard/detailQnaList.do", "post", "json", true, param, resultCallback2);
	 //alert("공지사항 상세 조회  22");
 }
 
 /*  공지사항 상세 조회 -> 콜백함수   */
 function fdetailResult(data){
        
          
    
     console.log(data.result);
     console.log(data.resultMsg);
     console.log(data.detailQna);
	 //alert("공지사항 상세 조회  33");
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 gfModalPop("#qnavue");
		 
		// 모달에 정보 넣기 
		frealPopModal(data.detailQna);
	 
	 }else{
		 alert(data.resultMsg);
	 }
 }
 
 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
 function frealPopModal(object){
	 
	 if(object == "" || object == null || object == undefined){
/* 		 
		 var writer = $("#swriter").val();
		 //var Now = new Date();
		 
		 $("#loginID").val(writer);
		 $("#loginID").attr("readonly", true);
		 
		 $("#write_date").val();
		 
		 $("#nt_title").val("");
		 $("#nt_note").val("");
		 
		 $("#btnDeleteqna").hide(); // 삭제버튼 숨기기
		 $("#btnUpdateqna").hide();
		 $("#btnSaveqna").show();
		 */
		 
	 }else{
		 
		 //alert("숫자찍어보세 : " + object.wno);// 페이징 처리가 제대로 안되서 
		 dqnaVue.loginID_vue = object.loginID;
		 dqnaVue.nt_title_vue = object.title;
		 dqnaVue.nt_note_vue = object.note;
		 
		 
		 dqnaVue.select_wno = object.wno;
		 dqnaVue.select_cmnt_level = object.cmnt_level;
		 dqnaVue.select_upper_wno = object.upper_wno;
			
		 console.log(object.wno);
		 $("#nt_novue").val(object.wno); // 중요한 num 값도 숨겨서 받아온다. 
// 		 $("#select_wno").val(object.wno); //위 값과 중복
		 $("#select_cmnt_level").val(object.cmnt_level);
		 $("#select_upper_wno").val(object.select_upper_wno);
		 

		 
		 //$("#btnDeleteqna").show(); // 삭제버튼 보이기 
		 //$("#btnSaveqna").hide();
		 //$("#btnUpdateqna").css("display","");
		 //if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
		 //$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
		
		 
	 }
 }

 
 /* 공지사항 모달창(팝업) 실행  */
 function fqnaModal2(wno) {
	 
	 console.log("fqnaModal2 wno : " + wno);
	 
	 // 신규저장 하기 버튼 클릭시 (값이 null)
	 if(wno == null || wno==""){
		// Tranjection type 설정
		//alert("넘을 찍어보자!!!!!!" + wno);
		
		$("#action").val("I"); // insert 
		frealPopModal2(); // 공지사항 초기화 
		
		//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
		gfModalPop("#qnavue");
		
	 }else{
		// Tranjection type 설정
		$("#action").val("U");  // update
		fdetailModal2(wno); //번호로 -> 공지사항 상세 조회 팝업 띄우기
	 }

 }
 
 
 /*공지사항 상세 조회*/
 function fdetailModal2(wno){
	 //alert("공지사항 상세 조회  ");
	 
	 var param = {wno : wno};
	 var resultCallback2 = function(data){
		 fdetailResult2(data);
	 };
	 
	 callAjax("/supportD/detailqnaList.do", "post", "json", true, param, resultCallback2);
	 //alert("공지사항 상세 조회  22");
 }
 
 /*  공지사항 상세 조회 -> 콜백함수   */
 function fdetailResult2(data){

	 //alert("공지사항 상세 조회  33");
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 gfModalPop("#qnavue");
		 
		// 모달에 정보 넣기 
		frealPopModal2(data.result);
	 
	 }else{
		 alert(data.resultMsg);
	 }
 }
	 

 /* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
 function frealPopModal2(object){
	 
	 if(object == "" || object == null || object == undefined){
		 var writer = $("#swriter_vue").val();
		 //var Now = new Date();
		 // ****************************
		 
		 ved.loginID_vue = writer; 
		 ved.write_date_vue = writer;
		 ved.nt_title_vue = "";
		 ved.nt_note_vue = "";
		 
	 }else{
		 console.log("frealPopModal2 object.loginID : " + object.loginID);
		 
		 ved.loginID_vue = object.loginID;
		 
		 console.log("frealPopModal2 ved.loginID_vue : " + ved.loginID_vue);
		 $("#loginID_vue").attr("readonly", true); // 작성자 수정불가 
		 ved.write_date_vue = object.write_date;
		 $("#write_date").attr("readonly", true); // 처음 작성된 날짜 수정불가 
		 ved.nt_title_vue = object.nt_title;
		 $("#nt_title_vue").attr("readonly", true);
		 ved.nt_note_vue = object.nt_note;
		 $("#nt_note_vue").attr("readonly", true);
		 
		 $("#wno_vue").val(object.wno); // 중요한 num 값도 숨겨서 받아온다. 
		 
		 //$("#btnDeleteqna").show(); // 삭제버튼 보이기 
		 //$("#btnSaveqna").hide();
		 //$("#btnUpdateqna").css("display","");
		 //if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
		 //$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
		
		 
	 }
 }
 
</script>

</head>
<body>
	<!-- 모달 배경 -->
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage" value="1"> 
	
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
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="#"
								class="btn_set refresh">새로고침</a>
						</p>


<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
                        <div id="searcharea">
                             <table class="col2 mb10" style="width: 800px;">
									<colgroup>
										<col width="50px">
										<col width="200px">
										<col width="60px">
										<col width="50px">
										<col width="50px">
									</colgroup>
									<tbody>
									   <tr>
									      <td>
									           <select id="searchkey" name="searchkey"  v-model="searchkey">
									               <option value="">전체</option>
									               <option value="title">제목</option>
									               <option value="wr">작성자</option>
									               <option value="ct">내용</option>
									           </select>
									      </td>
									      <td><input id="searchword" name="searchword"  v-model="searchword" placeholder="제목 검색조건"></td>
									      <td>작성일</td>
									      <td>
									           <div class="input-group date" style="width:150px;">
	                                                  <input id="startdate" name="startdate" type="text" class="form-control" v-model="startdate" data-date-format='yyyy-mm-dd'/>
														<span><b>&nbsp; ~ &nbsp;</b></span>
	                                                  <input id="enddate" name="enddate" type="text" class="form-control" v-model="enddate" data-date-format='yyyy-mm-dd'/>
	                                           </div>   
									      </td>
									  	  <td>
												<a class="btnType blue" href="javascript:selectqnaListvue();" name="modal"><span>검색</span></a>		  	  
									  	  </td>
									   </tr>									       
									</tbody>

								</table>
								
                        </div>
	
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
												<col width="40%">
												<col width="10%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th data-field="title">제목</th>
													<th data-field="reg_date">작성일</th>
													<th data-field="loginID">작성자</th>													
												</tr>
												
											</thead>
											<tbody>
												<template v-for="(row, index) in items" v-if="items.length">
												<tr @click="fdetailModal(row.wno)">
													<td style="text-align: left; ">
														{{ row.title }}														
													</td>
													<td>{{ row.reg_date }}</td>
													<td>{{ row.loginID }}</td>
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
						<div class="paging_area" id="pagingnavi"></div>
					</div>
				</li>
			</ul>

		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="qnavue" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="nt_novue" name="nt_novue">
		<input type="hidden" id="select_upper_wno" name="select_upper_wno">
		<input type="hidden" id="select_wno" name="select_wno">
		<input type="hidden" id="select_cmnt_level" name="select_cmnt_level">
		
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>QnA 상세보기 </strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="editvue">
					<table class="row" id="detailtable">
						<caption>caption</caption>

						<tbody>							
							<tr>
								<th rowspan="3" >원글</th>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									v-model="loginID_vue" name="loginID_vue" id="loginID_vue" readonly="readonly"/></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="write_date_vue" name="write_date_vue" id="write_date_vue" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									v-model="nt_title_vue" name="nt_title_vue" id="nt_title_vue" readonly="readonly"/></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										v-model="nt_note_vue" name="nt_note_vue" id="nt_note_vue" readonly="readonly">
								</textarea></td>
							</tr>
							
							
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="answer_id" name="answer_id"/></td>
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100" id="answer_title" name="answer_title"/></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea id="answer_note" name="answer_note">
								</textarea></td>
							</tr>
						</tbody>

					</table>
				</div>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>