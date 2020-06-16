package kr.happy.jobkorea.jmyp.service;

import java.util.Map;

import kr.happy.jobkorea.register.model.RegisterModel;

public interface MyinfoService {

	RegisterModel selectRegister(Map<String, Object> paramMap) throws Exception;
	
	public int userUpdate(Map<String, Object> paramMap) throws Exception;
	
	public int skillDelete(Map<String, Object> temp) throws Exception;
	
	public int updateSkill(Map<String, Object> temp) throws Exception;
	
}
