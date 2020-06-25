package kr.happy.jobkorea.jmyp.dao;

import java.util.Map;
import kr.happy.jobkorea.register.model.RegisterModel;

public interface MyinfoDao {
	
	RegisterModel selectRegister(Map<String, Object> paramMap);
	
	public int userUpdate(Map<String, Object> paramMap);
	
	public int skillDelete(Map<String, Object> temp);
	
	public int updateSkill(Map<String, Object> temp);

}
