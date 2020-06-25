package kr.happy.jobkorea.jmyp.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import kr.happy.jobkorea.jmyp.model.JMessageModel;

public interface JMessageService {
	
	List<JMessageModel> messageList(Map<String, Object> paramMap) throws Exception;
	
	int getSelectedCnt(Map<String, Object> paramMap) throws Exception ;

	int insertMessage(Map<String, Object> paramMap) throws Exception ;

	//void selectMessageCountup(Map<String, Object> paramMap);
	int deleteMessage(Map<String, Object> paramMap) throws Exception;
	
	List<JMessageModel> SearchID(Map<String, Object> paramMap) throws Exception;
	
	int getSelectedIDCnt(Map<String, Object> paramMap) throws Exception ;
	
}
