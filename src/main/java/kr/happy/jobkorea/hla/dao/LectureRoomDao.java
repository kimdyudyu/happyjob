package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.LectureRoomModel;

public interface LectureRoomDao {
	List<LectureRoomModel> lectureRoomList(Map<String, Object> paramMap);

	int lectureRoomTotalCnt(Map<String, Object> paramMap);
	
	int lectureRoomInsert(Map<String, Object> paramMap);
	
	LectureRoomModel lectureRoomDetail(Map<String, Object> paramMap);
	
	int lectureRoomDelete(Map<String, Object> paramMap);
	
	int lectureRoomUpdate(Map<String, Object> paramMap);
}
