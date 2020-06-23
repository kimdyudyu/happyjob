package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;
import kr.happy.jobkorea.hla.model.UserInfoModel;

public interface UserInfoService {
	void 				RegistUser(Map<String, Object> paramMap) throws Exception;
	void				UpdateUser(Map<String, Object> paramMap) throws Exception;
	
	List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap);
	List<UserInfoModel> SelectLectureList(Map<String, Object> paramMap);
	
	int 				getSelectedCnt(Map<String, Object> paramMap);
	
}
