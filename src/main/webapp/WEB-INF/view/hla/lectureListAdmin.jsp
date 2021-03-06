<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강 목록 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	//페이징입니다.
	var pageSizelist = 10;
	var pageBlockSizelist = 10;

	//유저페이징입니다.
	var pageSizeDtlList = 5;
	var pageBlockSizeDtlList = 5;
	//ON LOAD EVENT****
	$(function() {
		lectureListAdminList();

		fRegisterButtonClickEvent();
	});
	
	function studentInfo(no,loginID){
		console.log("studentInfo~"+no+" "+loginID);
		var param = {
				no : no,
				loginID : loginID
			};

			var resultCallback = function(data) {
				studentInfoResult(data);
			};

			callAjax("/hla/studentInfo.do", "post", "json", true, param,
					resultCallback);
	}
	
	function studentInfoResult(data){
		
		if (data.result == "SUCCESS") {

			gfModalPop("#studentInfo");
			
			studentInfoForm(data.studentInfo);

		} else {
			alert(data.resultMsg);
		}
	}
	function studentInfoForm(object){
		console.log(object.loginID);
		var phone=object.tel1+" - "+object.tel2+" - "+object.tel3;
		document.getElementById("loginID").innerHTML=object.loginID;
		document.getElementById("name").innerHTML=object.name;
		document.getElementById("birthday").innerHTML=object.birthday;
		document.getElementById("sex").innerHTML=object.sex;
		document.getElementById("hp").innerHTML=object.hp;
		document.getElementById("phone").innerHTML=phone;
		document.getElementById("area").innerHTML=object.area;
		document.getElementById("email").innerHTML=object.email;
		document.getElementById("joinDate").innerHTML=object.joinDate;
	}
	
	function restyn(seq, restyn) {
		console.log("restyn~" + seq + " " + restyn);
		var action = $("#restyn").val("y");
		var action_param=action.val();
		var resultCallback = function(data) {
			restynResult(data);
		}
		var param = {
			seq : seq,
			restyn : restyn,
			action_param : action_param
		}
		if (restyn == "y") {
			if (confirm("휴학취소?")) {
				console.log("휴학취소~");
				callAjax("/hla/restyn.do", "post", "json", true, param,
						resultCallback);
			} else {
				return false;
			}
		} else {
			if (confirm("휴학신청?")) {
				callAjax("/hla/restyn.do", "post", "json", true, param,
						resultCallback);
			} else {
				return false;
			}
		}

	}

	function restynResult(data) {
		// 목록 조회 페이지 번호
		var currentPage = "1";

		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);

			// 목록 조회
			var no = $("#tmpLecSeq").val();
			var grp_cod_nm = $("#tmpGrpCodNm").val();
			console.log("restynResult~" + no);
			fcnsUserList(currentPage, no);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}

	function restynCancleResult() {

	}

	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fSaveUserList();
				break;
			case 'btnCloseGrpCod':
				gfCloseModal();
				break;
			case 'btnDeleteClist':
				fDeleteClist();
				break;
			case 'btnCloseDtlCod':
				gfCloseModal();
				break;
			}
		});
	}
	//키 다운
	function enterKey() {

		if (event.keyCode == '13') {
			lectureListAdminList();
		}
	}

	//과정 리스트
	function lectureListAdminList(currentPage) {

		var searchKey = $("#searchKey").val();
		var searchWord = $("#searchWord").val();
		console.log(searchKey + " " + searchWord);
		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizelist,
			searchKey : searchKey,
			searchWord : searchWord
		}

		var resultCallback = function(data) {

			fcnsListResult(data, currentPage);
		};

		callAjax("/hla/lectureListAdminList.do", "post", "text", true, param,
				resultCallback);
	}
	//과정콜백
	function fcnsListResult(data, currentPage) {
		$('#list').empty();
		var $data = $($(data).html());

		var $list = $data.find('#list');
		$('#list').append($list.children());

		var $lectureListAdminCount = $data.find('#list');
		var lectureListAdminCount = $lectureListAdminCount.text();
		console.log(lectureListAdminCount);
		console.log(currentPage + " " + /* lectureListAdminCount */+" "
				+ pageSizelist + " " + pageBlockSizelist);
		var paginationHtml = getPaginationHtml(currentPage, 12, 10,
				pageBlockSizelist, 'lectureListAdminList');
		console.log(paginationHtml);
		$("#listPagiNation").empty().append(paginationHtml);
		$("#currentPagelist").val(currentPage);

	}
	// 학생 목록
	function fcnsUserList(currentPage, no) {
		console.log(no);
		currentPage = currentPage || 1;

		$("#tmpLecSeq").val(no);
		$("#tmpLecNm").val(no);

		var param = {
			no : no,
			currentPage : currentPage,
			pageSize : pageSizeDtlList
		}

		var resultCallback = function(data) {

			fcnsUserListResult(data, currentPage);
		};

		callAjax("/hla/lectureStudentList.do", "post", "text", true, param,
				resultCallback);
	}
	//유저 뽑기 콜백
	function fcnsUserListResult(data, currentPage) {
		$('#cnsUserDtlList').empty();
		var $data = $($(data).html());

		var $cnsUserDtlList = $data.find("#cnsUserDtlList");
		$("#cnsUserDtlList").append($cnsUserDtlList.children());

		var $totalCntDtlList = $data.find('#totalCntDtlList');
		var totalCntDtlList = $totalCntDtlList.text();

		var lec_seq = $("#tmpLecSeq").val();
		var lec_nm = $("#tmpLecNm").val();
		console.log(currentPage + " " + totalCntDtlList + " " + pageSizeDtlList
				+ " " + pageBlockSizelist);
		var paginationHtml = getPaginationHtml(currentPage, totalCntDtlList,
				pageSizeDtlList, pageBlockSizelist, 'fcnsUserList');
		$("#listDtlPagiNation").empty().append(paginationHtml);

		$("#currentPageDtlList").val(currentPage);
	}
	//유저모달 실행
	function fPopModalUserList(cns_seq, loginId, lecNm) {
		$("#cns_seq").val("");
		$("#cns_date").val("");
		$("#cns_place").val("");
		$("#cns_cstnt").val("");
		$("#cns_cstee").val(loginId);
		$("#task_tm").val("");
		$("#enr_user").val("");
		$("#enr_date").val("");
		$("#upd_user").val("${sessionScope.loginId}");
		$("#upd_date").val("");
		$("#cns_check").val("");
		$("#cns_content").val("");
		$("#cns_nm").val(lecNm);

		var lec_nm = $("#tmpLecNm").val();

		$("#cns_nm").val(lec_nm);
		gfModalPop("#layer1");
	}
	//단건 유저 뽑기
	function fSelectDtlCns(loginID, lec_seq) {

		alert(loginID, lec_seq);
		var param = {
			lec_seq : lec_seq,
			loginID : loginID
		};
		var resultCallback = function(data) {
			fSelectDtlCnsResult(data);
		};

		callAjax("/mss/selectUserList.do", "post", "json", true, param,
				resultCallback);
	}
	//단건 유저 뽑기 콜백
	function fSelectDtlCnsResult(data) {
		if (data.result == "SUCCESS") {
			console.log(data.cnsList);
			gfModalPop("#layer2");

			//fInitFormaPlist(data.cnsList);
		} else {
			alert("실패");
		}
	}
	//코드 저장띠
	function fSaveUserList() {

		$("#action").val("I");
		if (!fValidateUserList()) {
			return;
		}

		var resultCallback = function(data) {
			fSaveUserListResult(data);
		};

		callAjax("/mss/saveUserList.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	//그룹코드 저장띠 콜백
	function fSaveUserListResult(data) {

		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageDtlList").val();
		}

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);

			gfCloseModal();

			var lec_seq = $("#tmpLecSeq").val();
			var lec_nm = $("#tmpLecNm").val();
			fcnsUserList(currentPage, lec_seq, lec_nm);

		} else {

			alert(data.resultMsg);
		}
		fInitFormlist();
	}

	//유저리스트 저장 validation
	function fValidateUserList() {

		var chk = checkNotEmpty([ [ "cns_cotent", "상담내용을 입력하세요." ],
				[ "cns_nm", "강의명을 입력해주세요." ], ]);
		if (!chk) {
			return;
		}
		return true;
	}
	//상담삭제

	function fDeleteClist() {

		var resultCallback = function(data) {
			fDeleteClistResult(data);
		};
		callAjax("/mss/deleteClist.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	function fDeleteClistResult(data) {

		var currentPage = $("#currentPagelist").val();

		if (data.result == "SUCEESS") {
			alert(data.resultMsg);

			gfCloseModal();

			lectureListAdminList(currentPage, searchWord);
		}
	}
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPagelist" value="1"> <input
			type="hidden" id="currentPageDtlList" value="1"> <input
			type="hidden" id="tmpLecSeq" value=""> <input type="hidden"
			id="tmpLecNm" value=""> <input type="hidden" id="action"
			name="action" value=""> <input type="hidden" id="restyn"
			name="restyn" value="">

		<div id="mask"></div>
		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb"><jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3>

						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습관리</a> <span class="btn_nav bold"> <a
									href="/hla/lectureListAdmin.do">수강 목록 관리</a></span> <a
									href="/hla/lectureListAdmin.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="search">
								<select id="searchKey">
									<option value="lecture_no">강의번호</option>
									<option value="lecture_title">강의명</option>
									<option value="lecture_id">강사아이디</option>
									<option value="lecture_name">강사명</option>
									<option value="lecture_room">강의실</option>
								</select> <input
									onkeypress="if(event.keyCode==13) {lectureListAdminList(); return false;}"
									type="text" id="searchWord" name="searchWord" placeholder=""
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:lectureListAdminList()" onkeydown="enterKey()"
									name="search"><span id="searchEnter">검색</span></a>
							</p>
							<p class="conTitle">
								<span id="">강의 목록</span>
							</p>

							<div class="divlist">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">강사명</th>
											<th scope="col">강사아이디</th>
											<th scope="col">강의실</th>
											<th scope="col">수강인원</th>
										</tr>
									</thead>
									<tbody id="list"></tbody>
								</table>
							</div>
							<div class="paging_area" id="listPagiNation"></div>

							<p class="conTitle mt50">
								<span>학생목록</span><span class="fr"> </span>
							</p>

							<div class="divCnsUserDtlList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">학생아이디</th>
											<th scope="col">학생명</th>
											<th scope="col">출석</th>
											<th scope="col">개강일</th>
											<th scope="col">종강일</th>
											<th scope="col">휴학신청</th>
										</tr>
									</thead>
									<tbody id="cnsUserDtlList">
										<tr>
											<td colspan="12">강의를 선택해주세요</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="paging_area" id="listDtlPagiNation"></div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>수강상담관리등록</strong>
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
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
								<th scope="row">상담과목 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="cns_nm"
									id="cns_nm" /> <input type="hidden" class="inputTxt p100"
									name="cns_seq" id="cns_seq" /></td>
								<th scope="row">상담장소</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="cns_place" id="cns_place" /></td>
							</tr>
							<tr>
								<th scope="row">상담자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="cns_cstnt" id="cns_cstnt" />
								<th scope="row">대상자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="cns_cstee" id="cns_cstee" /></td>
							</tr>
							<tr>
								<th scope="row">상담일자 <span class="font_red"></span></th>
								<td colspan="3"><input type="date" class="inputTxt p100"
									name="cns_date" id="cns_date" style="font-size: 15px" />
							</tr>
							<tr>
								<th scope="row">등록자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="enr_user" id="enr_user" />
								<th scope="row">수정자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="upd_user" id="upd_user" /></td>

							</tr>
							<tr>
								<th scope="row">상담내용 <span class="font_red">*</span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="cns_content" id="cns_content"
										placeholder="상담 내용을 입력하세요." /></textarea></td>
							</tr>

							<tr>
								<th scope="row">확인여부 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="cns_check" id="cns_check" style="font-size: 15px" />
							</tr>
					</table>


					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteClist" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		<div id="studentInfo" class="layerPop layerType2"
			style="width: 600px;">
			<dl>
				<dt>
					<strong>학생 정보</strong>
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
								<th>아이디</th>
								<td id="loginID"></td>
								<th>이름</th>
								<td id="name"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td id="birthday"></td>
								<th>성별</th>
								<td id="sex"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td id="hp"></td>
								<th>폰번호</th>
								<td id="phone"></td>
							</tr>
							<tr>
								<th>사는곳</th>
								<td id="area"></td>
								<th>이메일</th>
								<td id="email"></td>
							</tr>
							<tr>
								<th colspan="2">가입일자</th>
								<td id="joinDate"></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>