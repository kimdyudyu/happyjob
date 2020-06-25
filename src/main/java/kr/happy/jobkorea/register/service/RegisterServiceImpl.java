package kr.happy.jobkorea.register.service;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.happy.jobkorea.common.comnUtils.ComnUtil;
import kr.happy.jobkorea.register.dao.RegisterDao;
import kr.happy.jobkorea.register.model.RegisterModel;

@Service
public class RegisterServiceImpl implements RegisterService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private RegisterDao registerDao;

	// 회원가입 유저
	public int insertRegister(Map<String, Object> paramMap) throws Exception {
		return registerDao.insertRegister(paramMap);
	}

	@Override
	public int insertSkill(Map<String, Object> temp) throws Exception {
		return registerDao.insertSkill(temp);
	}
	
	// 회원가입 기업
	public int insertComp(Map<String, Object> compMap) throws Exception {
		return registerDao.insertComp(compMap);
	}
	
	// 아이디 찾기
	public RegisterModel selectFindIdRegister(String email) throws Exception {

		return registerDao.selectFindIdRegister(email);
	}

	// 비밀번호 찾기

	public RegisterModel selectFindPwdRegister(RegisterModel rgmParam) throws Exception {
		return registerDao.selectFindPwdRegister(rgmParam);
	}
	
	// 아이디 체크
	public int selectIdCheck(String loginId) throws Exception{
		return registerDao.selectIdCheck(loginId);
	}

	@Override
	public int idCheck(String loginId) throws Exception {
		System.out.println("=================== 서비스 체크 ================");
		System.out.println(loginId);
		return registerDao.idCheck(loginId);
	}


}
