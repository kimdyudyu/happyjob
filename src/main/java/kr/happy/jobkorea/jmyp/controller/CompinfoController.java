package kr.happy.jobkorea.jmyp.controller;

import java.util.HashMap;
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

import kr.happy.jobkorea.jmyp.service.CompinfoService;
import kr.happy.jobkorea.register.model.RegisterModel;



@Controller
@RequestMapping("/jmyp/")
public class CompinfoController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CompinfoService compinfoService;
	
	@RequestMapping("/compMyinfo.do")
	public String compMyinfo(Model model) throws Exception {
		return "jmyp/Compinfo";
	}
	
	@RequestMapping("/selectComp.do")
	@ResponseBody
	public Map<String, Object> selectComp(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		System.out.println(session.getAttribute("loginId").toString());
		
		logger.info("MessageList - paramMap1 : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		RegisterModel compinfo = compinfoService.selectComp(paramMap);
		
//		compinfo.setLoginID(session.getAttribute("loginId").toString());
		
		resultMap.put("compinfo", compinfo);
		
		return resultMap;
		
	}
	
	@RequestMapping("/compUpdate.do")
	@ResponseBody
	public Map<String, Object> userUpdate(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
//		String action = (String) paramMap.get("action");
		
		String result;
		String resultMsg;
		try{
			compinfoService.compUpdate(paramMap);
			result = "SUCCESS";
			resultMsg = "수정이 완료되었습니다.";
		}
		catch(Exception e) {
			e.printStackTrace();
			result = "FALSE";
			resultMsg = "수정이 실패하였습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".initComnCod");
		
		return resultMap;
		
	}
	
}
