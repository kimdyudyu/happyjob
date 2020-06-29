<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>과정공지 및 일정</title>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
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
//페이징 설정 
var curPageSize = 10;    	// 화면에 뿌릴 데이터 수 
var curPageSizevue = 10;
var curPageBlock = 10;		// 블럭으로 잡히는 페이징처리 수

var vm;
var popvue;

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
		
$(function(){
	init();
	selectListvue();
});

function init(){
	vm = new Vue({
		el: '#vuetable',
		components: {
			'bootstrap-table': BootstrapTable
		},
		data: {
			items: [],
			option: {
				
			}
		},
		methods: {//no를 통해 팝업창 열기
			fdetailModal: function(no){
				
				
				console.log("=====================> " + no);
				
				fdetailModalpop(no);
			}
		}
	});  
	/* 팝업창 */
	popvue = new Vue({
		el :'#detailtable',
		 data :{
			 title_vue:'',
			 start_vue:'',
			 end_vue:'',
			 filename_vue:'',
			 plan_vue:''
			 
		},
		methods : {
			onEditorBlur:function(quill) {
      	    	 
    	        console.log('editor blur!', quill);
    	      },
    	      onEditorFocus:function(quill) {
    	    	 
    	        console.log('editor focus!', quill);
    	      },
    	      onEditorReady:function(quill){
    	    	 
    	        console.log('editor ready!', quill);
    	      },
    	      minusClickEvent:function(){
    	    	  console.log("call vm.showDetail");
    	    	  $("#dfile_nm").val("");
    	      },
    	      DownloadFileEvent :function(){
    	    	  if(confirm("다운받으시겠습니까?")){
      	    		 fDownloadFile();
      	    	  }else{
      	    		  alert("취소되었습니다.");
      	    	  }
   	          },
   	         setFileName : function(){
			      	this.file_nm=event.target.files[0].name;
				
			      }
		},
		computed :{
			editor:function() {
         		return this.$refs.quillEditor.quill;
			},
			mounted:function() {
         		console.log('this is quill instance object', this.editor);
           	}
		} 
	}); 
}


/* 공지사항 리스트 불러오기  */
function selectListvue(currentPage){
	
	currentPage = currentPage || 1;  
	//svm.stitle = "55555555555";
	//console.log("selectqnaListvue currentPage : " + currentPage);
	var startdate = $("#startdate").val();
	var enddate = $("#enddate").val();
	var searchkey = $("#searchkey").val();
	var searchword = $("#searchword").val();
	var no = $("#select_no").val();
	
	var param = {
			currentPage : currentPage ,
			pageSize : curPageSizevue,
			startdate : startdate,
			enddate : enddate,
			searchkey : searchkey,
			searchword : searchword,
			no: no
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		gridinit(data,currentPage); 
	}
	
	callAjax("/hls/curList.do","post","json", true, param, resultCallback);
	
}

function gridinit(data,currentPage){
	 //console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
	 //console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));
	 
	 vm.items=[];
	 vm.items=data.curList;
	 
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
   var pagingnavi = getPaginationHtml(currentPage, totalCnt, curPageSizevue,curPageBlock, 'selectListvue');
	 
   //console.log("pagingnavi : " + pagingnavi);
	 // 비운다음에 다시 append 
   $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
   $("#currentPage").val(currentPage);
} 

//gfModalPop("창띄울 div id값");

/* 상세 조회(팝업)*/
function fdetailModalpop(no){
	
// 	gfModalPop("#popvue");
	 var param = {no : no};
	 var resultCallback2 = function(data){
		 fdetailResult(data);
	 };
	 
	 callAjax("/hls/detailCurList.do", "post", "json", true, param, resultCallback2);
}

function fdetailResult2(data){
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 gfModalPop("#popvue");
		 
		// 모달에 정보 넣기 
		frealPopModal(data.detailcur);
	 
	 }else{
		 alert(data.resultMsg);
	 }
}

/*  공지사항 상세 조회 -> 콜백함수   */
function fdetailResult(data){

	 var json_obj = JSON.stringify(data);
     var jsonstr = json_obj.detailCur;

	 //alert("공지사항 상세 조회  33");
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 gfModalPop("#popvue");
		 
		// 모달에 정보 넣기 
		frealPopModal(data.detailcur);
	 
	 }else{
		 alert(data.resultMsg);
	 }
}

/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
function frealPopModal(object){
	 
	
	 //console.log("frealPopModal title : " + object.title);
	
	 if(object == "" || object == null || object == undefined){
	 }else{

		 popvue.title_vue = object.title;
		 popvue.start_vue = object.startdate;
		 popvue.end_vue = object.enddate;
		 popvue.filename_vue = object.filename;
		 popvue.plan_vue = object.plan;

		 $("#no_vue").val(object.no); // 중요한 num 값도 숨겨서 받아온다. 

		 
	 }
	 
}

function cancel(){
    //console.log("call cancel()");
    gfCloseModal();
    selectListvue();
 }
 
/* 파일다운로드 */
function fDownloadFile() {
	
	var params = "";
	params += "<input type='hidden' name='nt_no' value='"+ vm.nt_seq +"' />";
	
	
	jQuery("<form action='/hls/downloadFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
}

</script>

</head>


<body>

<form id="myForm" action="" method="">
	<div id="main">
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				
				<li class="contents">
					<h3 class="hidden">콘텐츠 영역</h3>
					
					<div class="content">
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
										<td><input id="searchword" name="searchword"  v-model="searchword" placeholder="검색조건"></td>
						  	  			<td>
											<a class="btnType blue" href="javascript:selectListvue();" name="modal"><span>검색</span></a>		  	  
									    </td>
									</tr>									       
								</tbody>
							</table>
						</div>
						
						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right"></div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">
										<table id="vuedatatable" class="col2 mb10" style="width: 1000px;">
											<colgroup>
												<col width="40%">
												<col width="10%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th data-field="title">강의명</th>
													<th data-field="startdate">시작일</th>
													<th data-field="loginID">작성자</th>
												</tr>
											</thead>
											
											<tbody>
												<template v-for="(row, index) in items" v-if="items.length">
													<tr @click="fdetailModal(row.no)">
														<td style="text-align: left; ">
															{{ row.title }}
														</td>
														<td>{{ row.startdate }}</td>
														<td>{{ row.loginID }}</td>
													</tr>
												</template>
											</tbody>
										</table>
										<div class="clearfix">
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
	<div id="popvue" class="layerPop layerType2" style="width: 800px;">
		<input type="hidden" id="no_vue" name="no_vue">
		
		<dl>
			<dt>강의 상세보기</dt>
			<dd class="content">
				<div id="editvue">
					<table class="row" id="detailtable">
						<caption>cap</caption>
						
						<tbody>
							<tr>
								<th>강의명</th>
								<th colspan="3">
									<input type="text" v-model="title_vue" name="title_vue" 
									id="title_vue date" readonly="readonly" class="inputTxt">
								</th>
								<th>강의기간</th>
								<th id="day"><input type="text" v-model="start_vue" name="start_vue" id="start_vue date" readonly="readonly"><br>~<br><input type="text" v-model="end_vue" name="end_vue" id="end_vue" readonly="readonly"></th>
							</tr>
							<tr>
								<th>내용</th>
								<th colspan="4">
								<textarea v-model="plan_vue" name="plan_vue" id="plan_vue" style="resize: none; width=300px; "></textarea></th>

							</tr>
							<tr>
								<th>첨부파일</th>
								<th><input type="text" v-model="filename_vue" name="filename_vue" id="filename_vue" readonly="readonly"></th>
								<th><button type="button" id="downloadBtn" @click="DownloadFileEvent">다운로드</button>	
							</tr>
							<tr align="center">
								<th><button type="button" id="submitBtn">신청</button></th>
								<th><button type="button" id="cancelBtn" onclick="cancel()">신청취소</button></th>
							</tr>
						</tbody>
					</table>
				</div>
			</dd>
		</dl>
	</div>
</form>
</body>
</html>