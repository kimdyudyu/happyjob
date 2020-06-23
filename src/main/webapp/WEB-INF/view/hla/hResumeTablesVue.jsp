<script type="text/javascript">
var hResumeLectureVue;
var hResumeTestVue;

function ResumeTablesInit()
{
	hResumeLectureVue = new Vue({
		el: '#resumeLecture',
		data : {
			/*	vLoginID		: ''
			,	vLectureNo		: ''	
			,	vLectureName	: ''
			,	vTeacherName	: ''
			,	vStartDate		: ''
			,	vEndDate		: ''
			,	vAttend			: 0
			,	vAbsent			: 0
			,*/	
			vLectures		: []
		}
		,methods : {
			Init : function()
			{
				/*this.vLectureName 	= '';
				this.vTeacherName 	= '';
				this.vStartDate 	= '';
				this.vEndDate 		= '';
				this.vAttend		= 0;
				this.vAbsent 		= 0;*/
				this.vLectures 	= [];
				
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

	hResumeTestVue = new Vue({
		el: '#resumeTest',
		data : {
				vTestDatas		: []
		}
		,methods : {
			Init : function()
			{
				this.vTestDatas 	= [];
			},
			LetureList : function()
			{				
				var param = {
					loginID : loginID
				}
				
				//console.log("여기왔나요? 1");
				var resultCallback = function(data) {
					TestListCallback(data);
				};
							
				//callAjax("/hla/hUserInfoList.do", "post", "json", true, param, resultCallback);
			}
		}
	});
	
}

function LectureListCallback(data)
{
	hResumeLectureVue.vLectures=[];
	hResumeLectureVue.vLectures=data.LectureList;		

}

function TestListCallback(data)
{
	hResumeTestVue.vTestDatas=[];
	hResumeTestVue.vTestDatas=data.TestList;
}

</script>