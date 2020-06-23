<script type="text/javascript">
var hResumeVue;

function ResumeMgrInit()
{
	hResumeVue = new Vue({
		el: '#resumeLecture',
		data : {
				vLoginID		: ''
			,	vLectureNo		: ''	
			,	vLectureName	: ''
			,	vTeacherName	: ''
			,	vStartDate		: ''
			,	vEndDate		: ''
			,	vAttend			: 0
			,	vAbsent			: 0
			,	vLectures		: []
		}
		,methods : {
			Init : function()
			{
				this.vLectureName 	= '';
				this.vTeacherName 	= '';
				this.vStartDate 	= '';
				this.vEndDate 		= '';
				this.vAttend		= 0;
				this.vAbsent 		= 0;
			},
			LetureList : function()
			{				
				var param = {
					loginID : loginID
				}
				
				//console.log("여기왔나요? 1");
				var resultCallback = function(data) {
					LectureListCallback(data);
				};
							
				//callAjax("/hla/hUserInfoList.do", "post", "json", true, param, resultCallback);
			}
		}
	});
}

function LectureListCallback(data)
{
	
}

</script>