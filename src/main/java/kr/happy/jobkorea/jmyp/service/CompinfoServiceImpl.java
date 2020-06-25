package kr.happy.jobkorea.jmyp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmyp.dao.CompinfoDao;
import kr.happy.jobkorea.register.model.RegisterModel;

@Service
public class CompinfoServiceImpl implements CompinfoService {
	
	@Autowired
	private CompinfoDao compinfoDao;
	
	@Override
	public RegisterModel selectComp(Map<String, Object> paramMap) throws Exception {
		return compinfoDao.selectComp(paramMap);
	}
	
	@Override
	public int compUpdate(Map<String, Object> paramMap) throws Exception {
		return compinfoDao.compUpdate(paramMap);
	}
	

}
