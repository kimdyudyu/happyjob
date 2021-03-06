package kr.happy.jobkorea.mpm.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.login.model.LgnInfoModel;
import kr.happy.jobkorea.login.model.UsrMnuAtrtModel;
import kr.happy.jobkorea.login.model.UsrMnuChildAtrtModel;
import kr.happy.jobkorea.mpm.model.MpmMainUserInfoModel;
import kr.happy.jobkorea.mpm.model.MpmUserInfoModel;

public interface MpmUserInfoDao {
	
	/** 유저정보 리스트 조회 */
	public List<MpmUserInfoModel> selectUserInfoList(Map<String, Object> paramMap);
	/** 유저정보 조회 */
	public List<MpmUserInfoModel> selectUserInfo(Map<String, Object> paramMap);
	/** 유저정보 저장 */
	public int deleteUserInfo(MpmUserInfoModel paramModel);
	/** 유저정보 삭제 */
	public int updateUserInfo(MpmUserInfoModel paramModel);
	/** 유저정보 업데이트 */
	public int insertUserInfo(MpmUserInfoModel paramModel);


	
}
