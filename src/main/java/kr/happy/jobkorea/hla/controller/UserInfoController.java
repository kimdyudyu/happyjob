package kr.happy.jobkorea.hla.controller;

import java.io.File;


import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.hla.model.UserInfoModel;
import kr.happy.jobkorea.hla.service.UserInfoService;



@Controller
@RequestMapping("/hla/")
public class UserInfoController {
	
	@Autowired
	UserInfoService userInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("/hUserInfo.do")
	public String InitUserInfo(Model model) throws Exception {
		logger.info("+ Start " + className + ".UserInfoPage");
		//logger.info("jmjm   - paramMap : ");
		return "/hla/hUserInfoPage";
	}
	
	@RequestMapping("/hResumeInfo.do")
	public String InitResumeInfo(Model model) throws Exception {
		logger.info("+ Start " + className + ".InitResumeInfo");
		//logger.info("jmjm   - paramMap : ");
		return "/hla/hResumeInfoPage";
	}
	
	
	@RequestMapping("/hUserInfoList.do")
	@ResponseBody
	public Map<String, Object> SelectUserInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".SelectUserInfo");
		
		logger.info("SelectUserInfo - paramMap1 : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<UserInfoModel> UserInfoList = userInfoService.SelectUserInfo(paramMap);
		
		int SelectedCnt = userInfoService.getSelectedCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("UserInfoList", UserInfoList);
		resultMap.put("SelectedCnt", SelectedCnt);
		
		
		logger.info("SelectUserInfo - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SelectUserInfo");
		
		return resultMap;
	}
	
	
	@RequestMapping("/hCRUDUser.do")
	@ResponseBody
	public Map<String, Object> registUser(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		String result = "SUCCESS";
		String resultMsg = "가입되었습니다.";
		
		logger.info(" registUser - paramMap : " + paramMap);
		
		String action = paramMap.get("action").toString();
		
		if(action.equals("U"))
		{
			userInfoService.UpdateUser(paramMap);
			result = "SUCCESS";
			resultMsg = "수정 되었습니다.";
		}
		else if(action.equals("I"))
		{
			userInfoService.RegistUser(paramMap);
			result = "SUCCESS";
			resultMsg = "가입 되었습니다.";
		}
		else if(action.equals("R"))
		{
		}
		else
		{
			logger.info(" action - paramMap : " + action);
			resultMsg = "에러";
		}
			
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	@RequestMapping("/hLectureList.do")
	@ResponseBody
	public Map<String, Object> SelectLectureList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".SelectLectureList");
		
		logger.info("SelectLectureList - paramMap1 : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<UserInfoModel> UserInfoList = userInfoService.SelectUserInfo(paramMap);
		
		int SelectedCnt = userInfoService.getSelectedCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("UserInfoList", UserInfoList);
		resultMap.put("SelectedCnt", SelectedCnt);
		
		
		logger.info("SelectUserInfo - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SelectUserInfo");
		
		return resultMap;
	}	
	
	
}
