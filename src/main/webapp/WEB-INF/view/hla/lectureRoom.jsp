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
		selectqnaListvue();
		//btnEvent();
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		admin();
	});

	function admin() {
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

	// 모달 실행
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

	/** 그룹코드 폼 초기화 */
	function fInitFormGrpCod(object) {
		console.log("object~" + object);
		if (object == "" || object == null || object == undefined) {
			console.log("insert~");
			$("#name_save").val("");
			$("#size_save").val("");
			$("#ccount_save").val("");
			$("#etc_save").val("");
			//$("#deleteBtn").hide();
		} else {
			/*
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
			 */
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
				fSaveGrpCod();
				break;
			case 'btnDeleteGrpCod':
				fDeleteGrpCod();
				break;
			case 'btnSaveDtlCod':
				$("#action").val("U");
				fSaveDtlCod();
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

	// 강의실 삭제
	function fDeleteGrpCod() {
		console.log("강의실 삭제~" + $("#myForm").serialize());

		var resultCallback = function(data) {
			fDeleteGrpCodResult(data);
		};
		if (confirm("삭제?")) {
			callAjax("/hla/lectureRoomDelete.do", "post", "json", true, $(
					"#myForm").serialize(), resultCallback);
		} else {
			console.log("삭제취소");
			return false;
		}
	}

	// 강의실 삭제 콜백
	function fDeleteGrpCodResult(data) {
		console.log("강의실삭제 callback~" + data.result);

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

	// 강의실 등록
	function fSaveGrpCod() {

		// vaildation 체크
		if (!fValidateGrpCod()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveGrpCodResult(data);
		};
		if (confirm("저장?")) {
			console.log("강의실 등록~" + $("#myForm").serialize());
			callAjax("/hla/lectureRoomSave.do", "post", "json", true, $(
					"#myForm").serialize(), resultCallback);
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
			fListComnGrpCod(currentPage);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		fInitFormGrpCod();
	}
	// 강의실관리 이동
	function fListComnGrpCod(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSize
		}

		var resultCallback = function(data) {
			//flistGrpCodResult(data, currentPage);
			//location.href("/hla/")
			testReload();
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/hla/lectureRoom.do", "post", "text", true, param,
				resultCallback);
	}

	function testReload() {
		location.href = "/hla/lectureRoom.do";
	}

	// 강의실 등록 Validation
	function fValidateGrpCod() {

		var chk = checkNotEmpty([ [ "name_save", "강의실명을 입력해 주세요." ],
				[ "size_save", "강의실크기 입력해 주세요" ],
				[ "ccount_save", "강의실 자리수를 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/*function btnEvent() {
		$('#btnSaveDtlCod').click(function(e) {
			e.preventDefault();

			fSaveDtlCod();
		});
	}*/

	// 강의실 수정
	function fSaveDtlCod() {
		// vaildation 체크 (유효성)
		if (!fValidateDtlCod()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveDtlCodResult(data);
		};
		console.log("강의실 수정~" + $("#myForm").serialize());
		callAjax("/hla/lectureRoomSave.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
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

			selectqnaListvue();
		} else {
			// 오류 응답 메시지 출력
			// 		console.log(data);
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		fInitForm();
	}

	function fInitForm() {
		//dqnaVue.loginID = '';
		//dqnaVue.name = '';
		//dqnaVue. = '';

		$('#answer_id').val();
		$('#answer_title').val();
		$('#answer_note').val();
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

				fdetailModal : function(room) {
					console.log("init~" + room);
					fdetailModalpop(room);
				}
			}
		});

		/* 상세보기. */
		dqnaVue = new Vue({
			el : '#detailtable',
			data : {
				room : '',
				name : '',
				room_size : '',
				ccount : '',
				etc : ''

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
	};

	// 강의실 수정 유효성검사
	function fValidateDtlCod() {

		var chk = checkNotEmpty([ [ "name", "강의실명을 입력해 주세요." ],
				[ "room_size", "강의실크기 입력해 주세요" ],
				[ "ccount", "강의실 자리수를 입력해 주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	// function goPage(){
	// 	if($("#searchkey").val()=="all"){
	// 		$("#searchword").val("");
	// 	}
	// 	$("#myForm").attr({
	// 		"method": "get",
	// 		"action": "/jboard/qnaboard"
	// 	});
	// 	$("#myForm").submit();
	// } 

	/* 강의실관리 리스트 불러오기  */
	function selectqnaListvue(currentPage) {

		currentPage = currentPage || 1; // or		
		var searchword = $("#searchword").val();
		console.log(currentPage + " " + searchword);
		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSizevue,
			searchword : searchword
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			gridinit(data, currentPage);
		}

		callAjax("/hla/lectureRoomList.do", "post", "json", true, param,
				resultCallback);

	}

	/* 강의실관리 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	function gridinit(data, currentPage) {
		//console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
		//console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));

		vm.items = [];
		vm.items = data.lectureRoomList;

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
				qnaPageSizevue, qnaPageBlock, 'selectqnaListvue');

		//console.log("pagingnavi : " + pagingnavi);
		// 비운다음에 다시 append 
		$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 

		// 현재 페이지 설정 
		$("#currentPage").val(currentPage);
	}

	// 강의실 상세조회
	function fdetailModalpop(room) {
		//alert("공지사항 상세 조회  ");
		console.log("room~" + room);
		var param = {
			room : room
		};
		var resultCallback2 = function(data) {
			fdetailResult(data);
		};

		callAjax("/hla/lectureRoomDetail.do", "post", "json", true, param,
				resultCallback2);
		//alert("공지사항 상세 조회  22");
	}

	/*  공지사항 상세 조회 -> 콜백함수   */
	function fdetailResult(data) {

		console.log("~" + data.result);
		console.log("~~" + data.resultMsg);
		console.log("~~~" + data.lectureRoomDetail);
		//alert("공지사항 상세 조회  33");
		if (data.resultMsg == "SUCCESS") {
			//모달 띄우기 
			gfModalPop("#qnavue");

			// 모달에 정보 넣기 
			frealPopModal(data.lectureRoomDetail);

		} else {
			alert(data.resultMsg);
		}
	}

	/* 팝업 _ 초기화 페이지(신규) 혹은 내용뿌리기  */
	function frealPopModal(object) {

		if (object == "" || object == null || object == undefined) {
			/* 		 
			 var writer = $("#swriter").val();
			 //var Now = new Date();
			
			 $("#loginID").val(writer);
			 $("#loginID").attr("readonly", true);
			
			 $("#write_date").val();
			
			 $("#nt_title").val("");
			 $("#nt_note").val("");
			
			 $("#btnDeleteqna").hide(); // 삭제버튼 숨기기
			 $("#btnUpdateqna").hide();
			 $("#btnSaveqna").show();
			 */

		} else {
			//alert("숫자찍어보세 : " + object.seq);// 페이징 처리가 제대로 안되서
			dqnaVue.room = object.room;
			dqnaVue.name = object.name;
			dqnaVue.room_size = object.room_size;
			dqnaVue.ccount = object.ccount;
			dqnaVue.etc = object.etc;

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
									class="btn_nav">물품관리</a> <span class="btn_nav bold"><a
									href="/hla/lectureRoom.do">강의실관리</a></span> <a
									href="/hla/lectureRoom.do" class="btn_set refresh">새로고침</a>
							</p>


							<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
							<div id="searcharea">
								<table class="col2 mb10" style="width: 1000px;">
									<colgroup>
										<col width="10%">
										<col width="60%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>
										<tr>
											<td>강의실명</td>
											<td><input style="width: 300px" id="searchword"
												name="searchword" v-model="searchword" placeholder="강의실명"
												autocomplete="off"
												onkeypress="if(event.keyCode==13) {selectqnaListvue(); return false;}"></td>
											<td><a class="btnType blue" href="javascript:reset();"
												name="modal"><span>초기화</span></a></td>
											<td><a class="btnType blue" id="SEARCH_KEYWORD"
												href="javascript:selectqnaListvue();" name="modal"><span>검색</span></a>
											</td>
											<td id="insertBtn"><a class="btnType blue"
												href="javascript:fPopModalComnGrpCod();" name="modal"><span>강의실등록</span></a></td>
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
													<col width="20%">
													<col width="20%">
													<col width="10%">
													<col width="40%">
												</colgroup>
												<thead>
													<tr>
														<th data-field="room">강의실번호</th>
														<th data-field="name">강의실명</th>
														<th data-field="size">강의실크기</th>
														<th data-field="ccount">강의실자리수</th>
														<th data-field="etc">비고</th>
													</tr>

												</thead>
												<tbody>
													<template v-for="(row, index) in items" v-if="items.length">
													<tr @click="fdetailModal(row.room)">
														<td style="text-align: center;">{{ row.room }}</td>
														<td>{{ row.name }}</td>
														<td>{{ row.room_size }}</td>
														<td>{{ row.ccount }}</td>
														<td>{{ row.etc }}</td>
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
					<strong>강의실 수정창</strong>
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
									<th scope="row">강의실번호</th>
									<td colspan="4"><input v-model="room" type="text"
										class="inputTxt p100" name="room" id="room" readonly /></td>
								</tr>
								<tr>
									<th scope="row">강의실명</th>
									<td colspan="4"><input v-model="name" type="text"
										class="inputTxt p100" name="name" id="name" /> <!-- <input
										type="hidden" v-model="seq" name="seq"> --></td>
								</tr>
								<tr>
									<th scope="row">강의실크기</th>
									<td><input class="inputTxt p100" v-model="room_size"
										name="room_size" id="room_size"></td>
								</tr>
								<tr>
									<th scope="row">강의실 자리수</th>
									<td><input
										onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
										placeholder="숫자만 입력가능합니다" class="inputTxt p100"
										v-model="ccount" name="ccount" id="ccount"></td>
								</tr>
								<tr>
									<th scope="row">비고</th>
									<td><textarea v-model="etc" name="etc" id="etc"></textarea></td>
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
					<strong>강의실 등록</strong>
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
						<tbody>
							<tr>
								<th scope="row">강의실명</th>
								<td colspan="4"><input v-model="name_save" type="text"
									class="inputTxt p100" name="name_save" id="name_save" /> <!-- <input
										type="hidden" v-model="seq" name="seq"> --></td>
							</tr>
							<tr>
								<th scope="row">강의실크기</th>
								<td><input class="inputTxt p100" v-model="size_save"
									name="size_save" id="size_save"></td>
							</tr>
							<tr>
								<th scope="row">강의실 자리수</th>
								<td><input
									onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
									placeholder="숫자만 입력가능합니다" class="inputTxt p100"
									v-model="ccount_save" name="ccount_save" id="ccount_save"></td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td><textarea v-model="etc_save" name="etc_save"
										id="etc_save"></textarea></td>
							</tr>
						</tbody>
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