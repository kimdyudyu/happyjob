package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.UserInfoModel;

public interface UserInfoDao {
	void RegistUser(Map<String, Object> paramMap);
	void UpdateUser(Map<String, Object> paramMap);
	
	List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap);
	
	int getSelectedCnt(Map<String, Object> paramMap);
}
