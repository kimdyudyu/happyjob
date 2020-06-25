package kr.happy.jobkorea.jmyp.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmyp.model.UserInfoVO;
import kr.happy.jobkorea.jmyp.model.aMypageVO;

public interface MypageADao {

	
	public List<aMypageVO> DmypageBoard(Map<String, Object> paramMap) throws Exception;
	
	public int DBoardCnt(Map<String, Object> paramMap);
	
	
	public aMypageVO projectDetailD(Map<String, Object> paramMap) throws Exception;
	
	
	public void supplyDeleteD(String projectId, String loginId) throws Exception;
	
	
	public UserInfoVO userInfo(String userID) throws Exception;
	
	
	

	
	public List<aMypageVO> CmypageBoard(Map<String, Object> paramMap) throws Exception;
	
	public int CBoardCnt(Map<String, Object> paramMap);
	
	
	public List<aMypageVO> supplyList(Map<String, Object> paramMap) throws Exception;
	
}
