<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>`


<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

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

.jMainList_ul, .jMainList_li {
	list-style-type: none;
	float: right;
	margin-left: 20px;
}

a:link {
	color: blue;
	text-decoration: none;
}

a:visited {
	color: blue;
}

a:hover {
	text-decoration: underline;
}

a:active {
	background-color: yellow;
}
</style>

<script>
	var pageSize = 5;
	var pageBlockSize = 5;

	var projectList;
	var pDetailVue;
	var pRegister;
	
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
				p_searcharea_Detail_2 : '',
				address_de : '',
				loginId : ''
			},
			methods : {
				delete_pFunc : function(){
					deletePjroject(this.p_projectId);
				},
				saveProject_pFunc : function(){
					saveProject();
				}
			}
		});
		
		//등록
		pRegister = new Vue({
			el : "#pResister_p",
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
				p_searchindDetail_2 : '',
				address_de : '',
				p_searcharea_Detail_2 : '',
				loginId : ''
			},
			methods : {
				delete_pFunc : function(){
					deletePjroject(this.p_projectId);
				},
				saveProject_pFunc : function(){
					saveProject();
				}
			}
		});
	}

	//공통 코드 불러오기
	function getCommonCode(){
		comcombo("areaCD","searcharea","all","");
		comcombo("JOBCD","searchjob","all","");
		comcombo("industryCD","searchind","all","");
		
		//등록
		comcombo("areaCD","p_searchareaDetail_R","all","");
		comcombo("areaCD","p_searcharea_Detail_2_R","all","");
		comcombo("JOBCD","p_searchjobDetail_R","all","");
		comcombo("industryCD","p_searchindDetail_R","all","");
		comcombo("SWCD","p_searchSWCD_R","all","");
		
		//상세보기 
		comcombo("areaCD","p_searchareaDetail","all","");
		comcombo("areaCD","p_searcharea_Detail_2","all","");
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
			console.log("data???? --- ",data);
			printProjectList(data);
		};

		callAjax("/jmli/projectList.do", "post", "json", true, paramProject, projectResultCallback);
		
		
	}
		
	function fNoticeList(currentPage) {
		var currentpage = currentPage || 1;
		var param = {
			currentPage : currentpage,
			pageSize : pageSize
		};

		var resultCallback = function(data) {
			printList(data);

		}

		callAjax("/jmli/noticeList.do", "post", "json", true, param,
				resultCallback);
		
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
			var userType = data.userType;
			
			
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
			pDetailVue.p_searcharea_Detail_2 = info.workarea_dtl;
			pDetailVue.address_de= info.workarea;
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
			if(info.tel_interview_yn !=0) document.getElementById('telYn').checked = true;
			if(info.dr_interview_yn !=0) document.getElementById('dictYn').checked = true;
				
			var device = info.device_yn;
			var meal_yn = info.meadl_yn;
			var dorm_yn = info.dorm_yn;
			
			
			//라디오 버튼 체크
			checkRadio(device,document.getElementsByName('support_equip_p'));
			checkRadio(meal_yn,document.getElementsByName('mealSupport_pYN'));
			checkRadio(dorm_yn,document.getElementsByName('supportDormYN'));
			
			if(userType!='A'){
				if(userType=='D' || loginId!=info.loginID){
					document.getElementById('delete_p').style.display = 'none';
					document.getElementById('modify_p').style.display = 'none';
				}else{
					document.getElementById('delete_p').style.display = '';
					document.getElementById('modify_p').style.display = '';
				}
			}else{
				document.getElementById('delete_p').style.display = '';
				document.getElementById('modify_p').style.display = '';
			
			}
			
			
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
		
		
		$('#pService_R').datepicker({
			 showOn: "both",
	         buttonImage: "images/calendar/calendar.gif",
	         buttonImageOnly: true,
	         buttonText: "Select date"		
		});
		$('#pService_REnd_R').datepicker();
		$('#pSign_R').datepicker();
		$('#pSignEnd_R').datepicker();
	}
	
	//프로젝트 목록 삭제
	function deletePjroject(projectId){
		var resultCallback = function(data){
			if(data.result =="fail") alert("삭제실패");
			else alert("삭제성공");
			cancle();
			//프로젝트 목록 리로딩
			getProjectList();
		};
		var param = {
			projectId : projectId
		}
		
		alert("!! "+projectId);
		
		callAjax("/jmli/projectDelete.do", "post", "json", true, param,resultCallback);
	}
	
	//프로젝트 목록 수정
	function modifyProject(){
		var skill = "";
		
		//프로젝트 skill_code 와 skill_detail 을 합쳐 배열에 저장
		$('input:checkbox[name="skill_P"]').each(function() {
	         if($(this).is(':checked')){
	        	var val = $(this).closest("div").attr("id")+"_"+$(this).val();
	        	skill+=val+"/";	        	
	         }
         
	      });
	
		var skillCount = $("input:checkbox[name=skill_P]:checked").length;
		var work_fr_date =  $('#pService').val().replace(/-/gi,"");
		var work_to_date = $('#pServiceEnd').val().replace(/-/gi,"");
		var receive_fr_date = $('#pSign').val().replace(/-/gi,"");
		var receive_to_date = $('#pSignEnd').val().replace(/-/gi,"");
		var device_yn = $('input:radio[name=support_equip_p]:checked').val();
		var meal_yn = $('input:radio[name=mealSupport_pYN]:checked').val();
		var dorm_yn = $('input:radio[name=supportDormYN]:checked').val();
		
		var tel_interview_yn = ($('#telYn').is(':checked')) ? 1:0;
		var dr_interview_yn = ($('#dictYn').is(':checked')) ? 1:0;
	
		
		if(pDetailVue.P_project_name=="" || 
				pDetailVue.P_project_name.length==0){
			alert("프로젝트 명을 입력해주세요 "); 
			return false;
		}else if((pDetailVue.p_searchareaDetail=="" || 
				pDetailVue.p_searchareaDetail.length==0)
				||
				(pDetailVue.p_searchjobDetail==""||
						pDetailVue.p_searchjobDetail.length==0)
				||
				(pDetailVue.p_searchindDetail==""||
						pDetailVue.p_searchindDetail.length==0)
				||
				(pDetailVue.p_searchSWCD==""||
						pDetailVue.p_searchSWCD.length==0))
		{
			alert("항목을 선택해주세요 ");
			return false;
		}else if(skillCount == 0){
			alert('기술을 선택해주세요');
			return false;
		}else if(pDetailVue.p_begin == "" || pDetailVue.p_middle =="" || pDetailVue.p_high == ""
				||pDetailVue.p_special ==""){
			alert('인원을 입력해주세요 ');	
			return false;
		}else if(work_fr_date=="" || work_to_date=="" || receive_fr_date==""
				||receive_to_date==""){
			alert("기간을 설정해주세요");
			return false;
		}else if(!(device_yn && meal_yn && dorm_yn)){
			alert("선택사항을 선택해주세요");
			return false;
		}else if(!$("input:checkbox[name=interCheck]:checked").length){
			alert("선택사항을 선택해주세요");
			return false;
		}

		
		else{
		
		
		
		
		var param = {
			projectId : pDetailVue.p_projectId,
			project_name : pDetailVue.P_project_name,
			region_code : pDetailVue.p_searchareaDetail,
			work_type :pDetailVue.p_searchjobDetail,
			industry_type :pDetailVue.p_searchindDetail,
			position_ime :	pDetailVue.p_searchSWCD,
			high : pDetailVue.p_high,
			middle : pDetailVue.p_middle,
			low : 	pDetailVue.p_begin,
			special : pDetailVue.p_special,
			work_fr_date : work_fr_date,
			work_to_date : work_to_date,
			receive_fr_date : receive_fr_date,
			receive_to_date : receive_to_date,
			note : pDetailVue.p_notoDetail,
			option_order : pDetailVue.p_option_order,
			notice : pDetailVue.p_singular_facts,
			workarea_dtl: pDetailVue.p_searcharea_Detail_2,
			workarea : pDetailVue.address_de,
			device_yn : device_yn,
			meal_yn : meal_yn,
			dorm_yn :dorm_yn,
			tel_interview_yn : tel_interview_yn,
			dr_interview_yn : dr_interview_yn, 
			skillDetail :  skill,
			updateId : pDetailVue.loginId
		};
		
		
		var resultCallback = function(data){
			if(data.result == "fail") alert("수정실패");
			else alert("수정성공");
			cancle();
			getProjectList();
		};
		
		$.ajax({
			url : "/jmli/projectUpdate.do",
			type : "post",
			dataType : "json",
			async : true,
			data : param,
			success : function(data) {
				resultCallback(data);
			}
		});
	}
	
	}

	//닫기버튼
	function cancle(){
		document.getElementById('detailtable_p').style.display ='none';
		document.getElementById('pResister_p').style.display ='none';
	}
	
	//프로젝트 등록 팝업
	function fWriterNotice(){
		reset();
		document.getElementById('pResister_p').style.display ='block';
		gfModalPop("#registerProject");
	}
	
	//프로젝트 등록
	function saveProject(){
		var skillCount = $("input:checkbox[name=Rskill_P]:checked").length;
		var work_fr_date =  $('#pService_R').val().replace(/-/gi,"");
		var work_to_date = $('#pService_REnd_R').val().replace(/-/gi,"");
		var receive_fr_date = $('#pSign_R').val().replace(/-/gi,"");
		var receive_to_date = $('#pSignEnd_R').val().replace(/-/gi,"");
		var device_yn = $('input:radio[name=Rsupport_equip_p]').is(':checked');
		var meal_yn = $('input:radio[name=RmealSupport_pYN]').is(':checked');
		var dorm_yn = $('input:radio[name=RsupportDormYN]').is(':checked');
		var tel_interview_yn;
		var dr_interview_yn;
		var skill;
	
		
		if(pRegister.P_project_name=="" || 
				pRegister.P_project_name.length==0){
			alert("프로젝트 명을 입력해주세요 "); 
			return false;
		}else if((pRegister.p_searchareaDetail=="" || 
				pRegister.p_searchareaDetail.length==0)
				||
				(pRegister.p_searchjobDetail==""||
						pRegister.p_searchjobDetail.length==0)
				||
				(pRegister.p_searchindDetail_2==""||
						pRegister.p_searchindDetail_2.length==0) 
				||
				(pRegister.p_searchSWCD==""||
						pRegister.p_searchSWCD.length==0)
		){
			alert("항목을 선택해주세요 ");
			return false;
		}else if(skillCount == 0){
			alert('기술을 선택해주세요');
			return false;
		}else if(pRegister.p_begin == "" || pRegister.p_middle =="" || pRegister.p_high == ""
				||pRegister.p_special ==""){
			alert('인원을 입력해주세요 ');	
			return false;
		}else if(work_fr_date=="" || work_to_date=="" || receive_fr_date==""
				||receive_to_date==""){
			alert("기간을 설정해주세요");
			return false;
		}else if(pRegister.p_searcharea_Detail_2 ==""
				|| pRegister.address_de==""){
			alert("근무장소를 설정해주세요 !");
			return false
		}else if(!(device_yn && meal_yn && dorm_yn)){
			alert("선택사항을 선택해주세요");
			return false;
		}else if(!$("input:checkbox[name=interCheck_R]:checked").length){
			alert("선택사항을 선택해주세요");
			return false;
		}

		
		else{
			skill = "";
			
			//프로젝트 skill_code 와 skill_detail 을 합쳐 배열에 저장
			$('input:checkbox[name="Rskill_P"]').each(function() {
		         if($(this).is(':checked')){
		        	var val = $(this).closest("div").attr("id")+"_"+$(this).val();
		        	skill+=val+"/";	        	
		         }
	         
		      })
			tel_interview_yn = ($('#telYn_R').is(':checked')) ? 1:0;
			dr_interview_yn = ($('#dictYn_R').is(':checked')) ? 1:0;
			

			device_yn = $('input:radio[name=Rsupport_equip_p]:checked').val();
			meal_yn = $('input:radio[name=RmealSupport_pYN]:checked').val();
			dorm_yn = $('input:radio[name=RsupportDormYN]:checked').val();
			
			
			var param ={
					project_name : pRegister.P_project_name,
					region_code : pRegister.p_searchareaDetail,
					work_type :pRegister.p_searchjobDetail,
					industry_type :pRegister.p_searchindDetail_2,
					position_ime :	pRegister.p_searchSWCD,
					high : pRegister.p_high,
					middle : pRegister.p_middle,
					low : 	pRegister.p_begin,
					special : pRegister.p_special,
					work_fr_date : work_fr_date,
					work_to_date : work_to_date,
					receive_fr_date : receive_fr_date,
					receive_to_date : receive_to_date,
					note : pRegister.p_notoDetail,
					option_order : pRegister.p_option_order,
					notice : pRegister.p_singular_facts,
					workarea_dtl : pRegister.p_searcharea_Detail_2,
					workarea : pRegister.address_de,
					device_yn : device_yn,
					meal_yn : meal_yn,
					dorm_yn :dorm_yn,
					tel_interview_yn : tel_interview_yn,
					dr_interview_yn : dr_interview_yn, 
					skillDetail :  skill,
				}
			
			var resultCallback = function(data){
				if(data.result =="fail") alert("등록실패");
				else alert("등록 성공");
				cancle();
				getProjectList();
			}
			
			callAjax("/jmli/Registerproject.do", "post", "json", true, param,resultCallback);
			
		}

	}

	//선택된 라디오 체크
	function checkRadio (val , obj){
		console.log("//////////////////////////////////");
		console.log("server val : ",val);
		console.log("radio val : ",obj);
		console.log("//////////////////////////////////");
 		$.each(obj,function(index,item){
 			if(item.value == val){
 				item.checked = true;
 				return false;
 			}
 		});

	}
	function reset(){
		$('#loginID_R').val("");
		$('#p_searchareaDetail_R').val("");
		$('#p_searchjobDetail_R').val("");
		$('#p_searchindDetail_R').val("");
		$('#p_searchSWCD_R').val("");
		$('input[type=checkbox]').prop('checked',false);
		$('#gradeRb').val("");
		$('#gradeRm').val("");
		$('#gradeRh').val("");
		$('#gradeRs').val("");
		$('#pService_REnd_R').val("");
		$('#pService_R').val("");
		$('#pSign_R').val("");
		$('#pSignEnd_R').val("");
		
		$('#reNo').val("");
		$('#essiontial').val("");
		$('#consul').val("");
		$('#p_searcharea_Detail_2_R').val("");
		$('#kuynm').val("");
		$('input[type=radio]').prop('checked',false);
		
	}

</script>
<body>
	<div id="container">
		<ul>
			<li class="lnb"><jsp:include
					page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include></li>
			<li class="contents">
				<div class="content">

					<div id="search_Project"
						style="border: 1px solid #e2e6ed; background: #f9fafb; padding: 0 24px; height: 60px; margin-bottom: 10px;">
						<div style="display: inline-block">
							<span>프로젝트 조회</span>
						</div>
						<div style="display: inline-block; margin-left: 30px;">
							<div style="display: inline-block; margin-left: 39px;">
								<select id="searcharea" name="searcharea"
									style="width: 104px; display: inline-block;"
									v-model="searcharea">
								</select>
							</div>
							<div style="display: inline-block; margin-left: 40px;">
								<select id="searchjob" name="searchjob"
									style="width: 104px; display: inline-block;"
									v-model="searchjob">
								</select>

							</div>
							<div style="display: inline-block; margin-left: 40px;">
								<select id="searchind" name="searchind"
									style="width: 104px; display: inline-block;"
									v-model="searchind">
								</select>
							</div>
							<div style="display: inline-block; margin-left: 350px;">
								<input type="button" name="search" id="searchBtn"
									class="btnType blue" @click="searchProject" value="검색">
							</div>
						</div>

					</div>

					<span style="float: left;"> <a class="btnType blue"
						href="javascript:fWriterNotice();"><span>프로젝트 등록</span></a>
					</span> <br> <br>
					<div id="projectvuetable">
						<div class="bootstrap-table">
							<div class="fixed-table-toolbar">
								<div class="bs-bars pull-left"></div>
								<div class="columns columns-right btn-group pull-right"></div>
							</div>
							<div class="fixed-table-container" style="padding-bottom: 0px;">
								<div class="fixed-table-body">

									<table id="" class="col2 mb10" style="width: 1000px;">
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
												<td>{{item.comp_name}}</td>
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
						<div class="paging_area" id="pagingnavi_p"></div>
					</div>


				</div>
			</li>
		</ul>
	</div>

	<!--프로젝트 상세보기 -->
	<jsp:include page="/WEB-INF/view/jmpm/projectDetail.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/jmpm/projectRegister.jsp"></jsp:include>

</body>
</html>