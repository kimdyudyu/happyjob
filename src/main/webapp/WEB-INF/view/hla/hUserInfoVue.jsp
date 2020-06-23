<script type="text/javascript">

var hUserInfoHeader;
var hUserInfoVue;
var hUserInfoFooter;

/*$(function(){	
	//RegisterInit();
	//register.setComboBox();
	//console.log("RegisterInit");
});*/

function hUserInfoHeader()
{
	console.log("hUserInfoHeader");
	hUserInfoHeader = new Vue({
		el: '#userInfoHeader',
		data: {
			vformUseType		: 	'I' //이력서 수정X, 그냥 수정 사용, 회원가입 타입은 3가지? Update, Read ,Create
		}
		,methods: {
			Init : function(UseType)
			{
				this.vformUseType = UseType;
			}
		}
	});
}

function hUserInfoFooter()
{
	console.log("hUserInfoFooter");
	hUserInfoFooter = new Vue({
		el: '#userInfoFooter',
		data: {
			vformUseType		: 	'' //이력서 수정X, 그냥 수정 사용, 회원가입 타입은 3가지? Update, Read ,Create
		}
		,methods: {
			Init : function()
			{
				this.vformUseType = hUserInfoHeader.vformUseType;
			}
		}
	});
}

function hUserInfoVueInit() {
	
	console.log("hUserInfoVueInit");
	hUserInfoVue = new Vue({
		el: '#hUserInfoVue',
		data: {
				vformUseType		: 	'' //이력서 수정X, 그냥 수정 사용, 회원가입 타입은 3가지? Update, Read ,Create
			,	vUserType			: 	'C' // C학생, D 교사, A 관리자
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
				//this.vAddressCombo = [];
				//this.vDomainCombo = [];
				this.vformUseType = hUserInfoHeader.vformUseType;
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
					async : false,
					data : param,
					success : function(data) {
//						alert("회원 가입이 완료가 되었습니다");
//						gfCloseModal();
						resultCallback(data);
					}
				});
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
					console.log("setcombo2");
					console.log(data);
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
//						alert("회원 가입이 완료가 되었습니다");
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
//						alert("회원 가입이 완료가 되었습니다");
//						gfCloseModal();
						resultCallback(data);						
					}
				});	
			},
			setUserData : function(Data)
			{
				console.log(Data);
				var mailSplit = Data.email.split('@');
				
				this.vUserType = Data.user_type;
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
				this.vUserEmail1 = mailSplit[0];
				this.vUserEmail2 = mailSplit[1];
			}
		}
	
	});

	
	
	//시작일
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

function totalInit()
{
	hUserInfoVue.Init();
	hUserInfoFooter.Init();
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
	console.log("Is Regist?");
	hUserInfoVue.registUser();
	hUserInfoVue.Init();
	$("#userInfoPopup").hide();
	
}

function UpdateUser()
{
	console.log("Is Update?");
	hUserInfoVue.UpdateUser();
	hUserInfoVue.Init();
	$("#userInfoPopup").hide();	
}	
</script>