package kr.happy.jobkorea.manageC.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface manageC_service {
	List<Map<String, Object>> call_test_exam();
	int totalCountRoom(Map<String, Object> param);
	int totalQcnt(Map<String, Object> param);
	
	List<Map<String, Object>> shList(Map<String, Object> param);
	void insertLmm(Map<String, Object> param, HttpServletRequest request) throws Exception;
	void updateLmm(Map<String, Object> param, HttpServletRequest request) throws Exception;
	List<Map<String, Object>> optionList(Map<String, Object> param); 
	
	List<Map<String, Object>> QList(Map<String, Object> param);
	List<Map<String, Object>> CList(Map<String, Object> param);
	
	void comment_write(Map<String, Object> param);
}
