package kr.happy.jobkorea.hla.dao;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.CareerInfoModel;

public interface CareerInfoDao {
	List<CareerInfoModel> careerInfoList(Map<String, Object> paramMap);

	int careerInfoListTotalCnt(Map<String, Object> paramMap);

	CareerInfoModel careerInfoListDetail(Map<String, Object> paramMap);

	int careerInfoInsert(Map<String, Object> paramMap);

	int careerInfoDelete(Map<String, Object> paramMap);

	int careerInfoUpdate(Map<String, Object> paramMap);
}
