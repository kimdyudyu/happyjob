//package kr.happy.jobkorea.jmgr.service;
//
//import java.util.List;
//import java.util.Map;
//
//import org.apache.log4j.LogManager;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import kr.happy.jobkorea.jmgr.dao.JmagrAdminNoticeDao;
//import kr.happy.jobkorea.jmgr.dao.JmgrUserDao;
//
//
//
//@Service
//public class JmgrAdminNoticeServiceImpl implements JmgrAdminNoticeService{
//	private final Logger logger = LogManager.getLogger(this.getClass());
//
//	// Get class name for logger
//	private final String className = this.getClass().toString();
//
//
//	@Autowired
//	JmagrAdminNoticeDao jmagrAdminNoticeDao;
//	@Override
//	public List<Map<String, Object>> getUserList(Map<String, Object> paramMap) {
//		
//		//return jmliDeveloperDao.getDeveloperList(paramMap);
//		for(Map.Entry<String, Object> entry : paramMap.entrySet()){
//			System.out.println("========++ "+entry.getKey()+ entry.getValue());
//		}
//		return jmagrAdminNoticeDao.getUserList(paramMap);
//	}
//
//	@Override
//	public int totalCountUser(Map<String, Object> paramMap) {
//		
//		return jmagrAdminNoticeDao.totalCountUser(paramMap);
//	}
//
//	@Override
//	public int idUp(String loginID) {
//		jmagrAdminNoticeDao.idUp(loginID);
//			
//		return jmagrAdminNoticeDao.getDeveloperCnt(loginID);
//		//return 1;
//	}
////
////	
////
////
////	@Override
////	public List<Map<String, Object>> getListReply(Map<String, Object> paramMap) {
////		
////		return jmliDeveloperDao.getListReply(paramMap);
////	}
////
////	@Override
////	public void insertReply(Map<String, Object> paramMap) {
////		jmliDeveloperDao.insertReply(paramMap);
////		
////	}
////
////
////
////	@Override
////	public void updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
////		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
////
////		
////		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
////		String dirPath = jmliDeveloperDao.getDirectory();
////		paramMap.put("dirPath", dirPath);
////		
////		// 파일 저장
////		String itemFilePath = dirPath+ File.separator;
////		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
////		Map<String, Object> fileInfo = fileUtil.uploadFiles();
////		
////		// 데이터 저장
////		try {
////				
////				paramMap.put("fileInfo", fileInfo);
////				jmliDeveloperDao.updateNotice(paramMap);
////				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
////			
////		} catch(Exception e) {
////			// 파일 삭제
////			fileUtil.deleteFiles(fileInfo);
////			throw e;
////		}
////	}
////
////	@Override
////	public void insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
////		
////		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
////
////		
////		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
////		String dirPath = jmliDeveloperDao.getDirectory();
////		paramMap.put("dirPath", dirPath);
////		
////		// 파일 저장
////		String itemFilePath = dirPath+ File.separator;
////		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
////		Map<String, Object> fileInfo = fileUtil.uploadFiles();
////		
////		// 데이터 저장
////		try {
////				
////				paramMap.put("fileInfo", fileInfo);
////				jmliDeveloperDao.insertNotice(paramMap);
////				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
////			
////		} catch(Exception e) {
////			// 파일 삭제
////			fileUtil.deleteFiles(fileInfo);
////			throw e;
////		}
////	
////	}
////
////	@Override
////	public void deleteReplyOne(int no) {
////		jmliDeveloperDao.deleteReplyOne(no);
////	}
////
////	@Override
////	public void deleteNotice(Map<String, Object> paramMap , HttpServletRequest request) throws Exception {
////		
////		String dirPath = jmliDeveloperDao.getDirectory();
////		paramMap.put("dirPath", dirPath);
////		
////		// 파일 저장
////		String itemFilePath = dirPath+ File.separator;
////		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
////		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
////		fileUtil.deleteFiles(paramMap);
////		
////		jmliDeveloperDao.deleteNotice(paramMap);
////		
////		
////	}
//////
//	@Override
//	public Map<String, Object> selectDeveloperOne(Map<String, Object> paramMap) {
//		
//		return jmagrAdminNoticeDao.selectDeveloperOne(paramMap);
//		//return 1;
//	}
//}
