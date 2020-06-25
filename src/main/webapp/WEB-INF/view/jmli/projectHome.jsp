<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  

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
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

</head>
<style>
.ql-editor {
	height: 200px;
}

.jMainList_ul,.jMainList_li {
	list-style-type:none;
	float:right;
	margin-left:20px;
	
}
a:link{color: blue;text-decoration:none;}
a:visited{color: blue;}
a:hover{text-decoration:underline;}
a:active{background-color:yellow;}
</style>

<script>
	var pageSize = 5;
	var pageBlockSize = 5;

	var nListVue;
	var searchVue;
	var dNoticeVue;
	var searchareaVueK;
	var projectList;
	var pDetailVue;
	
	
	$(document).ready(function() {
		
		init();
		
		//공통코드 불러오기
		getCommonCode();
		
		//프로젝트 목록 불러오기;
		getProjectList();
		
	    //$.datepicker.setDefaults($.datepicker.regional["ko"]);

		//날짜목록
		getDatePicker();

	});
	
	
	function init() {
	
		Vue.use(VueQuillEditor);

		/*처음 리스트*/
		nListVue = new Vue({
			el : "#vueListtable",
			data : {
				items : []
			},
			methods : {
				showDetail : function(item) {
					fShowDetail(item);
				}
			},
			computed : {
			}
				
		});
		
		
		//프로젝트 리스트
		projectList = new Vue({
			el : '#projectvuetable',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				items : [],
				options : {
					
				}
			},
			methods : {
				projectDetail : function(item){
					getProjectDetail(item);
				}
			}
		});
		
		searchareaVue = new Vue({
			el : "#search_Project",
			data : {
				searcharea :'',
				searchjob : '',
				searchind : ''
			},
			methods: {
				searchProject : function(){
					getProjectList(this.currentPage,this.searcharea,
							this.searchjob,this.searchind);
				}
			}
		});
		
		
		//프로젝트 상세보기 Vue
		pDetailVue = new Vue({
			el : "#detailtable_p",
			data : {
				P_project_name : '',
				P_loginID :'',
				p_begin :'',
				p_middle: '',
				p_high : '',
				p_special : '',
				p_notoDetail : '',
				p_option_order : '',
				p_singular_facts : '',
				p_searchareaDetail : '',
				p_searchjobDetail:'',
				p_searchindDetail : '',
				p_searchSWCD : '',
				p_projectId : '',
				loginId : ''
			},
			methods : {
				apply_func : function(){
					applyPjroject(this.p_projectId);
				}
			}
		});

	}

	//공통 코드 불러오기
	function getCommonCode(){
		comcombo("areaCD","searcharea","all","");
		comcombo("JOBCD","searchjob","all","");
		comcombo("industryCD","searchind","all","");
	
		//상세보기 
		comcombo("areaCD","p_searchareaDetail","all","");
		comcombo("JOBCD","p_searchjobDetail","all","");
		comcombo("industryCD","p_searchindDetail","all","");
		comcombo("SWCD","p_searchSWCD","all","");
	}
	
	//프로젝트 목록 불러오기
	function getProjectList(currentPage,searcharea,searchjob,searchind){
		
		var currentPage = currentPage || 1;
		var searcharea = searchareaVue.searcharea || '';
		var searchjob = searchareaVue.searchjob || '';
		var searchind = searchareaVue.searchind || '';
		
		var paramProject = {
				currentPage : currentPage,
				pageSize : pageSize,
				searcharea : searcharea,
				searchjob : searchjob,
				searchind : searchind
			};

		
		var projectResultCallback = function(data) {
			printProjectList(data);
		};

		callAjax("/jmli/projectList.do", "post", "json", true, paramProject, projectResultCallback);
		
		
	}
	
	
	//공지사항 출력
	function printList(data, currentPage) {

		var paginationHtml = getPaginationHtml(data.currentPageNoticeList,
				data.totalCountList, data.pageSize, pageBlockSize,
				'fNoticeList');
		$("#pagingnavi2").empty().append(paginationHtml);

		nListVue.items = data.list;
	}
	
	//프로젝트 출력
	function printProjectList(data,currentPage){
		projectList.items=data.list
		var paginationHtml = getPaginationHtml(data.currentPageNoticeList,
				data.totalCountList, data.pageSize, pageBlockSize,
				'getProjectList');
		$("#pagingnavi_p").empty().append(paginationHtml);
	
	};
	
	//프로젝트 상세보기
	function getProjectDetail(item){
		var param = {
				loginId : item.loginId,
				projectId : item.projectId
		}
		 
		var resultCallback = function(data){
			console.log("상세보기 data : ",data);
			
			var info = data.detailone;
			var user_skill = data.skill;
			var loginId = data.loginId;
			console.log("user_skill ",user_skill);
			
			pDetailVue.P_project_name = info.project_name;
			pDetailVue.P_loginID =info.loginID;
			pDetailVue.p_begin = info.low;
			pDetailVue.p_middle =info.middle;
			pDetailVue.p_high = info.high
			pDetailVue.p_special = info.special;
			pDetailVue.p_notoDetail = info.note
			pDetailVue.p_option_order = info.option_order;
			pDetailVue.p_singular_facts = info.notice;
			pDetailVue.p_searchareaDetail = info.area;
			pDetailVue.p_searchjobDetail = info.job;
			pDetailVue.p_searchindDetail = info.industry;
			pDetailVue.p_searchSWCD = info.position_ime;
			pDetailVue.p_projectId = info.projectId;
			pDetailVue.loginId =loginId;
			
			//상세화면 다시 조회했을시 선택되어있는 항목 초기화
			$('input[type=checkbox]').prop('checked',false);
			
			//모든 전문기술 체크박스 가져오기
			var skill = document.getElementsByName('skill_P');
			
			
			//프로젝트스킬 테이블의 데이터와 일치 하는 항목 체크
			skill.forEach(function(item){
				
				user_skill.forEach(function(user_item){
					
					var user_skill = user_item.skillDetail;
					var item_skill =item.value;
				
					if(item_skill == user_skill) {
						
						item.checked=true;
						return false;
					}
				});
	
			});
			
			//근무기간
			$('#pService').val(info.work_fr_date);
			$('#pServiceEnd').val(info.work_to_date);
			
			//접수기간
			$('#pSign').val(info.receive_fr_date);
			$('#pSignEnd').val(info.receive_to_date);
			
			//면접형태
			if(info.tel_interview_yn) document.getElementById('telYn').checked = true;
			if(info.dr_interview_yn) document.getElementById('dictYn').checked = true;
			
			//장비지원여부
			if(info.device_yn) document.getElementById('support_p').checked = true;
			
			
			//식사제공여부
			if(info.meadl_yn) document.getElementById('mealSupport_p').checked = true;
			
			
			/*
			//일반사용자이거나 프로젝트를 등록한 기업이 아닌경우에는  수정 ,삭제 버튼 보이지않게설정
			if(info.user_type =='D' || loginId!=info.loginId){
				document.getElementById('delete_p').style.display = 'none';
				document.getElementById('modify_p').style.display = 'none';
			}
			*/
			document.getElementById('detailtable_p').style.display ='block';
			gfModalPop("#noticeDetailvue_p");
		}
		
		callAjax("/jmli/selectProjectOne.do", "post", "json", true, param,resultCallback);
	
	}
	
	//날짜 목록불러오기
	function getDatePicker(){
		$('#pService').datepicker({
				 showOn: "both",
		         buttonImage: "images/calendar/calendar.gif",
		         buttonImageOnly: true,
		         buttonText: "Select date"		
		});
		$('#pServiceEnd').datepicker();
		$('#pSign').datepicker();
		$('#pSignEnd').datepicker();
	}
	
	//닫기버튼
	function cancle(){
	
		document.getElementById('detailtable_p').style.display ='none';
	}
	
	//프로젝트 목록 삭제
	function applyPjroject(projectId){
		var resultCallback = function(data){
			alert(data.msg);
			cancle();
			getProjectList();
		};
		var param = {
			projectId : projectId,
			project_name : pDetailVue.P_project_name
		}
		callAjax("/jmli/projectApply.do", "post", "json", true, param,resultCallback);
	}
	
</script>
<body>
	<div id="container">
		<ul>
		<li class="lnb">
			<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
		</li>
			<li class="contents">
				<div class="content">
					<div id="search_Project" style=" border: 1px solid #e2e6ed;background:#f9fafb; padding:0 24px;height:60px;margin-bottom: 10px;">
						<div style="display: inline-block">
							<span>프로젝트 조회</span>
						</div>
						<div style="display: inline-block; margin-left: 30px;">
							<div style="display: inline-block; margin-left: 39px;">
								<select id="searcharea" name="searcharea"  
									style="width:104px; display: inline-block;" v-model="searcharea">
								</select>
							</div>
							<div style="display: inline-block; margin-left: 40px;">
								<select id="searchjob" name="searchjob"
									style="width: 104px; display: inline-block;" v-model="searchjob">
								</select>
								
							</div>
							<div style="display: inline-block; margin-left: 40px;">
								<select id="searchind" name="searchind"
									style="width: 104px; display: inline-block;" v-model="searchind">
								</select>
							</div>
							<div style="display: inline-block; margin-left: 350px;">
								<input type="button" name="search" id="searchBtn" class="btnType blue" 
								@click="searchProject" value="검색">
							</div>
						</div>

					</div>
					
					<div id="projectvuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">
									</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="" class="col2 mb10"
											style="width: 1000px;">
											<colgroup>
												<col width="25px">
												<col width="25px">
												<col width="60px">
												<col width="60px">
												<col width="50px">
												<col width="50px">
												<col width="50px">
											</colgroup>
											<thead>
												<tr>
													<th data-field="">프로젝트명</th>
													<th data-field="">지역</th>
													<th data-field="">직무</th>
													<th data-field="">산업</th>
													<th data-field="">작성일</th>
													<th data-field="">모집마감일</th>
													<th data-field="">작성회사</th>
												</tr>
											</thead>
											<tbody>
												<template v-for="(item, index) in items" v-if="items.length">
												<tr @click="projectDetail(item)">
													<td>{{item.project_name}}</td>
													<td>{{item.area}}</td>
													<td>{{item.job}}</td>
													<td>{{item.industry}}</td>
													<td>{{item.boarding_date}}</td>
													<td>{{item.due_date}}</td>
													<td>{{item.name}}</td>
												</tr>
												</template>
											</tbody>
										</table>
										<div>
											<div>
												<div class="clearfix"></div>>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="paging_area" id="pagingnavi_p"></div>
						</div>
					
					
				</div>
			</li>
		</ul>
	</div>

<!--프로젝트 상세보기 -->
<jsp:include page="/WEB-INF/view/jmli/projectDetail.jsp"></jsp:include>
</body>
</html>