package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.UserInfoDao;
import kr.happy.jobkorea.hla.model.UserInfoModel;


@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	@Autowired
	UserInfoDao userInfoDao;

	@Override
	public void RegistUser(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		userInfoDao.RegistUser(paramMap);
	}

	@Override
	public List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectUserInfo(paramMap);
	}

	@Override
	public int getSelectedCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getSelectedCnt(paramMap);
	}

	@Override
	public void UpdateUser(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		userInfoDao.UpdateUser(paramMap);
	}

	@Override
	public List<UserInfoModel> SelectLectureList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectLectureList(paramMap);
	}

	@Override
	public int getLectureCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getLectureCnt(paramMap);
	}

	@Override
	public List<UserInfoModel> SelectStudentList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectStudentList(paramMap);
	}

	@Override
	public int getStudentCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getStudentCnt(paramMap);
	}

	@Override
	public List<UserInfoModel> ResumeLectureList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.ResumeLectureList(paramMap);
	}

	@Override
	public List<UserInfoModel> ResumeTestList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.ResumeTestList(paramMap);
	}

	@Override
	public UserInfoModel SelectAUserInfo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectAUserInfo(paramMap);
	}

	@Override
	public List<UserInfoModel> IDValidation(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.IDValidation(paramMap);
	}

}
