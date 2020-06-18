package kr.happy.jobkorea.hlteacher.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlteacher.model.lectureModel;


public interface hlTeacherService {
	
	List<Map<String, Object>> classList(Map<String, Object> paramMap);
}
