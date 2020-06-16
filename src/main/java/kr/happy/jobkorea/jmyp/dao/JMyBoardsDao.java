package kr.happy.jobkorea.jmyp.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmyp.model.JMyBoardsModel;

public interface JMyBoardsDao {
	public List<JMyBoardsModel> SelectBoards(Map<String, Object> paramMap) throws Exception;
	public int SelectedBoardsCount(Map<String, Object> paramMap) throws Exception;
}
