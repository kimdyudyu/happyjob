<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>질의 및 응답</title>
      <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
      <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
      
      <script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
      
      <link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
      <link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
      <link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">
      <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
      <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
      
      <style>
      .ql-editor {
         height: 200px;
      }
      </style>
      <script type="text/javascript">
      
         var pageSize = 5;
         var pageBlockSize = 5;
         
         var QListVue;
         var sessionVal;
         var searchVue;
         var showDetailVue;
         
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
            init();
            QList();
         });
         
         function printList(data,currentPage){
            console.log("call printList()");
            var paginationHtml = 
               getPaginationHtml(data.currentPageNoticeList, data.totalCountList,
                           data.pageSize,pageBlockSize, 'QList');
            
            $("#pagingnavi").empty().append(paginationHtml); 
            QListVue.items=data.list;
         };
         
         function QList(currentPage){   
            console.log("call QList");
            
            var count=$("select[name='searchkey'] option:selected").val();
            // console.log(count);
            // 검색 기준 유효성 검사 진행시 
            
            searchVue.searchkey= searchkey || 'nt_title';
              
            var currentpage= currentPage || 1;
            var searchkey = $('#searchkey').val();
            var searchword= $('#searchword').val();
            sessionVal = $('#sessionVal').val();
            
            var param=
            {
               currentPage : currentpage,
               pageSize : pageSize,
               searchkey : searchkey,
               searchword : searchword,
               sessionVal : sessionVal
            }; 
                
            var resultCallback = 
               function(data) {
                  printList(data);
            };
            
            callAjax("/manageC/QList.do", "post", "json", true, param, resultCallback);
         }
         
         function init(){
            Vue.use(VueQuillEditor);
            
            QListVue = new Vue({
               el :"#vueListtable",
               data : {
                  items:[]
               },
               methods:{
                     showDetail:function(item){
                    	 ShowQDetail(item);
                     }
               }
            });
            
            searchVue = new Vue({
               el:"#searcharea",
               data: {
                  currentPage : 1,
                  pageSize : pageSize,
                  searchkey :'nt_title',
                  searchword : ''
               }
            });
            
            commentDetailVue = new Vue({
                el:"#qna_comments",
                data: {
                	clist:[]
                }
             });
            
            showDetailVue = new Vue({
               el :'#detailtable',
               data :{
                  wno:'',
                  title:'',
                  note:'',
                  regId:'',
                  reg_date:'',
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
               },
               computed :{
                  editor:function() {
                     return this.$refs.quillEditor.quill;
                  },
                     mounted:function() {
                     console.log('this is quill instance object', this.editor);
                  }
               } 
            });
         };
         
         function cancel(){
            console.log("call cancel()");
            gfCloseModal();
            QList();
         }
         
         function ShowQDetail(item){
            console.log("call ShowQDetail()");
			
            var wno = {
            	wno : item.wno
            } 
              
            callAjax("/manageC/CList.do", "post", "json", true, wno , commentCallback);
            
            function commentCallback(data){
            	commentDetailVue.clist=data.clist;
           	    console.log(commentDetailVue.clist);
            }
            
             showDetailVue.title=item.title;
             showDetailVue.note=item.note;
             showDetailVue.regId=item.regId;
             showDetailVue.reg_date=item.reg_date;
             showDetailVue.wno=item.wno;
             	
            
             gfModalPop("#TmDetailvue");
             
             var param = {
                   no:item.no
             }
         }
         
         function write_comment(){
        	 var ctitle = document.getElementById("comment_title").value;
        	 var cnote = document.getElementById("comment_note").value;
        	 var wno = showDetailVue.wno;
        	 
        	 var param = {
        			 ctitle : ctitle,
        			 cnote : cnote,
        			 wno : wno
        	 }
        	 
        	 var resultCallback = 
                 function(data) {
                    test(data);
              };
              callAjax("/manageC/comment_write.do", "post", "text", true, param, resultCallback);
         }
         
         function test(data){
        	 alert("글 작성이 완료되었습니다.");
        	 location.reload();
         }
			
      </script>
   </head>
   <body>
      <jsp:include page="/WEB-INF/view/qna/qnaDetail.jsp"></jsp:include>
      
      <div id="mask"></div>
      <div id="wrap_area">
         <h2 class="hidden">컨텐츠 영역</h2>
         <div id="container">
            <ul>
               <li class="lnb">
                  <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
               </li>
               <li class="contents">
                  <h3 class="hidden">contents 영역</h3>
                  <div class="content">
   
                     <p class="Location">
                        <a href="#" class="btn_set home">메인으로</a> 
                        <a href="#" class="btn_nav">게시판</a><span class="btn_nav bold">질의 및 응답</span>
                        <a href="qna.do" class="btn_set refresh">새로고침</a>
                     </p>
   
                     <p class="conTitle" id="searcharea">
                        <span>질의 및 응답(QnA)</span> 
                     </p>
                     
                     <div id="searcharea">
                        <span>
                           <input type="hidden" id="sessionVal" value="${sessionScope.loginId}" />
                           <select id="searchkey" name="searchkey" style="width: 104px;" v-model="searchkey">
                              <option value="all">전체</option>
                              <option value="loginId">학생명</option>
                              <option value="nt_title">제목</option>
                           </select>
                           <input type="text" id="searchword" name="searchword" placeholder="입력하세요" 
                              style="height: 28px;"  @keyup.enter="searchbtn">
      					</span>
                        <span class="fr">
                           <a href="javascript:QList()" class="btnType gray">
                              <span>검색</span>
                           </a>
                        </span>
                     </div>
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
                                 <jsp:include page="/WEB-INF/view/qna/QList.jsp"></jsp:include>
                                 <div>
                                    <div>
                                       <div class="clearfix"></div>
                                    </div>
                                 </div>
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