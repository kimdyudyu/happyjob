<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이력서 관리</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!--  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>-->

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/hla/hUserInfoVue.jsp"></jsp:include>

<title>정보 수정</title>
<script>
$(function(){
	UserInfoFormInit();
	SetFormUseType("U");
	InitInfoPage();
	

});

function InitInfoPage()
{
	var param = {
			action			: "UR"
	}
	var resultCallback = function(data) {
		SetUpdateUserCallback(data);
	};			

	callAjax("/hla/hCRUDUser.do", "post", "json", true, param, resultCallback);
}

function SetUpdateUserCallback(data)
{
	param = [];
	param = data.userInfo;
	hUserInfoVue.setUserData(param);
}

</script>

</head>
<body>
	<div id="wrap_area">
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>	

					<li class="contents">
						<div class="content">						
							<p class="Location">
								<a href="#" class="btn_set home">마이페이지</a> <a href="#"
									class="btn_nav">마이페이지</a> <span class="btn_nav bold"> 정보수정</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
						<jsp:include page="/WEB-INF/view/hla/hUserInfoForm.jsp"></jsp:include>
						<div>
							<a href="javascript:UpdateMe()"	class="btnType gray"  id="btnClose" name="btn"><span>수정</span></a>
						</div>						
					</li>
				</ul>
			</div>
	</div>

	
</body>
</html>