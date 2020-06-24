package kr.happy.jobkorea.hlt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface hlTeacherLmmService {
	
	int totalCountRoom(Map<String, Object> param);
	
	List<Map<String, Object>> lmmList(Map<String, Object> param);
	
	public void updateLmm(Map<String, Object> param, HttpServletRequest request) throws Exception;

	public void insertLmm(Map<String, Object> param, HttpServletRequest request) throws Exception;

	void deleteLmm(Map<String, Object> param,  HttpServletRequest request) throws Exception;
}
