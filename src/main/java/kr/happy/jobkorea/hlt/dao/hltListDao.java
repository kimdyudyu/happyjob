package kr.happy.jobkorea.hlt.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlt.model.lectureModel;

public interface hltListDao {
	
	List<lectureModel> getClassList(Map<String, Object> paramMap);
	
	lectureModel detailList(Map<String, Object> paramMap);
	
	int getClassPerson(String No);
	
	List<lectureModel> hltManageList(Map<String, Object> paramMap);
	
	void hltDeleteNo(Map<String, Object> paramMap);
	
	void ModalUpdate(Map<String, Object> paramMap);
	
	void ModalInsert(Map<String, Object> paramMap);
	
	List<lectureModel> evaluationList(Map<String, Object> paramMap);
	
	List<lectureModel> DetailSurveyList(Map<String, Object> paramMap);
	
}
