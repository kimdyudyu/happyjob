<<<<<<< HEAD
package kr.happy.jobkorea.register.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.happy.jobkorea.register.MailSend;
import kr.happy.jobkorea.register.model.RegisterModel;
import kr.happy.jobkorea.register.service.RegisterService;
import kr.happy.jobkorea.register.service.RegisterServiceImpl;

@Controller
public class RegisterController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RegisterService registerService;

	// 회원가입
	@RequestMapping("/register.do")
	@ResponseBody
	public Map<String, Object> insertRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
//		paramMap.put("loginID", session.getAttribute("loginId").toString());
		
		logger.info("+ Start " + className + ".insertRegister");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
//		String loginID = (String) paramMap.get("loginID");
//		String loginID = session.getAttribute("loginId").toString();
//		session.setAttribute("loginId", action);
//		System.out.println("action : " + action);
		
		String skilldetail = (String) paramMap.get("skilldetail");
		String position = (String) paramMap.get("userPosition");
		
		String[] detailskill = skilldetail.split("/");
		paramMap.put("user_position", position);
		
//		가입 날짜
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String join_date = format1.format(time.getTime());
		System.out.println(join_date);
		paramMap.put("join_date", join_date);
		
		String result;
		String resultMsg;
		if ("I".equals(action)) {
			System.out.println("====================================================if문 접속=================================================");
			System.out.println("====================================================다오 접속=================================================");
			logger.info("   - Skill paramMap : " + paramMap);
			registerService.insertRegister(paramMap);
			System.out.println("====================================================다오 완료=================================================");
			result = "SUCCESS";
			resultMsg = "회원가입이 완료되었습니다.";
		} else {
			result = "FALSE";
			resultMsg = "회원가입이 실패하였습니다.";
			System.out.println("result가 뜨나? : " + result);
			System.out.println("resultMsg가 뜨나? : " + resultMsg);
		}
		
		for(int i=0; i<detailskill.length; i++)
		{
			String arrSkill = detailskill[i];
			char skill = arrSkill.charAt(0);
			String skillcd = String.valueOf(skill);
			String dskill = arrSkill.substring(1);
			String skillstr = "";
			
//			System.out.println(skillcd);
			
			if("L".equals(skillcd)) {
				skillstr = "Language";
			}
			
			if("W".equals(skillcd)) {
				skillstr = "WEB";
			}
			
			if("O".equals(skillcd)) {
				skillstr = "OS";
			}
			
			if("F".equals(skillcd)) {
				skillstr = "FrameWork";
			}
			
			if("D".equals(skillcd)) {
				skillstr = "DB";
			}
			
			if("N".equals(skillcd)) {
				skillstr = "Network";
			}
			
			if("S".equals(skillcd)) {
				skillstr = "WebServer";
			}
			
			Map<String, Object> temp = new HashMap<String, Object>();
			temp.put("loginID", paramMap.get("loginID"));
			temp.put("skill_code", skillstr);
			temp.put("skill_detail", dskill);
			
			System.out.println(temp);
			
			System.out.println("=============================다오 접속==================================");
			registerService.insertSkill(temp);
			System.out.println("=============================다오 완료==================================");
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".initComnCod");

		return resultMap;

	}
	
	@RequestMapping("/comp.do")
	@ResponseBody
	public Map<String, Object> insertComp(Model model, @RequestParam Map<String, Object> compMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String action = (String) compMap.get("action");
		String loginID = (String) compMap.get("loginID");
		session.setAttribute("loginId", action);
		
		String result;
		String resultMsg;
		if ("I".equals(action)) {
			System.out.println("====================================================if문 접속=================================================");
			System.out.println("====================================================다오 접속=================================================");
			registerService.insertComp(compMap);
			System.out.println("====================================================다오 완료=================================================");
			result = "SUCCESS";
			resultMsg = "회원가입이 완료되었습니다.";
		} else {
			result = "FALSE";
			resultMsg = "회원가입이 실패하였습니다.";
			System.out.println("result가 뜨나? : " + result);
			System.out.println("resultMsg가 뜨나? : " + resultMsg);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".initComnCod");

		return resultMap;
		
	}

	/* 아이디 찾기 (메일 전송) */
	@RequestMapping("/registerFindId.do")
	@ResponseBody
	public int selectRegisterFind(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println("registerFind 호출");
		int flag = 0;

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		if (paramMap.get("data-code").equals("I")) {
			RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

			if (StringUtils.isEmpty(rgmId)) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindIdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}

		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;
	}

	// 아이디 찾기 (아이디 뜨게)
	@RequestMapping("/findRegisterId.do")
	@ResponseBody
	public String selectFindIdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");

		RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

		String findId = rgmId.getLoginID();

		return findId;
	}

	// 비밀번호 찾기 (메일전송)
	@RequestMapping("/registerFindPwd.do")
	@ResponseBody
	public int selectRegisterFindPwd(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		int flag = 0;

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		if (paramMap.get("data-code").equals("P")) {
			RegisterModel rgmParam = new RegisterModel();
			rgmParam.setEmail(user_email);
			rgmParam.setLoginID(loginId);
			RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

			if (rgmPwd == null) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindPwdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}

		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;

	}

	// 비밀번호 찾기 (비번 뜨게)
	@RequestMapping("/findRegisterPwd.do")
	@ResponseBody
	public String selectFindPwdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginID");

		RegisterModel rgmParam = new RegisterModel();
		rgmParam.setLoginID(loginId);
		rgmParam.setEmail(user_email);
		System.out.println("비밀번호 찾기 loginId : " + loginId);
		System.out.println("비밀번호 찾기 email : " + user_email);

		RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

		String findPwd = rgmPwd.getPassword();

		return findPwd;
	}

	// 아이디 체크
	@RequestMapping("/registerIdCheck.do")
	@ResponseBody
	public Map<String, Object> selectIdCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String loginId = (String) paramMap.get("loginId");
		
		int count = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		count = registerService.selectIdCheck(loginId);
		map.put("cnt", count);
		
		return map;
		
		/*RegisterModel idParam = new RegisterModel();
		idParam.setLoginId(loginId);
		System.out.println("loginId가 찍힙니까? : " + loginId);

		RegisterModel rgmIdCheck = registerService.selectIdCheck(idParam);
		if(rgmIdCheck.equals(idParam)){
			
		}else{
			
		}
		System.out.println("idparam이 찍히니? : " + idParam);
		
		String checkId = rgmIdCheck.getLoginId();
		System.out.println("뜨나 ? : " + checkId);

		return idParam;
	}*/
	}
	
	@RequestMapping("/compCheck.do")
	@ResponseBody
	public Map<String, Object> compCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String compID = (String) paramMap.get("compId");
		String chkmsg = "";
		
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int compCheck = registerService.idCheck(compID);
		
		logger.info("   - idCheck : " + compCheck);
		
		if(compCheck == 0) {
			chkmsg = "N";
		} else {
			chkmsg = "Y";			
		}
		
		resultMap.put("chkmsg", chkmsg);
		
		logger.info("   - resultMap : " + resultMap + "000000000000000000000000");
		
		return resultMap;
		
	}
	
	@RequestMapping("/userCheck.do")
	@ResponseBody
	public Map<String, Object> userCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String userID = (String) paramMap.get("registerId");
		String chkmsg = "";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int userCheck = registerService.idCheck(userID);
		
		if(userCheck == 0) {
			chkmsg = "N";
		} else {
			chkmsg = "Y";			
		}
		
		resultMap.put("chkmsg", chkmsg);
		
		logger.info("   - resultMap : " + resultMap + "000000000000000000000000");
		
		return resultMap;
		
	}
	
}
=======
package kr.happy.jobkorea.register.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import kr.happy.jobkorea.register.MailSend;
import kr.happy.jobkorea.register.model.RegisterModel;
import kr.happy.jobkorea.register.service.RegisterService;
import kr.happy.jobkorea.register.service.RegisterServiceImpl;

@Controller
public class RegisterController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RegisterService registerService;

	// 회원가입
	@RequestMapping("/register.do")
	@ResponseBody
	public Map<String, Object> insertRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
//		paramMap.put("loginID", session.getAttribute("loginId").toString());
		
		logger.info("+ Start " + className + ".insertRegister");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
//		String loginID = (String) paramMap.get("loginID");
//		String loginID = session.getAttribute("loginId").toString();
//		session.setAttribute("loginId", action);
//		System.out.println("action : " + action);
		
		String skilldetail = (String) paramMap.get("skilldetail");
		String position = (String) paramMap.get("userPosition");
		
		String[] detailskill = skilldetail.split("/");
		paramMap.put("user_position", position);
		
//		가입 날짜
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String join_date = format1.format(time.getTime());
		System.out.println(join_date);
		paramMap.put("join_date", join_date);
		
		String result;
		String resultMsg;
		if ("I".equals(action)) {
			System.out.println("====================================================if문 접속=================================================");
			System.out.println("====================================================다오 접속=================================================");
			logger.info("   - Skill paramMap : " + paramMap);
			registerService.insertRegister(paramMap);
			System.out.println("====================================================다오 완료=================================================");
			result = "SUCCESS";
			resultMsg = "회원가입이 완료되었습니다.";
		} else {
			result = "FALSE";
			resultMsg = "회원가입이 실패하였습니다.";
			System.out.println("result가 뜨나? : " + result);
			System.out.println("resultMsg가 뜨나? : " + resultMsg);
		}
		
		for(int i=0; i<detailskill.length; i++)
		{
			String arrSkill = detailskill[i];
			char skill = arrSkill.charAt(0);
			String skillcd = String.valueOf(skill);
			String dskill = arrSkill.substring(1);
			String skillstr = "";
			
//			System.out.println(skillcd);
			
			if("L".equals(skillcd)) {
				skillstr = "Language";
			}
			
			if("W".equals(skillcd)) {
				skillstr = "WEB";
			}
			
			if("O".equals(skillcd)) {
				skillstr = "OS";
			}
			
			if("F".equals(skillcd)) {
				skillstr = "FrameWork";
			}
			
			if("D".equals(skillcd)) {
				skillstr = "DB";
			}
			
			if("N".equals(skillcd)) {
				skillstr = "Network";
			}
			
			if("S".equals(skillcd)) {
				skillstr = "WebServer";
			}
			
			Map<String, Object> temp = new HashMap<String, Object>();
			temp.put("loginID", paramMap.get("loginID"));
			temp.put("skill_code", skillstr);
			temp.put("skill_detail", dskill);
			
			System.out.println(temp);
			
			System.out.println("=============================다오 접속==================================");
			registerService.insertSkill(temp);
			System.out.println("=============================다오 완료==================================");
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".initComnCod");

		return resultMap;

	}
	
	@RequestMapping("/comp.do")
	@ResponseBody
	public Map<String, Object> insertComp(Model model, @RequestParam Map<String, Object> compMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String action = (String) compMap.get("action");
		String loginID = (String) compMap.get("loginID");
		session.setAttribute("loginId", action);
		
		String result;
		String resultMsg;
		if ("I".equals(action)) {
			System.out.println("====================================================if문 접속=================================================");
			System.out.println("====================================================다오 접속=================================================");
			registerService.insertComp(compMap);
			System.out.println("====================================================다오 완료=================================================");
			result = "SUCCESS";
			resultMsg = "회원가입이 완료되었습니다.";
		} else {
			result = "FALSE";
			resultMsg = "회원가입이 실패하였습니다.";
			System.out.println("result가 뜨나? : " + result);
			System.out.println("resultMsg가 뜨나? : " + resultMsg);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".initComnCod");

		return resultMap;
		
	}

	/* 아이디 찾기 (메일 전송) */
	@RequestMapping("/registerFindId.do")
	@ResponseBody
	public int selectRegisterFind(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println("registerFind 호출");
		int flag = 0;

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginId");

		if (paramMap.get("data-code").equals("I")) {
			RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

			if (StringUtils.isEmpty(rgmId)) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindIdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}

		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;
	}

	// 아이디 찾기 (아이디 뜨게)
	@RequestMapping("/findRegisterId.do")
	@ResponseBody
	public String selectFindIdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");

		RegisterModel rgmId = registerService.selectFindIdRegister(user_email);

		String findId = rgmId.getLoginID();

		return findId;
	}

	// 비밀번호 찾기 (메일전송)
	@RequestMapping("/registerFindPwd.do")
	@ResponseBody
	public int selectRegisterFindPwd(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("paramMap : " + paramMap);
		int flag = 0;

		String user_email = (String)paramMap.get("email");
		String loginId = (String)paramMap.get("loginId");

		if (paramMap.get("data-code").equals("P")) {
			RegisterModel rgmParam = new RegisterModel();
			rgmParam.setEmail(user_email);
			rgmParam.setLoginID(loginId);
			RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

			if (StringUtils.isEmpty(rgmPwd)) {
				flag = 1;
			} else {
				MailSend ms = new MailSend();
				String authNum = ms.RegisterFindPwdEmailSend(user_email);
				flag = Integer.parseInt(authNum);
			}
		} else {
			flag = 1; // 가입한 아이디가 없음
		}
		return flag;

	}

	// 비밀번호 찾기 (비번 뜨게)
	@RequestMapping("/findRegisterPwd.do")
	@ResponseBody
	public String selectFindPwdRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String user_email = (String) paramMap.get("email");
		String loginId = (String) paramMap.get("loginID");

		RegisterModel rgmParam = new RegisterModel();
		rgmParam.setLoginID(loginId);
		rgmParam.setEmail(user_email);
		System.out.println("비밀번호 찾기 loginId : " + loginId);
		System.out.println("비밀번호 찾기 email : " + user_email);

		RegisterModel rgmPwd = registerService.selectFindPwdRegister(rgmParam);

		String findPwd = rgmPwd.getPassword();

		return findPwd;
	}

	// 아이디 체크
	@RequestMapping("/registerIdCheck.do")
	@ResponseBody
	public Map<String, Object> selectIdCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String loginId = (String)paramMap.get("loginID");
		
		int count = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		count = registerService.selectIdCheck(loginId);
		map.put("cnt", count);
		
		return map;
		
		/*RegisterModel idParam = new RegisterModel();
		idParam.setLoginId(loginId);
		System.out.println("loginId가 찍힙니까? : " + loginId);

		RegisterModel rgmIdCheck = registerService.selectIdCheck(idParam);
		if(rgmIdCheck.equals(idParam)){
			
		}else{
			
		}
		System.out.println("idparam이 찍히니? : " + idParam);
		
		String checkId = rgmIdCheck.getLoginId();
		System.out.println("뜨나 ? : " + checkId);

		return idParam;
	}*/
	}
	
	@RequestMapping("/compCheck.do")
	@ResponseBody
	public Map<String, Object> compCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String compID = (String) paramMap.get("compId");
		String chkmsg = "";
		
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int compCheck = registerService.idCheck(compID);
		
		logger.info("   - idCheck : " + compCheck);
		
		if(compCheck == 0) {
			chkmsg = "N";
		} else {
			chkmsg = "Y";			
		}
		
		resultMap.put("chkmsg", chkmsg);
		
		logger.info("   - resultMap : " + resultMap + "000000000000000000000000");
		
		return resultMap;
		
	}
	
	@RequestMapping("/userCheck.do")
	@ResponseBody
	public Map<String, Object> userCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		String userID = (String) paramMap.get("registerId");
		String chkmsg = "";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int userCheck = registerService.idCheck(userID);
		
		if(userCheck == 0) {
			chkmsg = "N";
		} else {
			chkmsg = "Y";			
		}
		
		resultMap.put("chkmsg", chkmsg);
		
		logger.info("   - resultMap : " + resultMap + "000000000000000000000000");
		
		return resultMap;
		
	}
	
}
>>>>>>> origin/dhBackup
