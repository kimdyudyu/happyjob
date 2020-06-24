package kr.happy.jobkorea.hlt.dao;

import java.util.List;
import java.util.Map;

public interface hlTeacherLmmDao {
	
	List<Map<String, Object>> lmmList(Map<String, Object> param);
	
	int totalCountRoom(Map<String, Object> param);
	
	String getDirectory();

	void insertLmm(Map<String, Object> paramMap);

	void updateLmm(Map<String, Object> paramMap);

	void deleteLmm(Map<String, Object> paramMap);
}
