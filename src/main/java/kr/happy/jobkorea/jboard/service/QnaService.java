package kr.happy.jobkorea.jboard.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jboard.model.QnaModel;

public interface QnaService {

	List<QnaModel> qnaList(Map<String, Object> paramMap);

	int qnaTotalCnt(Map<String, Object> paramMap);

	QnaModel detailQna(Map<String, Object> paramMap);

	void insertQna(Map<String, Object> paramMap);
	
}
