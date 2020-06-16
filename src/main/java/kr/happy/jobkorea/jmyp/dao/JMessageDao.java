package kr.happy.jobkorea.jmyp.dao;


import java.util.List;


import java.util.Map;
import kr.happy.jobkorea.jmyp.model.JMessageModel;

public interface JMessageDao {
	//Message리스트 출력
	public List<JMessageModel> messageList(Map<String, Object> paramMap);
	
	//public int getTotalCnt(Map<String, Object> paramMap);
	
	public int getSelectedCnt(Map<String, Object> paramMap);

	public int insertMessage(Map<String, Object> paramMap);

	//public void selectMessageCountup(Map<String, Object> paramMap);
	//public void updateMessage(Map<String, Object> paramMap);
	public int deleteMessage(Map<String, Object> paramMap);
	
	
	public List<JMessageModel> SearchID(Map<String, Object> paramMap);
	
	public int getSelectedIDCnt(Map<String, Object> paramMap);
	
}