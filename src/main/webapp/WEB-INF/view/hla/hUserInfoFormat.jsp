<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/khcss/gridsetting.css" />

	<div id="userInfoPopup" class="layerPop layerType2" style="width: 900px; height: 500px;">
		<div id="userInfoHeader">
			<p class="conTitle">
				<span v-if="vformUseType === 'I'">회원 가입</span>
				<span v-if="vformUseType === 'U'">정보 수정</span>
				<span v-if="vformUseType === 'R'">이력서</span>
			</p>
		</div>
		<!-- ----------------------------------------------------------- -->
		<jsp:include page="/WEB-INF/view/hla/hUserInfoForm.jsp"></jsp:include>
		<!-- ----------------------------------------------------------- -->
	
		<div id="userInfoFooter">
			<template v-if="vformUseType === 'I'">
				<a href="javascript:RegistUser()"	class="btnType gray"  id="btnClose" name="btn"><span>등록</span></a>
				<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
			</template>
			<template v-if="vformUseType === 'U'">
				<a href="javascript:UpdateUser()"	class="btnType gray"  id="btnClose" name="btn"><span>수정</span></a>
				<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
			</template>
			<template v-if="vformUseType === 'R'">
				
			</template>
		</div>
	</div>