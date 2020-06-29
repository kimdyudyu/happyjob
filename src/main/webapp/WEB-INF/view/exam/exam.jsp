<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>

<style>
body {
	height: 100%;
	width: 90%;
	text-align: center;
	margin: auto;
}

#test_div1 {
	margin-top: 50px;
	width: 90%;
	height: 40%;
}

#btn_div1 {
	margin-left: 30px;
	margin-bottom: 10px;
	float: left;
}

#search_test_table {
	margin: auto;
	border: 1px dotted red;
	width: 95%;
}

#test_div2 {
	margin-left: -100px;
	margin-top: 75px;
	margin-bottom: 20px;
}

#div_btn1 {
	margin-left: -100px;
	margin-top: 20px;
	margin-bottom: 20px;
	width: 40px;
	height: 25px;
}

#div_btn2 {
	margin-left: -95px;
	margin-top: 20px;
	margin-bottom: 20px;
	width: 40px;
	height: 25px;
}

#scoreboard {
	text-align: left;
	margin-bottom: 20px;
	margin-top: 20px;
	margin-left: 20px;
}

click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}

</style>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<script type="text/javascript">
	var test_PageSize = 6; // 화면에 뿌릴 데이터 수 
	var test_PageSizevue = 6;
	var test_PageBlock = 6; // 블럭으로 잡히는 페이징처리 수

	$(function() { // onload 시 실행될 함수 정의 
		init();
		selectTestList();
		// selectTestList_vue(); 버튼으로 조회 
	});

	function init() {

		vm = new Vue({
			el : '#vuetable',
			components : {
				'bootstrap-table' : BootstrapTable
			},
		methods: {
		      rowClicked : function(row) {
		       // row 값을 받아 처리
		        var str = "";
                var tdArr = new Array();    // 배열 선언
                    
                // 현재 클릭된 Row(<tr>)
                var tr = $(row);
                var td = tr.children();
                
                td.each(function(i){
                    tdArr.push(td.eq(i).text());
                });
                        
                TestresultModal(tdArr[0], tdArr[1], tdArr[2]); // 시험 결과 modal 창으로 확인
                // console.log("배열에 담긴 값 : "+tdArr[1]);
		        
		      }
		  }		   
		});
	}
	
	function TestresultModal(no, testname, re) {
		 
		 var param = {
		 	no : no,
		 	re : re
		 }
			var resultCallback = function(data){
				result(data);
		 }
		 callAjax("/test/testList.do", "post", "text", true, param, resultCallback);
	 }

	function selectTestList(currentPage) {
		currentPage = currentPage || 1; // || = or
		console.log("selectNoticeList currentPage : " + currentPage);

		var param = {
			currentPage : currentPage,
			pageSize : test_PageSizevue // 10 
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			gridinit(data, currentPage);
		}

		callAjax("/test/examList.do", "post", "text", true, param,
				resultCallback);
	}

	function selectTestList_vue(currentPage) {

		currentPage = currentPage || 1; // || = or
		console.log("selectTestListvue currentPage : " + currentPage);

		var stitle = $("#areat option:selected").val();

		var param = {
			currentPage : currentPage,
			pageSize : test_PageSizevue, // 10 
			title : stitle
		}

		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			gridinit(data, currentPage);
		}

		callAjax("/test/examList.do", "post", "text", true, param,
				resultCallback);
	}

	/* 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	function gridinit(data, currentPage) {

		$("#test").empty(); // test의 값을 비우고
		$("#test").append(data); // 호출된 데이터를 붙인다.

		// 리스트의 총 개수를 추출합니다. 
		var totalCnt = $("#totalCnt").val();
		var pagingnavi = getPaginationHtml(currentPage, totalCnt,
				test_PageSizevue, test_PageBlock, 'selectTestList_vue');

		console.log("pagingnavi : " + pagingnavi);
		// 비운다음에 다시 append 
		$("#pagingnavi").empty().append(pagingnavi);
		// 현재 페이지 설정 
		$("#currentPagevue").val(currentPage);
	}
	
	function submit_test(){
		
		var Arr = new Array();
		var Seq = new Array();

		var radiobox = $(".testlist"); // count 용
		
		for(var i=1; i< radiobox.length+1; i++){ // 유효성 검사용
			if($("input:radio[name=question"+i+"]:checked").length < 1){
			    alert("문제"+ i + "번의 답이 선택되지 않았습니다.");
			    return ;
			}
		}
		
 		var no = $("#no").val();
 		var re = $("#re").val();
		for(var i=1; i< radiobox.length+1; i++){
			Arr[i] = $("input:radio[name=question"+i+"]:checked").val();
		}
		
		
		// console.log(Qname);
		console.log(Seq);
		
		var param = { no : no,
					  re : re, 	
					  seq1 : Arr[1], 
					  seq2 : Arr[2],
					  seq3 : Arr[3],
					  seq4 : Arr[4],
					  seq5 : Arr[5],
					  seq6 : Arr[6],
					  seq7 : Arr[7],
					  seq8 : Arr[8],
					  seq9 : Arr[9],
					  seq10 : Arr[10]
		}
		
		var resultCallback = function(data) { // 데이터를 이 함수로 넘깁시다. 
			calculation(data); // 결과 공지 팝업창.
		}

		callAjax("/test/calculation.do", "post", "text", true, param,
				resultCallback);
	}
	
	function calculation(data){
		alert("시험이 정상적으로 종료되었습니다.");
		location.reload();
	}
	
	function result(data){
		$("#test_result").empty(); // test의 값을 비우고
		$("#test_result").append(data); // 호출된 데이터를 붙인다.	
	}
	
	function cancel_test(){
		$("#test_result").empty();
	}
	

</script>

<body>

	<div id="wrap_area">
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>

				<li class="contents">
				
					<p class="Location" style="text-align:left; margin:15px;">
                        <a href="#" class="btn_set home">메인으로</a> <a href="#"
                           class="btn_nav">게시판</a> <span class="btn_nav bold">시험응시</span>
                        <a href="examination.do" class="btn_set refresh">새로고침</a>
                     </p>
				
					<div id="test_div1">
						<h2>시험 대상 목록</h2>
						<c:if test="${tot_cnt > 0}">
						<div id="btn_div1">
							<select id="areat" name="areat" style="width:70px; height:25px;">
								<option value="all">전 체</option>
								<option value="re">재시험</option>
								<option value="main">본시험</option>
							</select> <a href="javascript:selectTestList_vue();" id="btn_test_search">
								<strong style="margin-left:10px;">조 회</strong>
							</a>
						</div>
						</c:if>
						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right"></div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuedatatable" class="col2 mb10"
											style="width: 100%;">
											<colgroup>
												<col width="350px">
												<col width="240px">
												<col width="135px">
												<col width="145px">
											</colgroup>
											<thead>
												<tr>
													<th data-field="no">과정명</th>
													<th data-field="testname">시험명</th>
													<th data-field="re">구분</th>
													<th data-field="re">상태</th>
												</tr>
											</thead>
											<tbody id="test">
												<!-- 불러온 data를 붙이는 곳 -->
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- 페이징 처리 부분 -->
						<div class="paging_area" id="pagingnavi"></div>
						<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">
					</div>

					<div id="test_result"></div> <!-- re 처리된 test 결과 호출 -->

				</li>
			</ul>
		</div>
	</div>
</body>
</html>