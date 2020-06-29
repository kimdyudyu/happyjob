package kr.happy.jobkorea.manageC.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.manageC.dao.examDao;
import kr.happy.jobkorea.manageC.model.examModel;
import kr.happy.jobkorea.manageC.model.examAnswerModel;

@Service
public class examServiceImpl implements examService{
 
	@Autowired
	examDao dao ; 
	
	@Override
	public List<examModel> examList(Map<String, Object> paramMap) {
		List<examModel> examList = dao.examList(paramMap);
		return examList;
	}
	@Override
	public int examTotalCnt(Map<String, Object> paramMap) {
		int examTotalCnt = dao.examTotalCnt(paramMap);
		return examTotalCnt;
	}
	@Override
	public List<examModel> testList(Map<String, Object> paramMap) {
		List<examModel> testList = dao.testList(paramMap);
		return testList;
	}
	@Override
	public List<examAnswerModel> tresult(Map<String, Object> paramMap) {
		List<examAnswerModel> tresult = dao.tresult(paramMap);
		return tresult ; 
	}
	@Override
	public int tscore(Map<String, Object> paramMap) {
		int tscore = dao.tscore(paramMap);
		return tscore;
	}
	@Override
	public List<examModel> answerList(Map<String, Object> paramMap) {
		List<examModel> answerList = dao.answerList(paramMap);
		return answerList;
	}
	@Override
	public void calculate(Map<String, Object> paramMap) {
		dao.calculate(paramMap);
	}
	@Override
	public int search_score(Map<String, Object> paramMap) {
		int result = dao.search_score(paramMap);
		return result;
	}
}
