package kr.happy.jobkorea.hlt.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlt.model.LectureVO;
import kr.happy.jobkorea.hlt.model.QuestionsVO;

public interface TestManageMentDAO {

	List<LectureVO> getCourseList(Map<String, Object> paramMap);

	int totalCountCourse(Map<String, Object> paramMap);

	List<Map<String, Object>> getTestResult(Map<String, Object> paramMap);

	void saveQuestions(Map<String, Object> map);

	List<QuestionsVO> getTestResultDetail(Map<String, Object> paramMap);

	List<QuestionsVO> getTestResultDetailRe(Map<String, Object> paramMap);

	int getTotalC();

	int getTotalC(Map<String, Object> paramMap);

	int getTotalRe(Map<String, Object> paramMap);

	void deleteQuestions(Map<String, Object> map);

	void saveQuestionsM(Map<String, Object> map);

	List<Map<String, Object>> getSelectedTest(Map<String, Object> paramMap);

	List<Map<String, Object>> getTestStudentCount(Map<String, Object> list);

	List<Map<String, Object>> getNoList(List<Map<String, Object>> list);

	List<Map<String, Object>> getTookTestStudentCount(Map<String, Object> parmarr);

	int getTotalCount(Map<String, Object> paramMap);

	List<Map<String, Object>> getUserInfoD(Map<String, Object> paramMap);

	int getUserInfoCount(Map<String, Object> paramMap);

	List<Map<String, Object>> existMain(Map<String, Object> paramMap);

	List<Map<String, Object>> existRe(Map<String, Object> paramMap);

}
