package kr.happy.jobkorea.mss.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.mss.model.AdminLecModel;
import kr.happy.jobkorea.mss.model.AdminRModel;

public interface AdminPlDao {

	List<AdminLecModel> aPlist(Map<String, Object> paramMap);

	int countaPlist(Map<String, Object> paramMap);

	AdminLecModel selectaPlist(Map<Object, String> paramMap);

	int updateaPlist(Map<String, Object> paramMap);

	int deletePlist(Map<String, Object> paramMap);

	int insertaPlist(Map<String, Object> paramMap);

	List<Map<String,Object>> rList(Map<Object, String> paramMap);

}
