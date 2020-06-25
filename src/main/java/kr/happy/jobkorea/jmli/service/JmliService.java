package kr.happy.jobkorea.jmli.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmli.model.JmliProjectModel;
import kr.happy.jobkorea.jmli.model.JmliProjectSkill;
import kr.happy.jobkorea.jmli.model.developerModel;



public interface JmliService {

	List<Map<String, Object>> getDeveloperList(Map<String, Object> paramMap);

	int totalCountDeveloper(Map<String, Object> paramMap);

	public int idUp(String loginID);
	
	int insertMessage(Map<String, Object> paramMap) throws Exception ;

	developerModel selectDeveloperOne(String loginID);

	List<String> showSkill(String loginID);
	
	List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap);

	int totalCountNoticeList();

	List<JmliProjectModel> projectList(Map<String, Object> paramMap);

	int totalCountProjectList(Map<String, Object> paramMap);
	
	JmliProjectModel selectProjectOne(String projectId);

	List<JmliProjectSkill> selectProjectSkill(String projectId);

	int deleteTB_Project(String projectId);

	int deleteTB_ProjectSKILL(String projectId);

	int deleteTB_priApplication(String projectId);

	Map<String, Object> projectUpdate_data(Map<String, Object> paramMap);

	int proectUpdate_project(Map<String, Object> paramMap);

	int proectUpdate_deleteSkill(Map<String, Object> paramMap);

	int applyProject(Map<String, Object> paramMap);

	int resisterproject(Map<String, Object> paramMap);

	String getUserInfo(String id);
	
}
