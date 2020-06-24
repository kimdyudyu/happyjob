package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.ToolDao;
import kr.happy.jobkorea.hla.model.ToolModel;

@Service
public class ToolServiceImpl implements ToolService {
	@Autowired
	ToolDao toolDao;

	@Override
	public List<ToolModel> toolList(Map<String, Object> paramMap) {
		List<ToolModel> toolList = toolDao.toolList(paramMap);
		return toolList;
	}

	@Override
	public int toolCount(Map<String, Object> paramMap) throws Exception {
		int totalCount = toolDao.toolCount(paramMap);
		return totalCount;
	}

	@Override
	public List<ToolModel> toollist(Map<String, Object> paramMap) {
		List<ToolModel> toollist = toolDao.toollist(paramMap);
		return toollist;
	}

	@Override
	public int toolcount(Map<String, Object> paramMap) throws Exception {
		int totalcount = toolDao.toolcount(paramMap);
		return totalcount;
	}

	@Override
	public int toolInsert(Map<String, Object> paramMap) throws Exception {
		int toolInsert = toolDao.toolInsert(paramMap);
		return toolInsert;
	}

	@Override
	public ToolModel toolDetail(Map<String, Object> paramMap) {
		ToolModel toolDetail = toolDao.toolDetail(paramMap);
		return toolDetail;
	}

	@Override
	public int toolDelete(Map<String, Object> paramMap) throws Exception {
		int toolDelete = toolDao.toolDelete(paramMap);
		return toolDelete;
	}

	@Override
	public int toolUpdate(Map<String, Object> paramMap) throws Exception {
		int toolUpdate = toolDao.toolUpdate(paramMap);
		return toolUpdate;
	}

}
