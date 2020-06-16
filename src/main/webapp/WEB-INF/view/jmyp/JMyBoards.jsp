<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지-쪽지</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!--  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>-->



<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script type="text/javascript">

// 메세지리스트 페이징 설정
var pageSizeBoardList = 5;
var pageBlockSizeBoardList = 5;

var boardData;

	$(function(){		
		init();
		boardData.BoardList();
	});
	
	function init() {
	
		boardData = new Vue({
			el: '#boardArea',
			data: {
					BoardDatas 		: []
				,	searchTitle		: ''
				,	isBoard			: 'true'
				,	isRoom			: 'true'
				,	isQnA			: 'true'					
			}
      		,methods: {
				NoteFixed : function(BoardData)
				{
					let Fixedtemp = BoardData.title;
					if(Fixedtemp.length > 20)
					{
						Fixedtemp = Fixedtemp.substring(0,20);
						Fixedtemp += "...";
					}
					return Fixedtemp;
				},				

				deleteBoard : function(msg_code)
				{
					//console.log("msg_code : " + msg_code);
					
					var param = {
							msg_code		: msg_code						
					}
					
					var resultCallback = function(data) {
						//console.log("deletecallback? 2");
						deleteMessageCallback(data);
					};					
					//callAjax("/jmyp/deleteMessage.do", "post", "json", true, param, resultCallback);
				},
				BoardList : function(pageIndex)
				{
					pageIndex = pageIndex || 1;
					
					var param = {
								title			: this.searchTitle
							,	pageIndex 		: pageIndex
							,	pageSize 		: pageSizeBoardList
							,	fromDt   		: $("#fromDt").val()
							,	toDt	 		: $("#toDt").val()
							,	isBoard			: this.isBoard
							,	isRoom			: this.isRoom
							,	isQnA			: this.isQnA
					}
					
					console.log("여기왔나요? 1");
					var resultCallback = function(data) {
						BoardListCallback(data, pageIndex);
					};
					
					callAjax("/jmyp/JMyBoardList.do", "post", "json", true, param, resultCallback);
				},
				WriteType : function(BoardData)
				{
					if(Number(BoardData.cmnt_level) > 1)
					{
						return "댓글";
					}
					else
					{
						return "게시글";
					}
				},
				MoveToBoard : function(board_code)
				{
					//location.href = "${CTX_PATH}/dashboard/dashboard.do";
					//var param = {};
					switch(board_code)
					{
						case "q" : 
							//callAjax("/jboard/qnaboard.do", "post", "json", true, param, this.MoveToBoardCallBack);
							location.href = "${CTX_PATH}/jboard/qnaboard.do";
							break;
						case "r" :
							//callAjax("/jboard/room.do", "post", "json", true, param, this.MoveToBoardCallBack);
							location.href = "${CTX_PATH}/jboard/room.do";
							break;
						case "b" :
							//location.href = "${CTX_PATH}/jboard/room.do";
							break;
						default :
							throw new IllegalArgumentException("Unexpected BoardType: " + board_code);
					}
				}
      		}


		});
		
		var dateFormatstr = "yy-mm-dd";
		//시작일
		fromDt = $("#fromDt").datepicker({ 
			dateFormat: 'yy-mm-dd'
		}); 
		toDt = $("#toDt").datepicker({ 
			dateFormat: 'yy-mm-dd'
		});
		  
		$("#fromDt").change(function() {
			$("#toDt").datepicker("option", "minDate", $(this).val());
		})
		$("#toDt").change(function() {
			$("#fromDt").datepicker("option", "maxDate", $(this).val());
		})      
	}
	

	
	function BoardListCallback(data, PageIndex) {

		boardData.BoardDatas=[];
		boardData.BoardDatas=data.SelectBoardlist;		

		var SelectedCnt = data.SelectedCnt;
		

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(PageIndex, SelectedCnt, pageSizeBoardList, pageBlockSizeBoardList, 'boardData.BoardList');
		//console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#Pagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(PageIndex);
	}
	

	
	function deleteMessageCallback(data)
	{
		boardData.deleteCallback = [];
		boardData.deleteCallback = data;		
		boardData.BoardList();		
		alert(data.resultMsg);		
	}
	



	
</script>

</head>
<body>
	<form id="MyBoardsForm" action="" method="">
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
						<div class="boardArea" id="boardArea">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">마이 페이지</a> <span class="btn_nav bold"> 내 게시글</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							
							<p class="conTitle">
								<span>내 게시글</span>
							</p>				    	
				   	 		<table class="col" >
				   	 			<caption>caption</caption>
				   	 			<tbody>        
									<tr style="" >
										<td>
											<span>제 목 </span>
										</td>
										<td colspan="3">
											<input id="BoardTitle" style="height: 20px; width: 300px;" type="text" name="board_Title" size="20" v-model="searchTitle" @keyup.enter="BoardList()">
										</td>
										<td>
											<span> 일 자 </span>
										</td>	
										<td>
											<input type="text" style="height: 20px; width: 110px;" class="txtInput" id="fromDt" name="fromDt" data-date-format='yyyy-mm-dd' autocomplete=off>
										</td>	
										<td>
											<span><b>&nbsp; ~ &nbsp;</b></span>
										</td>							
										<td>
											<input type="text" style="height: 20px; width: 110px" class="txtInput" id="toDt" name="toDt" data-date-format='yyyy-mm-dd' autocomplete=off>
										</td>
										<td rowspan="2">
									    	<a style="cursor:pointer" class="btnType blue" v-on:click="BoardList()" name="modal" id="SearchBtn" ><span>검색</span></a>
										</td>								
									</tr>
									<tr>
										 <!-- <div id="MsgKinds">	-->		
										<td>
											<span>구 분</span>
										</td>
										<td><label><input type="checkbox" name="boardKinds" value="b" checked v-model="isBoard"> 자유게시판</label></td>
						      			<td><label><input type="checkbox" name="boardKinds" value="r" checked v-model="isRoom">자료실</label></td>
					      				<td><label><input type="checkbox" name="boardKinds" value="q" checked v-model="isQnA">Q&A</label></td>						      								      				
							      	
							      		<!--</div>-->
									</tr>
								</tbody>
							</table>					
							<div class="table-thead-box">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="40%">
										<col width="25%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th class="th_info" data-field="no">번호</th>
											<th class="th_info" data-field="board_type">게시판 구분</th>
											<th class="th_info" data-field="board_title">제목</th>
											<th class="th_info" data-field="board_date">일자</th>
											<th class="th_info" data-field="board_writetype">활동 구분</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(BoardData, index) in BoardDatas" v-if="BoardDatas.length">
											<tr @click="">
												<!--  <td class="hidden">{{ Message.msg_code }}</td>-->
												<td>{{ index + 1}}</td>
												<td><a style="cursor:pointer" v-on:click="MoveToBoard(BoardData.board_code)" >{{ BoardData.board_Type }}</a></td>									
												<td>{{ NoteFixed(BoardData) }}</td>
												<td>{{ BoardData.reg_date }}</td>
												<td>{{ WriteType(BoardData) }}</td>
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
			<!-- container -->
		</div>
		<!-- wrap Area -->
		
		
	</form>			 


</body>
</html>






