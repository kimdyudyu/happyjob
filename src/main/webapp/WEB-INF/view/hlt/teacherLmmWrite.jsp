<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


	<!-- 글쓰기 -->
	<div id="writeLmm" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
	    <form id="lmmWrtieForm" action="" method="">
		<!-- 업데이트냐 수정이냐 ~  vue 사용으로 필요없음. $data를 보내기때문 -->
		<input type="hidden" name="action" id="waction" value="">
		<input type="hidden"  name="nt_note" id="wnt_contents"  value="">
		<dl>
			<dt>
				<strong>자료게시판 글쓰기</strong>
			</dt>
			<dd class="content">
				<div id="wrtLmm">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3">
								<input type="text" class="inputTxt p100" name="nt_title" id="wnt_title" v-model="nt_title" autofocus required/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="loginId" id="wenr_user" v-model="loginId" />
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">		
									<div style="width: 900px;" >					 
										<quill-editor id="quillEditor"
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
									<!--multiple="multiple" -->
									<input type="file" name="filename" id="wfilename" @change="setFileName" ></input>
									<img v-if="filename !='' "src="/images/treeview/minus.gif" @click="minusClickEvent">	
								</td>
							</tr>
						</tbody>
					</table>
				</div>						
				<div class="btn_areaC mt30">						
					<a href="javascript:insertLmm()" class="btnType blue" ><span>저장</span></a>
					<a href="javascript:cancle()" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</form>
	</div>
