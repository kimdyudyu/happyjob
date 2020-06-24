package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.NoticeDao;
import kr.happy.jobkorea.hla.model.CareerInfoModel;
import kr.happy.jobkorea.hla.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao noticeDao;

	@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) {
		List<NoticeModel> noticeList = noticeDao.noticeList(paramMap);
		return noticeList;
	}

	@Override
	public int noticeTotalCnt(Map<String, Object> paramMap) {
		int noticeTotalCnt = noticeDao.noticeTotalCnt(paramMap);
		return noticeTotalCnt;
	}

	@Override
	public int noticeInsert(Map<String, Object> paramMap) {
		int noticeInsert = noticeDao.noticeInsert(paramMap);
		return noticeInsert;
	}

	@Override
	public NoticeModel noticeDetail(Map<String, Object> paramMap) {
		NoticeModel noticeDetail = noticeDao.noticeDetail(paramMap);
		return noticeDetail;
	}

	@Override
	public int noticeDelete(Map<String, Object> paramMap) {
		int noticeDelete = noticeDao.noticeDelete(paramMap);
		return noticeDelete;
	}

	@Override
	public int noticeUpdate(Map<String, Object> paramMap) {
		int noticeUpdate=noticeDao.noticeUpdate(paramMap);
		return noticeUpdate;
	}

}
