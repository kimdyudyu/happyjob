package kr.happy.jobkorea.jmyp.dao;

import java.util.Map;

import kr.happy.jobkorea.register.model.RegisterModel;

public interface CompinfoDao {
	
	RegisterModel selectComp(Map<String, Object> paramMap);
	
	public int compUpdate(Map<String, Object> paramMap);
	
}
