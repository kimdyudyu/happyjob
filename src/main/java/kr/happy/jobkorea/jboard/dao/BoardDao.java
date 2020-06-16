package kr.happy.jobkorea.jboard.dao;

import java.util.List;
import java.util.Map;

public interface BoardDao {

	List<Map<String, Object>> getRoomList(Map<String, Object> paramMap);
	

	int totalCountRoom(Map<String, Object> paramMap);
	

	void countUp(String nt_seq);

	int getNoticeCnt(String nt_seq);

	List<Map<String, Object>> getListReply(Map<String, Object> paramMap);

	void insertReply(Map<String, Object> paramMap);

	void deleteReplyOne(int no);

	String getDirectory();

	void insertNotice(Map<String, Object> paramMap);

	void updateNotice(Map<String, Object> paramMap);

	void deleteNotice(Map<String, Object> paramMap);

	Map<String, Object> selectNoticeOne(Map<String, Object> paramMap);
}
