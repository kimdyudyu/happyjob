package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.NoticeModel;

public interface NoticeService {
	List<NoticeModel> noticeList(Map<String, Object> paramMap);

	int noticeTotalCnt(Map<String, Object> paramMap);

	int noticeInsert(Map<String, Object> paramMap);

	NoticeModel noticeDetail(Map<String, Object> paramMap);

	int noticeDelete(Map<String, Object> paramMap);
	
	int noticeUpdate(Map<String, Object> paramMap);
}
