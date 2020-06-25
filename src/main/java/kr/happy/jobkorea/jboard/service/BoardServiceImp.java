package kr.happy.jobkorea.jboard.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happy.jobkorea.common.comnUtils.FileUtilCho;
import kr.happy.jobkorea.jboard.dao.BoardDao;

@Service
public class BoardServiceImp implements BoardService {
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public List<Map<String, Object>> getRoomList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return boardDao.getRoomList(paramMap);
	}

	@Override
	public int totalCountRoom(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return boardDao.totalCountRoom(paramMap);
	}

	@Override
	public void updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = boardDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
		
				paramMap.put("fileInfo", fileInfo);
				boardDao.updateNotice(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	
	}

	@Override
	public void insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		String dirPath = boardDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		// 데이터 저장
		try {
		
				paramMap.put("fileInfo", fileInfo);
				boardDao.insertNotice(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
	
	}
	
	@Override
	public void deleteNotice(Map<String, Object> paramMap , HttpServletRequest request) throws Exception {
		
		String dirPath = boardDao.getDirectory();
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator;
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		fileUtil.deleteFiles(paramMap);
		
		boardDao.deleteNotice(paramMap);
		
		
	}

	@Override
	public void countUp(String nt_seq) {
		boardDao.countUp(nt_seq);
		
		//return boardDao.getNoticeCnt(nt_seq);
	}

	@Override
	public Map<String, Object> selectNoticeOne(Map<String, Object> paramMap) {
		
		return boardDao.selectNoticeOne(paramMap);
	}
	
	
}
