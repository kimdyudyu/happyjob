package kr.happy.jobkorea.lss.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happy.jobkorea.lsm.model.LsmStuCodModel;
import kr.happy.jobkorea.lsm.model.taskFileModel;
import kr.happy.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.happy.jobkorea.login.model.LgnInfoModel;
import kr.happy.jobkorea.login.model.UsrMnuAtrtModel;
import kr.happy.jobkorea.login.model.UsrMnuChildAtrtModel;
import kr.happy.jobkorea.lsm.model.taskInfoModel;
import kr.happy.jobkorea.lss.model.LSSEnrDocModel;

public interface LSSEnrLecDao{
	
	//전체조회
	public List<Map<String, Object>> selectLssList(Map<String, Object> paramMap);
	
	//전체 개수 조회
	public int LecDocTotalCnt(Map<String, Object> paramMap);
	
	//신규 학습자료 저장
	public int insertLecDoc(Map<String, Object>paramMap);
	
	//파일 저장
	public int saveLecDocFile(Map<String, Object>paramMap);
	
	//등록시 강의번호 호출
	public List<Integer> selectLecSeq(String LoginId);
	
	//등록시 강의명 호출
	public List<String> selectLecNm();
	
	//단건 조회
	public Map<String, Object> selectLssDetail(Map<String, Object> paramMap);
	
	//수정
	public void updateLecDoc(Map<String, Object> paramMap);
	
	//삭제
	public void deleteLss(Map<String, Object>paramMap);
	
	//ldo_seq 최대값 조회
	public  int  selectldoseq(Map<String,Object> paramMap);

}
