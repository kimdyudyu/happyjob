package kr.happy.jobkorea.lsm.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happy.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.happy.jobkorea.lsm.model.LsmStuCodModel;
import kr.happy.jobkorea.lsm.model.taskFileModel;
import kr.happy.jobkorea.lsm.model.taskInfoModel;

public interface LSMBoardService {

	
	/**  강사들이 올린 리스트 조회  **/
	public List<Map<String,Object>> selectLsmBoardList (Map<String,Object> paramMap) throws Exception;

	public Map<String, Object> lsmModal(Map<String, Object> paramMap);
	
	public int countListLsmCod(Map<String, Object> paramMap) throws Exception;

	/* 단건 조회*/
	public Map<String,Object> selectLsmCod(Map<String, Object> paramMap) throws Exception;

	/* 과제등록 */
	public int insertLsmCod(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/* 강의번호 호출*/
	public List<Integer> selectLecSeq () throws Exception;
	
	/* 강의명 호출*/
	public List<String> selectLecNm () throws Exception;
	
	/* 강사명 호출*/
	public List<String> selectLecTName () throws Exception;
	

	//강의 시작일 조회해서 넘기기
	public List<Date> selectLecStartDate() throws Exception;

	//강의 종료일 조회해서 넘기기
	public List<Date> selectLecEndDate() throws Exception;
	
	//강의실 조회해서 넘기기
	public List<String> selectLecRoom() throws Exception;

	//진도 조회해서 넘기기
	public List<String> selectLecProgress() throws Exception;
	
	
	/* 과제 삭제 */
	public int deleteLsmCod(Map<String,Object>paramMap) throws Exception;

	/* 과제수정 */
	public int updateLsmCod(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/**  첨부 파일 저장 */
	public int saveLsmFil(Map<String, Object>paramMap) throws Exception;
		
	public List<Map<String,Object>>listLsmFilModel(Map<String,Object> paramMap) throws Exception;
	
	public String selectMaxNum (Map<String, Object> paramMap) throws Exception;
	
	/** 게시글 첨부 단건 조회 */
	public Map<String,Object> selectLsmFil(Map<String, Object>paramMap) throws Exception;
	
	/** 제출 첨부 단건 조회 */
	public Map<String,Object> selectStuFil(Map<String, Object>paramMap)throws Exception;
	
	/** 게시글 첨부 목록 조회 */
	public List<Map<String,Object>> listLsmFil(Map<String, Object>paramMap) throws Exception;
	
	/** 게시글 첨부 파일 수정 */
	public int updateLsmFile(Map<String, Object>paramMap) throws Exception;
	
	/** 게시글 첨부 파일 단건 삭제 */
	public int deleteLsmFil(Map<String, Object>paramMap) throws Exception;
	
	/** 과제 제출 학생 조회 */
	public List<Map<String,Object>>selectLsmStuList (Map<String, Object> paramMap) throws Exception;
	
	/** 과제 제출 목록 카운트 조회 */
	public int countLsmStuListCod(Map<String, Object> paramMap) throws Exception;
}
