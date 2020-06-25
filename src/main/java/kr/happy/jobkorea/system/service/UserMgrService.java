package kr.happy.jobkorea.system.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.system.model.ComnGrpCodModel;
import kr.happy.jobkorea.system.model.UserMgrModel;

public interface UserMgrService {

	public List<UserMgrModel> listUser(Map<String, Object> paramMap) throws Exception;

	public int countListUser(Map<String, Object> paramMap) throws Exception;

	public UserMgrModel detailUser(Map<String, Object> paramMap)throws Exception;

	public int insertUser(Map<String, Object> paramMap) throws Exception;

	public int updateUser(Map<String, Object> paramMap) throws Exception;

	public int deleteUser(Map<String, Object> paramMap) throws Exception;

}
