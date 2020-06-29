package kr.happy.jobkorea.register.dao;


import java.util.Map;

import kr.happy.jobkorea.register.model.RegisterModel;

public interface RegisterDao {
	
	// 회원 가입 유저
	public int insertRegister(Map<String, Object> paramMap);
	public int insertSkill(Map<String, Object> temp);
	
	// 회원 가입 기업
	public int insertComp(Map<String, Object> compMap);
	
	// 아이디 찾기
	public RegisterModel selectFindIdRegister(String user_email);
	
	// 비밀번호 찾기
	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam);

	// 아이디 체크
	public int selectIdCheck(String loginId);
	
	// 아이디 중복 체크
	public int idCheck(String loginId);
}