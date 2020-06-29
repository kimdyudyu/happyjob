package kr.happy.jobkorea.hls.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hls.model.ReferenceModel;

public interface RefDao {

	List<ReferenceModel> refList(Map<String, Object> paramMap);

	int refTotalCnt(Map<String, Object> paramMap);

	ReferenceModel detailRef(Map<String, Object> paramMap);

	void insertRef(Map<String, Object> paramMap);

}
