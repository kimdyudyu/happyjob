package kr.happy.jobkorea.hlteacher.dao;

import java.util.List;
import java.util.Map;

public interface hlTeacherDao {
	
	List<Map<String, Object>> getClassList(Map<String, Object> paramMap);
}
