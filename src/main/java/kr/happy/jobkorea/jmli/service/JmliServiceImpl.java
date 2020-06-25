package kr.happy.jobkorea.jmli.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmli.dao.JmliDeveloperDao;
import kr.happy.jobkorea.jmli.dao.JmliNoticeDao;
import kr.happy.jobkorea.jmli.dao.JmliProjectDao;
import kr.happy.jobkorea.jmli.model.JmliProjectModel;
import kr.happy.jobkorea.jmli.model.JmliProjectSkill;
import kr.happy.jobkorea.jmli.model.JmliUserSkill;
import kr.happy.jobkorea.jmli.model.developerModel;




@Service
public class JmliServiceImpl implements JmliService {
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	JmliDeveloperDao jmliDeveloperDao;
	@Autowired
	JmliNoticeDao jmliNoticeDao;
	@Autowired
	JmliProjectDao jmliProjectDao;
	
	@Override
	public List<Map<String, Object>> getDeveloperList(Map<String, Object> paramMap) {
		
		return jmliDeveloperDao.getDeveloperList(paramMap);
	}

	@Override
	public int totalCountDeveloper(Map<String, Object> paramMap) {
		
		return jmliDeveloperDao.totalCountDeveloper(paramMap);
	}
	
	
	@Override
	public int idUp(String loginID) {
		jmliDeveloperDao.idUp(loginID);
			
		return jmliDeveloperDao.getDeveloperCnt(loginID);
	}

	@Override
	public developerModel selectDeveloperOne(String loginID) {
		
		return jmliDeveloperDao.selectDeveloperOne(loginID);
	}
	

	
	//공지사항 목록
	@Override
	public List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap) {
		return jmliNoticeDao.getNoticeList(paramMap);
	}
	//공지사항 목록 갯수
	@Override
	public int totalCountNoticeList() {
		
		return jmliNoticeDao.totalCountNotice();
	}
	//프로젝트 목록
	@Override
	public List<JmliProjectModel> projectList(Map<String, Object> paramMap) {
		
		return jmliProjectDao.getProjectList(paramMap);
	}
	
	
	//프로젝트 목록 갯수
	@Override
	public int totalCountProjectList(Map<String, Object> paramMap) {
		
		return jmliProjectDao.totalCountProject(paramMap);
	}

	@Override
	public JmliProjectModel selectProjectOne(String projectId) {
		return jmliProjectDao.selectProjectOne(projectId);
	}

	@Override
	public List<JmliProjectSkill> selectProjectSkill(String projectId) {
		return jmliProjectDao.selectProjectSkill(projectId);
		
	}

	@Override
	public int deleteTB_Project(String projectId) {
		return 	jmliProjectDao.deleteTB_Project(projectId);
	}

	@Override
	public int deleteTB_ProjectSKILL(String projectId) {
		return jmliProjectDao.deleteTB_ProjectSKILL(projectId);
	}

	@Override
	public int deleteTB_priApplication(String projectId) {
		return jmliProjectDao.deleteTB_priApplication(projectId);
	}

	@Override
	public List<String> showSkill(String loginID) {

		List<String> skillList = new ArrayList<>();
		
		String paramstr = "";
		
		List<JmliUserSkill> rawMap = jmliDeveloperDao.showSkill(loginID);
		
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

	@Override
	public Map<String, Object> projectUpdate_data(Map<String,Object> paramMap) {

		String[] skillObj = ((String) paramMap.get("skillDetail")).split("/");
		List<JmliUserSkill> list = new ArrayList<>();
		
		
		for(int i=0; i<skillObj.length; i++){
			JmliUserSkill userSkill = new JmliUserSkill();
			
			String skillV[]	=skillObj[i].split("_");
				
			userSkill.setSkillCode(skillV[0]);
			userSkill.setSkillDetail(skillV[1]);
			userSkill.setProjectId((String)paramMap.get("projectId"));
			
			jmliProjectDao.proectUpdate_updateSkill(userSkill);
			
		}

		return paramMap;
	}

	@Override
	public int proectUpdate_project(Map<String, Object> paramMap) {
		return jmliProjectDao.proectUpdate_project(paramMap);
	}

	@Override
	public int proectUpdate_deleteSkill(Map<String, Object> paramMap) {
		
		return jmliProjectDao.proectUpdate_deleteSkill(paramMap);
	}



	@Override
	public int insertMessage(Map<String, Object> paramMap) throws Exception {
		int ret = jmliDeveloperDao.insertMessage(paramMap);
		return ret;
	}

	@Override
	public int applyProject(Map<String, Object> paramMap) {
		int ret = jmliProjectDao.applyProject(paramMap);
		return ret;
	}

	@Override
	public int resisterproject(Map<String, Object> paramMap) {
		return jmliProjectDao.resisterproject(paramMap);
	}

	@Override
	public String getUserInfo(String id) {	
		return jmliProjectDao.getUserInfo(id);
	}

}
