package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.LecListModel;

public interface LecDao {

	List<LecListModel> lectList(Map<String, Object> paramMap);
	
	int lecListCount(Map<String, Object> paramMap);

	List<LecListModel> lectPeopleInfo(Map<String, Object> paramMap);
	
	List<Map<String, Object>> studentCnsInfo(Map<String, Object> paramMap);

	List<Map<String, Object>> cnsDetail(Map<String, Object> paramMap);
	
	int updateCns(Map<String, Object> paramMap);
	int insertCns(Map<String, Object> paramMap);
	
	/*	List<LecListModel> classtListAct(Map<String, Object> paramMap);

	public int applyForClass(Map<String, Object> paramMap);
*/
}
