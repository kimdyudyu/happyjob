package kr.happy.jobkorea.jmgr.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmgr.dao.JmgrUserDao;
import kr.happy.jobkorea.jmgr.model.JmgrUserModel;
import kr.happy.jobkorea.jmgr.model.JmgrUserSkill;




@Service
public class JmgrUserServiceImpl implements JmgrUserService {
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();


	@Autowired
	JmgrUserDao jmgrUserDao;
	@Override
	public List<Map<String, Object>> getUserList(Map<String, Object> paramMap) {
		
		for(Map.Entry<String, Object> entry : paramMap.entrySet()){
			System.out.println("========++ "+entry.getKey()+ entry.getValue());
		}
		return jmgrUserDao.getUserList(paramMap);
	}

	@Override
	public int totalCountUser(Map<String, Object> paramMap) {
		
		return jmgrUserDao.totalCountUser(paramMap);
	}

	@Override
	public int idUp(String loginID) {
		jmgrUserDao.idUp(loginID);
		return jmgrUserDao.getDeveloperCnt(loginID);
	}
	
	@Override
	public void deleteSkill(String loginID){
		jmgrUserDao.deleteSkill(loginID);
	}

	@Override
	public JmgrUserModel selectDeveloperOne(String loginID) {
		return jmgrUserDao.selectDeveloperOne(loginID);
	}

	@Override
	public void deleteUser(String loginID) {
		jmgrUserDao.deleteUser(loginID);
	}
	
	@Override
	public void updateUser(Map<String, Object> paramMap) throws Exception{
		jmgrUserDao.updateUser(paramMap);
	}
	@Override
	public void updateComp(Map<String, Object> paramMap) throws Exception{
		jmgrUserDao.updateComp(paramMap);
	}
	@Override
	public void insertSkill(String loginID, String rawSkill_code, String skill_detail) {
		
		String skill_code = null;
		
		switch(rawSkill_code){
		
		case "we": skill_code = "webServer";
		   break;
		case "OS": skill_code = "OS";
		   break;
		case "WE": skill_code = "WEB";
		   break;
		case "La": skill_code = "Language";
		   break;
		case "fr": skill_code = "FrameWork";
		   break;
		case "DB": skill_code = "DB";
		   break;
		case "ne": skill_code = "NetWork";
		   break;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();

		
		paramMap.put("skill_code", skill_code);
		paramMap.put("loginID", loginID);
		paramMap.put("skill_detail", skill_detail);
		
		jmgrUserDao.insertSkill(paramMap);		
	}

	public List<String> showSkill(String loginID) {
		
		
		List<String> skillList = new ArrayList<>();
		
		String paramstr = "";
		
		List<JmgrUserSkill> rawMap = jmgrUserDao.showSkill(loginID);
		
		for(int i=0; i<rawMap.size(); i++){
			
			String rawSkillCode = rawMap.get(i).getSkillCode();
			
			String skillCode = "";
			
			String skillDetail = rawMap.get(i).getSkillDetail();
			
			switch(rawSkillCode){
			
			case "webServer": skillCode = "we";
			   break;
			case "OS": skillCode = "OS";
			   break;
			case "WEB": skillCode = "WE";
			   break;
			case "Language": skillCode = "La";
			   break;
			case "FrameWork": skillCode = "fr";
			   break;
			case "DB": skillCode = "DB";
			   break;
			case "NetWork": skillCode = "ne";
			   break;
			}
			
			paramstr = skillCode + skillDetail;
			
			skillList.add(paramstr);
				
			
		}
		
		

		return skillList;
	}
	
}
