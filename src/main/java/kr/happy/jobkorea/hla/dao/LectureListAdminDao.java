package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.LectureListAdminModel;

public interface LectureListAdminDao {
	List<LectureListAdminModel> lectureListAdminList(Map<String, Object> paramMap);

	int lectureListAdminCount(Map<String, Object> paramMap) throws Exception;
	
	List<LectureListAdminModel> lectureStudentList(Map<String, Object> paramMap);

	int lectureStudentListCount(Map<String, Object> paramMap) throws Exception;
	
	int restyn(Map<String, Object> paramMap);
}
