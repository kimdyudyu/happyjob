package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happy.jobkorea.hla.model.LecListModel;

public interface LecService {

	List<LecListModel> lectList(Map<String, Object> paramMap)throws Exception;

	int lecListCount(Map<String, Object> paramMap) throws Exception;
	
	List<LecListModel> lectPeopleInfo(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> studentCnsInfo(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> cnsDetail(Map<String, Object> paramMap) throws Exception;
	
	int updateCns(Map<String, Object> paramMap) throws Exception;
	
    void insertCns(Map<String, Object> paramMap) throws Exception;
	/*	List<LecListModel> classtListAct(Map<String, Object> paramMap)throws Exception;

	public int applyForClass(Map<String, Object> paramMap) throws Exception;
*/
}
