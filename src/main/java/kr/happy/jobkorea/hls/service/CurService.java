package kr.happy.jobkorea.hls.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hls.model.CurriculumModel;

public interface CurService {

	List<CurriculumModel> curList(Map<String, Object> paramMap);

	int curTotalCnt(Map<String, Object> paramMap);

	CurriculumModel detailCur(Map<String, Object> paramMap);

	void insertCur(Map<String, Object> paramMap);

	Map<String, Object> selectNoticeOne(Map<String, Object> paramMap);

}
