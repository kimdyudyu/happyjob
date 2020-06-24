package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.ToolModel;

public interface ToolService {
	List<ToolModel> toolList(Map<String, Object> paramMap);

	int toolCount(Map<String, Object> paramMap) throws Exception;

	List<ToolModel> toollist(Map<String, Object> paramMap);

	int toolcount(Map<String, Object> paramMap) throws Exception;

	int toolInsert(Map<String, Object> paramMap) throws Exception;

	ToolModel toolDetail(Map<String, Object> paramMap);

	int toolDelete(Map<String, Object> paramMap) throws Exception;

	int toolUpdate(Map<String, Object> paramMap) throws Exception;
}
