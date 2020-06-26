package kr.happy.jobkorea.manageC.dao;

import java.util.List;
import java.util.Map;

public interface manageC_Dao {
	List<Map<String, Object>> call_test_exam();

	List<Map<String, Object>> shList(Map<String, Object> param);
	int totalCountRoom(Map<String, Object> param);
	int totalQcnt(Map<String, Object> param);
	
	String getDirectory();
	
	void insertLmm(Map<String, Object> paramMap);
	void updateLmm(Map<String, Object> paramMap);
	void deleteLmm(Map<String, Object> paramMap);
	
	List<Map<String, Object>> optionList(Map<String, Object> paramMap);
	
	List<Map<String, Object>> QList(Map<String, Object> paramMap);
	List<Map<String, Object>> CList(Map<String, Object> paramMap);
	
	void comment_write(Map<String, Object> paramMap);
}
