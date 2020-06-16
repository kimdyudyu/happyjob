package kr.happy.jobkorea.jmyp.service;

import java.util.Map;

import kr.happy.jobkorea.register.model.RegisterModel;

public interface CompinfoService {
	
	RegisterModel selectComp(Map<String, Object> paramMap) throws Exception;
	
	public int compUpdate(Map<String, Object> paramMap) throws Exception;
	
}
