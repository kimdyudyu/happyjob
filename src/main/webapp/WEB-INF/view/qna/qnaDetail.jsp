<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
<div id="TmDetailvue" class="layerPop layerType2"
	style="width: 1100px; hight: 1000px;">
	<form id="detailTm" action="">
		<!-- <input type="hidden" name="action" id="daction" value=""> qna 테이블 값 대입할 것 -->
		<input type="hidden" name="comment_wno"
								id="comment_wno" v-model="wno" />
		<dl>
			<dt style="padding:10px;">
				<strong style="padding:10px;"> 상세보기 </strong>
			</dt>
			<dd class="content">
				<div>
					<table class="row" id="detailtable">
						<caption>caption</caption>
						<colgroup>
							<col width="60px">
							<col width="120">
							<col width="120px">
							<col width="120">
							<col width="120px">
							<col width="120">
						</colgroup>
							<th scope="row">제목</th>
							<td><input type="text" class="inputTxt p100" name="title"
								id="title" v-model="title" readonly="readonly" /></td>
							<th scope="row">작성일</th>
							<td><input type="text" class="inputTxt p100" name="reg_date"
								id="reg_date" v-model="reg_date" readonly="readonly" /></td>
							<th scope="row">작성자</th>
							<td><input type="text" class="inputTxt p100" name="regId"
								id="regId" v-model="regId" readonly="readonly" /></td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td colspan="5">
								<div style="width: 900px;">
									<quill-editor ref="quillEditor" class="editor" v-model="note"
										:options="editorOption" @blur="onEditorBlur($event)"
										@focus="onEditorFocus($event)" @ready="onEditorReady($event)" />
									<br>
								</div>
							</td>
						</tr>
					</table>
					<div id="qna_comments" style="margin-top:15px;">
							<dl>
								<dt>
									<strong style="padding:10px;">강의 후기</strong>
								</dt>
								<dd class="content">
									<div id="comment_write" style="padding:10px;">
										<form id="comment_frm">
											<span>제목 : </span>
											<input type="text" id="comment_title" name="comment_title" />
											<span style="margin-left:15px;">내용 : </span>
											<input type="textarea" id="comment_note" name="comment_note" />
											<a href="javascript:write_comment()" style="margin-left: 15px;">
												<strong>글 작 성</strong></a>
										</form>	
									</div>
								
									<div id="survey" style=" overflow:auto; height:155px;">
										<div style="padding:10px;" v-for="(row, index) in clist">
											<span style="margin-left:25px; margin-right:5px;"> 작성자 : </span>
											<input type="text" style="width:70px;" v-model="row.qcregId" readonly />
											<span style="margin-left:20px; margin-right:5px;">내용 : </span> 
											<input type="text" style="width:250px;" v-model="row.qcnote" readonly />
											<span style="margin-left:15px; margin-right:5px;">작성일 : </span> 
											<input type="text" style="width:100px;" v-model="row.qcreg_date" readonly />
										</div>
									</div>
								</dd>
							</dl>
							<a href="" class="closePop"><span class="hidden">닫기</span></a>
						</div>
				</div>

				<div class="btn_areaC mt30" id="updateoption" style="padding:10px;">
					<a href="javascript:cancel()" class="btnType gray"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="javascript:cancel()" class="closePop"><span
			class="hidden">닫기</span></a>
	</form>
</div>