package kr.happy.jobkorea.jmgr.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happy.jobkorea.jmgr.model.JmgrUserModel;



public interface JmgrUserService {

	List<Map<String, Object>> getUserList(Map<String, Object> paramMap);

	int totalCountUser(Map<String, Object> paramMap);

	public int idUp(String loginID);

	public void deleteSkill(String loginID);

	public void deleteUser(String loginID);

	public void updateUser(Map<String, Object> paramMap) throws Exception;

	public void updateComp(Map<String, Object> paramMap) throws Exception;
	
	JmgrUserModel selectDeveloperOne(String loginID);

	void insertSkill(String loginID, String rawSkill_code, String skill_detail);
	
	List<String> showSkill(String loginID);
	
}
