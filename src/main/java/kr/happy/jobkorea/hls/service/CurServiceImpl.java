package kr.happy.jobkorea.hls.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hls.dao.CurDao;
import kr.happy.jobkorea.hls.model.CurriculumModel;

@Service
public class CurServiceImpl implements CurService{

	@Autowired
	CurDao curDao;
	
	@Override
	public List<CurriculumModel> curList(Map<String, Object> paramMap) {
		List<CurriculumModel> curList = curDao.curList(paramMap);
		return curList;
	}

	@Override
	public int curTotalCnt(Map<String, Object> paramMap) {
		int curTotalCnt = curDao.curTotalCnt(paramMap);
		return curTotalCnt;
	}

	@Override
	public CurriculumModel detailCur(Map<String, Object> paramMap) {
		CurriculumModel detailCur = curDao.detailCur(paramMap);
		return detailCur;
	}

	@Override
	public void insertCur(Map<String, Object> paramMap) {
		curDao.insertCur(paramMap);
	}

	@Override
	public Map<String, Object> selectNoticeOne(Map<String, Object> paramMap) {
		return curDao.selectNoticeOne(paramMap);
	}

	

}
