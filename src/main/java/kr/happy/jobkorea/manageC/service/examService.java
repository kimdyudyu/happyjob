package kr.happy.jobkorea.manageC.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.manageC.model.examModel;
import kr.happy.jobkorea.manageC.model.examAnswerModel;

public interface examService {
	List<examModel> examList(Map<String, Object> paramMap);
	List<examModel> testList(Map<String, Object> paramMap);
	List<examModel> answerList(Map<String, Object> paramMap);
	List<examAnswerModel> tresult(Map<String, Object> paramMap);
	int examTotalCnt(Map<String, Object> paramMap);
	int tscore(Map<String, Object> paramMap);
	void calculate(Map<String, Object> paramMap);
	int search_score(Map<String, Object> paramMap);
}
