<script type="text/javascript">
var hResumeVue;

function ResumeTablesInit()
{
	hResumeVue = new Vue({
		el: '#resumeLecture',
		data : {
				vIsUse		: 'N'
			,	vLectures	: []
			,	vTestList	: []
		}
		,methods : {
			Init : function()
			{
				this.vLectures 		= [];
				this.vTestDatas 	= [];				
			},
			SetResumeTable : function(loginID)
			{				
				var param = {
					loginID : loginID //this.vCurrentID
				}				
				//console.log("여기왔나요? 1");
				var resultCallback = function(data) {
					ResumeTableCallback(data);
				};
							
				callAjax("/hla/hSetResumeTable.do", "post", "json", true, param, resultCallback);
			},
			SetUse : function(usetype)
			{
				this.vIsUse = usetype;
			}
		}
	});
	
}

function ResumeTableCallback(data)
{
	console.log(data);
	hResumeVue.vLectures=[];
	hResumeVue.vLectures=data.LectureList;
	hResumeVue.vTestList=[];
	hResumeVue.vTestList=data.TestList;
}


</script>