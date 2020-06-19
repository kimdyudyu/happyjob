package kr.happy.jobkorea.hlteacher.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hlteacher.dao.hlTeacherDao;
import kr.happy.jobkorea.hlteacher.model.lectureModel;

@Service
public class hlTeacherServiceImpl implements hlTeacherService{

	@Autowired
	hlTeacherDao hlTeacherDao;
	
	@Override
	public List<lectureModel> classList(Map<String, Object> paramMap) {
		
		return hlTeacherDao.getClassList(paramMap);
	}
	
	
}
