package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hla.model.CareerInfoModel;

public interface CareerInfoService {
	List<CareerInfoModel> careerInfoList(Map<String, Object> paramMap);

	int careerInfoListTotalCnt(Map<String, Object> paramMap);

	CareerInfoModel careerInfoListDetail(Map<String, Object> paramMap);

	int careerInfoInsert(Map<String, Object> paramMap);

	int careerInfoDelete(Map<String, Object> paramMap);

	int careerInfoUpdate(Map<String, Object> paramMap);

	List<CareerInfoModel> studentList();
}
