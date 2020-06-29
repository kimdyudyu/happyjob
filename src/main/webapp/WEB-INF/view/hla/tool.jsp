<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>lms</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	//  강의실 설정
	var pageSize = 5;
	var pageBlockSize = 5;

	// 장비 페이징 설정
	var pageSizeTool = 5;
	var pageBlockSizeTool = 10;

	/** OnLoad event */
	$(function() {
		// 강의실 목록
		roomList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		admin();
	});
	function admin() {
		var userType = "${sessionScope.userType}";
		console.log("userType~" + userType);
		if (userType != "A") {
			//$("#insertBtn").hide();
			$('#toolInsertBtn').attr('style', "display:none;"); //숨기기
			$('#toolUpdateBtn').attr('style', "display:none;"); //숨기기
		}
	}
	function reset() {
		$("#searchword").val("");
	}
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
			case 'btnUpdate':
				toolInsert();
				break;
			case 'btnDeleteDtlCod':
				toolDelete();
				break;
			case 'btnCloseGrpCod':
			case 'btnCloseDtlCod':
				gfCloseModal();
				break;
			}
		});
	}

	/** 장비 폼 초기화 */
	function toolForm(object) {
		var grpCod = $("#tmpGrpCod").val();
		var grpCodNm = $("#tmpGrpCodNm").val();

		if (object == "" || object == null || object == undefined) {
			$("#room_insert").val(grpCod);
			$("#tool_name_insert").val("");
			$("#tool_ccount_insert").val("");
			$("#tool_etc_insert").val("");
			$("#tool_name_insert").focus();
		} else {
			$("#tool_name").focus();
			$("#room").val(object.room);
			$("#seq").val(object.seq);
			$("#tool_name").val(object.tool_name);
			$("#tool_ccount").val(object.tool_ccount);
			$("#tool_etc").val(object.tool_etc);
		}
	}

	/** 장비 저장 validation */
	function validationTool() {

		var chk = checkNotEmpty([ [ "tool_name_insert", "장비명을 입력해 주세요." ],
				[ "tool_ccount_insert", "장비개수를 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	// 강의실 목록
	function roomList(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);
		var searchword = $("#searchword").val();
		console.log(searchword);
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			searchword : searchword
		}

		var resultCallback = function(data) {
			roomResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/hla/toolList.do", "post", "text", true, param,
				resultCallback);
	}

	/** 강의실 목록 콜백 함수 */
	function roomResult(data, currentPage) {

		//alert(data);
		//console.log("강의실 목록 콜백 함수~" + data);
		//console.log(data.totalCntComnGrpCod);
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
				pageSize, pageBlockSize, 'roomList');
		//console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#comnGrpCodPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}

	/** 장비 목록 모달 실행 */
	function toolModal(room, seq) {
		$("#room_insert").val($("#room_hidden").val());
		//alert("test~"+$("#room_insert").val());
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
			toolForm();

			// 모달 팝업
			gfModalPop("#layer2");

			// 수정 저장
		} else {
			console.log(seq);
			// Tranjection type 설정
			$("#action").val("U");

			// 장비 목록 단건 조회
			toolDetail(room, seq);
		}
	}

	/** 장비관리 목록 조회 */
	function toolList(currentPage, room) {
		var test = $("#room_hidden").val(room);
		console.log("test~" + test);
		currentPage = currentPage || 1;
		console.log(currentPage + " " + room);
		// 그룹코드 정보 설정
		$("#tmpGrpCod").val(room);

		var param = {
			room : room,
			currentPage : currentPage,
			pageSize : pageSizeTool
		}

		var resultCallback = function(data) {
			toolListResult(data, currentPage);
		};

		callAjax("/hla/listTool.do", "post", "text", true, param,
				resultCallback);
	}

	/** 장비 목록 조회 콜백 함수 */
	function toolListResult(data, currentPage) {
		// 기존 목록 삭제
		$('#listComnDtlCod').empty();

		var $data = $($(data).html());

		// 신규 목록 생성
		var $listComnDtlCod = $data.find("#listComnDtlCod");
		$("#listComnDtlCod").append($listComnDtlCod.children());

		// 총 개수 추출
		var $totalCntComnDtlCod = $data.find("#totalCntComnDtlCod");
		var totalCntComnDtlCod = $totalCntComnDtlCod.text();
		//alert(totalCntComnDtlCod);
		// 페이지 네비게이션 생성
		var grp_cod = $("#tmpGrpCod").val();
		var grp_cod_nm = $("#tmpGrpCodNm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod,
				pageSizeTool, pageBlockSizeTool, 'fListComnDtlCod', [ grp_cod ]);
		$("#comnDtlCodPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageComnDtlCod").val(currentPage);
	}

	/** 상세코드 단건 조회 */
	function toolDetail(room, seq) {
		console.log(room + " " + seq);
		var param = {
			room : room,
			seq : seq
		};

		var resultCallback = function(data) {
			toolDetailResult(data);
		};

		callAjax("/hla/toolDetail.do", "post", "json", true, param,
				resultCallback);
	}

	/** 장비 단건 조회 콜백 함수*/
	function toolDetailResult(data) {
		console.log("장비단건조회~" + data);
		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#toolDetail");

			// 장비 폼 데이터 설정
			toolForm(data.toolDetail);

		} else {
			alert(data.resultMsg);
		}
	}

	function ValidateTool() {

		var chk = checkNotEmpty([ [ "tool_name", "장비명을 입력해 주세요." ],
				[ "tool_ccount", "장비개수를 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}
	/** 장비 저장 */
	function toolInsert() {
		if ($("#seq").val() != "") {
			if (!ValidateTool()) {
				return;
			}
		} else {
			if (!validationTool()) {
				return;
			}
		}

		var resultCallback = function(data) {
			toolInsertResult(data);
		};
		//console.log(''+$("#myForm").serialize());
		if ($("#seq").val() == "") {
			if (confirm("저장?")) {
				callAjax("/hla/toolSave.do", "post", "json", true, $("#myForm")
						.serialize(), resultCallback);
			} else {
				return false;
			}
		} else {
			if (confirm("수정?")) {
				callAjax("/hla/toolSave.do", "post", "json", true, $("#myForm")
						.serialize(), resultCallback);
			} else {
				return false;
			}
		}
	}

	/** 상세코드 저장 콜백 함수 */
	function toolInsertResult(data) {

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
			toolList(currentPage, grp_cod, grp_cod_nm);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		toolForm();
	}

	/** 장비 삭제 */
	function toolDelete() {

		var resultCallback = function(data) {
			toolDeleteResult(data);
		};
		console.log($("#myForm").serialize());
		if (confirm("삭제?")) {
			callAjax("/hla/toolDelete.do", "post", "json", true, $("#myForm")
					.serialize(), resultCallback);
		} else {
			return false;
		}
	}

	/** 장비 삭제 콜백 함수 */
	function toolDeleteResult(data) {

		var currentPage = $("#currentPageComnDtlCod").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			var grp_cod = $("#tmpGrpCod").val();
			var grp_cod_nm = $("#tmpGrpCodNm").val();
			toolList(currentPage, grp_cod, grp_cod_nm);

		} else {
			alert(data.resultMsg);
		}
	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="room_hidden" value="" name="room"> <input
			type="hidden" id="currentPageComnGrpCod" value="1"> <input
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
							<div id="searcharea">
								<table class="col2 mb10" style="width: 1000px;">
									<colgroup>
										<col width="20%">
										<col width="60%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>
										<tr>
											<td>강의실명</td>
											<td><input name="searchword" id="searchword"
												style="width: 500px;" searchword" placeholder="강의실명"
												autocomplete="off"
												onkeypress="if(event.keyCode==13) {roomList(); return false;}"></td>
											<td><a class="btnType blue" href="javascript:reset();"
												name="modal"><span>초기화</span></a></td>
											<td><a class="btnType blue" id="SEARCH_KEYWORD"
												href="javascript:roomList();" name="modal"><span>검색</span></a>
											</td>
										</tr>
									</tbody>

								</table>

							</div>

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
							<div id="toolInsertBtn">
								<p class="conTitle mt50">
									<span>장비 목록</span> <span class="fr"> <a
										class="btnType blue" href="javascript:toolModal();"
										name="modal"><span>장비 등록</span></a>
									</span>
								</p>
							</div>
							<div class="divComDtlCodList">
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
							</div>

							<div class="paging_area" id="comnDtlCodPagination"></div>

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
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
									id="room_insert" name="room_insert" /></td>
							</tr>
							<tr>
								<th scope="row">장비명<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									id="tool_name_insert" name="tool_name_insert" /></td>
							</tr>
							<tr>
								<th scope="row">장비개수<span class="font_red">*</span></th>
								<td><input
									onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
									placeholder="숫자만 입력가능합니다" type="text" class="inputTxt p100"
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
								<td><input
									onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
									placeholder="숫자만 입력가능합니다" type="text" class="inputTxt p100"
									id="tool_ccount" name="tool_ccount" /></td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td colspan="3"><input type="text" class="inputTxt"
									id="tool_etc" name="tool_etc" /></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<div id="toolUpdateBtn">
							<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>
							<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>
						</div>
						<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>