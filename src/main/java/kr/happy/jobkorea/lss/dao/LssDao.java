package kr.happy.jobkorea.lss.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.lss.model.LssLectureModel;

public interface LssDao {

	List<LssLectureModel> pListAll(Map<String, Object> paramMap);

	int countPlist(Map<String, Object> paramMap);

	LssLectureModel selectPlist(Map<Object, String> paramMap);

	int updatePlist(Map<String, Object> paramMap);

}
