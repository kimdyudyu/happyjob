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
var pageSizeMessageList = 5;
var pageBlockSizeMessageList = 5;

var messagedata;
var sendMessage;
var app;
	$(function(){		
		init();
		messagedata.MessageList();
	});
	function init() {
	
		messagedata = new Vue({
			el: '#messageArea',
			data: {
					ToDate   		: ''
				,	FromDate 		: ''
				,	Messages 		: []
				,	user	 		: ''
				,	deleteCallback 	: []
				,	SendKinds		: ''
			}
      		,methods: {
      			showDetail : function(index){
      				//console.log("showDetail?" + index);
      				//console.log("Detail : " + index + " " + this.Messages[index].msg_note);
      				$('#showDetail_' + index).toggle();
      				//$('#showInfo_'+index).toggle();
      			}
				,NoteFixed : function(message)
				{
					let Fixedtemp = message.msg_note;
					if(Fixedtemp.length > 20)
					{
						Fixedtemp = Fixedtemp.substring(0,20);
						Fixedtemp += "..."
					}
					return Fixedtemp;
				},
				
				SendMessagePop : function(kinds, messageTo, messageToID)
				{
					sendMessage.SendKinds = kinds;
					//console.log("kindsss : " + sendMessage.SendKinds);

					sendMessage.messageTo = messageTo;
					sendMessage.messageToID = messageToID;
						
					//console.log("messageTo : " + sendMessage.messageTo);
					//console.log("MessageToID : " + sendMessage.messageToID);
					
					sendMessage.sendMessagePop();
					
					//$("#MessageTo").text(sendMessage.messageTo);
					//$("#MessageToID").text(sendMessage.messageToID);

					
					//gfModalPop("#SendMessagePop");

				},
				deleteMessage : function(msg_code)
				{
					//console.log("msg_code : " + msg_code);
					
					var param = {
							msg_code		: msg_code						
					}
					
					var resultCallback = function(data) {
						//console.log("deletecallback? 2");
						deleteMessageCallback(data);
					};					
					callAjax("/jmyp/deleteMessage.do", "post", "json", true, param, resultCallback);
				},
				MessageList : function MessageList(pageIndex)
				{
					pageIndex = pageIndex || 1;
					
					var param = {
								pageIndex 		: pageIndex
							,	pageSize 		: pageSizeMessageList
							,	UserName		: $("#UserName").val()
							,	fromDt   		: $("#fromDt").val()
							,	toDt	 		: $("#toDt").val()
							,	MsgKinds		: $('input[name="msgKinds"]:checked').val()
					}
					
					console.log("여기왔나요? 1");
					var resultCallback = function(data) {
						MessageListCallback(data, pageIndex);
					};
					
					for(var i = 0; i < pageSizeMessageList; i++)
					{
						$('#showDetail_' + i).css('display', 'none');

					}
					
					callAjax("/jmyp/JMessageList.do", "post", "json", true, param, resultCallback);
				}
      		}
		});
		
		sendMessage = new Vue({
			el: '#SendMessagePop',
			data: {
					messageTo  			: 'aaa'
				,	messageToID			: 'bbb'
				,	insertCallback 		: []
				,	SendKinds			: 'b'
				,	nameToIDs			: []
				,	searchIDCallback	: []
				,	currentMessageTo	: ''
				,	searchName			: ''
				,	pageIndex			: 0
				,	isReady				: false
				,	messageNote			: ''
			},
			methods :
			{
				sendMessagePop : function()
				{
					if(this.SendKinds == 'b')
					{
						$("#MessageTo").text(this.messageTo);
						$("#MessageToID").text(this.messageToID);
						//console.log("messageTo : " + this.messageTo);
					}
					else
					{
						$("#MessageTo").text("");
						$("#MessageToID").text("");
					}
					gfModalPop("#SendMessagePop");
				},
				nameToIDSearch : function(pageIndex)
				{
					//this.messageToID = '';
					//this.messageTo = ''
					//this.pageIndex = this.pageIndex || 1;

					this.currentMessageTo = this.searchName;
					//console.log("IDSearch? 000" + this.currentMessageTo);
					this.createPaging(pageIndex);
					
				},
				createPaging : function(pageIndex)
				{
					pageIndex = pageIndex || 1;					
					var param = {
							pageIndex 		: pageIndex
						,	pageSize 		: pageSizeMessageList
						,	SearchName		: this.currentMessageTo
					}
					
					var resultCallback = function(data) {
						console.log("IDSearch? 1");
						SearchIDCallback(data, pageIndex);
					};					
					callAjax("/jmyp/searchID.do", "post", "json", true, param, resultCallback);	
				},
				SetSend : function(SendName, SendID)
				{
					this.messageTo = SendName;
					this.messageToID = SendID;
				}
			},
			computed : {

				
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
	
	function SearchIDCallback(data, PageIndex)
	{		
		/*var pg = document.getElementById('SIPagination');
		if(pg == null)
		{
			console.log("어떻게 만들까!!? : " + pg);
		}
		console.log("pg : " + pg);*/
		
		sendMessage.nameToIDs = [];
		sendMessage.nameToIDs = data.SearchIDList;	
		var SelectedCnt = data.SelectedCnt;
		/*var paginationHtml = getPaginationHtml(PageIndex, SelectedCnt, pageSizeMessageList, pageBlockSizeMessageList, 'sendMessage.createPaging');

		$("#SIPagination").empty().append( paginationHtml );
		$("#SIcurrentPage").val(PageIndex);*/
		InitPaging(PageIndex, SelectedCnt);
	}
	
	function InitPaging(PageIndex, SelectedCnt)
	{
		var paginationHtml = getPaginationHtml(PageIndex, SelectedCnt, pageSizeMessageList, pageBlockSizeMessageList, 'sendMessage.createPaging');

		$("#SIPagination").empty().append( paginationHtml );
		$("#SIcurrentPage").val(PageIndex);
	}
	
	function MessageListCallback(data, PageIndex) {

		messagedata.Messages=[];
		messagedata.Messages=data.SelectMessagelist;		

		var SelectedCnt = data.SelectedCnt;
		

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(PageIndex, SelectedCnt, pageSizeMessageList, pageBlockSizeMessageList, 'messagedata.MessageList');
		//console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#Pagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPage").val(PageIndex);
	}
	
	function CreateMessage()
	{
		var param = {
				msg_receive		: sendMessage.messageToID
			,	msg_note		: $("#msg_note").val()
		}
		
		console.log("아이디 : ", sendMessage.messageToID)
		
		if(sendMessage.messageToID =='' || sendMessage.messageToID == null)
		{
			alert("보낼사람을 정해주세요");
			return;
		}
		
		if(sendMessage.messageNote =='' || sendMessage.messageNote == null)
		{
			alert("내용을 적어주세요");
			return;
		}
		
		var resultCallback = function(data) {

			insertMessageCallback(data);
		};
		
		callAjax("/jmyp/insertMessage.do", "post", "json", true, param, resultCallback);
	}
	
	function insertMessageCallback(data)
	{
		sendMessage.insertCallback = [];
		sendMessage.insertCallback = data;
		
		$("#SendMessagePop").hide();		
		$("#msg_note").val("");
		sendMessage.messageNote = '';
		sendMessage.messageTo ='';
		sendMessage.messageToID ='';
		sendMessage.currentMessageTo ='';
		sendMessage.nameToIDs = [];	
		sendMessage.SelectedCnt = 0;
		$("#SIPagination").empty();
		messagedata.MessageList();
		alert(data.resultMsg);		
	}
	
	function deleteMessageCallback(data)
	{
		messagedata.deleteCallback = [];
		messagedata.deleteCallback = data;		
		messagedata.MessageList();		
		alert(data.resultMsg);			
	}
	



	
</script>

</head>
<body>
	<form id="MsgSearchForm" action="" method="">
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
						<div class="messageArea" id="messageArea">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">마이 페이지</a> <span class="btn_nav bold"> 쪽지</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							
							<p class="conTitle">
								<span>쪽지</span> <span class="fr"> <a class="btnType blue" style="cursor:pointer"  v-on:click="SendMessagePop('a')" >
								<span>메세지 보내기</span></a>
								</span>
							</p>				    	
				   	 		<table class="col" >
				   	 			<caption>caption</caption>
				   	 			<tbody>        
									<tr style="" >
										<td>
											<span>사용자 </span>
										</td>
										<td>
											<input id="UserName" style="height: 20px; width: 300px;" type="text" name="user_Name" size="20" v-model="user" @keyup.enter="MessageList()">
										</td>
										<td>
											<span> 일자 </span>
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
									    	<a style="cursor:pointer" class="btnType blue" v-on:click="MessageList()" name="modal" id="SearchBtn" @keyup.enter="SearchBtn"><span>검색</span></a>
										</td>								
									</tr>
									<tr>
										 <!-- <div id="MsgKinds">	-->		
										<td>
											<span>구분</span>
										</td>
										<td><label><input type="radio" name="msgKinds" value="a" checked> 모든 쪽지</label>	
												<label><input type="radio" name="msgKinds" value="s"> 보낸 쪽지</label>
							      				<label><input type="radio" name="msgKinds" value="r"> 받은 쪽지</label>					      				
							      		</td>
							      		<!--</div>-->
									</tr>
								</tbody>
							</table>					
							<div class="table-thead-box">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="50%">
										<col width="25%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th class="th_info" data-field="no">번호</th>
											<th class="th_info" data-field="msg_date">내용</th>
											<th class="th_info" data-field="msg_date">일자</th>
											<th class="th_info" data-field="msg_send">보낸이</th>
											<th class="th_info" data-field="msg_send">받는이</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(Message, index) in Messages" v-if="Messages.length">
											<tr @click="showDetail(index)">
												<!--  <td class="hidden">{{ Message.msg_code }}</td>-->
												<td>{{ index + 1}}</td>									
												<td>{{ NoteFixed(Message) }}</td>
												<td>{{ Message.msg_date }}</td>
												<td>{{ Message.send_name }}</td>	
												<td>{{ Message.receive_name }}</td>
											</tr>
											<tr style="display:none" :id="'showDetail_'+index">
												<td colspan="3"> {{ Message.msg_note }} </td>
												<template v-if="Message.msgtype === 'r'">
													<td colspan="1"> <a style="cursor:pointer" v-on:click="SendMessagePop('b', Message.send_name, Message.msg_send)">답장 </a> </td>
												</template>
												<template v-if="Message.msgtype === 's'">
													<td colspan="1"> <a style="cursor:pointer" v-on:click="SendMessagePop('b', Message.receive_name, Message.msg_receive )">보내기 </a> </td>
												</template>
												<td colspan="1"> <a style="cursor:pointer" v-on:click="deleteMessage(Message.msg_code)">삭제 </a> </td>
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
		<!-- 모달팝업 -->
		<div id="SendMessagePop" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="SIcurrentPage" value="1">		
			<dl>
				<dt>
					<strong>메세지 보내기</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
	
						<tbody>
							<tr>
								<th scope="row"> 보낼 사람 </th>								
								<input type="hidden" id="MessageTo" v-model="messageTo">
								<td style="text-align:center;">{{ messageTo }}</td>
								<input type="hidden" id="MessageToID" v-model="messageToID"> 
								<td style="text-align:center;">{{ messageToID }}</td>								
							</tr>
							<tr style="text-align:center;">	
								<td v-if="SendKinds === 'a'"><span>이름으로 검색</span></td>							
								<td v-if="SendKinds === 'a'"><input type="text" class="inputTxt p50" name="MessageTo" id="MessageTo" v-model="searchName" @keyup.enter="nameToIDSearch()"></input></td>
								<td v-if="SendKinds === 'a'"><a style="cursor:pointer" class="btnType blue" @click="nameToIDSearch()"><span> 검색하기 </span></a></td>	
							</tr>							
																			
								
							<tr v-for="(nameToID, index) in nameToIDs" v-if="nameToIDs.length" @click="SetSend(nameToID.name, nameToID.loginID)">							
								<td>{{ index + 1 }}</td>
								<td>{{ nameToID.name }}</td>
								<td colspan="2">{{ nameToID.loginID }}</td>
							</tr>							
							<tr>
								 <td colspan="3">
								  	<div class="paging_area" id="SIPagination"></div>
								 </td> 
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3">
									<textarea class="inputTxt p100" name="msg_note" id="msg_note" v-model="messageNote">
									</textarea>
								</td>
							</tr>
							
						</tbody>
					</table>	
					<!-- e : 여기에 내용입력 -->
	
					<div class="btn_areaC mt30">
						<a href="javascript:CreateMessage();" class="btnType blue" id="btnSendMessage" name="btn"><span>보내기</span></a> 
						<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
	
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		
	</form>
			 


</body>
</html>






