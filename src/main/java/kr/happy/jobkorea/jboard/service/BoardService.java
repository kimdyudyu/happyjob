package kr.happy.jobkorea.jboard.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BoardService {

	List<Map<String, Object>> getRoomList(Map<String, Object> paramMap);

	int totalCountRoom(Map<String, Object> paramMap);
	
	public void updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	public void insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	void deleteNotice(Map<String, Object> paramMap,  HttpServletRequest request) throws Exception;

	void countUp(String nt_seq);

	Map<String, Object> selectNoticeOne(Map<String, Object> paramMap);

}
