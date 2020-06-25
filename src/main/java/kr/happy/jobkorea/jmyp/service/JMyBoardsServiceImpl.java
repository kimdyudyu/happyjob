package kr.happy.jobkorea.jmyp.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.jmyp.model.JMessageModel;
import kr.happy.jobkorea.jmyp.model.JMyBoardsModel;
import kr.happy.jobkorea.jmyp.dao.JMyBoardsDao;

@Service
public class JMyBoardsServiceImpl implements JMyBoardsService {
	
	@Autowired
	JMyBoardsDao jMyboardsDao;

	@Override
	public List<JMyBoardsModel> SelectBoards(Map<String, Object> paramMap) throws Exception {
		List<JMyBoardsModel> list = jMyboardsDao.SelectBoards(paramMap);
		return list;
	}

	@Override
	public int SelectedBoardsCount(Map<String, Object> paramMap) throws Exception {
		int totalCount = jMyboardsDao.SelectedBoardsCount(paramMap);
		return totalCount;
	}

}
