package kr.happy.jobkorea.hla.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hla.dao.CareerInfoDao;
import kr.happy.jobkorea.hla.model.CareerInfoModel;

@Service
public class CareerInfoServiceImpl implements CareerInfoService {

	@Autowired
	CareerInfoDao careerInfoDao;

	@Override
	public List<CareerInfoModel> careerInfoList(Map<String, Object> paramMap) {
		List<CareerInfoModel> careerInfoList = careerInfoDao.careerInfoList(paramMap);
		return careerInfoList;
	}

	@Override
	public int careerInfoListTotalCnt(Map<String, Object> paramMap) {
		int careerInfoListTotalCnt = careerInfoDao.careerInfoListTotalCnt(paramMap);
		return careerInfoListTotalCnt;
	}

	@Override
	public CareerInfoModel careerInfoListDetail(Map<String, Object> paramMap) {
		CareerInfoModel careerInfoListDetail = careerInfoDao.careerInfoListDetail(paramMap);
		return careerInfoListDetail;
	}

	@Override
	public int careerInfoInsert(Map<String, Object> paramMap) {
		int careerInfoInsert = careerInfoDao.careerInfoInsert(paramMap);
		return careerInfoInsert;
	}

	@Override
	public int careerInfoDelete(Map<String, Object> paramMap) {
		int careerInfoDelete = careerInfoDao.careerInfoDelete(paramMap);
		return careerInfoDelete;
	}

	@Override
	public int careerInfoUpdate(Map<String, Object> paramMap) {
		int careerInfoUpdate = careerInfoDao.careerInfoUpdate(paramMap);
		return careerInfoUpdate;
	}

	@Override
	public List<CareerInfoModel> studentList() {
		List<CareerInfoModel> studentList = careerInfoDao.studentList();
		return studentList;
	}
}
