package kr.happy.jobkorea.jmli.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmli.model.JmliUserSkill;
import kr.happy.jobkorea.jmli.model.developerModel;

public interface JmliDeveloperDao {

	List<Map<String, Object>> getDeveloperList(Map<String, Object> paramMap);

	int totalCountDeveloper(Map<String, Object> paramMap);

	void idUp(String loginID);

	int getDeveloperCnt(String loginID);

	developerModel selectDeveloperOne(String loginID);
	
	List<JmliUserSkill> showSkill(String loginID);
	
	public int insertMessage(Map<String, Object> paramMap);

}
