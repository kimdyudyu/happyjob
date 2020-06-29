package kr.happy.jobkorea.hlt.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happy.jobkorea.common.comnUtils.FileUtil;
import kr.happy.jobkorea.common.comnUtils.FileUtilCho;
import kr.happy.jobkorea.common.comnUtils.FileUtilModel;
import kr.happy.jobkorea.hlt.dao.hlTeacherLmmDao;

@Service
public class hlTeacherLmmServiceImpl implements hlTeacherLmmService{
	
	@Autowired
	private hlTeacherLmmDao hlteacherLmmDao;
	
	@Override
	public int totalCountRoom(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return hlteacherLmmDao.totalCountRoom(param);
	}
	
	@Override
	public List<Map<String, Object>> lmmList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return hlteacherLmmDao.lmmList(param);
	}
	
	@Override
	public void updateLmm(Map<String, Object> param, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = hlteacherLmmDao.getDirectory();
		param.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
			param.put("fileInfo", fileInfo);
			hlteacherLmmDao.updateLmm(param);
			//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);	
		}catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	
	}

	@Override
	public void insertLmm(Map<String, Object> param, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = hlteacherLmmDao.getDirectory();
		param.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
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
				// 사이즈
				
				hlteacherLmmDao.insertLmm(param);
				
				System.out.println(param);
				
			}
		}catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	}
	
	@Override
	public void deleteLmm(Map<String, Object> param , HttpServletRequest request) throws Exception {
		
		String dirPath = hlteacherLmmDao.getDirectory();
		param.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		fileUtil.deleteFiles(param);
		
		hlteacherLmmDao.deleteLmm(param);
	}
}
