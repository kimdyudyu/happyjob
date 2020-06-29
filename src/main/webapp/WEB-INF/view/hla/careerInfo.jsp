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
	var studentList;

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
		careerList();
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
			$('#adminUpdate').attr('style', "display:none;"); //숨기기
		}
	}
	function reset() {
		$("#searchword").val("");
		$("#startdate").val("");
		$("#enddate").val("");
	}

	// 모달 실행
	function careerInsertModal(grp_cod) {

		// 신규 저장
		if (grp_cod == null || grp_cod == "") {

			// Tranjection type 설정
			$("#action").val("I");

			// 그룹코드 폼 초기화
			careerFormInit();

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

	/** 취업정보 폼 초기화 */
	function careerFormInit(object) {
		console.log("object~" + object);
		$("#loginID").focus();
		if (object == "" || object == null || object == undefined) {
			console.log("insert~");
			$("#loginID").val("");
			$("#name").val("");
			$("#hire_date").val("");
			$("#resign_date").val("");
			$("#cop_name").val("");
			$("input:radio[name=work_yn]:input[value='Y']").attr("checked",
					true);
			$("#loginID").focus();
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
				careerInfoInsert();
				break;
			case 'btnDeleteGrpCod':
				careerInfoDelete();
				break;
			case 'btnSaveDtlCod':
				$("#action").val("U");
				careerInfoUpdate();
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

	// 취업정보 삭제
	function careerInfoDelete() {
		if (confirm("삭제?")) {
			console.log("careerInfoDelete()~" + $("#myForm").serialize());
			var resultCallback = function(data) {
				careerDeleteResult(data);
			};

			callAjax("/hla/careerInfoDelete.do", "post", "json", true, $(
					"#myForm").serialize(), resultCallback);
		} else {
			console.log("삭제취소");
			return false;
		}
	}

	// 취업정보 삭제 콜백
	function careerDeleteResult(data) {
		console.log("fDeleteGrpCodResult~" + data.result);

		var currentPage = $("#currentPageComnGrpCod").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			careerInfo(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}

	// 취업정보 저장
	function careerInfoInsert() {
		if (confirm("저장?")) {
			// vaildation 체크
			if (!careerInfoValidation()) {
				return;
			}

			var resultCallback = function(data) {
				careerInsertResult(data);
			};
			console.log("취업정보 저장~" + $("#myForm").serialize());
			callAjax("/hla/careerInfoSave.do", "post", "json", true, $(
					"#myForm").serialize(), resultCallback);
		} else {
			return false;
		}
	}

	// 취업정보 저장 콜백 함수 */
	function careerInsertResult(data) {
		console.log("careerInsertResult~");
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
			careerInfo(currentPage);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		careerFormInit();
	}

	// 취업정보 이동
	function careerInfo(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSize
		}

		var resultCallback = function(data) {
			//flistGrpCodResult(data, currentPage);
			//location.href("/hla/")
			careerInfoReload();
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/hla/careerInfo.do", "post", "text", true, param,
				resultCallback);
	}

	function careerInfoReload() {
		location.href = "/hla/careerInfo.do";
	}
	// 취업정보 저장 Validation
	function careerInfoValidation() {

		var chk = checkNotEmpty([ /* [ "loginID_save", "아이디를 입력해 주세요." ], */
				/* [ "name_save", "학생명을 입력해 주세요" ], */[ "hire_date_save",
						"입사일을 입력해 주세요." ], [ "cop_name_save", "업체명을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	// 취업정보 수정
	function careerInfoUpdate() {
		// vaildation 체크 (유효성)
		if (!careerInfoUpdateValidation()) {
			return;
		}

		var resultCallback = function(data) {
			careerInfoDetailResult(data);
		};
		console.log("취업정보 수정~" + $("#myForm").serialize());
		callAjax("/hla/careerInfoSave.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	/** 상세코드 저장 콜백 함수 */
	function careerInfoDetailResult(data) {

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

			careerList();
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

				fdetailModal : function(seq) {
					//alert(wno);
					careerInfoDetail(seq);
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

		studentList = new Vue({
			el : '#layer1',
			data : {
				items : [],
				options : {
				//  paginated:"paginated"
				}
			},
			methods : {
				studentName : function(loginID) {
					alert(loginID);
					//careerInfoDetail(seq);
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

	// 취업정보 수정 유효성검사
	function careerInfoUpdateValidation() {

		var chk = checkNotEmpty([ [ "hire_date_d", "입사일을 입력해 주세요." ],
				[ "cop_name_d", "업체명을 입력해 주세요." ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/* 취업정보 리스트 불러오기  */
	function careerList(currentPage) {

		currentPage = currentPage || 1; // or		
		//svm.stitle = "55555555555";

		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		//var searchkey = $("#searchkey").val();
		var searchword = $("#searchword").val();
		console.log(currentPage + " " + searchword + " " + startdate + " "
				+ enddate + " ");
		var param = {
			currentPage : currentPage,
			pageSize : qnaPageSizevue,
			startdate : startdate,
			enddate : enddate,
			searchword : searchword
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			gridinit(data, currentPage);
		}

		callAjax("/hla/careerInfoList.do", "post", "json", true, param,
				resultCallback);

	}

	/* 공지사항 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	function gridinit(data, currentPage) {
		//console.log("qnaListResult2 data : " + JSON.stringify(qnaList));
		//console.log("qnaListResult2 qnaList : " + JSON.stringify(data.qnaList));

		vm.items = [];
		vm.items = data.careerInfoList;
		//console.log("vm.items~"+vm.items);
		console.log(data.totalCnt + " : " + currentPage);

		studentList.items = [];
		studentList.items = data.studentList;
		console.log(data.studentList);
		// 리스트의 총 개수를 추출합니다. 
		//var totalCnt = $data.find("#totalCnt").text();
		var totalCnt = data.totalCnt; // qnaRealList() 에서보낸값 
		//alert("totalCnt 찍어봄!! " + totalCnt);

		// * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
		// function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		// 파라미터를 참조합시다. 
		//var list = $("#tmpList").val();
		//var listnum = $("#tmpListNum").val();
		console.log(currentPage + " " + totalCnt + " " + qnaPageSizevue + " "
				+ qnaPageBlock);
		var pagingnavi = getPaginationHtml(currentPage, totalCnt,
				qnaPageSizevue, qnaPageBlock, 'careerList');

		//console.log("pagingnavi : " + pagingnavi);
		// 비운다음에 다시 append 
		$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 

		// 현재 페이지 설정 
		$("#currentPage").val(currentPage);
	}

	/*공지사항 상세 조회*/
	function careerInfoDetail(seq) {
		//alert("공지사항 상세 조회  ");
		console.log("seq~" + seq);
		var param = {
			seq : seq
		};
		var resultCallback2 = function(data) {
			fdetailResult(data);
		};

		callAjax("/hla/careerInfoDetail.do", "post", "json", true, param,
				resultCallback2);
		//alert("공지사항 상세 조회  22");
	}

	/*  공지사항 상세 조회 -> 콜백함수   */
	function fdetailResult(data) {

		console.log("~" + data.result);
		console.log("~~" + data.resultMsg);
		console.log("~~~" + data.careerInfoListDetail);
		//alert("공지사항 상세 조회  33");
		if (data.resultMsg == "SUCCESS") {
			//모달 띄우기 
			gfModalPop("#qnavue");

			// 모달에 정보 넣기 
			frealPopModal(data.careerInfoListDetail);

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
			var test123;
			for ( var test in object) {
				test123 = object[test]
			}
			console.log(test123);
			dqnaVue.seq = object.seq;
			dqnaVue.loginID = object.loginID;
			console.log("dqnaVue.loginID~" + dqnaVue.loginID);
			dqnaVue.name = object.name;
			dqnaVue.hire_date = object.hire_date;
			dqnaVue.resign_date = object.resign_date;
			dqnaVue.cop_name = object.cop_name;
			dqnaVue.work_yn = object.work_yn;

			dqnaVue.select_wno = object.wno;
			//dqnaVue.select_cmnt_level = object.cmnt_level;
			//dqnaVue.select_upper_wno = object.upper_wno;

			//console.log(object.wno);
			$("#nt_novue").val(object.seq); // 중요한 num 값도 숨겨서 받아온다. 
			// 		 $("#select_wno").val(object.wno); //위 값과 중복
			//$("#select_cmnt_level").val(object.cmnt_level);
			//$("#select_upper_wno").val(object.select_upper_wno);

			//$("#btnDeleteqna").show(); // 삭제버튼 보이기 
			//$("#btnSaveqna").hide();
			//$("#btnUpdateqna").css("display","");
			//if문써서 로그인 아이디 == 작성자 아이디 일치시  --- 추가하기 
			//$("#grp_cod").attr("readonly", false);  // false, true(읽기만)로 수정
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
									class="btn_nav">취업관리</a> <span class="btn_nav bold"><a
									href="/hla/careerInfo.do">취업정보</a></span> <a href="/hla/careerInfo.do"
									class="btn_set refresh">새로고침</a>
							</p>


							<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
							<div id="searcharea">
								<table class="col2 mb10" style="width: 1000px;">
									<colgroup>
										<col width="10%">
										<col width="35%">
										<col width="10%">
										<col width="25%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>
										<tr>
											<td>회사명</td>
											<td><input id="searchword" name="searchword"
												v-model="searchword" placeholder="회사명" autocomplete="off"
												onkeypress="if(event.keyCode==13) {careerList(); return false;}"></td>
											<td>취업일</td>
											<td align="center">
												<div class="input-group date" style="width: 150px;">
													<input v-model="hire_date" id="startdate" name="startdate"
														type="text" class="form-control" v-model="startdate"
														data-date-format='yyyy-mm-dd' autocomplete="off"
														onkeypress="if(event.keyCode==13) {careerList(); return false;}" />
													<span><b>&nbsp; ~ &nbsp;</b></span> <input
														v-model="resign_date" id="enddate" name="enddate"
														type="text" class="form-control" v-model="enddate"
														data-date-format='yyyy-mm-dd' autocomplete="off"
														onkeypress="if(event.keyCode==13) {careerList(); return false;}" />
												</div>
											</td>
											<td><a class="btnType blue" href="javascript:reset();"
												name="modal"><span>초기화</span></a></td>
											<td><a class="btnType blue" id="SEARCH_KEYWORD"
												href="javascript:careerList();" name="modal"><span>검색</span></a>
											</td>
											<td id="insertBtn"><a class="btnType blue"
												href="javascript:careerInsertModal();" name="modal"><span>신규등록</span></a></td>
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
													<col width="20%">
													<col width="20%">
													<col width="10%">
												</colgroup>
												<thead>
													<tr>
														<th data-field="seq">번호</th>
														<th data-field="name">학생명</th>
														<th data-field="hire_date">입사일</th>
														<th data-field="resign_date">퇴사일</th>
														<th data-field="cop_name">업체명</th>
														<th>재직여부</th>
													</tr>

												</thead>
												<tbody>
													<template v-for="(row, index) in items" v-if="items.length">
													<tr @click="fdetailModal(row.seq)">
														<td style="text-align: center;">{{ row.seq }}</td>
														<td>{{ row.name }}</td>
														<td>{{ row.hire_date }}</td>
														<td>{{ row.resign_date }}</td>
														<td>{{ row.cop_name }}</td>
														<template v-if="row.work_yn === 'Y'">
														<td>재직</td>
														</template>
														<template v-if="row.work_yn === 'N'">
														<td>퇴사</td>
														</template>
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
					<strong>취업정보 수정창</strong>
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
									<th scope="row">번호</th>
									<td colspan="4"><input readonly v-model="seq" type="text"
										class="inputTxt p100" name="seq" id="seq_d" /> <!-- <input
										type="hidden" v-model="seq" name="seq"> --></td>
								</tr>
								<tr>
									<th scope="row">아이디</th>
									<td><input readonly v-model="loginID" type="text"
										class="inputTxt p100" name="loginID" id="loginID_d" /></td>
									<th scope="row">학생명</th>
									<td><input readonly v-model="name" type="text"
										class="inputTxt p100" name="name" id="name_d" /></td>
								</tr>
								<tr>
									<th scope="row">입사일</th>
									<td><input v-model="hire_date"
										data-date-format='yyyy-mm-dd' autocomplete="off" type="text"
										class="inputTxt p100" name="hire_date" id="hire_date_d" /></td>
									<th scope="row">퇴사일</th>
									<td><input v-model="resign_date" id="resign_date_d"
										data-date-format='yyyy-mm-dd' autocomplete="off" type="text"
										class="inputTxt p100" name="resign_date" /></td>
								</tr>
								<tr>
									<th scope="row">업체명</th>
									<td><input v-model="cop_name" type="text"
										class="inputTxt p100" name="cop_name" id="cop_name_d" /></td>
									<th scope="row">재직여부</th>
									<td colspan="3"><input type="radio" name="work_yn"
										value='Y' v-model="work_yn" /> <label for="radio1-1">입사</label>
										&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="work_yn"
										value="N" v-model="work_yn" /> <label for="radio1-2">퇴직</label></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn_areaC mt30">
						<div id="adminUpdate">
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
					<strong>취업정보 등록</strong>
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
								<th scope="row">아이디</th>
								<td style="text-align: center;"><select name="loginID_save">
										<option v-for="(row, index) in items" v-if="items.length">
											{{ row.loginID}}</option>
								</select></td>
								<!-- <td> <input type="text" class="inputTxt p100"
									name="loginID_save" id="loginID" /></td> -->
								<th scope="row">학생명</th>
								<td><select name="name_save">
										<option v-for="(row, index) in items" v-if="items.length">
											{{ row.name}}</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">입사일</th>
								<td><input data-date-format='yyyy-mm-dd' autocomplete="off"
									type="text" class="inputTxt p100 hire_date"
									name="hire_date_save" id="hire_date" v-model="hire_date" /></td>
								<th scope="row">퇴사일</th>
								<td><input data-date-format='yyyy-mm-dd' autocomplete="off"
									type="text" class="inputTxt p100 resign_date"
									name="resign_date_save" id="resign_date" v-model="resign_date" /></td>
							</tr>
							<tr>
								<th scope="row">업체명</th>
								<td><input type="text" class="inputTxt p100"
									name="cop_name_save" id="cop_name" v-model="cop_name" /></td>

								<th scope="row">재직<br>여부
								</th>
								<td><input type="radio" id="radio1-1" name="work_yn_save"
									id="work_yn" value='Y' v-model="work_yn" /> <label
									for="radio1-1">입사</label>&nbsp;&nbsp;&nbsp;&nbsp;<input
									v-model="work_yn" type="radio" id="radio1-2"
									name="work_yn_save" id="work_yn2" value="N" /> <label
									for="radio1-2">퇴직</label></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveGrpCod" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>