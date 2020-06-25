package kr.happy.jobkorea.jmyp.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.jmyp.service.MyinfoService;
import kr.happy.jobkorea.jmyp.service.MyinfoServiceImpl;
import kr.happy.jobkorea.register.model.RegisterModel;

@Controller
@RequestMapping("/jmyp/")
public class MyinfoController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MyinfoService myinfoService;
	
	@RequestMapping("/userMyinfo.do")
	public String userMyinfo(Model model) throws Exception {
		return "jmyp/Myinfo";
	}
	
	@RequestMapping("/selectRegister.do")
	@ResponseBody
	public Map<String, Object> selectRegister(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		System.out.println(session.getAttribute("loginId").toString());
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		RegisterModel myinfo = myinfoService.selectRegister(paramMap);
		
		resultMap.put("myinfo", myinfo);
		
		return resultMap;
		
	}
	
	@RequestMapping("/userUpdate.do")
	@ResponseBody
	public Map<String, Object> userUpdate(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

//		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		logger.info("+ Start " + className + ".insertRegister");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
//		String loginID = (String) paramMap.get("loginId");
		String loginID = session.getAttribute("loginId").toString();
		
		String skilldetail = (String) paramMap.get("skilldetail");
		String position = (String) paramMap.get("userPosition");

		String[] detailskill = skilldetail.split("/");
		paramMap.put("user_position", position);
		
		System.out.println("==================================================================================================================");
		logger.info("   - paramMap 넘어오는거 확인 : " + paramMap);
		System.out.println("==================================================================================================================");
		
		String result;
		String resultMsg;
		try{
			myinfoService.userUpdate(paramMap);
			result = "SUCCESS";
			resultMsg = "수정이 완료되었습니다.";
		}
		catch(Exception e) {
			e.printStackTrace();
			result = "FALSE";
			resultMsg = "수정이 실패하였습니다.";
		}
		
		Map<String, Object> skilldel = new HashMap<String, Object>();
		skilldel.put("loginID", loginID);
		
		System.out.println("===============================삭제 접속==============================");
		myinfoService.skillDelete(skilldel);
		System.out.println("===============================삭제 완료==============================");
		
		for(int i=0; i<detailskill.length; i++)
		{
			String arrSkill = detailskill[i];
			char skill = arrSkill.charAt(0);
			String skillcd = String.valueOf(skill);
			String dskill = arrSkill.substring(1);
			String skillstr = "";
			
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
			temp.put("loginID", loginID);
			temp.put("skill_code", skillstr);
			temp.put("skill_detail", dskill);
			
			System.out.println(temp);
			
			System.out.println("===============================다오 접속==============================");
			System.out.println("===============================insert 시작==============================");
			myinfoService.updateSkill(temp);
			System.out.println("===============================insert 완료==============================");
			System.out.println("===============================다오 접속==============================");
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".initComnCod");
		
		
		
		return resultMap;
		
	}

}
