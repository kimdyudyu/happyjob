<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
<div id="questionForm" class="layerPop layerType2"
	style="width: 1100px; hight: 1000px;">


	<div class="bootstrap-table">
		<div class="fixed-table-toolbar">
		<div class="columns columns-right btn-group pull-right"></div>
		</div>
		<div class="fixed-table-container" style="padding-bottom: 0px;">
			<div class="fixed-table-body">
				<div id="makingQuestion">
					<table class="row" id="detailtable_n"><!--  id="detailtable"  -->
						<caption>caption</caption>
					<!--	
						<colgroup>
							<col width="60px">
							<col width="120px">
							<col width="120px">
							<col width="300px">
							<col width="120px">
							<col width="120px">
						</colgroup>
						-->
						<tbody>
							
							<tr>
								<th scope="row">문제번호 </th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="seq"/ >
									</td>
								<th scope="row">문제 </th>
									<td  colspan="7">
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="problem" /> 
									</td>
								<th scope="row">정답 </th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="answer"/>
									</td>
							</tr>
						</table>
						<table class="row" id="">
							<tr>
								<th scope="row">보기1</th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="answer1"/>
									</td>
								<th scope="row">보기2</th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="answer2" /> 
									</td>
								<th scope="row">보기3</th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="answer3"/>
									</td>
								<th scope="row">보기4</th>
									<td>
										<input type="text" class="inputTxt p100" name="inputTxtQuestions" id="" v-model="answer4"/>
									</td>
								
									<td>
										<input type="button" class="inputTxt p100" name="" id="" value="추가" @click="questionAdd"/>
										<input type="button" class="inputTxt p100" name="" id="" value="삭제 "@click="questionDelete"/>
									</td>
								
							</tr>
						<!-- </tbody> -->
					</table>
				</div>
				
				
				
			<div>
				<table id=questionList class="col2 mb10" style="width: 1000px;">
					<colgroup>
						<col width="80px">
						<col width="200px">
						<col width="60px">
						<col width="100px">
						<col width="100px">
						<col width="100px">
						<col width="100px">
						<col width="100px">
					</colgroup>
					<thead>
						<tr>
							<th>문제번호</th>
							<th>문제</th>
							<th>정답</th>
							<th>보기1</th>
							<th>보기2</th>
							<th>보기3</th>
							<th>보기4</th>
							<th colspan="2">점수</th>
						</tr>
					</thead>
					<tbody id="makingQuestionList">
						
					</tbody>
					<tfoot>
						<tr>
							<td colspan="8" style="text-align:right">
								<button id="saveQuestion">저장</button>
								<button id="cancleButton">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
				</div>
				<div>
					<div>
						<div class="clearfix" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
