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
	public int totalCountCourse(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return testManageMentDAO.totalCountCourse(paramMap);
	}


	@Override
	public List<Map<String, Object>> getTestResult(Map<String, Object> paramMap) {
		return testManageMentDAO.getTestResult(paramMap);
	}

	
	@Override
	public void saveQuestions(List<Map<String, Object>> resultMap)
	{
		
		
		Iterator<Map<String, Object>> itr = resultMap.iterator();
		
		while(itr.hasNext()){
			Map<String, Object> map = itr.next();
			//System.out.println("11111111111111111111111111111111111111111111111111111111111111111111");
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

	@Override
	public List<Map<String, Object>> getSelectedTest(Map<String, Object> paramMap) {
		return testManageMentDAO.getSelectedTest(paramMap);
	}

	@Override
	public List<Map<String, Object>> getNoList(List<Map<String, Object>> list) {
		return testManageMentDAO.getNoList(list);
	}

	@Override
	public List<Map<String, Object>> getTestStudentCount(Map<String, Object> list) {
		return testManageMentDAO.getTestStudentCount(list);
	}

	@Override
	public int getTotalCount(Map<String, Object> paramMap) {
		return testManageMentDAO.getTotalCount(paramMap);
	}

	@Override
	public List<Map<String, Object>> getTookTestStudentCount(Map<String, Object> parmarr) {
		// TODO Auto-generated method stub
		return testManageMentDAO.getTookTestStudentCount(parmarr);
	}

	@Override
	public List<Map<String, Object>> getUserInfoD(Map<String, Object> paramMap) {
		return testManageMentDAO.getUserInfoD(paramMap);
	}

	@Override
	public int getUserInfoCount(Map<String, Object> paramMap) {
		return testManageMentDAO.getUserInfoCount(paramMap);
	}

	@Override
	public List<Map<String, Object>> existMain(Map<String, Object> paramMap) {
		return testManageMentDAO.existMain(paramMap);
	}

	@Override
	public List<Map<String, Object>> existRe(Map<String, Object> paramMap) {
		return testManageMentDAO.existRe(paramMap);
	}


}
