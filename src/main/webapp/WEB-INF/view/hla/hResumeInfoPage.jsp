<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이력서 관리</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!--  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>-->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/hla/hUserInfoVue.jsp"></jsp:include>
<script type="text/javascript">


var pageSizeLectureList = 5;
var pageBlockSizeLectureList = 5;

var LectureListVue;

$(function(){		
	InitLectureList();
	LectureListVue.LectureList();
});

function InitLectureList() {
	
	LectureListVue = new Vue({
		el: '#LectureTable',
		data: {
				vSearchLectureNm	: ''
				,vLectures			: []
		}
  		,methods: {
  			Init : function()
  			{
  				
  			},
  			showDetail : function(index){
  				//gfModalPop("#userInfoPopup");
  			},
  			showResume : function(loginID){
  				gfModalPop("#userInfoPopup");
  			},
  			LectureList : function(pageIndex)
  			{
  				pageIndex = pageIndex || 1;
				
				var param = {
							pageIndex 		: pageIndex
						,	pageSize 		: pageSizeLectureList
						,	LectureName		: vSearchLectureNm
				}
				
				//console.log("여기왔나요? 1");
				var resultCallback = function(data) {
					LectureListCallback(data, pageIndex);
				};
				
				
				//callAjax("/hla/hUserInfoList.do", "post", "json", true, param, resultCallback);
  			}
  		}
	});
	
	hUserInfoHeader();
	hUserInfoHeader.Init("R");
	hUserInfoVueInit();
	hUserInfoFooter();
	totalInit();
}

function LectureListCallback(data, pageIndex)
{
	LectureListVue.vLectures=[];
	LectureListVue.vLectures=data.LectureList;		
	console.log(data);
	var SelectedCnt = data.SelectedCnt;
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(pageIndex, SelectedCnt, pageSizeLectureList, pageBlockSizeLectureList, 'LectureListVue.LectureList');
	//console.log("paginationHtml : " + paginationHtml);
	//alert(paginationHtml);
	$("#Pagination").empty().append( paginationHtml );
	
	// 현재 페이지 설정
	$("#currentPage").val(pageIndex);
}


</script>
</head>
<body>
<form id="UserInfoForm" action="" method="">
	<input type="hidden" id="currentPage" value="1">
		
	<div id="wrap_area">
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>	

				<li class="contents">
					<div class="content">						
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">취업관리</a> <span class="btn_nav bold"> 이력서 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<div class="LectureTable" id="LectureTable">
							<p class="conTitle">
								<span>이력서 관리</span>
							</p>				    	
				   	 		<table class="col" >
				   	 			<caption>caption</caption>
				   	 			<tbody>        
									<tr style="" >
										<td>
											<span>강의명</span>
										</td>
										<td>
											<input id="LectureName" style="height: 20px; width: 500px;" type="text" name="user_Name" size="20" v-model="vSearchLectureNm" @keyup.enter="LectureList()">
										</td>
										<td rowspan="2">
									    	<a style="cursor:pointer" class="btnType blue" v-on:click="UserList()" name="modal" id="SearchBtn" @keyup.enter=""><span>검색</span></a>
										</td>								
									</tr>
								</tbody>
							</table>					
							<div class="table-thead-box">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="30%">
										<col width="50%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th class="th_info" >번호</th>
											<th class="th_info" >강의명</th>
											<th class="th_info" >기간</th>
											<th class="th_info" >수강인원</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(Lecture, index) in vLectures">
											<tr @click="showDetail(index)">												
												<td>{{ index + 1}}</td>									
												<td>{{ Lecture.title }}</td>
												<td>{{ Lecture.startdate + '~' + Lecture.enddate }}</td>
												<td>{{ Lecture.students }}</td>
											</tr>													
										</template>
									</tbody>
								</table>	
							</div>	
							<div class="paging_area"  id="Pagination"> </div>		
						</div>
					</div>
				</li>	
			</ul>				
		</div>
	</div>
</form>	
	
	<jsp:include page="/WEB-INF/view/hla/hUserInfoFormat.jsp"></jsp:include>
	
</body>
</html>