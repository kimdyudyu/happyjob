package kr.happy.jobkorea.jmyp.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmyp.dao.MypageADao;
import kr.happy.jobkorea.jmyp.model.UserInfoVO;
import kr.happy.jobkorea.jmyp.model.aMypageVO;


@Service
public class MypageAServiceImpl implements MypageAService {

	@Autowired
	MypageADao mypageADao;

	@Override
	public List<aMypageVO> DmypageBoard(Map<String, Object> paramMap) throws Exception {
		return mypageADao.DmypageBoard(paramMap);
	}

	
	@Override
	public int DBoardCnt(Map<String, Object> paramMap) {
		return mypageADao.DBoardCnt(paramMap);
	}


	
	@Override
	public List<aMypageVO> CmypageBoard(Map<String, Object> paramMap) throws Exception {
		return mypageADao.CmypageBoard(paramMap);
	}


	@Override
	public int CBoardCnt(Map<String, Object> paramMap) {
		return mypageADao.CBoardCnt(paramMap);
	}


	@Override
	public List<aMypageVO> supplyList(Map<String, Object> paramMap) throws Exception {
		return mypageADao.supplyList(paramMap);
	}


	@Override
	public aMypageVO projectDetailD(Map<String, Object> paramMap) throws Exception {
		return mypageADao.projectDetailD(paramMap);
	}


	@Override
	public void supplyDeleteD(String projectId, String loginId) throws Exception {
		mypageADao.supplyDeleteD(projectId, loginId);
	}


	@Override
	public UserInfoVO userInfo(String userID) throws Exception {
		return mypageADao.userInfo(userID);
	}
	
}
