package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.LectureRoomDao;
import kr.happy.jobkorea.hla.model.LectureRoomModel;

@Service
public class LectureRoomServiceImpl implements LectureRoomService {

	@Autowired
	LectureRoomDao lectureRoomDao;

	@Override
	public List<LectureRoomModel> lectureRoomList(Map<String, Object> paramMap) {
		List<LectureRoomModel> lectureRoomList = lectureRoomDao.lectureRoomList(paramMap);
		return lectureRoomList;
	}

	@Override
	public int lectureRoomTotalCnt(Map<String, Object> paramMap) {
		int lectureRoomTotalCnt = lectureRoomDao.lectureRoomTotalCnt(paramMap);
		return lectureRoomTotalCnt;
	}

	@Override
	public int lectureRoomInsert(Map<String, Object> paramMap) {
		int lectureRoomInsert = lectureRoomDao.lectureRoomInsert(paramMap);
		return lectureRoomInsert;
	}

	@Override
	public LectureRoomModel lectureRoomDetail(Map<String, Object> paramMap) {
		LectureRoomModel lectureRoomDetail = lectureRoomDao.lectureRoomDetail(paramMap);
		return lectureRoomDetail;
	}

	@Override
	public int lectureRoomDelete(Map<String, Object> paramMap) {
		int lectureRoomDelete = lectureRoomDao.lectureRoomDelete(paramMap);
		return lectureRoomDelete;
	}

	@Override
	public int lectureRoomUpdate(Map<String, Object> paramMap) {
		int lectureRoomUpdate = lectureRoomDao.lectureRoomUpdate(paramMap);
		return lectureRoomUpdate;
	}

}
