
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강 목록 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.2/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.0.1/dist/vue-router.js"></script>
<script type="text/javascript">
var pageSize=10;
var pageBlock=10;

var lect;
var studentList;

//var isM = isMobile();
var isM = false;
var popperProps = {
		  popperOptions: {
		    modifiers: {
		      preventOverflow: {
		        padding: 20
		      }
		    },
		    onUpdate: function (data) {
		      console.log(JSON.stringify(data.attributes))
		    }
		  }
		};

/* onload 이벤트  */
$(function(){
	
	// 강의 리스트
	init();
	lectList();
	
});

function init() {
	lect = new Vue({
		el : '#lecture_box',
		 component : {
			'lectInfo' : lectInfo
		}, 
		data : {
			lectureListAdminList : [],
			lectureStudentList : [],
			search_name : '',
			test : '',
			selected : 'A',
			options : [
				{text : '강의번호', value : 'A'},
				{text : '강의명', value : 'B'},
				{text : '강사아이디', value : 'C'},
				{text : '강사명', value : 'D'},
				{text : '강의실', value : 'E'}
			           ]
		},
		computed : {
			filtered : function() {
				
				let sname = this.search_name.trim();
				return this.lectureListAdminList.filter((item) => {
					if(this.selected == 'A') {
						if(item.no.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'B') {
						if(item.title.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'C') {
						if(item.loginID.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'D') {
						if(item.name.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'E') {
						if(item.rname.includes(sname)) {
							return true;
						}
					} 
				});
			}
		},
		methods : {
			showPerson: function(index, no){
					 personInfo(no);
			},
			fdetailModal : function(no,loginID) {
				studentInfo(no,loginID);
			},
			restyn : function(no,seq,restyn) {
				console.log(no+" "+seq+" "+restyn);
				rest(no,seq,restyn);
			}
			
		}
	});
};
function studentInfo(no,loginID){
	console.log("studentInfo~"+no+" "+loginID);
	var param = {
			no : no
			,loginID : loginID
		};
		var resultCallback2 = function(data) {
			fdetailResult(data);
		};

		callAjax("/hla/studentInfo.do", "post", "json", true, param,
				resultCallback2);
}

function fdetailResult(data){
	console.log(data.resultMsg);
	if (data.result == "SUCCESS") {
		//모달 띄우기 
		gfModalPop("#studentInfo");
		// 모달에 정보 넣기 
		frealPopModal(data.studentInfo);
	} else {
		alert(data.resultMsg);
	}
}

function frealPopModal(object){
	var phone=object.tel1+" - "+object.tel2+" - "+object.tel3;
	console.log(phone);
	//$("#test123").val(object.loginID);
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
// 강의 전체 목록 조회
function lectList(currentPage) {
	currentPage = currentPage || 1;
	console.log("lectList~"+currentPage+" "+pageSize);
	var param={
			currentPage : currentPage,
			pageSize : pageSize
		}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		lectListCallback(data,currentPage); 
 	}
 	callAjax("/hla/lectureListAdminList.do","post","json", true, param, resultCallback);
	
}

//강의 전체 목록 조회 콜백
function lectListCallback(data,currentPage){
	//alert(JSON.stringify(data));
	lect.lectureListAdminList=[];
	lect.lectureListAdminList=data.lectureListAdminList;
	
	console.log(data.lectureListAdminCount + " : " + currentPage);
	
	var lectureListAdminCount=data.lectureListAdminCount;
	
	console.log(currentPage+" "+lectureListAdminCount+" "+pageSize+" "+pageBlock);
	
	var pagingnavi = getPaginationHtml(currentPage, lectureListAdminCount,
			pageSize, pageBlock, 'lectList');
	$("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다.
	$("#currentPage").val(currentPage);
}

// 수강중인 학생 조회
function personInfo(no,currentPage) {
	console.log("no? "+no);
	currentPage = currentPage || 1;
	 var param = {
			no : no,
			currentPage : currentPage,
			pageSize : pageSize
		 }
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		personInfoCallback(data,currentPage); 
 	}
 	callAjax("/hla/lectureStudentList.do","post","json", true, param, resultCallback);
}

//수강중인 학생 조회 콜백
function personInfoCallback(data,currentPage){
	//alert(JSON.stringify(data));
	lect.lectureStudentList=[];
	lect.lectureStudentList=data.lectureStudentList;
	
	var lectureStudentListCount=data.lectureStudentListCount;
	
	console.log(currentPage+" "+lectureStudentListCount+" "+pageSize+" "+pageBlock);
	
	var pagingnavi = getPaginationHtml(currentPage, lectureStudentListCount,
			pageSize, pageBlock, 'lectureStudentList');
	$("#pagingnavi2").empty().append(pagingnavi); // 위에꺼를 첨부합니다.
	//console.log(typeof(lectureStudentListCount));
	$("#currentPage").val(currentPage);
}

function rest(no,seq, restyn) {
	console.log("restyn~" +no+" "+ seq + " " + restyn);
	var action = $("#restyn").val("y");
	var action_param=action.val();
	var resultCallback = function(data) {
		restynResult(data);
	}
	var param = {
		no : no,
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
	
	function restynResult(data) {
		// 목록 조회 페이지 번호
		var currentPage = "1";

		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);

			// 목록 조회
			var no = data.no;
			console.log("restynResult~~" + data.no);
			personInfo(no,currentPage);
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}

}
function close(){
	$("#studentInfo").hide();
	alert("test");
}
</script>
<body>
	<input type="hidden" id="currentPage" value="1">
	<!-- 모달 배경 -->
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
					<div class="home_area">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">학습관리</a> <span class="btn_nav bold"> <a
								href="/hla/lectureListVuejs.do">수강 목록 관리</a></span> <a
								href="/hla/lectureListVuejs.do" class="btn_set refresh">새로고침</a>
						</p>
					</div>
					<h3 class="hidden">강의실 검색 영역</h3>
					<div id="lecture_box">
						<div class="lecture_searchbox">
							<div class="lecture_selectbox">
								<select v-model="selected">
									<option v-for="option in options" v-bind:value="option.value">
										{{ option.text }}</option>
								</select>
							</div>
							<div class="lecture_serch_input">
								<input type="text" name="room_search" v-model="search_name"
									placeholder="검색 내용을 입력해주세요.">
							</div>
						</div>
						<!-- /.lecture_searchbox -->

						<div class="lecture_box">
							<div class="lecture_tit_box">강의 목록</div>
							<div class="lecture_listbox">
								<table id="lectInfo">
									<thead>
										<tr>
											<th>강의번호</th>
											<th>강의명</th>
											<th>강사명</th>
											<th>강사아이디</th>
											<th>강의실</th>
											<th>수강인원</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(list, index) in filtered">
										<tr @click="showPerson(index, list.no)">
											<td>{{ list.no }}</td>
											<td>{{ list.title }}</td>
											<td>{{ list.name }}</td>
											<td>{{ list.loginID }}</td>
											<td>{{ list.rname }}</td>
											<td>{{list.pcnt}}</td>
										</tr>
										</template>
									</tbody>
								</table>
							</div>
							<div class="paging_area" id="pagingnavi"></div>
						</div>
						<!-- /.lecture_box -->

						<div>
							<div class="lecture_box">
								<div class="lecture_tit_box">학생 목록</div>
								<div class="lecture_listbox">
									<table>
										<thead>
											<tr>
												<th>강의번호</th>
												<th>강의명</th>
												<th>학생아이디</th>
												<th>학생명</th>
												<th>출석</th>
												<th>개강일</th>
												<th>종강일</th>
												<th>휴학신청</th>
											</tr>
										</thead>
										<tbody>
											<template v-for="(Slist, index) in lectureStudentList"
												v-bind:item="Slist" v-bind:index="index">
											<tr>
												<template v-if="Slist.cnt === 0">
												<td colspan="10">{{Slist.no }}번 강의를 수강하는 학생 없음</b>
												</td>
												</template>
												<template v-if="Slist.cnt > 0">
												<td>{{Slist.no }}</td>
												<td>{{ Slist.title }}</td>
												<td @click="fdetailModal(Slist.no,Slist.loginID)"><b>{{
														Slist.loginID }}</b></td>
												<td>{{ Slist.name }}</td>
												<td>{{ Slist.attend }}</td>
												<td>{{ Slist.startdate }}</td>
												<td>{{ Slist.enddate }}</td>
												<template v-if="Slist.restyn === 'y'">
												<td @click="restyn(Slist.no,Slist.seq,Slist.restyn)"><b>휴학취소</b>
												</td>
												</template> <template v-if="Slist.restyn === 'n'">
												<td @click="restyn(Slist.no,Slist.seq,Slist.restyn)"><b>휴학신청</b>
												</td>
												</template> </template>
											</tr>
											</template>
										</tbody>
									</table>
									<!-- <div class="paging_area" id="pagingnavi2"></div> -->
								</div>
								<div class="paging_area" id="pagingnavi2"></div>
								<!-- /.student_list -->
							</div>
						</div>
						<!-- /.lecture_box -->
					</div>
		</div>
	</div>


	<div id="studentInfo" class="layerPop layerType2" style="width: 600px;">
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
						<!-- <td><input id="test123" name="loginID"></td> -->
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
							<td id="joinDate" colspan="2" style="text-align: center"></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>