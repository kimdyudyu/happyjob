<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
	<form id="CompanyForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<div id="layer3" class="layerPop layerType3" style="width: 1000px;">
			<dl>
				<dt>
					<strong>기업회원 가입</strong>
				</dt>
				<dd class="container">
					<!-- s : 여기에 내용입력 -->
					<table class="row" id="detailtable2">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						
						<tbody>
							<tr>
								<th scope="row" style="width:100px;">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="loginID" id="registerId" style="width:100px; height:20px;" v-model="loginID" /></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">회사명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="comp_name" id="comp_name" style="width:100px; height:20px;"/></td>
								<th scope="row" style="width:100px;">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mailtxt" name="email" id="compEmail" style="width:80px; height:20px;"/>
									@
									<input class="domaintxt" name="email_cop" id="domainEmail" list="emailselect" placeholder="직접입력/선택" style="width:100px; height:20px;"/>
									<datalist name="emailselect" id="emailselect" style="width:100px; height:22px;">
									    <option value="">이메일 선택</option>
									    <option value="naver.com">네이버</option>
									    <option value="gmail.com">구글</option>
									    <option value="daum.net">다음</option>
									</datalist>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="mgr_name" id="mgr_name" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">설립일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="compDate" name="comp_birthday" id="comp_birthday" style="width:100px; height:20px;"/>
								</td>
								<th scope="row" style="width:100px;">연락처<span class="font_red">*</span></th>
								<td>
									<select name="mgr_tel1" id="mgr_tel1" style="width:90px; height:22px;">
									    <option value="">번호 선택</option>
									    <option value="010">010</option>
									    <option value="011">011</option>
									    <option value="019">017</option>
									    <option value="017">019</option>
									</select>
									<input type="text" class="midNum" name="mgr_tel2" id="mgr_tel2" style="width:80px; height:20px;"/>
									<input type="text" class="lastNum" name="mgr_tel3" id="mgr_tel3" style="width:80px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">회사소개</th>
								<td colspan="5">
									<input type="text" class="comp_info" name="comp_info" id="comp_info" style="width:900px; height:200px;"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_areaC mt30" id="updateoption">
						
							<a href="javascript:fdeleteUser()" class="btnType blue"><span>삭제</span></a>
									
							<a href="javascript:fupdateComp()" class="btnType blue"><span>수정</span></a>
									
							<a href="javascript:cancle()" class="btnType gray" ><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>