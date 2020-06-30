
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강상담이력(관리자)</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.2/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router@3.0.1/dist/vue-router.js"></script>

<style>
td:hover {
	cursor: pointer;
}
</style>


<script type="text/javascript">
var pageSize=10;
var pageBlock=10;
var lect;
var cnsv;
var cnsdetailvue;
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
	$('#insert_button').hide();
});
function init2(){

	}
function init() {
	$('#insert_button').hide();
	lect = new Vue({
		el : '#lecture_box',
		 component : {
			'lectInfo' : lectInfo
		}, 
		data : {
			lectList : [],
			studentList : [],
			search_name : '',
			test : '',
			selected : 'A',
			cns : [],
			options : [
				{text : '강의번호', value : 'A'},
				{text : '강의명', value : 'B'},
				{text : '강사아이디', value : 'C'}/* ,
				{text : '강사명', value : 'D'},
				{text : '강의실명', value : 'E'} */
			           ]
		},
		computed : {
			filtered : function() {
				
				let sname = this.search_name.trim();
				return this.lectList.filter((item) => {
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
					} /* else if (this.selected == 'D') {
						if(item.name.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'E') {
						if(item.rm_seq.includes(sname)) {
							return true;
						}
					} */ 
				});
			}
		},
		methods : {
			showPerson: function(index, no){
				
				if(this.test == null || this.test == '') {
					 this.test = index+1;
					
					personInfo(no);
				} else if (this.test == index+1 ) {
					this.test = '';
					/* $('.hide_tr').hide(); */
				} else {
					this.test = index+1;
					/* $('.hide_tr').hide(); */
					/* $('#showPerson_'+index).show(); */
					 personInfo(no);
				}
			},
			showCns : function(loginID,no) {
				console.log("학생클릭타나요");
			    $('#insert_button').show();
			    cnsv.no = no;
			    cnsv.loginID=loginID;
				if(loginID!=null){
					console.log("loginID 찍어보자"+loginID);
					console.log("no 찍어보자"+no);
					showCns2(loginID,no);
					
				}else{
					alert("없습니다.")
				}
				
			}
			
		}
	});
	/* 상담이력 뽑 */
	cnsv = new Vue({
		el : '#cnsbox',
			
			data : {
				cnsq : [],
				cnsd : [],
				no :'',
				loginID:''
			},
			methods : {
				showCnsDetail : function(cnsNo){
					
					cnsDetail(cnsNo);
					
				},
				insertCns : function(no,loginID,lec_name,cns_name){
					console.log(no+" 등록 눌렀을 때 "+loginID);
					cnsInsert(no,loginID,lec_name,cns_name);
				}
			}
	});
	/* 상담내용 뽑 */
	cnsdetailvue = new Vue({
		el : '#cnsdetailveudiv',
			
			data : {
				lec_name : '',
				cns_name : '',
				regId : '',
				reg_date : '',
				counsel : '',
				userId : '',
				cnsNo : '',
				no	: ''
				
			},
			methods :{
				updateCns : function(counsel,regId,cnsNo){
					console.log(loginID);
					fupdateCns(counsel,regId,cnsNo);
				}
				
			}
	});
	
	/* 상담내용 등록 */
	cnsdetailvue2 = new Vue({
		el : '#cnsdetailveudiv2',
			
			data : {
				lec_name : '',
				cns_name : '',
				regId : '',
				reg_date : '',
				counsel : '',
				userId : '',
				cnsNo : '',
				no	: '',
				loginID : ''
			
			},
			methods :{
				insertCns2 : function(e){
					e.preventDefault();
					console.log(this.lec_name);
					console.log(this.cns_name);
				
					console.log(this.no);
					console.log(this.loginID);
					finsertCns(e);
				}
				
			}
	});

};
	

// 강의 전체 목록 조회
function lectList(currentPage) {
	console.log("여기왔나요? ");
	currentPage = currentPage || 1;
	var param={
			currentPage : currentPage,
			pageSize : pageSize
		}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		console.log("여기왔나요? -2 ");
		lectListCallback(data,currentPage); 
 	}
 	callAjax("/hla/lectListAct.do","post","json", true, param, resultCallback);
	
}

//강의 전체 목록 조회 콜백
function lectListCallback(data,currentPage){
	//alert(JSON.stringify(data));
	lect.lectList=[];
	lect.lectList=data.lectList;
	
	console.log(lect.lectList);
   var lecListCount = data.lecListCount;
   console.log(currentPage+" "+lecListCount+" "+pageSize+" "+pageBlock);
   var pagingnavi = getPaginationHtml(currentPage, lecListCount,
			pageSize, pageBlock, 'lectList');
   console.log("lecListCount 찍기"+lecListCount);
   
   $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다.
	$("#currentPage").val(currentPage);
}

// 수강중인 학생 조회
function personInfo(no) {
	console.log("no? "+no);
	
	 var param = {
			 no : no
		 }
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		personInfoCallback(data); 
 	}
 	callAjax("/hla/lectPeopleInfo.do","post","json", true, param, resultCallback);
	
}

//수강중인 학생 조회 콜백
function personInfoCallback(data){
	//alert(JSON.stringify(data));
	$('#insert_button').hide();
	lect.studentList=[];
	lect.studentList=data.lectPeopleInfo;
	//강의 번호를 3번째 학생상담이력 테이블에 값 보내주기
/* 	cnsv.cnsq=[];
	if(data.lectPeopleInfo[0].no!=''){
		cnsv.no=data.lectPeopleInfo[0].no;
		console.log("강의 번호를 3번째 학생상담이력 테이블에 값 보내주기"+cnsv.no);
		console.log("강의 번호를 3번째 학생상담이력 테이블에 값 보내주기"+data.lectPeopleInfo[0].no);
		console.log("lect.studentList"+lect.studentList);
	  	
	}else if(data.lectPeopleInfo[0].no==''){
		cnsv.cnsq
	}
		 */	
			
	
}

//학생의 상담이력 조회
function showCns2(loginID,no){
	console.log("상담이력조회오나요");
	var param = {
			loginID : loginID
	}
	
	var resultCallback = function(data){
		studentCnsInfoCallback(data);
	}
	callAjax("/hla/studentCnsInfo.do", "post", "json", true, param, resultCallback);
	
}

function studentCnsInfoCallback(data){
	console.log("상담이력콜백타나요");
	cnsv.cnsq=[];
	cnsv.cnsq=data.studentCnsInfo;
	console.log(data);
	console.log("data.studentCnsInfo : "+data.studentCnsInfo);
  	console.log("cnsv.cnsq = "+cnsv.cnsq);
  	console.log("cnsv"+cnsv);
  	console.log(cnsv.cnsq);
  	console.log(data.studentCnsInfo);
  	
}







//학생의 상담내용 조회
function cnsDetail(cnsNo){
	console.log("상담상세내용조회오나요");
	var param = {
			cnsNo : cnsNo
	}
	
	var resultCallback = function(data){
		cnsDetailCallback(data);
	}
	callAjax("/hla/cnsDetail.do", "post", "json", true, param, resultCallback);
	
}
//학생 상담내용 resultcallback
function cnsDetailCallback(data){
	console.log("상담내용정보가져옴 ?")
	/* cnsdetailvue.cnsdata=[];
	cnsdetailvue.cnsdata=data.cnsDetail;
	console.log(data.cnsDetail);
	console.log(cnsdetailvue.cnsdata);
	
	console.log(data.cnsDetail[0].regId);
	console.log(cnsdetailvue.cnsdata[0].regId); */
	cnsdetailvue.lec_name = data.cnsDetail[0].title;
	cnsdetailvue.cns_name = data.cnsDetail[0].name;
	cnsdetailvue.regId = data.cnsDetail[0].regId;
	cnsdetailvue.reg_date = data.cnsDetail[0].reg_date;
	cnsdetailvue.counsel = data.cnsDetail[0].counsel;
	cnsdetailvue.userId = 'admin';
	cnsdetailvue.cnsNo = data.cnsDetail[0].cnsNo;
	cnsdetailvue.loginID = data.cnsDetail[0].loginID;
	console.log("ttttttttttttttttt");
	console.log(cnsdetailvue.lec_name);
	console.log(data.cnsDetail[0].title);
	gfModalPop("#layer1");
	for( var k in data.cnsDetail){
		console.log("k : "+ k + " value : " + data.cnsDetail[k]);
	}
}
//상담내용 insert
function cnsInsert(no,loginID,lec_name,cns_name){
	console.log("상담등록");
	
	console.log(no);
	console.log(loginID);
	cnsdetailvue2.no = no;
	cnsdetailvue2.loginID = loginID;
	cnsdetailvue2.lec_name = lec_name;
	cnsdetailvue2.cns_name = cns_name;
	console.log(cnsdetailvue2.no);
	console.log(cnsdetailvue2.loginID);
	
	console.log(cnsdetailvue2.lec_name);
	console.log(cnsdetailvue2.cns_name);
		gfModalPop("#layer2");
		
	
	
}


//상담내용 업데이트
function fupdateCns(counsel,regId,cnsNo){
	console.log("업데이트 저장 버튼 오나요");
	console.log(cnsdetailvue.$data);
	var resultCallback = function(data){
		
		alert(data.msg);
		gfCloseModal();
	}
	
	callAjax("/hla/updateCns.do", "post", "json", true, cnsdetailvue.$data, resultCallback);
}

//상남내용 신규 insert
function finsertCns(e){
	console.log("상담내용 신규 등록");
	console.log(cnsdetailvue2.$data);
	var resultCallback = function(data){
		
		alert(data.msg);
		gfCloseModal();
	}
	callAjax("/hla/insertCns.do","post","json",true, cnsdetailvue2.$data, resultCallback);
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
							<a href="#" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">수강인원 확인</span> <a href="#"
								class="btn_set refresh">새로고침</a>
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
											<th>강사아이디</th>
											<th>강의시작일</th>
											<th>강의종료일</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(list, index) in filtered">
										<tr @click="showPerson(index, list.no)">

											<td>{{ list.no }}</td>
											<td>{{ list.title }}</td>
											<td>{{ list.loginID }}</td>
											<td>{{ list.st_date }}</td>
											<td>{{ list.ed_date }}</td>
										</tr>

										<!-- /.lecturerinfor_box --> </template>
									</tbody>
								</table>
								<div class="paging_area" id="pagingnavi"></div>
								<div class="" id="lecture_box">

									<div class="lecture_tit_box">수강학생 목록</div>
									<table id="lectInfo">
										<thead>
											<tr>
												<th>과목명</th>
												<th>학생이름</th>
												<th>주소</th>
												<th>이메일</th>
											</tr>
										</thead>
										<tbody>
											<template v-for="(Slist, index) in studentList"
												v-bind:item="Slist" v-bind:index="index">
											<tr @click="showCns(Slist.loginID,Slist.no)">
												<td>{{ Slist.title }}</td>
												<td>{{ Slist.name }}</td>
												<td>{{ Slist.area }}</td>
												<td>{{ Slist.email }}</td>
											</tr>
											</template>
										</tbody>
									</table>

									<!-- /.student_list -->
								</div>
							</div>
						</div>

						<!-- /.lecture_box -->
					</div>
					<div class="lecture_box2" id="cnsbox" style="margin-bottom: 10em;">
						<div class="lecture_tit_box">
							학생 상담 이력
							<div id="insert_button">
								<a id="insertbutton" href=""
									style="float: right; margin-bottom: 20px;" class="btnType blue"
									@click.prevent="insertCns(no,loginID,lec_name,cns_name)"><span>등록</span></a>
							</div>
						</div>
						<div class="lecture_listbox">
							<table id="cnsInfo">
								<thead>
									<tr>
										<th>상담 번호</th>
										<th>학생이름</th>
										<th>상담일자</th>
										<th>상담자</th>
										<th>아이디</th>
									</tr>
								</thead>
								<tbody>
									<template v-for="Cnslist in cnsq">
									<tr @click="showCnsDetail(Cnslist.cnsNo)">
										<td>{{Cnslist.no}}</td>
										<td>{{ Cnslist.name }}</td>
										<td>{{ Cnslist.reg_date }}</td>
										<td>{{ Cnslist.regId }}</td>
										<td>{{Cnslist.loginID}}</td>
									</tr>

									</template>
								</tbody>
							</table>
						</div>
					</div> <!-- /.student_list -->

				</li>
			</ul>
		</div>
	</div>
	<!--==================================================================================================  -->
	<!-- 모달팝업 -->

	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<div id='cnsdetailveudiv'>
			<input type="hidden" id="cnsNo" name="cnsNo" v-model="cnsNo">
			<dl>
				<dt>
					<strong>수강상담관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<!-- 	<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
 -->
						<tbody>
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
								<th scope="row">강의명</th>
								<td><input type="text" class="inputTxt p100" name="lec_nm"
									id="lec_nm" v-model='lec_name' readonly="readonly" /></td>

								<!-- <th scope="row">상담장</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								v-model="cns_place" name="cns_place" id="cns_place"
								readonly="readonly" /></td> -->
							</tr>
							<tr>
								<th scope="row">대상자<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="cns_name" id="cns_name" v-model='cns_name'
									readonly="readonly" /></td>
								<th scope="row">상담사</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="regId" id="regId" v-model='regId' /></td>
							</tr>
							<tr>
								<th scope="row">상담일자 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100"
									name="reg_date" id="reg_date" v-model='reg_date'
									style="font-size: 15px" />
							</tr>
							<tr>
								<th scope="row">상담내용 <span class="font_red"></span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="counsel" id="counsel" v-model='counsel'
										placeholder="상담 내용을 입력하세요." /></textarea></td>
							</tr>

							<tr>
								<th scope="row">등록자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="userID"
									id="userID" v-model='userId' readonly='readonly'
									style="font-size: 15px" />
							</tr>
					</table>


					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" @click.prevent="updateCns"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</div>

	<!-- 모달팝업2 -->

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<div id='cnsdetailveudiv2'>
			<input type="hidden" id="cnsNo" name="cnsNo" v-model="cnsNo">
			<input type="hidden" id="no" name="no" v-model="no" >
			<input type="hidden" id="loginID" name="loginID" v-model="loginID">
			<dl>
				<dt>
					<strong>수강상담관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<!-- 	<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
 -->
						<tbody>
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
								<th scope="row">강의명</th>

								<td><input type="text" class="inputTxt p100" name="lec_name"
									id="lec_name" v-model='lec_name' /></td>

								<!-- <th scope="row">상담장</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								v-model="cns_place" name="cns_place" id="cns_place"
								readonly="readonly" /></td> -->
							</tr>
							<tr>
								<th scope="row">대상자<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="cns_name" id="cns_name" v-model='cns_name' /></td>
								<th scope="row">상담사</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="regId" id="regId" v-model='regId' /></td>
							</tr>
							<tr>
								<th scope="row">상담일자 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100"
									name="reg_date" id="reg_date" v-model='reg_date'
									style="font-size: 15px" />
							</tr>
							<tr>
								<th scope="row">상담내용 <span class="font_red"></span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="counsel" id="counsel" v-model='counsel'
										placeholder="상담 내용을 입력하세요." /></textarea></td>
							</tr>

							<tr>
								<th scope="row">등록자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="userID"
									id="userID" v-model='userId' style="font-size: 15px" />
							</tr>
					</table>


					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" v-on:click="insertCns2"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</div>


</body>

</html>