package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.UserInfoModel;

public interface UserInfoDao {
	void RegistUser(Map<String, Object> paramMap);
	void UpdateUser(Map<String, Object> paramMap);
	
	List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap);
	
	UserInfoModel 		SelectAUserInfo(Map<String, Object> paramMap);
	
	List<UserInfoModel> SelectLectureList(Map<String, Object> paramMap);
	int 				getSelectedCnt(Map<String, Object> paramMap);
	int 				getLectureCnt(Map<String, Object> paramMap);
	
	int 				getStudentCnt(Map<String, Object> paramMap);
	List<UserInfoModel> SelectStudentList(Map<String, Object> paramMap);
	
	List<UserInfoModel> ResumeLectureList(Map<String, Object> paramMap);
	
	List<UserInfoModel> ResumeTestList(Map<String, Object> paramMap);
	//int 				ResumeTestScore(Map<String, Object> paramMap);
}
