package kr.happy.jobkorea.jmyp.service;

import java.util.List;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.happy.jobkorea.common.comnUtils.ComnUtil;
import kr.happy.jobkorea.jmyp.dao.JMessageDao;
import kr.happy.jobkorea.jmyp.model.JMessageModel;
import kr.happy.jobkorea.system.model.ComnGrpCodModel;

@Service
public class JMessageServiceImpl implements JMessageService{
	
	@Autowired
	JMessageDao jMessageDao;

	@Override
	public List<JMessageModel> messageList(Map<String, Object> paramMap) throws Exception  {
		List<JMessageModel> list = jMessageDao.messageList(paramMap);
		return list;
	}

	@Override
	public int getSelectedCnt(Map<String, Object> paramMap) throws Exception  {
		int totalCount = jMessageDao.getSelectedCnt(paramMap);
		return totalCount;
	}

	@Override
	public int insertMessage(Map<String, Object> paramMap) throws Exception  {
		// TODO Auto-generated method stub
		int ret = jMessageDao.insertMessage(paramMap);
		return ret;
	}

	@Override
	public int deleteMessage(Map<String, Object> paramMap) throws Exception {
		int ret = jMessageDao.deleteMessage(paramMap);
		return ret;
	}

	@Override
	public List<JMessageModel> SearchID(Map<String, Object> paramMap) throws Exception {
		
		List<JMessageModel> list = jMessageDao.SearchID(paramMap);

		return list;
	}

	@Override
	public int getSelectedIDCnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = jMessageDao.getSelectedIDCnt(paramMap);
		return totalCount;
	}




}
