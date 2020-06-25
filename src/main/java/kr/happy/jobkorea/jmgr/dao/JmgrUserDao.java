package kr.happy.jobkorea.jmgr.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmgr.model.JmgrUserModel;
import kr.happy.jobkorea.jmgr.model.JmgrUserSkill;

public interface JmgrUserDao {

	List<Map<String, Object>> getUserList(Map<String, Object> paramMap);

	int totalCountUser(Map<String, Object> paramMap);

	void idUp(String loginID);

	int getDeveloperCnt(String loginID);

	void deleteSkill(String loginID);

	void updateUser(Map<String, Object> paramMap);

	void updateComp(Map<String, Object> paramMap);
	
	void deleteUser(String loginID);

	JmgrUserModel selectDeveloperOne(String loginID);

	void insertSkill(Map<String, Object> paramMap);
	
	List<JmgrUserSkill> showSkill(String loginID);

}
