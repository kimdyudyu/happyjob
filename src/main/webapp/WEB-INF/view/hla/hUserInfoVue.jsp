<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

var hUserInfoHeaderVue;
var hUserInfoVue;
var hUserInfoFooterVue;

/*$(function(){	
	//RegisterInit();
	//register.setComboBox();
	//console.log("RegisterInit");
});*/

function hUserInfoHeader()
{
	//alert("hinit");
	//console.log("hUserInfoHeader");
	hUserInfoHeaderVue = new Vue({
		el: '#userInfoHeader',
		data: {
			vformUseType		: 	'I' //ì´ë ¥ì ìì X, ê·¸ë¥ ìì  ì¬ì©, íìê°ì íìì 3ê°ì§? Update, Read ,Create
		}
		,methods: {
			Init : function(UseType)
			{				
				//this.vformUseType = UseType;
			}
		}
	});
}

function hUserInfoFooter()
{
	//alert("finit");
	//console.log("hUserInfoFooter");
	hUserInfoFooterVue = new Vue({
		el: '#userInfoFooter',
		data: {
			vformUseType		: 	'' //ì´ë ¥ì ìì X, ê·¸ë¥ ìì  ì¬ì©, íìê°ì íìì 3ê°ì§? Update, Read ,Create
		}
		,methods: {
			Init : function()
			{				
				//this.vformUseType = hUserInfoHeaderVue.vformUseType;
			}
		}
	});
}

function hUserInfoVueInit() {
	//alert("uinit");
	hUserInfoVue = new Vue({
		el: '#divUserInfoVue'
		,data: {
				vformUseType		: 	'' //ì´ë ¥ì ìì X, ê·¸ë¥ ìì  ì¬ì©, íìê°ì íìì 3ê°ì§? Update, Read ,Create
			,	vUserType			: 	'' // Cíì, D êµì¬, A ê´ë¦¬ì
			,	vUserId				: 	''
			,	vUserPw 			: 	''
			,	vUserName 			: 	''
			,	vUserGender	 		: 	''
			,	vUserPhone1	 		: 	''
			,	vUserPhone2	 		: 	''
			,	vUserPhone3	 		: 	''
			,	vUserAddress		: 	''
			,	vUserJoinDate		: 	''
			,	vUserBirthDate		: 	''
			,	vUserEmail1			: 	''
			,	vUserEmail2			: 	''
			,	vAddressCombo		:	[]
			,	vDomainCombo		:	[]
			,	vIdCheck			:   false
		}
		,methods: {
			Init : function()
			{				
				this.vformUseType = '';
				this.vUserType = '';
				this.vUserId = '';
				this.vUserPw = '';
				this.vUserName = '';
				this.vUserGender = '';
				this.vUserPhone1 = '';
				this.vUserPhone2 = ''; 
				this.vUserPhone3 = '';
				this.vUserAddress = '';
				this.vUserJoinDate = '';
				this.vUserBirthDate = '';
				this.vUserEmail1 = '';
				this.vUserEmail2 = '';
				this.vIdCheck = false;
				//this.vAddressCombo = [];
				//this.vDomainCombo = [];
				this.vformUseType = hUserInfoHeaderVue.vformUseType;
			},
			registUser : function()
			{				
				var param = {
				 	loginID 	: 	this.vUserId,
				 	user_type 	: 	this.vUserType,
				 	name 		: 	this.vUserName,
				 	password 	: 	this.vUserPw,
				 	email 		: 	this.vUserEmail1 + '@' + this.vUserEmail2,
				 	sex 		: 	this.vUserGender,
				 	tel1 		: 	this.vUserPhone1,
				 	tel2 		: 	this.vUserPhone2,
				 	tel3 		: 	this.vUserPhone3,
				 	//join_date 	: 	this.vUserJoinDate,
				 	area 		: 	this.vUserAddress,
				 	birthday 	: 	this.vUserBirthDate,
				 	action		:	"I"
				};
				var resultCallback = function(data) {
					console.log("resultCallback");
					alert(data.resultMsg);
				};
				console.log("registUser");
				//callAjax("/hla/hRegistUser.do", "post", "json", false, param, resultCallback);
				
				$.ajax({
					url : "/hla/hCRUDUser.do",
					type : "post",
					dataType : "json",
					async : true,
					data : param,
					success : function(data) {
//						alert("íì ê°ìì´ ìë£ê° ëììµëë¤");
//						gfCloseModal();
						resultCallback(data);
					}
				});
			},
			SetUserType : function(usertype)
			{
				this.vUserType = usertype;
			},
			UpdateUser : function(){
				var param = {
					 	loginID 	: 	this.vUserId,
					 	user_type 	: 	this.vUserType,
					 	name 		: 	this.vUserName,
					 	password 	: 	this.vUserPw,
					 	email 		: 	this.vUserEmail1 + '@' + this.vUserEmail2,
					 	sex 		: 	this.vUserGender,
					 	tel1 		: 	this.vUserPhone1,
					 	tel2 		: 	this.vUserPhone2,
					 	tel3 		: 	this.vUserPhone3,
					 	area 		: 	this.vUserAddress,
					 	birthday 	: 	this.vUserBirthDate,
					 	action		:	"U"
					};
					var resultCallback = function(data) {
						console.log("updateCallback");
						alert(data.resultMsg);
					};
					console.log("UpdateUser");
					callAjax("/hla/hCRUDUser.do", "post", "json", false, param, resultCallback);
			},
			setComboBox : function(){
				
				var param = {
						"group_code" : "areaCD"
				};
				var resultCallback = function(data) {
					//console.log("setcombo2");
					//console.log(data);
					InitComboCallBack(data);
					//console.log(this.vAddressCombo[0].dtl_cod_nm);
				};
				
				
				$.ajax({
					url : "/commonproc/comcombo.do",
					type : "post",
					dataType : "json",
					async : false,
					data : param,
					success : function(data) {
//						alert("íì ê°ìì´ ìë£ê° ëììµëë¤");
//						gfCloseModal();
						resultCallback(data);
						
					}
				});
				
				var param1 = {
						"group_code" : "MAILCD"
				};
				var resultCallback = function(data) {
					console.log("setcombo3");
					console.log(data);
					InitComboCallBack1(data);
					//console.log(this.vAddressCombo[0].dtl_cod_nm);
				};
				
				
				$.ajax({
					url : "/commonproc/comcombo.do",
					type : "post",
					dataType : "json",
					async : false,
					data : param1,
					success : function(data) {
//						alert("íì ê°ìì´ ìë£ê° ëììµëë¤");
//						gfCloseModal();
						resultCallback(data);						
					}
				});	
			},
			setUserData : function(Data)
			{
				console.log(Data);
				if(Data.email)
				{
					var mailSplit = Data.email.split('@');
					this.vUserEmail1 = mailSplit[0];
					this.vUserEmail2 = mailSplit[1];
				}
				//this.vUserType = Data.user_type;
				this.vUserId = Data.loginID;
				this.vUserPw = Data.password;
				this.vUserName = Data.name;
				this.vUserGender = Data.sex;
				this.vUserPhone1 = Data.tel1;
				this.vUserPhone2 = Data.tel2; 
				this.vUserPhone3 = Data.tel3;
				this.vUserAddress = Data.area;
				this.vUserJoinDate = Data.joinDate;
				this.vUserBirthDate = Data.birthday;

			},
			hidCheck : function()
			{
				if(this.vUserId != '')
				{
					var param = {
							loginID : this.vUserId
					};
					var resultCallback = function(data) {
						CheckIdCallback(data);
					};				
					
					$.ajax({
						url : "/hla/hIdCheck.do",
						type : "post",
						dataType : "json",
						async : true,
						data : param,
						success : function(data) {
							resultCallback(data);						
						}
					});
				}
				else
				{
					alert("아이디를 입력해주세요");
				}
			},
			RegistValidation : function()
			{				
				if(this.vUserId == '')
				{
					alert("아이디를 입력해주세요");
					return false;
				}
				if(this.vUserPw == '')
				{
					alert("비밀번호를 입력해주세요");
					return false;
				}
				if(this.vUserName == '')
				{
					alert("이름을 입력해주세요");
					return false;
				}
				if(this.vUserGender == '')
				{
					alert("성별을 선택해주세요");
					return false;
				}
				if(this.vUserPhone1 == '')
				{
					alert("연락처를 입력해주세요");
					return false;
				}
				if(this.vUserPhone2 == '')
				{
					alert("연락처를 입력해주세요");
					return false;
				}
				if(this.vUserPhone3 == '')
				{
					alert("연락처를 입력해주세요");
					return false;
				}
				if(this.vUserAddress == '')
				{
					alert("거주지를 선택해주세요");
					return false;
				}
				if(this.vUserEmail1 == '')
				{
					alert("이메일을 입력해주세요");
					return false;
				}
				if(this.vUserEmail2 == '')
				{
					alert("이메일을 입력해주세요");
					return false;
				}
				if(this.vUserBirthDate == '')
				{
					alert("생년월일을 선택해주세요");
					return false;
				}
				return true;
			}			
		}
	
	});

	
	
	//ììì¼
	var userBirth = $("#userBirth").datepicker({ 
		dateFormat: 'yy-mm-dd'
	});
	  
	$("#userBirth").change(function() {
		//$("#userBirth").datepicker("option", "minDate", $(this).val());
		hUserInfoVue.vUserBirthDate = $("#userBirth").val();
	})
	
	var userjoinDate = $("#userjoinDate").datepicker({ 
		dateFormat: 'yy-mm-dd'
	});
	  
	$("#userjoinDate").change(function() {
		hUserInfoVue.vUserJoinDate = $("#userjoinDate").val();
	})

};
function SetFormUseType(usetype)
{
	hUserInfoHeaderVue.vformUseType = usetype;
	hUserInfoVue.vformUseType = usetype;
	hUserInfoFooterVue.vformUseType = usetype;	
}

function CheckIdCallback(data)
{
	hUserInfoVue.vIdCheck = data.result;
	if(data.result)
	{		
		alert(data.resultMsg);
		return true;
	}
	else
	{
		alert(data.resultMsg);
		return false;
	}
}

function UserInfoFormInit()
{
	hUserInfoHeader();
	hUserInfoFooter();
	hUserInfoVueInit();
	hUserInfoHeaderVue.Init();
	hUserInfoVue.Init();
	hUserInfoFooterVue.Init();
	hUserInfoVue.setComboBox();
}

function InitComboCallBack(data)
{
	hUserInfoVue.vAddressCombo = [];
	hUserInfoVue.vAddressCombo = data.list;
}

function InitComboCallBack1(data)
{
	hUserInfoVue.vDomainCombo = [];
	hUserInfoVue.vDomainCombo = data.list;
}

function RegistUser()
{
	if(hUserInfoVue.RegistValidation())
	{	
		if(hUserInfoVue.vIdCheck)
		{
			console.log("Is Regist?");
			hUserInfoVue.registUser();
			hUserInfoVue.Init();
			$("#userInfoPopup").hide();
			//alert(hUserInfoVue.vUserType);
		}
		else
		{
			alert("아이디 중복체크 해주세요");
		}
	}
}
function UpdateUser()
{
	console.log("Is Update?");
	hUserInfoVue.UpdateUser();
	hUserInfoVue.Init();
	$("#userInfoPopup").hide();
	location.reload();
}

function UpdateMe()
{
	hUserInfoVue.UpdateUser();
}
</script>