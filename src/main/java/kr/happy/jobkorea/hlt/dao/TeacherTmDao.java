package kr.happy.jobkorea.hlt.dao;

import java.util.List;
import java.util.Map;

public interface TeacherTmDao {
	
	List<Map<String, Object>> tmList(Map<String, Object> param);
	
	int totalCountRoom(Map<String, Object> param);
	
	Map<String, Object> selectTmFile(Map<String, Object> paramMap);
}
