package kr.happy.jobkorea.hlt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hlt.dao.hltListDao;
import kr.happy.jobkorea.hlt.model.lectureModel;

@Service
public class hltListServiceImpl implements hltListService{

	@Autowired
	hltListDao hltListDao;
	
	@Override
	public List<lectureModel> classList(Map<String, Object> paramMap) {
		
		List<lectureModel> classList = hltListDao.getClassList(paramMap);
		for(int i=0; i<classList.size(); i++){
			lectureModel lecture = classList.get(i);
			int count = hltListDao.getClassPerson(lecture.getNo());
			classList.get(i).setTcnt(count);
		}
		return classList;
	}

	@Override
	public lectureModel detailClass(Map<String, Object> paramMap) {
		
		return hltListDao.detailList(paramMap);
	}

	@Override
	public List<lectureModel> hltManageList(Map<String, Object> paramMap) {
		
		return hltListDao.hltManageList(paramMap);
	}

	@Override
	public void hltDeleteNo(Map<String, Object> paramMap) {
		
		hltListDao.hltDeleteNo(paramMap);
	}

	@Override
	public void hltModalList(Map<String, Object> paramMap) {
		
			if(paramMap.get("branch").equals("update")){
				hltListDao.ModalUpdate(paramMap);
			}else if(paramMap.get("branch").equals("insert")){
				hltListDao.ModalInsert(paramMap);
			}
			

	}

	@Override
	public List<lectureModel> evaluationList(Map<String, Object> paramMap) {
		List<lectureModel> evaluationList = hltListDao.evaluationList(paramMap);
		for(int i=0; i<evaluationList.size(); i++){
			lectureModel lecture = evaluationList.get(i);
			int count = hltListDao.getClassPerson(lecture.getNo());
			evaluationList.get(i).setTcnt(count);
		}
		return evaluationList;
	}

	@Override
	public List<lectureModel> DetailSurveyList(Map<String, Object> paramMap) {
		
		return hltListDao.DetailSurveyList(paramMap);
	}
	
	
}
