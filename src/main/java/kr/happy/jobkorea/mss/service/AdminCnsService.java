package kr.happy.jobkorea.mss.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.mss.model.AdminCnsModel;
import kr.happy.jobkorea.mss.model.AdminLecModel;

public interface AdminCnsService {

	List<AdminLecModel> cnsList(Map<String, Object> paramMap);

	int countlist(Map<String, Object> paramMap);

	List<AdminLecModel> cnsUserList(Map<String, Object> paramMap);

	int countUser(Map<String, Object> paramMap);

	AdminCnsModel selectUser(Map<Object, String> paramMap);

	int insertCnsUser(Map<String, Object> paramMap);

	int updateCnsUser(Map<String, Object> paramMap);

	int deleteClist(Map<String, Object> paramMap);

}
