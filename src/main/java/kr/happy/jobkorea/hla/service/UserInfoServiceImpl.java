package kr.happy.jobkorea.hla.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happy.jobkorea.common.comnUtils.FileUtilCho;
import kr.happy.jobkorea.hla.dao.UserInfoDao;
import kr.happy.jobkorea.hla.model.UserInfoModel;
import kr.happy.jobkorea.common.comnUtils.FileUtil;
import kr.happy.jobkorea.common.comnUtils.FileUtilModel;


@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	@Autowired
	UserInfoDao userInfoDao;

	@Override
	public void RegistUser(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		userInfoDao.RegistUser(paramMap);
	}

	@Override
	public List<UserInfoModel> SelectUserInfo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectUserInfo(paramMap);
	}

	@Override
	public int getSelectedCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getSelectedCnt(paramMap);
	}

	@Override
	public void UpdateUser(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
        Iterator<String> files = multipartHttpServletRequest.getFileNames();
        
        System.out.println(files.hasNext());
        
        //while(files.hasNext()){
        	
            //String uploadFile = files.next();
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String savaDir = "D:/egov/workspace/happyjob/src/main/webapp/WEB-INF/resource/images/userImage/";
		String dirPath = userInfoDao.getDirectory();
		
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		//System.out.println("itemFilePath    :    " + itemFilePath);
		FileUtil fileUtil = new FileUtil(multipartHttpServletRequest, savaDir, "");
		List<FileUtilModel> models = null;
		
		
		// 데이터 저장
		try {
			if(files.hasNext()){
				models = fileUtil.uploadFiles();
				//models = fileUtil.uploadFiles();
				if(models != null && models.size()>0){
					
						//System.out.println("itemFilePath    :    " + savaDir + File.separator + itemFilePath);
					   FileUtilModel model = models.get(0);
					   paramMap.put("fileName", model.getLgc_fil_nm());
					   paramMap.put("filePath", "/images/userImage/" );
					   paramMap.put("fileSize", model.getFil_siz());
					   System.out.println("fileName : " + model.getLgc_fil_nm());
					   //System.out.println("filePath : " + model.getLgc_fil_nm());
			   }
			}
			userInfoDao.UpdateUser(paramMap);
			//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);	
		}catch(Exception e) {
			// 파일 삭제
			//fileUtil.deleteFiles(models);
			throw e;
		}
		
		
	}

	@Override
	public List<UserInfoModel> SelectLectureList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectLectureList(paramMap);
	}

	@Override
	public int getLectureCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getLectureCnt(paramMap);
	}

	@Override
	public List<UserInfoModel> SelectStudentList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectStudentList(paramMap);
	}

	@Override
	public int getStudentCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.getStudentCnt(paramMap);
	}

	@Override
	public List<UserInfoModel> ResumeLectureList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.ResumeLectureList(paramMap);
	}

	@Override
	public List<UserInfoModel> ResumeTestList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.ResumeTestList(paramMap);
	}

	@Override
	public UserInfoModel SelectAUserInfo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.SelectAUserInfo(paramMap);
	}

	@Override
	public List<UserInfoModel> IDValidation(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userInfoDao.IDValidation(paramMap);
	}

}
