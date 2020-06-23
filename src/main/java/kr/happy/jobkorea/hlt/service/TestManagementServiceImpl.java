package kr.happy.jobkorea.hlt.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hlt.dao.TestManageMentDAO;
import kr.happy.jobkorea.hlt.model.LectureVO;
import kr.happy.jobkorea.hlt.model.QuestionsVO;

@Service
public class TestManagementServiceImpl implements TestManagementService {
	private final Logger logger = LogManager.getLogger(this.getClass());
	@Autowired
	private TestManageMentDAO testManageMentDAO;
	
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<LectureVO> getCourseList(Map<String, Object> paramMap) {	
		return testManageMentDAO.getCourseList(paramMap);
	}

	@Override
	public int totalCountCourse() {
		return testManageMentDAO.totalCountCourse();
	}

	@Override
	public List<LectureVO> getTestResult(Map<String, Object> paramMap) {
		return testManageMentDAO.getTestResult(paramMap);
	}

	
	@Override
	public void saveQuestions(List<Map<String, Object>> resultMap)
	{
		
		
		Iterator<Map<String, Object>> itr = resultMap.iterator();
		
		while(itr.hasNext()){
			Map<String, Object> map = itr.next();
			logger.info(map);
			testManageMentDAO.saveQuestions(map);

		}

	}

	@Override
	public List<QuestionsVO> getTestResultDetail(Map<String, Object> paramMap) {
			return testManageMentDAO.getTestResultDetail(paramMap);
	}

	@Override
	public List<QuestionsVO> getTestResultDetailRe(Map<String, Object> paramMap) {
		return testManageMentDAO.getTestResultDetailRe(paramMap);
	}

	@Override
	public int getTotalC(Map<String, Object> paramMap) {
		return testManageMentDAO.getTotalC(paramMap);
	}

	@Override
	public int getTotalRe(Map<String, Object> paramMap) {
		return testManageMentDAO.getTotalRe(paramMap);
	}

	@Override
	public void deleteQuestions(Map<String, Object> map) {
		testManageMentDAO.deleteQuestions(map);
	}

	@Override
	public void saveQuestionsM(List<Map<String, Object>> resultMap) {
		Iterator<Map<String, Object>> itr = resultMap.iterator();
		
		while(itr.hasNext()){
			Map<String, Object> map = itr.next();
			logger.info(map);
			testManageMentDAO.saveQuestionsM(map);

		}
	}

}
