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
	var pageSize = 5;
	var pageBlockSize = 5;

	var nListVue;
	var searchVue;
	var dNoticeVue;
	var dCompVue;
	
	/** OnLoad event */
	$(function() {	
		init();
		fuser_list();
	});
	
	
	function init(){
		
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
				 name:'', 
				 loginID:'',
				 user_type:'',
				 email:'',
				 email_cop:'',
				 sex:'',
				 birthday:'',
				 area:'',
				 tel1:'',
				 tel2:'',
				 tel3:'',
				 user_position:'',
				 salary:'',
				 consult_yn:'',
				 career_year:'',
				 career_mm:'',
				 skill_add:'',
				 singular_facts:'',
				 comp_name:'',
				 mgr_name:'',
				 join_date:'',
				 updateId:'',
				 update_date:'',
				 skill:'',
				 career_contents:'',
				 editorOption: {
	     			  theme: 'snow'
	    			 }
			},
			methods : {
	      	  
			},
			computed :{
	        	   
			} 
		});
		
		dCompVue = new Vue({
			el :'#detailtable2',
			 data :{
				 name:'', 
				 loginID:'',
				 user_type:'',
				 email:'',
				 email_cop:'',
				 sex:'',
				 birthday:'',
				 area:'',
				 tel1:'',
				 tel2:'',
				 tel3:'',
				 user_position:'',
				 salary:'',
				 consult_yn:'',
				 career_year:'',
				 career_mm:'',
				 skill_add:'',
				 singular_facts:'',
				 comp_name:'',
				 mgr_name:'',
				 join_date:'',
				 updateId:'',
				 update_date:'',
				 skill:'',
				 career_contents:'',
				 editorOption: {
	     			  theme: 'snow'
	    			 }
			},
			methods : {
	      	  
			},
			computed :{
	        	   
			} 
		});		
	}/* init() End */

	
	function fuser_list(currentPage,searchkey,searchword){	

		searchVue.searchkey= searchkey || '';
		  
		  var currentpage= currentPage || 1;
		  var searchkey = searchkey || '';
		  var searchword= searchword || '';
		  
		 var param={
				currentPage : currentpage,
				pageSize : pageSize,
				searchkey :searchkey,
				searchword :  searchword
			};
		 
		var resultCallback = function(data) {	
			printList(data);
		};
		
		callAjax("/jmgr/userList.do", "post", "json", true,param ,resultCallback);
	}
	
	function printList(data,currentPage){
		var paginationHtml = 
			getPaginationHtml(data.currentPageNoticeList, data.totalCountUser,
							data.pageSize,pageBlockSize, 'searchSSS');
		$("#pagingnavi2").empty().append(paginationHtml); 
		nListVue.items=data.list;	
	};
	
	function fShowDetail(item){
		
	 	var param={
				 loginID:item.loginID
		 }
		
		var resultCallback = function(data) {			 
			var selectone = data.detailone;
			var user_skill = data.skill;
			 	 
		 	dNoticeVue.loginID=selectone.loginID;
		 	dNoticeVue.name=selectone.name;
		 	dNoticeVue.email=selectone.email;
		 	dNoticeVue.email_cop=selectone.email_cop;
		 	dNoticeVue.sex=selectone.sex;
		 	dNoticeVue.birthday=selectone.birthday;
		 	dNoticeVue.area=selectone.area;
		 	dNoticeVue.tel1=selectone.tel1;
		 	dNoticeVue.tel2=selectone.tel2;
		 	dNoticeVue.tel3=selectone.tel3;
		 	dNoticeVue.user_position=selectone.user_position;
		 	dNoticeVue.salary=selectone.salary;
		 	
		 	dNoticeVue.career_year=selectone.career_year;
		 	dNoticeVue.career_mm=selectone.career_mm;
		 	dNoticeVue.skill_add=selectone.skill_add;
		 	dNoticeVue.singular_facts=selectone.singular_facts;
		 	
		 	dCompVue.loginID=selectone.loginID;
		 	dCompVue.comp_name=selectone.comp_name;
		 	dCompVue.mgr_name=selectone.mgr_name;
		 	dCompVue.mgr_tel1=selectone.mgr_tel1;
		 	dCompVue.mgr_tel2=selectone.mgr_tel2;
		 	dCompVue.mgr_tel3=selectone.mgr_tel3;
		 	dCompVue.email=selectone.email;
		 	dCompVue.email_cop=selectone.email_cop;
		 	dCompVue.comp_birthday=selectone.comp_birthday;
		 	dCompVue.comp_info=selectone.comp_info;
		 	
		 	dNoticeVue.join_date=selectone.join_date;
		 	dNoticeVue.updateId=selectone.updateId;
		 	dNoticeVue.update_date=selectone.update_date;
		 	dNoticeVue.skill=selectone.skill;
		 	dNoticeVue.career_contents=selectone.career_contents;
			
		 	var consult = document.getElementsByName('priceCheck');
		 	
				consult.forEach(function(item){
						item.checked=false;
						return false;
				});
		 	
				consult.forEach(function(item){	
					
					var consultCheck =item.value;
				
					if(consultCheck == selectone.consult_yn) {
						
						item.checked=true;
						return false;
					};
				});
		 	
			var skill = document.getElementsByName('skillcheck');
			
			skill.forEach(function(item){
				
				item.checked=false;
				return false;
			});
			
			skill.forEach(function(item){
				
				user_skill.forEach(function(user_item){
					
					
					var item_skill =item.value;
				
					if(item_skill == user_item) {
						
						item.checked=true;
						return false;
					}
				});
	
			});
			if(selectone.user_type == "D"){
				gfModalPop("#noticeDetailvue");
			}else{
				gfModalPop("#layer3");
			}
		};
		
		callAjax("/jmgr/selectDeveloperOne.do", "post", "json", true,param,resultCallback); 
		
	}
	
	
	function fdeleteUser(){

		var param={
			loginID:dNoticeVue.loginID
		};
		
		var resultCallback = function(data) {
			alert("돌아옴"+data.msg);
			gfCloseModal();
			fuser_list();
		};
		
		callAjax("/jmgr/deleteUser.do", "post", "json",true, param,resultCallback);
		
	}
	
	function fupdateUser(){
		
		var consult ="";
		
		$("input[name=priceCheck]:checked").each(function(index) {
			consult += $(this).val();
	    });
		
		
		var paramstr = "";
		
		$("input[name=skillcheck]:checked").each(function(index) {
			paramstr += $(this).val() + "/";
	    });
		
		var param={
				loginID:dNoticeVue.loginID,
				name:dNoticeVue.name,
				sex:dNoticeVue.sex,
				email:dNoticeVue.email,
				email_cop:dNoticeVue.email_cop,
				skill:dNoticeVue.skill,
				user_position:dNoticeVue.user_position,
				birthday:dNoticeVue.birthday,
				area:dNoticeVue.area,
				tel1:dNoticeVue.tel1,
				tel2:dNoticeVue.tel2,
				tel3:dNoticeVue.tel3,
				career_year:dNoticeVue.career_year,
				career_mm:dNoticeVue.career_mm,
				salary:dNoticeVue.salary,
				skill_add:dNoticeVue.skill_add,
				career_contents:dNoticeVue.career_contents,
				singular_facts:dNoticeVue.singular_facts,
				paramstr:paramstr,
				consult_yn:consult
		};
		
		var resultCallback = function(data) {
			alert(data.msg);
			gfCloseModal();
			fuser_list();
		};
		
		callAjax("/jmgr/updateUser.do", "post", "json",true, param,resultCallback);
		
	}
	
	function fupdateComp(){
		
		var param={
				
				loginID:dCompVue.loginID,
				comp_name:dCompVue.comp_name,
				mgr_name:dCompVue.mgr_name,
				mgr_tel1:dCompVue.mgr_tel1,
				mgr_tel2:dCompVue.mgr_tel2,
				mgr_tel3:dCompVue.mgr_tel3,
				email:dCompVue.email,
				email_cop:dCompVue.email_cop,
				comp_birthday:dCompVue.comp_birthday,
				comp_info:dCompVue.comp_info
		}
		
		var resultCallback = function(data) {
			alert(data.msg);
			gfCloseModal();
			fuser_list();
		};
		
		callAjax("/jmgr/updateComp.do", "post", "json",true, param,resultCallback);
		
	}
	
	function cancle(){
		
		gfCloseModal();
		fuser_list();
	}
	
	function searchSSS(i){
		
		var pagenum = i;
		var searchkey=$("#searchkey").val();
		var searchword=$("#searchword").val();
		
		fuser_list(pagenum,searchkey,searchword);
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
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> 
								<a href="#" class="btn_nav">관리자</a> 
								<span class="btn_nav bold">사용자관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>

							<p class="conTitle" id="searcharea">
								<span>사용자관리</span> 
								<span class="fr">
								 <select id="searchkey" name="searchkey" style="width: 104px;" v-model="searchkey" >
								    <option value=''>전체</option> 
									<option value='C' >기업회원</option>
									<option value='D' >일반회원</option>
								</select>
								
								<input type="text" id="searchword" name="searchword"  
								          placeholder="이름을 입력하세요" style="height: 28px;" v-model="searchword" @keyup.enter="searchbtn"> 
								<input type="button" class="btnType blue" name="search" id="searchBtn" @click="searchbtn" value="검색"></a>
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
												<div class="clearfix"></div>
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
	<jsp:include page="/WEB-INF/view/jmgr/userDetail.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/jmgr/userDetail2.jsp"></jsp:include>

</body>
</html>