package kr.happy.jobkorea.jmyp.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.jmyp.model.JMyBoardsModel;

public interface JMyBoardsService {
	
	List<JMyBoardsModel> SelectBoards(Map<String, Object> paramMap) throws Exception;
	
	int SelectedBoardsCount(Map<String, Object> paramMap) throws Exception;

}
