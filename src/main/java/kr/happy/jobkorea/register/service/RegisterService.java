package kr.happy.jobkorea.register.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.register.model.RegisterModel;

public interface RegisterService {
	
	/* 회원가입 */

	public int insertRegister(Map<String, Object> paramMap) throws Exception;
	public int insertSkill(Map<String, Object> temp) throws Exception;
	
	public int insertComp(Map<String, Object> compMap) throws Exception;
	
	/* 아이디 찾기 */
	
	public RegisterModel selectFindIdRegister(String user_email) throws Exception;
	
	/* 비밀번호 찾기 */
	
	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam) throws Exception;
	
	/* 아이디 체크 */
	public int selectIdCheck(String loginId) throws Exception;
	
	/* 아이디 중복 체크 */
	public int idCheck(String loginId) throws Exception;
	
}
