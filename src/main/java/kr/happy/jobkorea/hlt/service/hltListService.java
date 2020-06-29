package kr.happy.jobkorea.hlt.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlt.model.lectureModel;
import kr.happy.jobkorea.supportD.model.NoticeDModel;

public interface hltListService {

	List<lectureModel> classList(Map<String, Object> paramMap);
	
	lectureModel detailClass(Map<String, Object> paramMap);
	
	List<lectureModel> hltManageList(Map<String, Object> paramMap);
	
	void hltDeleteNo(Map<String, Object> paramMap);
	
	void hltModalList(Map<String, Object> paramMap);
	
	List<lectureModel> evaluationList(Map<String, Object> paramMap);
	
	List<lectureModel> DetailSurveyList(Map<String, Object> paramMap);
	
}
