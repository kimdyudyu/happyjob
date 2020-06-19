package kr.happy.jobkorea.hlteacher.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlteacher.model.lectureModel;

public interface hlTeacherDao {
	
	List<lectureModel> getClassList(Map<String, Object> paramMap);
}
