package kr.happy.jobkorea.jmyp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmyp.dao.MyinfoDao;
import kr.happy.jobkorea.register.model.RegisterModel;

@Service
public class MyinfoServiceImpl implements MyinfoService {
	
	@Autowired
	private MyinfoDao myinfoDao;

	@Override
	public RegisterModel selectRegister(Map<String, Object> paramMap) {
		return myinfoDao.selectRegister(paramMap);
	}
	
	@Override
	public int userUpdate(Map<String, Object> paramMap) throws Exception {
		return myinfoDao.userUpdate(paramMap);
	}
	
	@Override
	public int skillDelete(Map<String, Object> temp) throws Exception {
		return myinfoDao.skillDelete(temp);
	}
	
	@Override
	public int updateSkill(Map<String, Object> temp) throws Exception {
		return myinfoDao.updateSkill(temp);
	}

}
