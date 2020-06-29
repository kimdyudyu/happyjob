<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>과제관리</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<script
	src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>

<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
.ql-editor {
	height: 200px;
}
</style>
<script type="text/javascript">
	var pageSize = 5;
	var pageBlockSize = 5;

	var shListVue;
	var sessionVal;
	var showDetailVue;
	var wrtLmmVue;

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

	$(function() {
		init();
		shList();
		var log = $("#nt_no").val();
		console.log(log);
	});

	function init() {
		Vue.use(VueQuillEditor);

		shListVue = new Vue({
			el : "#vueListtable",
			data : {
				items : []
			},
			methods : {
				showDetail : function(item) {
					ShowTmDetail(item);
				}
			}
		});

		wrtLmmVue = new Vue({
			el : '#wrtLmm',
			data : {
				action : '',
				nt_no : '',
				nt_title : '',
				nt_note : '',
				loginId : '',
				filename : '',
				filepath : '',
				filesize : '',
				select : [],
				editorOption : {
				theme : 'snow'
				}
			},
			methods : {
				onEditorBlur : function(quill) {
					console.log('editor blur!', quill);
				},
				onEditorFocus : function(quill) {
					console.log('editor focus!', quill);
				},
				onEditorReady : function(quill) {
					console.log('editor ready!', quill);
				},
				minusClickEvent : function() {
					$("#wfile_nm").val("");
					wrtLmmVue.filename = '';
				},
				setFileName : function() {
					this.filename = event.target.files[0].name;
				}
			},
			computed : {
				editor : function() {
					// alert( this.$refs.quillEditor.quill.getText());
					return this.$refs.quillEditor.quill
				},
				mounted : function() {
					console.log('this is quill instance object', this.editor)
				}
			}
		});

		/* 상세보기. */
		showDetailVue = new Vue({
			el : '#detailtable',
			data : {
				fileupdateset : false,
				action : '',
				nt_no : '',
				nt_title : '',
				nt_note : '',
				loginId : '',
				reg_date : '',
				filename : '',
				filepath : '',
				filesize : '',
				editorOption : {
				theme : 'snow'
				}
			},
			methods : {
				onEditorBlur : function(quill) {
					console.log('editor blur!', quill);
				},
				onEditorFocus : function(quill) {
					console.log('editor focus!', quill);
				},
				onEditorReady : function(quill) {
					console.log('editor ready!', quill);
				},
				minusClickEvent : function() {
					console.log("call showDetailVue.showDetail");
					$("#dfile_nm").val("");
				},
				setFileName : function() {
					this.filename = event.target.files[0].name;
				}
			},
			computed : {
				editor : function() {
					return this.$refs.quillEditor.quill;
				},
				mounted : function() {
					console.log('this is quill instance object', this.editor);
				}
			}
		});
	};

	function shList(currentPage) {
		console.log("call shList");

		var currentpage = currentPage || 1;

		var param = {
			currentPage : currentpage,
			pageSize : pageSize
		};

		var resultCallback = function(data) {
			printList(data);
		};

		callAjax("/manageC/st_hwList.do", "post", "json", true, param,
				resultCallback);
	}

	function printList(data, currentPage) {
		console.log("call printList()");
		var paginationHtml = getPaginationHtml(data.currentPageNoticeList,
				data.totalCountList, data.pageSize, pageBlockSize, 'shList');
		
		$("#pagingnavi").empty().append(paginationHtml);
		shListVue.items = data.list;
		wrtLmmVue.select = data.select;
		
		if(data.list.length == 0){
			$("#kimjs").hide();
		}
	};

	function cancel() {
		console.log("call cancel()");
		gfCloseModal();
		shList();
	}

	function ShowTmDetail(item) {
		console.log("call ShowTmDetail()");

		if (item.filename != null || item.filename != '') {
			showDetailVue.fileupdateset = true;
		} else {
			showDetailVue.fileupdateset = false;
		}
		
		showDetailVue.nt_no = item.nt_no;
		showDetailVue.nt_title = item.nt_title;
		showDetailVue.nt_note = item.nt_note;
		showDetailVue.loginId = item.loginID;
		showDetailVue.reg_date = item.reg_date;
		showDetailVue.filename = item.filename;
		showDetailVue.filepath = item.filepath;
		showDetailVue.filesize = item.filesize;

		gfModalPop("#TmDetailvue");

		var param = {
			no : item.nt_no
		}
	}

	function writeDetail() {
		console.log("call LmmWriter()");
		
		wrtLmmVue.loginId = "${sessionScope.loginId}";
		$("#wnt_title").focus();

		gfModalPop("#writeLmm");
	}

	
	function insertLmm() {
		console.log("call insertLmm()");

		wrtLmmVue.action = "I";
		$("#waction").val(wrtLmmVue.action);
		$("#wnt_contents").val(wrtLmmVue.nt_note);

		var frm = document.getElementById("lmmWrtieForm");
		frm.enctype = 'multipart/form-data';

		var fileData = new FormData(frm);

		var resultCallback = function(data) {
			alert(data.msg);
			lmmList();
		};

		callAjaxFileUploadSetFormData("/manageC/IUDLmm.do", "post", "json",
				true, fileData, resultCallback);
		
		gfCloseModal();
	}
	function UpdateLmm() {
		console.log("call UpdateLmm()");
		showDetailVue.action = "U" ;

		$("#daction").val(showDetailVue.action);
		$("#nt_no").val(showDetailVue.nt_no);
		$("#nt_note").val(showDetailVue.nt_note);
		
		console.log(showDetailVue.nt_no);
		
		var frm = document.getElementById("detailLmm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);

		var resultCallback = function(data) {
			alert(data.msg);
			gfCloseModal();
			lmmList();
		};

		callAjaxFileUploadSetFormData("/manageC/IUDLmm.do", "post", "json", true,
				fileData, resultCallback);
	}

	function lmmList(currentPage) {
		console.log("call lmmList");

		var currentpage = currentPage || 1;
		sessionVal = $('#sessionVal').val();

		var param = {
			currentPage : currentpage,
			pageSize : pageSize,
			sessionVal : sessionVal
		};

		var resultCallback = function(data) {
			printList(data);
		};
		callAjax("/manageC/st_hwList.do", "post", "json", true, param, resultCallback);
	}
	
    function fileupdateset(){
        showDetailVue.fileupdateset=true;
     }
    
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/view/homework/st_hwdetail.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/homework/st_hwwrite.jsp"></jsp:include>

	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
				<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">게시판</a> <span class="btn_nav bold">과제제출</span> <a
								href="homework.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searcharea">
							<span>과제제출</span>
						</p>
						<a id="kimjs" href="javascript:writeDetail()" style="margin: 25px;">
						<strong>글 쓰 기</strong></a>
						<br>

						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right"></div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">
										<!-- 공지사항 리스트-->
										<jsp:include page="/WEB-INF/view/homework/st_hwList.jsp"></jsp:include>
									</div>
								</div>
							</div>
						</div>
						<div class="paging_area" id="pagingnavi"></div>
						<br>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>