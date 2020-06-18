<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script
	src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>

<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
.ql-editor {
	height: 200px;
}
</style>
<script>
console.log("3");
var pageSize = 5;
var pageBlockSize = 5;

var nListVue;
var searchVue;
var dNoticeVue;
var wNoticeVue;
var replyVue;
var upOV;
var fromDt;
var toDt;


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


	/** OnLoad event */
	$(function() {	
		console.log("1");
		init();
		console.log("2");
		fNoticeList();
	});

	$(document).on("click","#deleterpy",function(){
		console.log("4");
		var resultCallback = function(data) {			
			replyVue.rlist=data.rList;	
		};
		//alert(event.target.tagName);
		var e= $(event.target);
		e.remove();
		callAjax("/jboard/deleteReply.do", "post", "json", true,{no:replyVue.no,nt_seq:dNoticeVue.nt_seq},resultCallback);
	}); 

function init(){
	console.log("5");
	
	/////
	// $("#myForm").attr("style","display:none");	
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
     ////
	
	
	Vue.use(VueQuillEditor);
	
	/* 초기화면 & 검색  */
	searchVue = new Vue({
		el:"#searcharea",
		data: {
			currentPage : 1,
			pageSize : pageSize,
			searchkey :'nt_title',
			searchword : '',
				fromDt : '',
				toDt : ''
		}
	});
	
	
	upOV = new Vue({
		el:'#updateoption',
		data:{
			usertype:'A',
			option:false,
			enr_user:''
		},
		methods:{
			optionch:function(){
				fileupdateset();
				this.option = !this.option;
			}
		}
		
	});
	
	
	/* 처음리스트  */
	nListVue = new Vue({
		el :"#vueListtable",
		data : {
			items:[]
		},
		methods:{
				showDetail:function(item){
					
					fShowDetail(item);
				}
		},
		computed :{
			
		}
	});
	
	/* 상세보기. */
	 dNoticeVue = new Vue({
		el :'#detailtable',
		 data :{
			 fileupdateset:false,
			action:'',
			 wno:'', 
			 title:'',
			 note:'',
			 cnt:'',
			 loginId:'',
			 reg_date:'',
			 upd_user:'',
			 upd_date:'',
			 file_name:'',
			 file_loc:'',
			 file_size:'',
			 editorOption: {
     			  theme: 'snow'
    			 }
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
        	    	  console.log("call dNoticeVue.showDetail");
        	    	  $("#dfile_nm").val("");
        	      },
        	      DownloadQnaFileEvent :function(){
        	    	  if(confirm("다운받으시겠습니까?")){
          	    		 fDownloadQnaFile();
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
         	    	 // alert( this.$refs.quillEditor.quill.getText());
         	        return this.$refs.quillEditor.quill;
         	      },
         	   	 mounted:function() {
           	      console.log('this is quill instance object', this.editor);
           	    }
		} 
	});
	

	 wNoticeVue = new Vue({
	 	el:'#writevue2',
	 	data : {
	 		action:'',
	 		 nt_seq:'', 
	 		 nt_title:'',
	 		 nt_contents:'',
	 		 nt_cnt:'',
	 		 enr_user:'',
	 		 enr_date:'',
	 		 upd_user:'',
	 		 upd_date:'',
	 		 file_nm:'',
	 		 file_loc:'',
	 		 file_size:'',
	 		 editorOption: {
	  			  theme: 'snow'
	 			 }
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
	 	    	     $("#wfile_nm").val("");
	 	    	  	 wNoticeVue.file_nm='';
	 	          },
	 	       	  setFileName : function(){
	 			     this.file_nm=event.target.files[0].name;
	 			  }
	 	},
	 	computed:{
	     	   editor:function() {
	      	    	 // alert( this.$refs.quillEditor.quill.getText());
	      	        return this.$refs.quillEditor.quill
	      	      },
	      	   	 mounted:function() {
	        	      console.log('this is quill instance object', this.editor)
	        	    }
	 	}
	 });
	 
}/* init() End */
console.log("20");
/* 게시판 리스트 조회.  */
	function fNoticeList(currentPage){	
		   console.log("call fNoticeList");
		   
		   searchVue.searchkey= searchkey || 'nt_title';
		 
		 /*  vue 사용했을떄 리로드가되는현상.. 발썡...
		  var currentpage= currentPage || 1;
		  var searchkey = searchVue.searchkey;
		  var searchword= searchVue.searchword; 
		   */
		  
		  var currentpage= currentPage || 1;
		  var searchkey = $('#searchkey').val();
		  var searchword= $('#searchword').val();
	      var fromDt = $('#fromDt').val();  //시작일
		  var toDt = $('#toDt').val();    //끝 
		   
		  
		  //alert(searchVue.searchkey + " , " + searchVue.searchword);
		  
		 var param={
				currentPage : currentpage,
				pageSize : pageSize,
				searchkey :searchkey,
				searchword :  searchword,
				fromDt :  fromDt,
				toDt :  toDt
			}; 
		 
		 
		//alert(searchVue.$data);
		var resultCallback = function(data) {
			/* alert(searchVue.searchkey + " , "+searchVue.searchword); */
			
			printList(data);
			
		};
		
		callAjax("/jboard/roomList.do", "post", "json", true,param ,resultCallback);
	}
	

function printList(data,currentPage){
	console.log("call printList()");
	var paginationHtml = 
		getPaginationHtml(data.currentPageNoticeList, data.totalCountList,
						data.pageSize,pageBlockSize, 'fNoticeList');
	
	$("#pagingnavi2").empty().append(paginationHtml); 
	nListVue.items=data.list;	
};

function fShowDetail(item){
	console.log("call fShowDetail()");
  /*   for( var key in item){
	   console.log("key : "+ key+" ,  value : "+item[key]);
   }  */
   
	if(item.file_name){
		 dNoticeVue.fileupdateset=true;
	}else{ 
   		dNoticeVue.fileupdateset=false;
	}
    upOV.option=false;
    upOV.enr_user=item.enr_user;
   
 	dNoticeVue.nt_seq=item.wno;
	dNoticeVue.nt_title=item.title;
	dNoticeVue.nt_contents=item.note;
	dNoticeVue.nt_cnt=item.cnt;
	dNoticeVue.enr_user=item.loginID;
	dNoticeVue.enr_date=item.reg_date;
	dNoticeVue.upd_user=item.upd_user;
	dNoticeVue.upd_date=item.upd_date;
	dNoticeVue.file_nm=item.file_name;
	dNoticeVue.file_loc=item.file_path;
	dNoticeVue.file_size=item.file_size; 
	/* 	
	for( var key in dNoticeVue.$data){
		   console.log("2key : "+ key+" ,  value : "+row[key]);
	}
	 */
	 
 	var param = {
			 nt_seq:item.nt_seq
	 }
	
	var resultCallback = function(data) {			
		
		dNoticeVue.nt_cnt=data.cnt;
		gfModalPop("#noticeDetailvue");
	};
	
	callAjax("/jboard/gereplyNcntUp.do", "post", "json", true,param,resultCallback); 
	
}



function fupdateNotice(){
	console.log("call fupdateNotice()");
	dNoticeVue.action='U';
	/* 		callAjax("/jboard/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
		 */	
			$("#daction").val(dNoticeVue.action);
		 	$("#dnt_seq").val(dNoticeVue.nt_seq);
		
			var frm = document.getElementById("detailNotice");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			
			var resultCallback = function(data) {
				alert("돌아옴"+data.msg);
				gfCloseModal();
				fNoticeList();
			};
			
	callAjaxFileUploadSetFormData("/jboard/updateNotice.do", "post", "json",true, fileData,resultCallback);
	
}

function fdeleteNotice(){
	console.log("call fdeleteNotice()");
	dNoticeVue.action='D';
/* 		callAjax("/jboard/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
 */	
	$("#daction").val(dNoticeVue.action);
    $("#dnt_seq").val(dNoticeVue.nt_seq);
    
    var frm = document.getElementById("detailNotice");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	var resultCallback = function(data) {
		alert("돌아옴"+data.msg);
		gfCloseModal();
		fNoticeList();
	};
	
	callAjaxFileUploadSetFormData("/jboard/updateNotice.do", "post", "json",true, fileData,resultCallback);
	
}


function fWriterNotice(){
	console.log("call fWriterNotice()");
	wNoticeVue.enr_user="${sessionScope.loginId}";
	/* $(".ql-editor").css("height","300px"); */
	$("#wnt_title").focus();
	
	gfModalPop("#writeNotice");
}

function finsertNotice(){
	console.log("call finsertNotice()");
	
	wNoticeVue.action='I';
	
	$("#waction").val(wNoticeVue.action);
	$("#wnt_contents").val(wNoticeVue.nt_contents);
	
	var frm = document.getElementById("noticeWrtieForm");
	frm.enctype = 'multipart/form-data';
	
	var fileData = new FormData(frm);
	
	var resultCallback = function(data) {
		alert(data.msg);
		fNoticeList();
		
	};
	
	callAjaxFileUploadSetFormData("/jboard/updateNotice.do", "post", "json",true, fileData,resultCallback);
	
	gfCloseModal();
}


function cancle(){
	console.log("call cancle()");
	gfCloseModal();
	fNoticeList();
}

/* 파일다운로드 */
function fDownloadQnaFile() {
	
	var params = "";
	params += "<input type='hidden' name='wno' value='"+ dNoticeVue.nt_seq +"' />";
	
	
	jQuery("<form action='/jboard/downloadQnaFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
}


/* javascript:searchSSS() */
function searchSSS(){
	
	var searchkey=$("#searchkey").val();
	var searchword=$("#searchword").val();
	
	fNoticeList(1,searchkey,searchword);
}



function fileupdateset(){
	dNoticeVue.fileupdateset=true;
}

</script>

</head>
<body>
<!-- 게시판 상세보기 모달팝업 -->

	<!-- <form id="test"></form> -->
	<jsp:include page="/WEB-INF/view/jboard/roomDetail.jsp"></jsp:include>

	<!-- 게시판 글쓰기 모달팝업 -->
	<%-- <jsp:include page="/WEB-INF/view/jboard/roomWrite.jsp"></jsp:include>
	 --%><div id="mask"></div>

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
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">게시판</a> <span class="btn_nav bold">자료게시판</span>
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searcharea">
							<span>자료게시판</span> <span class="fr">
								<form>
									<select id="searchkey" name="searchkey" style="width: 104px;"
										v-model="searchkey">
										<option value="all">전체</option>
										<option value="title">제목</option>
										<option value="enr_user">작성자</option>
										<option value="nt_contents">내용</option>
									</select> <input type="text" id="searchword" name="searchword"
										placeholder="입력하세요" style="height: 28px;" v-model="searchword"
										@keyup.enter="searchbtn"> <input type="text"
										style="height: 31px; width: 110px;" class="txtInput"
										id="fromDt" name="fromDt" v-model="fromDt"
										data-date-format='yyyy-mm-dd'> <span><b>&nbsp
											~ &nbsp</b></span> <input type="text" style="height: 31px; width: 110px"
										class="txtInput" id="toDt" name="toDt" v-model="toDt"
										data-date-format='yyyy-mm-dd'>



									<!-- a태그에 @click 이벤트 같은걸? 걸어주면 href가 나중에 실행되는듯!!리로드현상해결.  -->
									<!-- <a class="btnType blue" href=""  name="search" id="searchBtn" @click="searchbtn"><span>검색</span></a> -->
							</span>
						</p>

						<span style="float: left;"> <a
							href="javascript:fNoticeList()" class="btnType gray"><span>검색</span></a>
							<a class="btnType blue" href="javascript:fWriterNotice();"><span>글쓰기</span></a>
						</span><br>
						<br>

						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right"></div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<!-- 공지사항 리스트-->

										<jsp:include page="/WEB-INF/view/jboard/roomList.jsp"></jsp:include>

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
						<br> 
					</div>
				</li>
			</ul> 
		</div>
	</div>
	<form>
	
	</form>
	<form id="noticeWrtieForm" action="" method="" >
	<!-- 글쓰기 -->
	<div id="writeNotice" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
		<!-- 업데이트냐 수정이냐 ~  vue 사용으로 필요없음. $data를 보내기때문 -->
		<input type="hidden" name="action" id="waction" value="">
		<input type="hidden"  name="nt_contents" id="wnt_contents"  value="">
	
	

		<dl>
			<dt>
				<strong>자료게시판 글쓰기</strong>
			</dt>
			<dd class="content">
				<div id="writevue2">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3">
								<input type="text" class="inputTxt p100" name="nt_title" id="wnt_title" v-model="nt_title" autofocus required/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="wenr_user" v-model="enr_user" />
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								
								<div style="width: 900px;" >
								 
								  <quill-editor id="quillEditor"
								    ref="quillEditor" class="editor" v-model="nt_contents" :options="editorOption" 
								    @blur="onEditorBlur($event)"
								    @focus="onEditorFocus($event)"
								    @ready="onEditorReady($event)"
								  />
								  <br>
								 
								</div>
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
									<!--multiple="multiple" -->
									<input type="file" name="file_nm" id="wfile_nm" @change="setFileName" ></input>
									<img v-if="file_nm !='' "src="/images/treeview/minus.gif" @click="minusClickEvent">
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
					
				<div class="btn_areaC mt30">
					
						<a href="javascript:finsertNotice()" class="btnType blue" ><span>저장</span></a>
		
						<a href="javascript:cancle()" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	</form>




</body>
</html>