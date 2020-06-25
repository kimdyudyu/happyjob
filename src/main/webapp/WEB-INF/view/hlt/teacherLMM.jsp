<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>학습자료관리</title>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		
		<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/vue"></script>
		<!-- Quill JS Vue -->
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
	
			var nListVue;
			var searchVue;
			var showDetailVue;
			var wrtLmmVue;
			var replyVue;
			var upOV;
			var fromDt;
			var toDt;
		    var fromDtvue;
		    var toDtvue;
		    var sessionVal;
	
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
		
			$(function(){
				console.log($('#sessionVal').val());
				init();
				lmmList();
				
				$("#searchkey").change(function(){
					if($(this).val() == "all"){
						$("#searchword").val('');
						$("#searchword").attr({"placeholder" : "전체목록을 조회합니다.", "readonly" : true});
					}else{
						$("#searchword").val('');
						$("#searchword").attr({"placeholder" : "입력하세요.", "readonly" : false});
					}
				});
			});
			
			function printList(data,currentPage){
				console.log("call printList()");
				var paginationHtml = 
					getPaginationHtml(data.currentPageNoticeList, data.totalCountList,
									data.pageSize,pageBlockSize, 'lmmList');
				
				$("#pagingnavi2").empty().append(paginationHtml); 
				nListVue.items=data.list;
			};
			
			function lmmList(currentPage){	
				console.log("call lmmList");
				   
				searchVue.searchkey= searchkey || 'nt_title';
				  
				var currentpage= currentPage || 1;
				var searchkey = $('#searchkey').val();
				var searchword= $('#searchword').val();
			    var fromDt = $('#fromDt').val();  //시작일
				var toDt = $('#toDt').val();    //끝 
				sessionVal = $('#sessionVal').val();
				
				//alert(searchVue.searchkey + " , " + searchVue.searchword);
				  
				var param=
				{
					currentPage : currentpage,
					pageSize : pageSize,
					searchkey : searchkey,
					searchword : searchword,
					fromDt :  fromDt,
					toDt :  toDt,
					sessionVal : sessionVal
				}; 
					 
					 
				//alert(searchVue.$data);
				var resultCallback = 
					function(data) {
						/* alert(searchVue.searchkey + " , "+searchVue.searchword); */	
						printList(data);
				};
				
				callAjax("/lmm/lmmList.do", "post", "json", true, param, resultCallback);
			}
			
			function init(){
				Vue.use(VueQuillEditor);
				
				//Vue의  datepicker 사용.
				fromDtvue = new Vue({
					el: '#fromDt',
					name: 'date-picker',
					props: {
						date: String
					},
					data: {
						fromDt : ""
					},
					mounted: function() {
						var that = this;
						$(this.$el).datepicker({
							'autoclose':true,
							'minViewMode':0, //day까지 선택할수 있게 선언
							'maxViewMode':2,
							'format':'yyyy.mm.dd' //날짜 포맷
						}).on('changeDate', function(e){
							var year = e.date.getFullYear();
							var month = e.date.getMonth() + 1;
							if(month < 10) month = '0' + month;
							var day = e.date.getDate();
							that.$emit('change',String(year)+'.'+String(month)+'.'+day);
				    	});
				     },
				     updated: function(){
				            $(this.$el).datepicker('update', this.date);
				     }   
				});
					
					//Vue의  datepicker 사용.
				toDtvue = new Vue({
					el: '#toDt',
					name: 'date-picker',
					props: {
						date: String
					},
					data: {
						toDt : ""					
					},
					mounted: function() {
						var that = this;
						$(this.$el).datepicker({
							'autoclose':true,
							'minViewMode':0, //day까지 선택할수 있게 선언
							'maxViewMode':2,
							'format':'yyyy.mm.dd' //날짜 포맷
						}).on('changeDate', function(e){
							var year = e.date.getFullYear();
							var month = e.date.getMonth() + 1;
							if(month < 10) month = '0' + month;
							var day = e.date.getDate();
							that.$emit('change',String(year)+'.'+String(month)+'.'+day);
				    	});
				     },
				     updated: function(){
				            $(this.$el).datepicker('update', this.date);
				     }   
				});
					
				nListVue = new Vue({
					el :"#vueListtable",
					data : {
						items:[]
					},
					methods:{
							showDetail:function(item){
								
								ShowLmmDetail(item);
							}
					}
				});
				
				/* 초기화면 & 검색  */
				searchVue = new Vue({
					el:"#searcharea",
					data: {
						currentPage : 1,
						pageSize : pageSize,
						searchkey :'nt_title',
						searchword : '',
							fromDt : '',
							toDt : ''
					}
				});
					
				/* 상세보기. */
				showDetailVue = new Vue({
					el :'#detailtable',
					data :{
						fileupdateset:false,
						action:'',
						nt_no:'', 
						nt_title:'',
						nt_note:'',
						loginId:'',
						write_date:'',
						filename:'',
						filepath:'',
						filesize:'',
						editorOption: {
			     			theme: 'snow'
			    		}
					},
					methods : {
						onEditorBlur:function(quill) {  	 
			        		console.log('editor blur!', quill);
						},
			        	onEditorFocus:function(quill) {
			        	    console.log('editor focus!', quill);
			        	},
			        	onEditorReady:function(quill){
			        	    console.log('editor ready!', quill);
			        	},
			        	minusClickEvent:function(){
			        	   	console.log("call showDetailVue.showDetail");
			        	   	$("#dfile_nm").val("");
			        	},
			        	DownloadQnaFileEvent :function(){
							if(confirm("다운받으시겠습니까?"))
							{
			          	    	fDownloadQnaFile();
			          	    }
							else
							{
			          	    	alert("취소되었습니다.");
			          	    }
			       	    },
			       	    setFileName : function(){
			   				this.filename=event.target.files[0].name;
			   			}
					},
					computed :{
						editor:function() {
							// alert( this.$refs.quillEditor.quill.getText());
							return this.$refs.quillEditor.quill;
						},
			         	mounted:function() {
							console.log('this is quill instance object', this.editor);
						}
					} 
				});
				
				//글쓰기  vue
				wrtLmmVue = new Vue({
					el:'#wrtLmm',
				 	data : {
				 		action:'',
				 		nt_no:'', 
				 		nt_title:'',
				 		nt_note:'',
				 		loginId:'',
				 		filename:'',
				 		filepath:'',
				 		filesize:'',
				 		editorOption: {
				  			 theme: 'snow'
				 		}
				 	},
				 	methods : {
						onEditorBlur:function(quill) {
							console.log('editor blur!', quill);
						},
						onEditorFocus:function(quill) {
							console.log('editor focus!', quill);
						},
						onEditorReady:function(quill){
							console.log('editor ready!', quill);
						},
						minusClickEvent:function(){
							$("#wfile_nm").val("");
							wrtLmmVue.filename='';
						},
						setFileName : function(){
							this.filename=event.target.files[0].name;
						}
				 	},
				 	computed:{
						editor:function() {
							// alert( this.$refs.quillEditor.quill.getText());
							return this.$refs.quillEditor.quill
						},
						mounted:function() {
							console.log('this is quill instance object', this.editor)
						}
					}
				});
				
				upOV = new Vue({
					el:'#updateoption',
					data:{
						usertype:'A',
						option:false,
						loginId:''
					},
					methods:{
						optionch:function(){
							fileupdateset();
							this.option = !this.option;
						}
					}
					
				});
			} //init()메소드 종료
			
			function cancle(){
				console.log("call cancle()");
				gfCloseModal();
				lmmList();
			}
			
			function LmmWriter(){
				console.log("call LmmWriter()");
				wrtLmmVue.loginId="${sessionScope.loginId}";
				/* $(".ql-editor").css("height","300px"); */
				$("#wnt_title").focus();
				
				gfModalPop("#writeLmm");
			}
			
			function insertLmm(){
				console.log("call insertLmm()");
				
				wrtLmmVue.action='I';
				
				$("#waction").val(wrtLmmVue.action);
				$("#wnt_contents").val(wrtLmmVue.nt_note);
				
				
				var frm = document.getElementById("lmmWrtieForm");
				frm.enctype = 'multipart/form-data';
				
				var fileData = new FormData(frm);
				
				var resultCallback = function(data) {
					alert(data.msg);
					lmmList();
				};
				
				callAjaxFileUploadSetFormData("/lmm/IUDLmm.do", "post", "json", true, fileData, resultCallback);
				gfCloseModal();
			}
			
			function ShowLmmDetail(item){
				console.log("call ShowLmmDetail()");
			  	/*for( var key in item){
				   console.log("key : "+ key+" ,  value : "+item[key]);
				}*/

				if(item.filename){
					showDetailVue.fileupdateset=true;
				}else{ 
					showDetailVue.fileupdateset=false;
				}
			    upOV.option=true;
			    upOV.loginId=item.loginID;
			   
			    showDetailVue.nt_no=item.nt_no;
			    showDetailVue.nt_title=item.nt_title;
			    showDetailVue.nt_note=item.nt_note;
			    showDetailVue.loginId=item.loginID;
			    showDetailVue.write_date=item.write_date;
			    showDetailVue.filename=item.filename;
			    showDetailVue.filepath=item.filepath;
			    showDetailVue.filesize=item.filesize;
				
			    gfModalPop("#LmmDetailvue");
			    /* 	
				for( var key in dNoticeVue.$data){
					   console.log("2key : "+ key+" ,  value : "+row[key]);
				}
				 */
				 
			 	var param = {
						 nt_no:item.nt_no
				 }
			}
			
			function UpdateLmm(){
				console.log("call UpdateLmm()");
				showDetailVue.action='U';
				/* 		callAjax("/jboard/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
					 */	
						$("#daction").val(showDetailVue.action);
					 	$("#nt_no").val(showDetailVue.nt_no);
					 	$("#nt_note").val(showDetailVue.nt_note);
					
						var frm = document.getElementById("detailLmm");
						frm.enctype = 'multipart/form-data';
						var fileData = new FormData(frm);
						
						var resultCallback = function(data) {
							alert("돌아옴"+data.msg);
							gfCloseModal();
							lmmList();
						};
						
				callAjaxFileUploadSetFormData("/lmm/IUDLmm.do", "post", "json", true, fileData, resultCallback);
			}
			
			function DeleteLmm(){
				console.log("call DeleteLmm()");
				showDetailVue.action='D';
				alert("삭제 하시겠습니까?");
			/* 		callAjax("/jboard/updateNotice.do", "post", "json", true, dNoticeVue.$data,resultCallback);
			 */	
				$("#daction").val(showDetailVue.action);
			    $("#nt_no").val(showDetailVue.nt_no);
			    
			    var frm = document.getElementById("detailLmm");
				frm.enctype = 'multipart/form-data';
				var fileData = new FormData(frm);
				
				var resultCallback = function(data) {
					alert("돌아옴"+data.msg);
					gfCloseModal();
					lmmList();
				};
				
				callAjaxFileUploadSetFormData("/lmm/IUDLmm.do", "post", "json", true, fileData, resultCallback);
			}
			
			/* 파일다운로드 */
			function fDownloadQnaFile() {
				
				var params = "";
				params += "<input type='hidden' name='nt_no' value='"+ showDetailVue.nt_no +"' />";
				
				
				//jQuery("<form action='/jboard/downloadQnaFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
			}
			
			function fileupdateset(){
				showDetailVue.fileupdateset=true;
			}
			
			
		</script>
	</head>
	<body>
		<!-- 게시판 상세보기 모달팝업 -->
		<!-- <form id="test"></form> -->
		<jsp:include page="/WEB-INF/view/hlt/teacherLmmDetail.jsp"></jsp:include>
		
		<!-- 게시판 글쓰기 모달팝업 -->
		<jsp:include page="/WEB-INF/view/hlt/teacherLmmWrite.jsp"></jsp:include>
		
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
									class="btn_nav">게시판</a> <span class="btn_nav bold">자료게시판</span>
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>
	
							<p class="conTitle" id="searcharea">
								<span>자료게시판</span> 
							</p>
							<div id="searcharea">
								<span>
									<input type="hidden" id="sessionVal" value="${sessionScope.loginId}" />
									<select id="searchkey" name="searchkey" style="width: 104px;" v-model="searchkey">
										<option value="all">전체</option>
										<option value="nt_title">제목</option>
										<option value="nt_note">내용</option>
									</select>
									<input type="text" id="searchword" name="searchword" placeholder="전체목록을 조회합니다." 
										style="height: 28px;"  @keyup.enter="searchbtn" readonly="readonly">
									
									<input type="text" style="height: 31px; width: 110px;" 
										class="txtInput" id="fromDt" name="fromDt" v-model="fromDt" 
										data-date-format='yyyy-mm-dd'>
							
									<span>
										<b>&nbsp;~&nbsp;</b>
									</span>
							
								 	<input type="text" style="height: 31px; width: 110px"
										class="txtInput" id="toDt" name="toDt" v-model="toDt"
										data-date-format='yyyy-mm-dd'>
			                  
											
									<!-- a태그에 @click 이벤트 같은걸? 걸어주면 href가 나중에 실행되는듯!!리로드현상해결.  -->
									<!-- <a class="btnType blue" href=""  name="search" id="searchBtn" @click="searchbtn"><span>검색</span></a> -->
								</span>
								<span class="fr">
									<a href="javascript:lmmList()" class="btnType gray">
										<span>검색</span>
									</a>
									<a class="btnType blue" href="javascript:LmmWriter();">
										<span>글쓰기</span>
									</a>
								</span>
							</div>
	
							<br>
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
											<jsp:include page="/WEB-INF/view/hlt/teacherLmmList.jsp"></jsp:include>
											<div>
												<div>
													<div class="clearfix"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="paging_area" id="pagingnavi2"></div>
							<br> 
						</div>
					</li>
				</ul> 
			</div>
		</div>
	</body>
</html>