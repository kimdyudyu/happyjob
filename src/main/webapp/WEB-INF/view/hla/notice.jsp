<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>취업정보</title>

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
}
</style>
<script type="text/javascript">
	// 페이징 설정 
	var qnaPageSize = 10; // 화면에 뿌릴 데이터 수 
	var qnaPageSizevue = 10;
	var qnaPageBlock = 10; // 블럭으로 잡히는 페이징처리 수

	var vm;
	var dqnaVue;

	//var isM = isMobile();
	var isM = false;
	var popperProps = {
		popperOptions : {
			modifiers : {
				preventOverflow : {
					padding : 20
				}
			},
			onUpdate : function(data) {
				console.log(JSON.stringify(data.attributes))
			}
		}
	};

	/* onload 이벤트  */
	$(function() {
		// 취업정보 리스트 뿌리기 함수 
		init();
		noticeList();
		//btnEvent();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		adminNotice();
	});

	function adminNotice() {
		var userType = "${sessionScope.userType}";
		console.log("userType~" + userType);
		if (userType != "A") {
			//$("#insertBtn").hide();
			$('#insertBtn').attr('style', "display:none;"); //숨기기
			$('#adminInsert').attr('style', "display:none;"); //숨기기
			$('#update_btn_admin').attr('style', "display:none;"); //숨기기
		}
	}
	function reset() {
		$("#searchKeyword").val("titleNote");
		$("#searchword").val("");
		$("#startdate").val("");
		$("#enddate").val("");
	}

	// 공지 작성 모달 실행
	function noticeInsertModal(nt_no) {

		// 신규 저장
		if (nt_no == null || nt_no == "") {

			// Tranjection type 설정
			$("#action").val("I");

			// 공지 작성 폼 초기화
			noticeFormInit();

			// 모달 팝업
			gfModalPop("#layer1");
		}

	}

	/** 공지 작성 폼 초기화 */
	function noticeFormInit(object) {
		console.log("object~" + object);
		$("#nt_title_insert").focus();
		if (object == "" || object == null || object == undefined) {
			console.log("insert~");
			$("#nt_title_insert").val("");
			$("#nt_note_insert").val("");
		}
	}

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			console.log("btnId~" + btnId);

			switch (btnId) {
			case 'btnSaveGrpCod':
				noticeInsert();
				break;
			case 'btnDeleteGrpCod':
				noticeDelete();
				break;
			case 'btnSaveDtlCod':
				$("#action").val("U");
				noticeUpdate();
				break;
			case 'btnDeleteDtlCod':
				fDeleteDtlCod();
				break;
			case 'btnCloseGrpCod':
			case 'btnCloseDtlCod':
			case 'btnClose_vue':
				gfCloseModal();
				break;
			}
		});
	}

	// 공지 삭제
	function noticeDelete() {
		console.log("공지삭제~" + $("#myForm").serialize());

		var resultCallback = function(data) {
			noticeDeleteResult(data);
		};
		if (confirm("삭제?")) {
			callAjax("/hla/noticeDelete.do", "post", "json", true, $("#myForm")
					.serialize(), resultCallback);
		} else {
			console.log("삭제취소");
			return false;
		}
	}

	// 취업정보 삭제 콜백
	function noticeDeleteResult(data) {
		console.log("삭제콜백~" + data.result);

		var currentPage = $("#currentPageComnGrpCod").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			notice(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}

	// 공지 저장
	function noticeInsert() {

		// vaildation 체크
		if (!noticeVaildation()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};
		if (confirm("저장?")) {
			console.log("공지 저장~" + $("#myForm").serialize());
			callAjax("/hla/noticeSave.do", "post", "json", true, $("#myForm")
					.serialize(), resultCallback);
		} else {
			return false;
		}
	}

	// 취업정보 저장 콜백 함수 */
	function fSaveGrpCodResult(data) {
		console.log("fSaveGrpCodResult~");
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageComnGrpCod").val();
		}

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 목록 조회
			notice(currentPage);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		noticeFormInit();
	}

	// 취업정보 이동
	function notice(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSize
		}

		var resultCallback = function(data) {
			noticeReload();
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/hla/notice.do", "post", "text", true, param, resultCallback);
	}

	function noticeReload() {
		location.href = "/hla/notice.do";
	}
	// 공지 저장 Validation
	function noticeVaildation() {

		var chk = checkNotEmpty([ [ "nt_title_insert", "공지제목을 입력해 주세요." ],
				[ "nt_note_insert", "공지내용을 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	// 취업정보 수정
	function noticeUpdate() {
		// vaildation 체크 (유효성)
		if (!noticeUpdateVaildation()) {
			return;
		}

		var resultCallback = function(data) {
			noticeUpdateResult(data);
		};
		console.log("공지 수정~" + $("#myForm").serialize());
		callAjax("/hla/noticeSave.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	/** 상세코드 저장 콜백 함수 */
	function noticeUpdateResult(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageComnDtlCod").val();
		}

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 목록 조회

			noticeList();
		} else {
			// 오류 응답 메시지 출력
			// 		console.log(data);
			alert(data.resultMsg);
		}
	}

	function init() {

		vm = new Vue({
			el : '#vuetable',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				items : [],
				options : {
				//  paginated:"paginated"
				}
			},
			methods : {

				fdetailModal : function(nt_no) {
					console.log("init~" + nt_no);
					noticeDetail(nt_no);
				}
			}
		});

		/* 상세보기. */
		dqnaVue = new Vue({
			el : '#detailtable',
			data : {
				nt_no : '',
				nt_title : '',
				nt_note : ''

			//nt_note_vue : '',

			},
			methods : {},
			computed : {
				editor : function() {
					// alert( this.$refs.quillEditor.quill.getText());
					return this.$refs.quillEditor.quill;
				},
				mounted : function() {
					console.log('this is quill instance object', this.editor);
				}
			}
		});

		var dateFormat = "yy-mm-dd";
		//시작일
		$("#startdate").datepicker({
			dateFormat : dateFormat
		});
		$("#enddate").datepicker({
			dateFormat : dateFormat
		});
		$("#hire_date").datepicker({
			dateFormat : dateFormat
		});
		$("#resign_date").datepicker({
			dateFormat : dateFormat
		});
		$("#hire_date_d").datepicker({
			dateFormat : dateFormat
		});
		$("#resign_date_d").datepicker({
			dateFormat : dateFormat
		});

		$("#startdate").change(function() {
			$("#enddate").datepicker("option", "minDate", $(this).val());
		});

		$("#enddate").change(function() {
			$("#startdate").datepicker("option", "maxDate", $(this).val());
		});

	};

	// 공지 수정 유효성검사
	function noticeUpdateVaildation() {

		var chk = checkNotEmpty([ [ "nt_title", "공지제목을 입력해 주세요." ],
				[ "nt_note", "공지내용을 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/* 공지 리스트 불러오기  */
	function noticeList(currentPage) {

		currentPage = currentPage || 1; // or		
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		var searchkeyword = $("#searchKeyword").val();
		var searchword = $("#searchword").val();
		console.log(currentPage + " " + searchkeyword + " " + searchword + " "
				+ startdate + " " + enddate + " ");
		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSizevue,
			startdate : startdate,
			enddate : enddate,
			searchkeyword : searchkeyword,
			searchword : searchword
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			gridinit(data, currentPage);
		}

		callAjax("/hla/noticeList.do", "post", "json", true, param,
				resultCallback);

	}

	/* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	function gridinit(data, currentPage) {
		//console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
		//console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));

		vm.items = [];
		vm.items = data.noticeList;

		console.log(data.totalCnt + " : " + currentPage);

		// 리스트의 총 개수를 추출합니다. 
		//var totalCnt = $data.find("#totalCnt").text();
		var totalCnt = data.totalCnt; // qnaRealList() 에서보낸값 
		//alert("totalCnt 찍어봄!! " + totalCnt);

		// * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		// function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		// 파라미터를 참조합시다. 
		//var list = $("#tmpList").val();
		//var listnum = $("#tmpListNum").val();
		var pagingnavi = getPaginationHtml(currentPage, totalCnt,
				qnaPageSizevue, qnaPageBlock, 'noticeList');

		//console.log("pagingnavi : " + pagingnavi);
		// 비운다음에 다시 append 
		$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 

		// 현재 페이지 설정 
		$("#currentPage").val(currentPage);
	}

	/*공지사항 상세 조회*/
	function noticeDetail(nt_no) {
		//alert("공지사항 상세 조회  ");
		console.log("nt_no~" + nt_no);
		var param = {
			nt_no : nt_no
		};
		var resultCallback2 = function(data) {
			noticeDetailResult(data);
		};

		callAjax("/hla/noticeDetail.do", "post", "json", true, param,
				resultCallback2);
		//alert("공지사항 상세 조회  22");
	}

	/*  공지사항 상세 조회 -> 콜백함수   */
	function noticeDetailResult(data) {

		console.log("~" + data.result);
		console.log("~~" + data.resultMsg);
		console.log("~~~" + data.noticeDetail);
		//alert("공지사항 상세 조회  33");
		if (data.resultMsg == "SUCCESS") {
			//모달 띄우기 
			gfModalPop("#qnavue");

			// 모달에 정보 넣기 
			frealPopModal(data.noticeDetail);

		} else {
			alert(data.resultMsg);
		}
	}

	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	function frealPopModal(object) {

		if (object == "" || object == null || object == undefined) {

		} else {
			//alert("숫자찍어보세 : " + object.seq);// 페이징 처리가 제대로 안되서
			dqnaVue.nt_no = object.nt_no;
			dqnaVue.nt_title = object.nt_title;
			dqnaVue.nt_note = object.nt_note;
			$("#nt_novue").val(object.seq); // 중요한 num 값도 숨겨서 받아온다. 
		}
	}
</script>

</head>
<body>
	<!-- 모달 배경 -->
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageComnGrpCod" value="1"> <input
			type="hidden" id="currentPageComnDtlCod" value="1"> <input
			type="hidden" id="tmpGrpCod" value=""> <input type="hidden"
			id="tmpGrpCodNm" value=""> <input type="hidden" name="action"
			id="action" value=""> <input type="hidden" id="currentPage"
			value="1">

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
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습지원</a> <span class="btn_nav bold"><a
									href="/hla/notice.do">공지사항</a></span> <a href="/hla/notice.do"
									class="btn_set refresh">새로고침</a>
							</p>


							<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
							<div id="searcharea">
								<table class="col2 mb10" style="width: 1000px;">
									<colgroup>
										<col width="10%">
										<col width="30%">
										<col width="10%">
										<col width="30%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>
										<tr>
											<td><select id="searchKeyword">
													<option value="titleNote">제목+내용</option>
													<option value="title">제목</option>
													<option value="note">내용</option>
											</select></td>
											<td><input id="searchword" name="searchword"
												v-model="searchword" placeholder="입력하시오" autocomplete="off"
												onkeypress="if(event.keyCode==13) {noticeList(); return false;}"></td>
											<td>작성일</td>
											<td align="center">
												<div class="input-group date" style="width: 150px;">
													<input v-model="hire_date" id="startdate" name="startdate"
														type="text" class="form-control" v-model="startdate"
														data-date-format='yyyy-mm-dd' autocomplete="off"
														onkeypress="if(event.keyCode==13) {noticeList(); return false;}" />
													<span><b>&nbsp; ~ &nbsp;</b></span> <input
														v-model="resign_date" id="enddate" name="enddate"
														type="text" class="form-control" v-model="enddate"
														data-date-format='yyyy-mm-dd' autocomplete="off"
														onkeypress="if(event.keyCode==13) {noticeList(); return false;}" />
												</div>
											</td>
											<td><a class="btnType blue" href="javascript:reset();"
												name="modal"><span>초기화</span></a></td>
											<td><a class="btnType blue" id="SEARCH_KEYWORD"
												href="javascript:noticeList();" name="modal"><span>검색</span></a>
											</td>
											<td id="insertBtn"><a class="btnType blue"
												href="javascript:noticeInsertModal();" name="modal"><span>공지작성</span></a></td>
										</tr>
									</tbody>

								</table>

							</div>

							<div id="vuetable">
								<div class="bootstrap-table">
									<div class="fixed-table-toolbar">
										<div class="bs-bars pull-left"></div>
										<div class="columns columns-right btn-group pull-right">
										</div>
									</div>
									<div class="fixed-table-container" style="padding-bottom: 0px;">
										<div class="fixed-table-body">

											<table id="vuedatatable" class="col2 mb10"
												style="width: 1000px;">
												<colgroup>
													<col width="10%">
													<col width="70%">
													<col width="10%">
													<col width="10%">
												</colgroup>
												<thead>
													<tr>
														<th data-field="nt_no">공지번호</th>
														<th data-field="nt_title">공지제목</th>
														<th data-field="write_date">공지일</th>
														<th data-field="loginID">쓰신분</th>
													</tr>

												</thead>
												<tbody>
													<template v-for="(row, index) in items" v-if="items.length">
													<tr @click="fdetailModal(row.nt_no)">
														<td style="text-align: center;">{{ row.nt_no }}</td>
														<td>{{ row.nt_title }}</td>
														<td>{{ row.write_date }}</td>
														<td>{{ row.loginID }}</td>
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
							<div class="paging_area" id="pagingnavi"></div>
						</div>
					</li>
				</ul>

			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="qnavue" class="layerPop layerType2" style="width: 600px;">
			<input type="hidden" id="nt_novue" name="nt_novue"> <input
				type="hidden" id="select_upper_wno" name="select_upper_wno">
			<input type="hidden" id="select_wno" name="select_wno"> <input
				type="hidden" id="select_cmnt_level" name="select_cmnt_level">

			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong>공지사항 수정창</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<div id="editvue">
						<table class="row" id="detailtable">
							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>

							<tbody>
								<tr>
									<th scope="row">공지번호</th>
									<td colspan="4"><input v-model="nt_no" type="text"
										class="inputTxt p100" name="nt_no" id="nt_no" readonly /></td>
								</tr>
								<tr>
									<th scope="row">공지제목</th>
									<td colspan="4"><input v-model="nt_title" type="text"
										class="inputTxt p100" name="nt_title" id="nt_title" /> <!-- <input
										type="hidden" v-model="seq" name="seq"> --></td>
								</tr>
								<tr>
									<th scope="row">공지내용</th>
									<td><textarea v-model="nt_note" name="nt_note"
											id="nt_note"></textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn_areaC mt30">
						<div id="update_btn_admin">
							<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>수정</span></a>
							<a href="" class="btnType gray" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a>
						</div>
						<a href="" class="btnType blue" id="btnClose_vue" name="btn"><span>취소</span></a>
					</div>
				</dd>

			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>


		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>공지사항 작성</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="loginID_insert" id="loginID_insert"
									value="${sessionScope.userNm}" readonly /></td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
                     <td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="nt_title_insert" id="nt_title_insert" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="nt_note_insert" id="nt_note_insert"></textarea></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<div id="adminInsert">
							<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a>
						</div>
						<div id="deleteBtn">
							<!-- <a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a> -->
						</div>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>