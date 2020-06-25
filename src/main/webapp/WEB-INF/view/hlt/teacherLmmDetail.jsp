<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
<div id="LmmDetailvue" class="layerPop layerType2" style="width: 1100px; hight: 1000px;">
	<form id="detailLmm" action="">
		<input type="hidden" name="action" id="daction" value="">
		<input type="hidden" name="nt_no" id="nt_no" value="">
		<input type="hidden"  name="nt_note" id="nt_note"  value="">
		<dl>
			<dt>
				<strong> 상세보기 </strong>
			</dt>
			<dd class="content">
			
				<div >
					<table class="row" id="detailtable"><!--  id="detailtable"  -->
					
					
						<caption>caption</caption>
						
						<colgroup>
							<col width="60px">
							<col width="120">
							<col width="120px">
							<col width="120">
							<col width="120px">
							<col width="120">
						</colgroup>
						<!-- <tbody> -->
						
							<tr>
								<th scope="row">제목 </th>
								<td>
								<input type="text" class="inputTxt p100" name="nt_title" id="d_nt_title" v-model="nt_title"/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="loginId" id="d_enr_user" v-model="loginId" readonly="readonly"/> 
								</td>
								<th scope="row">등록일 </th>
								<td><input type="text" class="inputTxt p100" name="write_date" id="d_enr_date" v-model="write_date"/>
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								
								<div style="width: 900px;" >
								 
								  <quill-editor
								    ref="quillEditor" class="editor" v-model="nt_note" :options="editorOption" 
								    @blur="onEditorBlur($event)"
								    @focus="onEditorFocus($event)"
								    @ready="onEditorReady($event)"
								  />
								  <br>
								 
								</div>
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
									<div v-if="fileupdateset">
										<div v-if="filename !='' & filename != null" id="filearea">
											<img src="/images/treeview/file.gif" name="filename"id="d_file_nm">
											<span>{{filename}}</span>
											<span style="font-size: xx-small;" >{{filesize}}Byte</span>
											<img v-if="filename !=''" src="/images/treeview/minus.gif" @click="minusClickEvent">
										</div>
										<input type="file" name="filename" id="dfile_nm" @change="setFileName" value="">
									</div>
								</td>
							</tr>
							
						<!-- </tbody> -->
					</table>
				</div>
					
				<div class="btn_areaC mt30" id="updateoption">
					
								
						<a v-if="option" 
								href="javascript:UpdateLmm()" class="btnType blue"><span>저장</span></a>
						
						<a v-if="option" 
								href="javascript:DeleteLmm()" class="btnType blue"><span>삭제</span></a>
								
						<a v-if="'${sessionScope.userType}'== usertype && !option"  class="btnType blue" @click.prevent="optionch"><span>수정</span></a>
								
								
						<a href="javascript:cancle()" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</form>
</div>