package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happy.jobkorea.hla.model.UserInfoModel;

public interface UserInfoService {
	void 				RegistUser(Map<String, Object> paramMap) throws Exception;
	void				UpdateUser(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	UserInfoModel 		SelectAUserInfo(Map<String, Object> paramMap);
	List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap);
	List<UserInfoModel> SelectLectureList(Map<String, Object> paramMap);
	List<UserInfoModel> SelectStudentList(Map<String, Object> paramMap);
	int 				getSelectedCnt(Map<String, Object> paramMap);
	
	int					getLectureCnt(Map<String, Object> paramMap);
	int					getStudentCnt(Map<String, Object> paramMap);
	
	List<UserInfoModel> ResumeLectureList(Map<String, Object> paramMap);
	List<UserInfoModel> ResumeTestList(Map<String, Object> paramMap);
	List<UserInfoModel> IDValidation(Map<String, Object> paramMap);
}
