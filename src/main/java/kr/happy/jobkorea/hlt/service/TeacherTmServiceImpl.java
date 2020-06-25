package kr.happy.jobkorea.hlt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hlt.dao.TeacherTmDao;

@Service
public class TeacherTmServiceImpl implements TeacherTmService{
	
	@Autowired
	private TeacherTmDao teacherTmDao;
	
	@Override
	public int totalCountRoom(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return teacherTmDao.totalCountRoom(param);
	}
	
	@Override
	public List<Map<String, Object>> tmList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return teacherTmDao.tmList(param);
	}
	
	@Override
	public Map<String, Object> selectTmFile(Map<String, Object> paramMap) {
		return teacherTmDao.selectTmFile(paramMap);
	}
}
