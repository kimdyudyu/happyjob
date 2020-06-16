package kr.happy.jobkorea.jmli.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmli.model.JmliProjectModel;
import kr.happy.jobkorea.jmli.model.JmliProjectSkill;
import kr.happy.jobkorea.jmli.model.JmliUserSkill;

public interface JmliProjectDao {

	List<JmliProjectModel> getProjectList(Map<String, Object> paramMap);

	int totalCountProject(Map<String, Object> paramMap);
	
	JmliProjectModel selectProjectOne(String projectId);

	List<JmliProjectSkill> selectProjectSkill(String projectId);

	int deleteTB_Project(String projectId);

	int deleteTB_ProjectSKILL(String projectId);

	int deleteTB_priApplication(String projectId);

	int proectUpdate_project(Map<String, Object> paramMap);

	int proectUpdate_deleteSkill(Map<String, Object> paramMap);

	int proectUpdate_updateSkill(JmliUserSkill userSkill);

	int applyProject(Map<String, Object> paramMap);

	int resisterproject(Map<String, Object> paramMap);

	String getUserInfo(String id);
}
