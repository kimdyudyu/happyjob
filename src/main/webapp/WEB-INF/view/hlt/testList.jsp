<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>잡코리아 dashboard</title>
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

<!-- D3 -->
<style>
//
click-able rows
.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}

.teacherliston {
	background-color: #fff;
	border: 1px solid #bebebe;
	color: #000;
	!
	important
}
</style>
<script type="text/javascript">
	
	var pageSize = 6;
	var pageBlock = 5;
	var listVue;
	var userInfoVue;
	
	$(document).ready(function() {

		init();
		//현재 진행중인 강의 목록 불러오기
		
		getTestList();
		//selectNoticeListvue();
	});

	function init() {
		listVue = new Vue({
			el:"#testListVue",
			data: {
				items :[]
			},
			methods:{
				
				rowClicked:function(item){
					getUserInfoF(item);	 
				}  
			},
			computed:{
				
			}
		});
		
		userInfoVue = new Vue({
			el : "#uesrinfoVueD",
			data : {
				items : []			
			},
			methods :{
				userInfoF :function(item){
					getUserInfoF(item);
				}
				
			}
		});

	}
	
	function getTestList(currentPage){
		var val = $("#testSelect option:selected").val();
		
		var currentPage = currentPage || 1;
		
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			status :  val
		}
		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			getCourseListResult(data); 
		}
		
		console.log("param :: ",param);
		callAjax("/hlt/getSelectedTestList.do","post","json", true, param, resultCallback);

	}
	
	function getCourseListResult(data){
	//	console.log(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
	//	console.log("data.currentPage ",data.currentPage);
	//	console.log("data.totalCount ",data.totalCount);
	//	console.log("data.pageSize ",data.pageSize);
	//	console.log("pageBlock",pageBlock);
	//	console.log("getTestList",getTestList);
	//	console.log(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
		var paginationHtml = 
			getPaginationHtml(data.currentPage, data.totalCount,
							data.pageSize,pageBlock,'getTestList');
		
			console.log("data ? :::::::  ",data);
			
			$("#pagingnavi2").empty().append(paginationHtml);
			
			
			listVue.items = data.list;
			
			console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			console.log("data.list :",data.list);
			console.log("listVue.items  :",listVue.items);
	}
	
	
	function getUserInfoF(item){
		console.log("------------------------");
		var noTemp = item.no;
		var currentPage = currentPage || 1;
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			no : item.no
		}
		
		var resultCallback = function(data){  
			userInfoDisplay(data); 
		}
		
		console.log("param :: ",param);
		callAjax("/hlt/getUsertInfoC.do","post","json", true, param, resultCallback);
		
	}
	
	
	function userInfoDisplay(data){
		var paginationHtml = 
			getPaginationHtml(data.currentPage, data.totalCount,
							data.pageSize,pageBlock,'userPagingF');
		
		$("#userPaging").empty().append(paginationHtml);
		userInfoVue.items=data.list;
		 
		gfModalPop("#uesrinfoVueD");
		
	}
	
	function userPagingF(currentPage){
		var currentPage = currentPage || 1;
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			no : noTemp
		}
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			userInfoDisplay(data); 
		}
		
		console.log("param :: ",param);
		callAjax("/hlt/getUsertInfoC.do","post","json", true, param, resultCallback);
		
	}
	
</script>

</head>
<body>

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

					


						<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
						<div id="">
							<select id="testSelect">
								<option value="ongoing">진행중 시험</option>
								<option value="finished">지난 시험</option>
							</select>
							<a href="javascript:getTestList();" id="btn_prelogin2"> <strong>조회</strong></a>

						</div>


						<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">

						<div id="">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">
									</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="testListVue" class="col2 mb10" style="width: 1000px;">
								
											<colgroup>
												<col width="100px">
												<col width="150px">
												<col width="100px">
												<col width="100px">
												<col width="150px">
												<col width="150px">
												<col width="150px">

											</colgroup>
										
											<thead>
												<tr>
													<th>과정명</th>
													<th>시험명</th>
													<th>구분</th>
													<th>상태</th>
													<th>대상자수</th>
													<th>응시자수</th>
													<th>미응시자수</th>
												</tr>
											</thead>
											<tbody>
												<template v-for="(item, index) in items" v-if="items.length">
												<tr @click="rowClicked(item)">
													<td>{{item.title}}</td>
													<td>{{item.testname}}</td>
													<td>{{item.re}}</td>
													<td>{{item.status}}</td>
													<td>{{item.pcnt}}</td>
													<td>{{item.llcnt}}</td>
													<td>{{item.NOcnt}}</td>
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
						<div class="paging_area" id="pagingnavi2"></div>
					</div>
				</li>
			</ul>

		</div>
	</div>

	<jsp:include page="/WEB-INF/view/hlt/userInfoList.jsp"></jsp:include>


</body>
</html>