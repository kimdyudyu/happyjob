<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>


<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
.ql-editor {
	height:200px;
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
		fuser_list();
		
		
	});
	
	
	function init(){
		console.log("5");
		
		Vue.use(VueQuillEditor);
		
		/* 초기화면 & 검색  */
		searchVue = new Vue({
			el:"#searcharea",
			data: {
				currentPage : 1,
				pageSize : pageSize,
				searchkey :'name',
				searchword : ''
			},
			methods:{
					searchbtn:function(){
					 fuser_list(this.currentPage,this.searchkey,this.searchword);	 
				}  
			},
			computed:{
				
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
				 name:'', 
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
			el:'#writevue',
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
	/* 공지사항 리스트 조회.  */
	function fuser_list(currentPage,searchkey,searchword){	
		   console.log("call fuser_list");
		   console.log(currentPage);
		   console.log(searchkey);
		   console.log(searchword);
		   searchVue.searchkey= searchkey || '';
		 
		 /*  vue 사용했을떄 리로드가되는현상.. 발썡...
		  var currentpage= currentPage || 1;
		  var searchkey = searchVue.searchkey;
		  var searchword= searchVue.searchword; 
		   */
		  
		  var currentpage= currentPage || 1;
		  var searchkey = searchkey || '';
		  var searchword= searchword || '';
		  
		  //alert(searchVue.searchkey + " , " + searchVue.searchword);
		  
		 var param={
				currentPage : currentpage,
				pageSize : pageSize,
				searchkey :searchkey,
				searchword :  searchword
			};
		 
		 
		 
		//alert(searchVue.$data);
		var resultCallback = function(data) {	
			/* alert(searchVue.searchkey + " , "+searchVue.searchword); */
			
			
			printList(data);
			
		};
		
		callAjax("/jmgr/adminNoticeList.do", "post", "json", true,param ,resultCallback);
	}
	
	function printList(data,currentPage){
		console.log("call printList()");
		var paginationHtml = 
			getPaginationHtml(data.currentPageNoticeList, data.totalCountUser,
							data.pageSize,pageBlockSize, 'fuser_list');
		
		 console.log("여기까지 " + data.currentPageNoticeList);
		
		$("#pagingnavi2").empty().append(paginationHtml); 
		nListVue.items=data.list;	
	};
	
	function fShowDetail(item){
		console.log("call fShowDetail()");
	  /*   for( var key in item){
		   console.log("key : "+ key+" ,  value : "+item[key]);
	   }  */

	   	dNoticeVue.fileupdateset=false;
	    upOV.option=false;
	    upOV.enr_user=item.enr_user;
	   
	 	dNoticeVue.loginID=item.loginID;
		dNoticeVue.name=item.name;
		/* 	
		for( var key in dNoticeVue.$data){
			   console.log("2key : "+ key+" ,  value : "+row[key]);
		}
		 */
	 	var param={
				 loginID:item.loginID,
				 name:item.name
				 
		 }
		
		var resultCallback = function(data) {	
			 
		 		dNoticeVue.loginID='';
		 		dNoticeVue.name='';
		 		
		 		dNoticeVue.loginID=item.loginID;
		 		dNoticeVue.name=item.name;

			gfModalPop("#noticeDetailvue");
		};
		
		callAjax("/jmgr/cntUp.do", "post", "json", true,param,resultCallback); 
		
	}
	
	
	function fupdateNotice(){
		console.log("call fupdateNotice()");
		dNoticeVue.action='U';
		/* 		callAjax("/mss/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
			 */	
				$("#daction").val(dNoticeVue.action);
			 	$("#dnt_seq").val(dNoticeVue.nt_seq);
			
				var frm = document.getElementById("detailNotice");
				frm.enctype = 'multipart/form-data';
				var fileData = new FormData(frm);
				
				var resultCallback = function(data) {
					alert("돌아옴"+data.msg);
					gfCloseModal();
					fuser_list();
				};
				
		callAjaxFileUploadSetFormData("/jmgr/cntUp.do", "post", "json",true, fileData,resultCallback);
		
	}
	
	function fdeleteNotice(){
		console.log("call fdeleteNotice()");
		dNoticeVue.action='D';
/* 		callAjax("/mss/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
	 */	
		$("#daction").val(dNoticeVue.action);
	    $("#dnt_seq").val(dNoticeVue.nt_seq);
	    
	    var frm = document.getElementById("detailNotice");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		var resultCallback = function(data) {
			alert("돌아옴"+data.msg);
			gfCloseModal();
			fuser_list();
		};
		
		callAjaxFileUploadSetFormData("/jmgr/cntUp.do", "post", "json",true, fileData,resultCallback);
		
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
			fuser_list();
			
		};
		
		callAjaxFileUploadSetFormData("/jmgr/cntUp.do", "post", "json",true, fileData,resultCallback);
		
		gfCloseModal();
	}
	
	
	function cancle(){
		console.log("call cancle()");
		gfCloseModal();
	}
	
	
	
	/* javascript:searchSSS() */
	function searchSSS(){
		
		var searchkey=$("#searchkey").val();
		var searchword=$("#searchword").val();
		
		
		fuser_list(1,searchkey,searchword);
	}
	

</script>



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
					<div class="content">

						<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> 
								<a href="#" class="btn_nav">관리자</a> 
								<span class="btn_nav bold">공지사항 관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

							<p class="conTitle" id="searcharea">
								<span>사용자관리</span> 
								<span class="fr">
								<!-- 
								<select id="searchkey" name="searchkey" style="width: 104px;" v-model="searchkey" > 
									<option value="nt_title" >지역</option>
									<option value="enr_user" >등급</option>
									<option value="nt_contents">산업</option>
								</select>
								 -->
								 
								 
								 <select id="searchkey" name="searchkey" style="width: 104px;" v-model="searchkey" >
								    <option value=''>전체</option> 
									<option value='C' >기업회원</option>
									<option value='D' >일반회원</option>
								</select>
								
								<input type="text" id="searchword" name="searchword"  
								          placeholder="이름을 입력하세요" style="height: 28px;" v-model="searchword" @keyup.enter="searchbtn"> 
						
								<input type="button" class="btnType blue" name="search" id="searchBtn" @click="searchbtn" value="검색"></a>
								
								<!-- a태그에 @click 이벤트 같은걸? 걸어주면 href가 나중에 실행되는듯!!리로드현상해결.  -->
								<!-- <a class="btnType blue" href=""  name="search" id="searchBtn" @click="searchbtn"><span>검색</span></a> -->
								</span>
								
							</p>

						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right"></div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

								<!-- 공지사항 리스트-->
								 <jsp:include page="/WEB-INF/view/jmgr/userList.jsp"></jsp:include>
								
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
	
	<!-- 개발자 상세보기 모달팝업 -->
	<jsp:include page="/WEB-INF/view/jmli/developerDetail.jsp"></jsp:include>

	
</body>
</html>