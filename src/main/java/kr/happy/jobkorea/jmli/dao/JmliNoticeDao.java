package kr.happy.jobkorea.jmli.dao;

import java.util.List;
import java.util.Map;

public interface JmliNoticeDao {
	List<Map<String, Object>> getNoticeList(Map<String, Object> paramMap);

	int totalCountNotice();
}
