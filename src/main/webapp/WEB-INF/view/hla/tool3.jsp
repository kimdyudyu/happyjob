<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	var vm;
	var dqnaVue;
	// 그룹코드 페이징 설정
	var pageSizeComnGrpCod = 5;
	var pageBlockSizeComnGrpCod = 5;

	// 상세코드 페이징 설정
	var pageSizeComnDtlCod = 5;
	var pageBlockSizeComnDtlCod = 10;

	/** OnLoad event */
	$(function() {

		// 그룹코드 조회
		fListComnGrpCod();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSaveGrpCod':
				fSaveGrpCod();
				break;
			case 'btnDeleteGrpCod':
				fDeleteGrpCod();
				break;
			case 'btnSaveDtlCod':
				fSaveDtlCod();
				break;
			case 'btnDeleteDtlCod':
				fDeleteDtlCod();
				break;
			case 'btnCloseGrpCod':
			case 'btnCloseDtlCod':
				gfCloseModal();
				break;
			}
		});
	}

	/** 그룹코드 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#grp_cod").focus();
		if (object == "" || object == null || object == undefined) {

			$("#grp_cod").val("");
			$("#grp_cod_nm").val("");
			$("#grp_cod_eplti").val("");
			$("#grp_tmp_fld_01").val("");
			$("#grp_tmp_fld_02").val("");
			$("#grp_tmp_fld_03").val("");
			$("input:radio[name=grp_use_poa]:input[value='Y']").attr("checked",
					true);
			$("#grp_cod").attr("readonly", false);
			$("#grp_cod").css("background", "#FFFFFF");
			$("#grp_cod").focus();
			$("#btnDeleteGrpCod").hide();

		} else {

			$("#grp_cod").val(object.grp_cod);
			$("#grp_cod_nm").val(object.grp_cod_nm);
			$("#grp_cod_eplti").val(object.grp_cod_eplti);
			$("#grp_tmp_fld_01").val(object.tmp_fld_01);
			$("#grp_tmp_fld_02").val(object.tmp_fld_02);
			$("#grp_tmp_fld_03").val(object.tmp_fld_03);
			$(
					"input:radio[name=grp_use_poa]:input[value="
							+ object.use_poa + "]").attr("checked", true);
			$("#grp_cod").attr("readonly", true);
			$("#grp_cod").css("background", "#F5F5F5");
			$("#grp_cod_nm").focus();
			$("#btnDeleteGrpCod").show();
		}
	}

	/** 상세코드 폼 초기화 */
	function fInitFormDtlCod(object) {

		var grpCod = $("#tmpGrpCod").val();
		var grpCodNm = $("#tmpGrpCodNm").val();

		if (object == "" || object == null || object == undefined) {
			$("#room_insert").val(grpCod);
			$("#tool_name_insert").val("");
			$("#tool_ccount_insert").val("");
			$("#tool_etc_insert").val("");
			$("#tool_name_insert").focus();
		} else {

			$("#dtl_grp_cod").val(object.grp_cod);
			$("#dtl_grp_cod_nm").val(object.grp_cod_nm);
			$("#dtl_cod").val(object.dtl_cod);
			$("#dtl_cod_nm").val(object.dtl_cod_nm);
			$("#dtl_odr").val(object.odr);
			$("#dtl_cod_eplti").val(object.dtl_cod_eplti);
			$("#dtl_tmp_fld_01").val(object.tmp_fld_01);
			$("#dtl_tmp_fld_02").val(object.tmp_fld_02);
			$("#dtl_tmp_fld_03").val(object.tmp_fld_03);
			$("#dtl_tmp_fld_04").val(object.tmp_fld_04);
			$(
					"input:radio[name=dtl_use_poa]:input[value='"
							+ object.use_poa + "']").attr("checked", true);

			$("#dtl_grp_cod").attr("readonly", true);
			$("#dtl_grp_cod").css("background", "#F5F5F5");
			$("#dtl_grp_cod_nm").attr("readonly", true);
			$("#dtl_grp_cod_nm").css("background", "#F5F5F5");
			$("#dtl_cod").attr("readonly", true);
			$("#dtl_cod").css("background", "#F5F5F5");
			$("#btnDeleteDtlCod").show();
			$("#dtl_cod_nm").focus();
		}
	}

	/** 그룹코드 저장 validation */
	function fValidateGrpCod() {

		var chk = checkNotEmpty([ [ "grp_cod", "그룹 코드를 입력해 주세요." ],
				[ "grp_cod_nm", "그룹 코드 명을 입력해 주세요" ],
				[ "grp_cod_eplti", "그룹 코드 설명을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/** 상세코드 저장 validation */
	function fValidateDtlCod() {

		var chk = checkNotEmpty([ [ "tool_name_insert", "장비명을 입력해 주세요." ],
				[ "tool_ccount_insert", "장비개수를 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/** 그룹코드 모달 실행 */
	function fPopModalComnGrpCod(grp_cod) {

		// 신규 저장
		if (grp_cod == null || grp_cod == "") {

			// Tranjection type 설정
			$("#action").val("I");

			// 그룹코드 폼 초기화
			fInitFormGrpCod();

			// 모달 팝업
			gfModalPop("#layer1");

			// 수정 저장
		} else {

			// Tranjection type 설정
			$("#action").val("U");

			// 그룹코드 단건 조회
			fSelectGrpCod(grp_cod);
		}
	}

	// 강의실 목록
	function fListComnGrpCod(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeComnGrpCod
		}

		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/hla/toolList.do", "post", "json", true, param,
				resultCallback);
	}

	/** 강의실 목록 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {

		//alert(data);
		console.log("강의실 목록 콜백 함수~" + data);

		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		//$('#listComnGrpCod').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $listComnGrpCod = $data.find("#listComnGrpCod");
		$("#listComnGrpCod").append($listComnGrpCod.children());

		// 총 개수 추출
		var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
		var totalCntComnGrpCod = $totalCntComnGrpCod.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod,
				pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#comnGrpCodPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}

	/** 그룹코드 단건 조회 */
	function fSelectGrpCod(grp_cod) {

		var param = {
			grp_cod : grp_cod
		};

		var resultCallback = function(data) {
			fSelectGrpCodResult(data);
		};

		callAjax("/system/selectComnGrpCod.do", "post", "json", true, param,
				resultCallback);
	}

	/** 그룹코드 단건 조회 콜백 함수*/
	function fSelectGrpCodResult(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInitFormGrpCod(data.comnGrpCodModel);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 그룹코드 저장 */
	function fSaveGrpCod() {

		// vaildation 체크
		if (!fValidateGrpCod()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};

		callAjax("/system/saveComnGrpCod.do", "post", "json", true,
				$("#myForm").serialize(), resultCallback);
	}

	/** 그룹코드 저장 콜백 함수 */
	function fSaveGrpCodResult(data) {

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
			fListComnGrpCod(currentPage);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		fInitFormGrpCod();
	}

	/** 그룹코드 삭제 */
	function fDeleteGrpCod() {

		var resultCallback = function(data) {
			fDeleteGrpCodResult(data);
		};

		callAjax("/system/deleteComnGrpCod.do", "post", "json", true, $(
				"#myForm").serialize(), resultCallback);
	}

	/** 그룹코드 삭제 콜백 함수 */
	function fDeleteGrpCodResult(data) {

		var currentPage = $("#currentPageComnGrpCod").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			fListComnGrpCod(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 장비 목록 모달 실행 */
	function fPopModalComnDtlCod(room, seq) {

		// 신규 저장
		if (seq == null || seq == "") {
			//alert("저장");
			if ($("#tmpGrpCod").val() == "") {
				alert("강의실을 선택해 주세요.");
				return;
			}
			console.log(seq);
			// Tranjection type 설정
			$("#action").val("I");

			// 장비등록 폼 초기화
			fInitFormDtlCod();

			// 모달 팝업
			gfModalPop("#layer2");

			// 수정 저장
		} else {
			console.log(seq);
			// Tranjection type 설정
			$("#action").val("U");

			// 장비 목록 단건 조회
			fSelectDtlCod(room, seq);
		}
	}

	/** 장비관리 목록 조회 */
	function fListComnDtlCod(currentPage, room) {

		currentPage = currentPage || 1;
		console.log(currentPage + " " + room);
		// 그룹코드 정보 설정
		$("#tmpGrpCod").val(room);

		var param = {
			room : room,
			currentPage : currentPage,
			pageSize : pageSizeComnDtlCod
		}

		var resultCallback = function(data) {
			gridinit(data, currentPage);
		};

		callAjax("/hla/listTool.do", "post", "text", true, param,
				resultCallback);
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

				fdetailModal : function(seq) {
					//alert(wno);
					fdetailModalpop(seq);
				}
			}
		});

		/* 상세보기. */
		dqnaVue = new Vue({
			el : '#detailtable',
			data : {
				seq : '',
				loginID : '',
				name : '',
				hire_date : '',
				resign_date : '',
				cop_name : '',
				work_yn : ''

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
	}
	/* 장비 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	function gridinit(data, currentPage) {
		init();
		//console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
		//console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));

		vm.items = [];
		vm.items = data.listToool;

		console.log(data.totalCnt + " : " + currentPage);

		// 리스트의 총 개수를 추출합니다. 
		//var totalCnt = $data.find("#totalCnt").text();
		var toolCount = data.toolCount; // qnaRealList() 에서보낸값 
		//alert("totalCnt 찍어봄!! " + totalCnt);

		// * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		// function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		// 파라미터를 참조합시다. 
		//var list = $("#tmpList").val();
		//var listnum = $("#tmpListNum").val();
		var pagingnavi = getPaginationHtml(currentPage, toolCount,
				pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'selectqnaListvue');

		//console.log("pagingnavi : " + pagingnavi);
		// 비운다음에 다시 append 
		$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 

		// 현재 페이지 설정 
		$("#currentPage").val(currentPage);
	}

	/** 장비 목록 조회 콜백 함수 */
	function flistDtlCodResult(data, currentPage) {
		// 기존 목록 삭제
		$('#listComnDtlCod').empty();

		var $data = $($(data).html());

		// 신규 목록 생성
		var $listComnDtlCod = $data.find("#listComnDtlCod");
		$("#listComnDtlCod").append($listComnDtlCod.children());

		// 총 개수 추출
		var $totalCntComnDtlCod = $data.find("#totalCntComnDtlCod");
		var totalCntComnDtlCod = $totalCntComnDtlCod.text();

		// 페이지 네비게이션 생성
		var grp_cod = $("#tmpGrpCod").val();
		var grp_cod_nm = $("#tmpGrpCodNm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod,
				pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListComnDtlCod',
				[ grp_cod ]);
		$("#comnDtlCodPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageComnDtlCod").val(currentPage);
	}

	/** 상세코드 단건 조회 */
	function fSelectDtlCod(room, seq) {
		console.log(room + " " + seq);
		var param = {
			room : room,
			seq : seq
		};

		var resultCallback = function(data) {
			fSelectDtlCodResult(data);
		};

		callAjax("/hla/toolDetail.do", "post", "json", true, param,
				resultCallback);
	}

	/** 장비 단건 조회 콜백 함수*/
	function fSelectDtlCodResult(data) {
		console.log("장비단건조회~" + data);
		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#toolDetail");

			// 그룹코드 폼 데이터 설정
			fInitFormDtlCod(data.comnDtlCodModel);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 장비 저장 */
	function fSaveDtlCod() {

		// vaildation 체크
		if (!fValidateDtlCod()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveDtlCodResult(data);
		};
		//console.log(''+$("#myForm").serialize());
		if (confirm("저장?")) {
			callAjax("/hla/toolSave.do", "post", "json", true, $("#myForm")
					.serialize(), resultCallback);
		} else {
			return false;
		}
	}

	/** 상세코드 저장 콜백 함수 */
	function fSaveDtlCodResult(data) {

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
			var grp_cod = $("#tmpGrpCod").val();
			var grp_cod_nm = $("#tmpGrpCodNm").val();
			fListComnDtlCod(currentPage, grp_cod, grp_cod_nm);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		fInitFormDtlCod();
	}

	/** 상세코드 삭제 */
	function fDeleteDtlCod() {

		var resultCallback = function(data) {
			fDeleteDtlCodResult(data);
		};

		callAjax("/system/deleteComnDtlCod.do", "post", "json", true, $(
				"#myForm").serialize(), resultCallback);
	}

	/** 상세코드 삭제 콜백 함수 */
	function fDeleteDtlCodResult(data) {

		var currentPage = $("#currentPageComnDtlCod").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			var grp_cod = $("#tmpGrpCod").val();
			var grp_cod_nm = $("#tmpGrpCodNm").val();
			fListComnDtlCod(currentPage, grp_cod, grp_cod_nm);

		} else {
			alert(data.resultMsg);
		}
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageComnGrpCod" value="1"> <input
			type="hidden" id="currentPageComnDtlCod" value="1"> <input
			type="hidden" id="tmpGrpCod" value=""> <input type="hidden"
			id="tmpGrpCodNm" value=""> <input type="hidden" name="action"
			id="action" value="">

		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

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
									class="btn_nav">물품관리</a> <span class="btn_nav bold"><a
									href="/hla/tool.do">장비관리</a></span> <a href="/hla/tool.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강의실 목록</span>
							</p>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="40%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강의실 번호</th>
											<th scope="col">강의실 명</th>
											<th scope="col">강의실 크기</th>
											<th scope="col">강의실 자리수</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listComnGrpCod"></tbody>
								</table>
							</div>

							<div class="paging_area" id="comnGrpCodPagination"></div>

							<p class="conTitle mt50">
								<span>장비 목록</span> <span class="fr"> <a
									class="btnType blue" href="javascript:fPopModalComnDtlCod();"
									name="modal"><span>장비 등록</span></a>
								</span>
							</p>
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
													<col width="10%">
													<col width="30%">
													<col width="10%">
													<col width="40%">
												</colgroup>
												<thead>
													<tr>
														<th data-field="seq">장비번호</th>
														<th data-field="tool_name">장비명</th>
														<th data-field="tool_ccount">장비개수</th>
														<th data-field="tool_etc">비고</th>
													</tr>

												</thead>
												<tbody>
													<template v-for="(row, index) in items" v-if="items.length">
													<tr @click="fdetailModal(row.seq)">
														<td style="text-align: center;">{{ row.seq }}</td>
														<td>{{ row.tool_name }}</td>
														<td>{{ row.tool_ccount }}</td>
														<td>{{ row.tool_etc }}</td>
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
		<%-- <div class="divComDtlCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="30%">
										<col width="10%">
										<col width="40%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강의실 번호</th>
											<th scope="col">장비 번호</th>
											<th scope="col">장비 명</th>
											<th scope="col">장비 개수</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listComnDtlCod">
										<tr>
											<td colspan="12">강의실을 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div> --%>

		<div class="paging_area" id="comnDtlCodPagination"></div>

		</div>
		<!--// content -->

		<h3 class="hidden">풋터 영역</h3>
		<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
		</li>
		</ul>
		</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>그룹코드 관리</strong>
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
								<th scope="row">그룹 코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="grp_cod"
									id="grp_cod" /></td>
								<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="grp_cod_nm" id="grp_cod_nm" /></td>
							</tr>
							<tr>
								<th scope="row">코드 설명 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_cod_eplti" id="grp_cod_eplti" /></td>
							</tr>
							<tr>
								<th scope="row">임시 필드 01</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_tmp_fld_01" id="grp_tmp_fld_01" /></td>
							</tr>
							<tr>
								<th scope="row">임시 필드 02</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_tmp_fld_02" id="grp_tmp_fld_02" /></td>
							</tr>
							<tr>
								<th scope="row">임시 필드 03</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="grp_tmp_fld_03" id="grp_tmp_fld_03" /></td>
							</tr>
							<tr>
								<th scope="row">사용 유무 <span class="font_red">*</span></th>
								<td colspan="3"><input type="radio" id="radio1-1"
									name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label
									for="radio1-1">사용</label> &nbsp;&nbsp;&nbsp;&nbsp; <input
									type="radio" id="radio1-2" name="grp_use_poa"
									id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>장비 등록</strong>
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
								<th scope="row">강의실번호<span class="font_red">*</span></th>
								<td><input readonly type="text" class="inputTxt p100"
									id="room_insert" name="room" /></td>
							</tr>
							<tr>
								<th scope="row">장비명<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									id="tool_name_insert" name="tool_name_insert" /></td>
							</tr>
							<tr>
								<th scope="row">장비개수<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									id="tool_ccount_insert" name="tool_ccount_insert" /></td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td colspan="3"><input type="text" class="inputTxt"
									id="tool_etc_insert" name="tool_etc_insert" /></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
						<!-- <a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a> -->
						<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		<!--// 모달팝업 -->

		<div id="toolDetail" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>장비 수정</strong>
				</dt>
				<dd class="content">

					<!-- s : 여기에 내용입력 -->

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
								<th scope="row">강의실번호<span class="font_red">*</span></th>
								<td><input readonly type="text" class="inputTxt p100"
									id="room" name="room" /></td>
							</tr>
							<tr>
								<th scope="row">장비번호<span class="font_red">*</span></th>
								<td><input readonly type="text" class="inputTxt p100"
									id="seq" name="seq" /></td>
							</tr>
							<tr>
								<th scope="row">장비명<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" id="tool_name"
									name="tool_name" /></td>
							</tr>
							<tr>
								<th scope="row">장비개수<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									id="tool_ccount" name="tool_ccount" /></td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td colspan="3"><input type="text" class="inputTxt"
									id="tool_etc" name="tool_etc_insert" /></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
						<!-- <a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a> -->
						<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>