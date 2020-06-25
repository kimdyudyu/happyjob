package kr.happy.jobkorea.hlt.service;

import java.util.List;
import java.util.Map;

public interface TeacherTmService {
	
	int totalCountRoom(Map<String, Object> param);
	
	List<Map<String, Object>> tmList(Map<String, Object> param);
	
	Map<String, Object> selectTmFile(Map<String, Object> paramMap);
}
