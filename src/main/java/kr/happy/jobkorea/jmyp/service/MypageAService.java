package kr.happy.jobkorea.jmyp.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmyp.model.UserInfoVO;
import kr.happy.jobkorea.jmyp.model.aMypageVO;


public interface MypageAService{
	
	
	// 개인
	///////////////
	
	// 게시판 조회
	public List<aMypageVO> DmypageBoard(Map<String, Object> paramMap) throws Exception;
	
	// cnt
	public int DBoardCnt(Map<String, Object> paramMap); 
	
	// projectDetail
	public aMypageVO projectDetailD(Map<String, Object> paramMap) throws Exception; 
	
	// delete
	public void supplyDeleteD(String projectId, String loginId) throws Exception;
	
	
	
	
	// 기업
	////////////////
	public List<aMypageVO> CmypageBoard(Map<String, Object> paramMap) throws Exception;
	
	public int CBoardCnt(Map<String, Object> paramMap);
	
	
	public List<aMypageVO> supplyList(Map<String, Object> paramMap) throws Exception;
	
	
	public UserInfoVO userInfo(String userID) throws Exception;
	

}
