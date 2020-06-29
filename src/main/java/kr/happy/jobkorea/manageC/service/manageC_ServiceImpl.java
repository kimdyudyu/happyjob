package kr.happy.jobkorea.manageC.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happy.jobkorea.common.comnUtils.FileUtil;
import kr.happy.jobkorea.common.comnUtils.FileUtilCho;
import kr.happy.jobkorea.common.comnUtils.FileUtilModel;
import kr.happy.jobkorea.manageC.dao.manageC_Dao;

@Service
public class manageC_ServiceImpl implements manageC_service {

	@Autowired
	manageC_Dao dao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	public manageC_ServiceImpl() {
		// 생성자
	}

	@Override
	public List<Map<String, Object>> call_test_exam() {
		// 해당 함수 오버라이딩

		logger.info("+ Start " + className + ".manageC_service");

		List<Map<String, Object>> result_list = dao.call_test_exam();
		return result_list;
	}

	@Override
	public int totalCountRoom(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.totalCountRoom(param);
	}
	
	@Override
	public int totalQcnt(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.totalQcnt(param);
	}

	@Override
	public List<Map<String, Object>> shList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.shList(param);
	}

	@Override
	public void insertLmm(Map<String, Object> param, HttpServletRequest request) throws Exception {

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		String dirPath = dao.getDirectory();
		param.put("dirPath", dirPath);

		// 파일 저장
		String itemFilePath = dirPath + File.separator;
		FileUtil fileUtil = new FileUtil(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		List<FileUtilModel> fileInfo = fileUtil.uploadFiles();
		

		// 데이터 저장
		try {
			for (FileUtilModel fileUtilModel : fileInfo) {

				param.put("filename", fileUtilModel.getLgc_fil_nm());
				// 논리파일명
				param.put("filepath", fileUtilModel.getPsc_fil_nm());
				// 물리파일명
				param.put("filesize", fileUtilModel.getFil_siz());
				dao.insertLmm(param);
			}
		} catch (Exception e) {
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	}

	@Override
	public void updateLmm(Map<String, Object> param, HttpServletRequest request) throws Exception {

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		String dirPath = dao.getDirectory();
		param.put("dirPath", dirPath);

		String itemFilePath = dirPath + File.separator;
		FileUtil fileUtil = new FileUtil(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		List<FileUtilModel> fileInfo = fileUtil.uploadFiles();

		try {
			for (FileUtilModel fileUtilModel : fileInfo) {

				param.put("filename", fileUtilModel.getLgc_fil_nm());
				// 논리파일명
				param.put("filepath", fileUtilModel.getPsc_fil_nm());
				// 물리파일명
				param.put("filesize", fileUtilModel.getFil_siz());
				dao.updateLmm(param);
			}
		} catch (Exception e) {
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> optionList(Map<String, Object> param) {
		List<Map<String, Object>> optionList = dao.optionList(param);
		return optionList;
	}

	@Override
	public List<Map<String, Object>> QList(Map<String, Object> param) {
		return dao.QList(param);
	}
	
	@Override
	public List<Map<String, Object>> CList(Map<String, Object> param) {
		return dao.CList(param);
	}
	
	@Override
	public void comment_write(Map<String, Object> paramMap) {
		dao.comment_write(paramMap);
	}
}
