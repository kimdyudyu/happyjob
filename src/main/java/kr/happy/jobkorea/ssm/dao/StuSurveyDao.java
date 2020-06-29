package kr.happy.jobkorea.ssm.dao;

import java.util.List;
import java.util.Map;

public interface StuSurveyDao {

	List<Map<String, Object>> getLecList(Map<String, Object> paramMap);

	Map<String, Object> getSurveyList(Map<String, Object> paramMap);

	void savesurvey(Map<String, Object> paramMap);

}
