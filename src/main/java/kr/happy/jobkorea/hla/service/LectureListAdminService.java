package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.dao.LectureListAdminDao;
import kr.happy.jobkorea.hla.model.LectureListAdminModel;

public interface LectureListAdminService {
	List<LectureListAdminModel> lectureListAdminList(Map<String, Object> paramMap);

	int lectureListAdminCount(Map<String, Object> paramMap) throws Exception;

	List<LectureListAdminModel> lectureStudentList(Map<String, Object> paramMap);

	int lectureStudentListCount(Map<String, Object> paramMap) throws Exception;

	int resty(Map<String, Object> paramMap);

	int restn(Map<String, Object> paramMap);

	LectureListAdminModel studentInfo(Map<String, Object> paramMap);
}
