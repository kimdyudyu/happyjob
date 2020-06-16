<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>개발자 조회</title>

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
	
	/** OnLoad event */
	$(function() {	
		init();
		fNoticeList();

	});
	
	
	function init(){
		comcombo("areaCD", "areasel", "all", "");
		comcombo("SKLCD", "level", "all", "");
		comcombo("SWCD", "ind", "all", "");
		
		/* 초기화면 & 검색  */
		searchVue = new Vue({
			el:"#searcharea",
			data: {
				currentPage : 1,
				pageSize : pageSize,
				searcharea :'',
				searchlevel : '',
				searchind : ''
			},
			methods:{
				
					searchbtn:function(){
					 fNoticeList(this.currentPage,this.searcharea,this.searchlevel, this.searchind);	 
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
				 fileupdateset:false,
				action:'',
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

	
	/* 공지사항 리스트 조회.  */
	function fNoticeList(currentPage,searcharea,searchlevel,searchind){	
		   
		  var currentpage= currentPage || 1;
		  var searcharea = searcharea || '';
		  var searchlevel= searchlevel || '';
		  var searchind= searchind || '';
		  
		 var param={
				currentPage : currentpage,
				pageSize : pageSize,
				searcharea :searcharea,
				searchlevel :  searchlevel,
				searchind : searchind
			};
		 
		 
		 
		//alert(searchVue.$data);
		var resultCallback = function(data) {	
			printList(data);
		};
		callAjax("/jmli/developerList.do", "post", "json", true,param ,resultCallback);
	}
	
	function printList(data,currentPage){
		var paginationHtml = 
			getPaginationHtml(data.currentPageNoticeList, data.totalCountDeveloper,
							data.pageSize,pageBlockSize, 'searchSSS');
		
		$("#pagingnavi2").empty().append(paginationHtml); 
		nListVue.items=data.list;	
	};
	
	function fShowDetail(item){
	
	 	var param={
				 loginID:item.loginID,
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
		 	dNoticeVue.comp_name=selectone.comp_name;
		 	dNoticeVue.mgr_name=selectone.mgr_name;
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
			
			
			gfModalPop("#noticeDetailvue");
		};
		
		callAjax("/jmli/selectDeveloperOne.do", "post", "json", true,param,resultCallback); 
		
	}
		
	function sendMessage(){
		
		var param={
				receiver : dNoticeVue.loginID,
				messageText : dNoticeVue.message
		};
		  
		
		var resultCallback = function(data) {
			
			alert("메시지를 전송했습니다.");
			gfCloseModal();
		};
		
		callAjax("/jmli/insertMessage.do", "post", "json", true,param,resultCallback);
		
	}
	
	function cancle(){

		gfCloseModal();
	}
	
	
	function searchSSS(i){
		var index = i;
		var searcharea=$("#areasel").val();
		var searchlevel=$("#level").val();
		var searchind=$("#ind").val();
		
		fNoticeList(i,searcharea,searchlevel,searchind);
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
								<a href="#" class="btn_nav">목록조회</a> 
								<span class="btn_nav bold">개발자 조회</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>
							<p class="conTitle">
								<span>개발자 조회</span> 
								<span class="fr">
								<span>지역</span>
								<select id="areasel" name="areasel" style="width: 104px;" >
								</select>
								<span>등급</span>
								<select id="level" name="level" style="width: 104px;" >
								</select>
								<span>산업</span>
								<select id="ind" name="ind" style="width: 104px;" >
								</select>
								<input type="button" class="btnType blue" name="search" id="searchBtn" onclick="javascript:searchSSS()" value="검색">
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
										
								<jsp:include page="/WEB-INF/view/jmli/developerList.jsp"></jsp:include>
								
								
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
	<jsp:include page="/WEB-INF/view/jmli/developerDetail.jsp"></jsp:include>

</body>
</html>