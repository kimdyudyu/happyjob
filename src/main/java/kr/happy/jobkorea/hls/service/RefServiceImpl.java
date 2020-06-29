package kr.happy.jobkorea.hls.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hls.dao.RefDao;
import kr.happy.jobkorea.hls.model.ReferenceModel;

@Service
public class RefServiceImpl implements RefService {

	@Autowired
	RefDao refDao;
	
	@Override
	public List<ReferenceModel> refList(Map<String, Object> paramMap) {
		List<ReferenceModel> refList = refDao.refList(paramMap);
		return refList;
	}

	@Override
	public int refTotalCnt(Map<String, Object> paramMap) {
		int refTotalCnt = refDao.refTotalCnt(paramMap);
		return refTotalCnt;
	}

	@Override
	public ReferenceModel detailRef(Map<String, Object> paramMap) {
		ReferenceModel detailRef = refDao.detailRef(paramMap);
		return detailRef;
	}

	@Override
	public void insertRef(Map<String, Object> paramMap) {
		refDao.insertRef(paramMap);
	}

}
