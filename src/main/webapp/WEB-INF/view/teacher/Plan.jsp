<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>JobKorea</title>

<link rel="stylesheet" type="text/css" href="/css/admin/basic.css">
<link rel="stylesheet" type="text/css" href="/css/jh_css/style.css">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="/css/vuecss/bootstrap-datepicker3.css">
<link rel="stylesheet" type="text/css" href="/css/vuecss/bootstrap-datepicker3.min.css">
<link rel="stylesheet" type="text/css" href="/css/vuecss/bootstrap-datepicker3.standalone.min.css">
<link rel="stylesheet" type="text/css" href="/css/vuecss/bootstrap-datepicker3.standalone.css">
<link rel="stylesheet" type="text/css" href="/js/bootstrap/custom_bootstrap.css">


<script type="text/javascript" charset="utf-8" src="/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/underscore-min.js"></script>	
<script type="text/javascript" charset="utf-8" src="/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/jquery.form.min.js"></script>
<!-- 모달팝업 -->
<script type="text/javascript" charset="utf-8" src="/js/global_pub.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/jquery.model.js"></script>
<!-- IE 8 이하에서 HTML5 태그 지원 -->
<script type="text/javascript" charset="utf-8" src="/js/html5shiv.js"></script>
<!-- 공통 스크립트 -->
<script type="text/javascript" charset="utf-8" src="/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/commonAjax.js"></script>

<script type="text/javascript" charset="utf-8" src="/js/stringBuffer.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/map.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/jquery.blockUI.js"></script>

<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>  -->
<script type="text/javascript" src="//unpkg.com/vue@latest/dist/vue.js"></script>    
<script type="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js"></script><style type="text/css">.bootstrap-table .table{margin-bottom:0!important;border-bottom:1px solid #ddd;border-collapse:collapse!important;border-radius:1px}.bootstrap-table .table:not(.table-condensed),.bootstrap-table .table:not(.table-condensed)>tbody>tr>td,.bootstrap-table .table:not(.table-condensed)>tbody>tr>th,.bootstrap-table .table:not(.table-condensed)>tfoot>tr>td,.bootstrap-table .table:not(.table-condensed)>tfoot>tr>th,.bootstrap-table .table:not(.table-condensed)>thead>tr>td{padding:8px}.bootstrap-table .table.table-no-bordered>tbody>tr>td,.bootstrap-table .table.table-no-bordered>thead>tr>th{border-right:2px solid transparent}.bootstrap-table .table.table-no-bordered>tbody>tr>td:last-child{border-right:none}.fixed-table-container{position:relative;clear:both;border:1px solid #ddd;border-radius:4px;-webkit-border-radius:4px;-moz-border-radius:4px}.fixed-table-container.table-no-bordered{border:1px solid transparent}.fixed-table-footer,.fixed-table-header{overflow:hidden}.fixed-table-footer{border-top:1px solid #ddd}.fixed-table-body{overflow-x:auto;overflow-y:auto;height:100%}.fixed-table-container table{width:100%}.fixed-table-container thead th{height:0;padding:0;margin:0;border-left:1px solid #ddd}.fixed-table-container thead th:focus{outline:0 solid transparent}.fixed-table-container thead th:first-child{border-left:none;border-top-left-radius:4px;-webkit-border-top-left-radius:4px;-moz-border-radius-topleft:4px}.fixed-table-container tbody td .th-inner,.fixed-table-container thead th .th-inner{padding:8px;line-height:24px;vertical-align:top;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.fixed-table-container thead th .sortable{cursor:pointer;background-position:100%;background-repeat:no-repeat;padding-right:30px}.fixed-table-container thead th .sortable.both{background-image:url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAQAAADYWf5HAAAAkElEQVQoz7X QMQ5AQBCF4dWQSJxC5wwax1Cq1e7BAdxD5SL+Tq/QCM1oNiJidwox0355mXnG/DrEtIQ6azioNZQxI0ykPhTQIwhCR+BmBYtlK7kLJYwWCcJA9M4qdrZrd8pPjZWPtOqdRQy320YSV17OatFC4euts6z39GYMKRPCTKY9UnPQ6P+GtMRfGtPnBCiqhAeJPmkqAAAAAElFTkSuQmCC')}.fixed-table-container thead th .sortable.asc{background-image:url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAZ0lEQVQ4y2NgGLKgquEuFxBPAGI2ahhWCsS/gDibUoO0gPgxEP8H4ttArEyuQYxAPBdqEAxPBImTY5gjEL9DM+wTENuQahAvEO9DMwiGdwAxOymGJQLxTyD+jgWDxCMZRsEoGAVoAADeemwtPcZI2wAAAABJRU5ErkJggg==')}.fixed-table-container thead th .sortable.desc{background-image:url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAZUlEQVQ4y2NgGAWjYBSggaqGu5FA/BOIv2PBIPFEUgxjB+IdQPwfC94HxLykus4GiD+hGfQOiB3J8SojEE9EM2wuSJzcsFMG4ttQgx4DsRalkZENxL+AuJQaMcsGxBOAmGvopk8AVz1sLZgg0bsAAAAASUVORK5CYII=')}.fixed-table-container th.detail{width:30px}.fixed-table-container tbody td{border-left:1px solid #ddd}.fixed-table-container tbody tr:first-child td{border-top:none}.fixed-table-container tbody td:first-child{border-left:none}.fixed-table-container tbody .selected td{background-color:#f5f5f5}.fixed-table-container .bs-checkbox{text-align:center}.fixed-table-container .bs-checkbox .th-inner{padding:8px 0}.fixed-table-container input[type=checkbox],.fixed-table-container input[type=radio]{margin:0 auto!important}.fixed-table-container .no-records-found{text-align:center}.fixed-table-pagination .pagination-detail,.fixed-table-pagination div.pagination{margin-top:10px;margin-bottom:10px}.fixed-table-pagination div.pagination .pagination{margin:0}.fixed-table-pagination .pagination a{padding:6px 12px;line-height:1.428571429}.fixed-table-pagination .pagination-info{line-height:34px;margin-right:5px}.fixed-table-pagination .btn-group{position:relative;display:inline-block;vertical-align:middle}.fixed-table-pagination .dropup .dropdown-menu{margin-bottom:0}.fixed-table-pagination .page-list{display:inline-block}.fixed-table-toolbar .columns-left{margin-right:5px}.fixed-table-toolbar .columns-right{margin-left:5px}.fixed-table-toolbar .columns label{display:block;padding:3px 20px;clear:both;font-weight:400;line-height:1.428571429}.fixed-table-toolbar .bs-bars,.fixed-table-toolbar .columns,.fixed-table-toolbar .search{position:relative;margin-top:10px;margin-bottom:10px;line-height:34px}.fixed-table-pagination li.disabled a{pointer-events:none;cursor:default}.fixed-table-loading{position:absolute;right:0;top:0;bottom:0;left:0;z-index:99}.fixed-table-loading-bg{position:absolute;width:100%;height:100%;opacity:.9;background-color:#fff}.fixed-table-loading-text:before{content:'';display:inline-block;height:100%;vertical-align:middle}.fixed-table-loading-text{position:absolute;width:100%;height:100%;display:inline-block;text-align:center;vertical-align:middle}.fixed-table-body .card-view .title{font-weight:700;display:inline-block;min-width:30%;text-align:left!important}.fixed-table-body thead th .th-inner,.table td,.table th{box-sizing:border-box}.table td,.table th{vertical-align:middle}.fixed-table-toolbar .dropdown-menu{text-align:left;max-height:300px;overflow:auto}.fixed-table-toolbar .btn-group>.btn-group{display:inline-block;margin-left:-1px!important}.fixed-table-toolbar .btn-group>.btn-group>.btn{border-radius:0}.fixed-table-toolbar .btn-group>.btn-group:first-child>.btn{border-top-left-radius:4px;border-bottom-left-radius:4px}.fixed-table-toolbar .btn-group>.btn-group:last-child>.btn{border-top-right-radius:4px;border-bottom-right-radius:4px}.bootstrap-table .table>thead>tr>th{vertical-align:bottom;border-bottom:1px solid #ddd}.bootstrap-table .table thead>tr>th{padding:0;margin:0}.bootstrap-table .fixed-table-footer tbody>tr>td{padding:0!important}.bootstrap-table .fixed-table-footer .table{border-bottom:none;border-radius:0;padding:0!important}.pull-right .dropdown-menu{right:0;left:auto}p.fixed-table-scroll-inner{width:100%;height:200px}div.fixed-table-scroll-outer{top:0;left:0;visibility:hidden;width:200px;height:150px;overflow:hidden}</style>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script> 

<!-- <script· src="https://unpkg.com/@livelybone/vue-datepicker/lib/umd/DatetimePicker.js"></script>

<script· src="https://unpkg.com/@livelybone/vue-datepicker/lib/umd/Timepicker.js"></script> -->
<!-- <script src="https://unpkg.com/@livelybone/vue-datepicker"></script>
<script· src="https://unpkg.com/@livelybone/vue-datepicker/lib/umd/Datepicker.js"></script> -->

<script type="text/javascript" charset="utf-8" src="/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

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
				case 'btnSaveGrpCod' :
					fSaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fDeleteGrpCod();
					break;
				case 'btnSaveDtlCod' :
					fSaveDtlCod();
					break;
				case 'btnDeleteDtlCod' :
					fDeleteDtlCod();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	/** 그룹코드 폼 초기화 */
	function fInitFormGrpCod(object) {
		$("#grp_cod").focus();
		if( object == "" || object == null || object == undefined) {
			
			$("#grp_cod").val("");
			$("#grp_cod_nm").val("");
			$("#grp_cod_eplti").val("");
			$("#grp_tmp_fld_01").val("");
			$("#grp_tmp_fld_02").val("");
			$("#grp_tmp_fld_03").val("");
			$("input:radio[name=grp_use_poa]:input[value='Y']").attr("checked", true);
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
			$("input:radio[name=grp_use_poa]:input[value="+object.use_poa+"]").attr("checked", true);
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

		if( object == "" || object == null || object == undefined) {
			
			$("#dtl_grp_cod").val(grpCod);
			$("#dtl_grp_cod_nm").val(grpCodNm);
			$("#dtl_cod").val("");
			$("#dtl_cod_nm").val("");
			$("#dtl_odr").val("");
			$("#dtl_cod_eplti").val("");
			$("#dtl_tmp_fld_01").val("");
			$("#dtl_tmp_fld_02").val("");
			$("#dtl_tmp_fld_03").val("");
			$("#dtl_tmp_fld_04").val("");
			$("input:radio[name=dtl_use_poa]:input[value='Y']").attr("checked", true);
			
			$("#dtl_grp_cod").attr("readonly", true);
			$("#dtl_grp_cod").css("background", "#F5F5F5");
			$("#dtl_grp_cod_nm").attr("readonly", true);
			$("#dtl_grp_cod_nm").css("background", "#F5F5F5");
			$("#dtl_cod").attr("readonly", false);
			$("#dtl_cod").css("background", "#FFFFFF");
			$("#btnDeleteDtlCod").hide();
			$("#dtl_cod").focus();
			
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
			$("input:radio[name=dtl_use_poa]:input[value='"+object.use_poa+"']").attr("checked", true);
			
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

		var chk = checkNotEmpty(
				[
						[ "grp_cod", "그룹 코드를 입력해 주세요." ]
					,	[ "grp_cod_nm", "그룹 코드 명을 입력해 주세요" ]
					,	[ "grp_cod_eplti", "그룹 코드 설명을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 상세코드 저장 validation */
	function fValidateDtlCod() {

		var chk = checkNotEmpty(
				[
						[ "dtl_grp_cod", "그룹 코드를 선택해 주세요." ]
					,	[ "dtl_cod", "상세 코드를 입력해 주세요." ]
					,	[ "dtl_cod_nm", "상세 코드 명을 입력해 주세요" ]
					,	[ "dtl_cod_eplti", "상세 코드 설명을 입력해 주세요." ]
					,	[ "dtl_odr", "상세 코드 설명을 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	/** 그룹코드 모달 실행 */
	function fPopModalComnGrpCod(grp_cod) {
		
		// 신규 저장
		if (grp_cod == null || grp_cod=="") {
		
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
	
	
	/** 그룹코드 조회 */
	function fListComnGrpCod(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);
		
		var param = {
					currentPage : currentPage
				,	pageSize : pageSizeComnGrpCod
		}
		
		var resultCallback = function(data) {
			flistGrpCodResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/system/listComnGrpCod.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 그룹코드 조회 콜백 함수 */
	function flistGrpCodResult(data, currentPage) {
		
		//alert(data);
		console.log(data);
		
		// 기존 목록 삭제
		$('#listComnGrpCod').empty();
		//$('#listComnGrpCod').find("tr").remove() 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listComnGrpCod = $data.find("#listComnGrpCod");		
		$("#listComnGrpCod").append($listComnGrpCod.children());
		
		// 총 개수 추출
		var $totalCntComnGrpCod = $data.find("#totalCntComnGrpCod");
		var totalCntComnGrpCod = $totalCntComnGrpCod.text(); 
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		console.log("paginationHtml : " + paginationHtml);
		//alert(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnGrpCod").val(currentPage);
	}
	
	
	/** 그룹코드 단건 조회 */
	function fSelectGrpCod(grp_cod) {
		
		var param = { grp_cod : grp_cod };
		
		var resultCallback = function(data) {
			fSelectGrpCodResult(data);
		};
		
		callAjax("/system/selectComnGrpCod.do", "post", "json", true, param, resultCallback);
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
		if ( ! fValidateGrpCod() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};
		
		callAjax("/system/saveComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
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
		
		callAjax("/system/deleteComnGrpCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
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
	
	
	/** 상세코드 모달 실행 */
	function fPopModalComnDtlCod(grp_cod, dtl_cod) {
		
		// 신규 저장
		if (dtl_cod == null || dtl_cod=="") {
		
			if ($("#tmpGrpCod").val() == "") {
				alert("그룹 코드를 선택해 주세요.");
				return;
			}
			
			// Tranjection type 설정
			$("#action").val("I");
			
			// 상세코드 폼 초기화
			fInitFormDtlCod();
			
			// 모달 팝업
			gfModalPop("#layer2");

		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#action").val("U");
			
			// 상세코드 단건 조회
			fSelectDtlCod(grp_cod, dtl_cod);
		}
	}
	
	
	/** 상세코드 목록 조회 */
	function fListComnDtlCod(currentPage, grp_cod, grp_cod_nm) {
		
		currentPage = currentPage || 1;
		
		// 그룹코드 정보 설정
		$("#tmpGrpCod").val(grp_cod);
		$("#tmpGrpCodNm").val(grp_cod_nm);
		
		var param = {
					grp_cod : grp_cod
				,	currentPage : currentPage
				,	pageSize : pageSizeComnDtlCod
		}
		
		var resultCallback = function(data) {
			flistDtlCodResult(data, currentPage);
		};
		
		callAjax("/system/listComnDtlCod.do", "post", "text", true, param, resultCallback);
	}
	
	
	/** 상세코드 조회 콜백 함수 */
	function flistDtlCodResult(data, currentPage) {
		
		// 기존 목록 삭제
		$('#listComnDtlCod').empty(); 
		
		var $data = $( $(data).html() );

		// 신규 목록 생성
		var $listComnDtlCod = $data.find("#listComnDtlCod");		
		$("#listComnDtlCod").append($listComnDtlCod.children());
		
		// 총 개수 추출
		var $totalCntComnDtlCod = $data.find("#totalCntComnDtlCod");
		var totalCntComnDtlCod = $totalCntComnDtlCod.text(); 
		
		// 페이지 네비게이션 생성
		var grp_cod = $("#tmpGrpCod").val();
		var grp_cod_nm = $("#tmpGrpCodNm").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCntComnDtlCod, pageSizeComnDtlCod, pageBlockSizeComnDtlCod, 'fListComnDtlCod', [grp_cod]);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		$("#currentPageComnDtlCod").val(currentPage);
	}
	
	
	/** 상세코드 단건 조회 */
	function fSelectDtlCod(grp_cod, dtl_cod)
</script>

</head>
<body>

<div class="content">


						<p class="conTitle">
					        <select>
					          <option>제목</option>
					          <option>강사명</option>
					          <option>과목</option>
					        </select>
					        <input class="keyword" type="text" name="search" maxlength="255" val="">
					        <a>작성일</a>
					        <input type="date" value="">
					        <a>~</a>
					        <input type="date" value="">
					        <input class="search" type="button" id="search" value="search">
					    </p>
						
						<div class="divComGrpCodList">
							        <table class="col">
							            <caption>caption</caption>
							            <colgroup>
							                <col width="6%">
							                <col width="14%">
							                <col width="14%">
							                <col width="5%">
							                <col width="10%">
							                <col width="10%">
							                <col width="10%">
							                <col width="*">
							                <col width="7%">
							            </colgroup>
							
							            <thead>
							                <tr>
							                    <th scope="col"></th>
							                    <th scope="col">분류</th>
							                    <th scope="col">과목</th>
							                    <th scope="col">강사명</th>
							                    <th scope="col">강의시작일</th>
							                    <th scope="col">강의종료일</th>
							                    <th scope="col">신청인원</th>
							                    <th scope="col">정원</th>
							                </tr>
							            </thead>
							            <tbody id="listComnGrpCod">
							                <tr>
							                <td></td>
							                <td></td>
							                <td></td>
							                <td></td>
							                <td></td>
							                <td></td>
							                <td></td>
							                <td></td>
							                </tr>
							            </tbody>
							        </table>
							    </div>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area" id="comnGrpCodPagination">
						<div class="paging">
						<a class="first" href="javascript:fListComnGrpCod(1)">
						<span class="hidden">맨앞</span>
						</a>
						<a class="pre" href="javascript:fListComnGrpCod(1)">
						<span class="hidden">이전</span>
						</a><strong>1</strong> 
						<a href="javascript:fListComnGrpCod(2)">2</a> 
						<a href="javascript:fListComnGrpCod(3)">3</a>
						<a class="next" href="javascript:fListComnGrpCod(3)">
						<span class="hidden">다음</span>
						</a>
						<a class="last" href="javascript:fListComnGrpCod(3)">
						<span class="hidden">맨뒤</span>
						</a>
						</div>
						</div>
	
						<p class="conTitle mt50">
							<span>상세 코드</span> <span class="fr"> 
							<a class="btnType blue" href="javascript:fPopModalComnDtlCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
	
						<div class="divComDtlCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="5%">
									<col width="5%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="10%">
									<col width="*">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">그룹 코드 ID</th>
										<th scope="col">상세 코드 ID</th>
										<th scope="col">상세 코드 명</th>
										<th scope="col">순서</th>
										<th scope="col">사용</th>
										<th scope="col">임시 필드 01</th>
										<th scope="col">임시 필드 01</th>
										<th scope="col">임시 필드 03</th>
										<th scope="col">임시 필드 04</th>
										<th scope="col">코드 설명</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listComnDtlCod">
									<tr>
										<td colspan="12">그룹코드를 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area" id="comnDtlCodPagination"> </div>

					</div>

</body>
</html>