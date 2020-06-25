package kr.happy.jobkorea.jboard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jboard.model.QnaModel;
import kr.happy.jobkorea.jboard.dao.QnaDao;

@Service
public class QnaServiceImp implements QnaService {
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	QnaDao qnaDao;
	
	
	@Override
	public List<QnaModel> qnaList(Map<String, Object> paramMap) {
		List<QnaModel> qnaList = qnaDao.qnaList(paramMap);
		return qnaList;
	}


	@Override
	public int qnaTotalCnt(Map<String, Object> paramMap) {
		int qnaTotalCnt = qnaDao.qnaTotalCnt(paramMap);
		return qnaTotalCnt;
	}


	@Override
	public QnaModel detailQna(Map<String, Object> paramMap) {
		QnaModel detailQna = qnaDao.detailQna(paramMap);
		return detailQna;
	}


	@Override
	public void insertQna(Map<String, Object> paramMap) {
		qnaDao.insertQna(paramMap);
	}
}
