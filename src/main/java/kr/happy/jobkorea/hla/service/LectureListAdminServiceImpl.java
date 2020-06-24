package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.LectureListAdminDao;
import kr.happy.jobkorea.hla.model.LectureListAdminModel;

@Service
public class LectureListAdminServiceImpl implements LectureListAdminService {
	@Autowired
	LectureListAdminDao lectureListAdminDao;

	@Override
	public List<LectureListAdminModel> lectureListAdminList(Map<String, Object> paramMap) {
		List<LectureListAdminModel> lectureListAdminList = lectureListAdminDao.lectureListAdminList(paramMap);
		return lectureListAdminList;
	}

	@Override
	public int lectureListAdminCount(Map<String, Object> paramMap) throws Exception {
		int lectureListAdminCount = lectureListAdminDao.lectureListAdminCount(paramMap);
		return lectureListAdminCount;
	}

	@Override
	public List<LectureListAdminModel> lectureStudentList(Map<String, Object> paramMap) {
		List<LectureListAdminModel> lectureStudentList = lectureListAdminDao.lectureStudentList(paramMap);
		return lectureStudentList;
	}

	@Override
	public int lectureStudentListCount(Map<String, Object> paramMap) throws Exception {
		int lectureStudentListCount = lectureListAdminDao.lectureStudentListCount(paramMap);
		return lectureStudentListCount;
	}

	@Override
	public int restyn(Map<String, Object> paramMap) {
		int restyn = lectureListAdminDao.restyn(paramMap);
		return restyn;
	}

}
