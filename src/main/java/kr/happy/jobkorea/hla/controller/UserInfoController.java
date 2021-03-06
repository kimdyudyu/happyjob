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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happy.jobkorea.common.comnUtils.FileUtilCho;
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
	
	@RequestMapping("/hTeacherInfo.do")
	public String InitUserInfo(Model model) throws Exception {
		logger.info("+ Start " + className + ".UserInfoPage");
		//logger.info("jmjm   - paramMap : ");
		
		model.addAttribute("calltype", "D");
		
		return "/hla/hUserInfoPage";
	}
	
	@RequestMapping("/hStudentInfo.do")
	public String InitUserInfo2(Model model) throws Exception {
		logger.info("+ Start " + className + ".UserInfoPage");
		//logger.info("jmjm   - paramMap : ");
		
		model.addAttribute("calltype", "C");	
		
		return "/hla/hUserInfoPage";
	}	
	
	@RequestMapping("/hResumeInfo.do")
	public String InitResumeInfo(Model model) throws Exception {
		logger.info("+ Start " + className + ".InitResumeInfo");
		//logger.info("jmjm   - paramMap : ");
		return "/hla/hResumeInfoPage";
	}
	///hla/hUpdateMyInfo.do
	
	@RequestMapping("/hUpdateMyInfo.do")
	public String UpdateMyInfo(Model model) throws Exception {
		logger.info("+ Start " + className + ".hUpdateMyInfo");
		//logger.info("jmjm   - paramMap : ");
		return "/hla/hUpdateMyInfo";
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
		Map<String, Object> resultMap = new HashMap<String, Object>();
		logger.info(" registUser - paramMap : " + paramMap);
		logger.info("registUser- request : " + request);
		
		String action = paramMap.get("action").toString();
		
		if(action.equals("U"))
		{			
			userInfoService.UpdateUser(paramMap, request);
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
			UserInfoModel userInfo = userInfoService.SelectAUserInfo(paramMap);
			
			resultMap.put("userInfo", userInfo);
		}
		else if(action.equals("UR"))
		{
			paramMap.put("loginID", session.getAttribute("loginId").toString());
			UserInfoModel userInfo = userInfoService.SelectAUserInfo(paramMap);			
			resultMap.put("userInfo", userInfo);
		}
		else
		{
			logger.info(" action - paramMap : " + action);
			resultMsg = "에러";
		}		
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
		
		List<UserInfoModel> LectureList = userInfoService.SelectLectureList(paramMap);
		
		int SelectedCnt = userInfoService.getLectureCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("LectureList", LectureList);
		resultMap.put("SelectedCnt", SelectedCnt);
		
		
		logger.info("SelectUserInfo - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SelectLectureList");
		
		return resultMap;
	}
	
	@RequestMapping("/hStudentList.do")
	@ResponseBody
	public Map<String, Object> SelectStudentList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".SelectStudentList");
		
		logger.info("SelectStudentList - paramMap1 : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<UserInfoModel> StudentList = userInfoService.SelectStudentList(paramMap);
		
		int SelectedCnt = userInfoService.getStudentCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("StudentList", StudentList);
		resultMap.put("SelectedCnt", SelectedCnt);
		
		
		logger.info("SelectUserInfo - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SelectStudentList");
		
		return resultMap;
	}
	
	@RequestMapping("/hSetResumeTable.do")
	@ResponseBody
	public Map<String, Object> SetResumeTable(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".SetResumeTable");
		
		logger.info("SetResumeTable - paramMap1 : " + paramMap);
		
		List<UserInfoModel> LectureList  = userInfoService.ResumeLectureList(paramMap);
		List<UserInfoModel> TestList	 = userInfoService.ResumeTestList(paramMap);
		//List<UserInfoModel> TestScores	 = userInfoService.reResumeTestList(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("LectureList", LectureList);
		resultMap.put("TestList", TestList);
		
		
		logger.info("SelectUserInfo - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SetResumeTable");
		
		return resultMap;
	}
	
	@RequestMapping("/hIdCheck.do")
	@ResponseBody
	public Map<String, Object> IdCheck(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".IdCheck");
		
		logger.info("IdCheck - paramMap1 : " + paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;
		String resultMsg = "";		
		//List<UserInfoModel> LectureList  = userInfoService.ResumeLectureList(paramMap);
		//List<UserInfoModel> TestList	 = userInfoService.ResumeTestList(paramMap);
		//List<UserInfoModel> TestScores	 = userInfoService.reResumeTestList(paramMap);
		
		List<UserInfoModel> CheckID  = userInfoService.IDValidation(paramMap);
		
		if(CheckID.isEmpty())
		{
			result = true;
			resultMsg = "사용가능합니다.";
		}
		else
		{
			result = false;
			resultMsg = "중복되었습니다.";			
		}		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		
		logger.info("IdCheck - resultMap : " + resultMap);
		logger.info("+ End " + className + ".IdCheck");
		
		return resultMap;
	}
	
	/*@RequestMapping("/hSetUserImage.do")
	@ResponseBody
	public String SetUserImage(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{		
		logger.info("+ Start " + className + ".SetUserImage");
		
		logger.info("SetUserImage - paramMap1 : " + paramMap);
		
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		logger.info("SetUserImage - request : " + multipartHttpServletRequest);
		
		//String dirPath = UserInfoDao.getDirectory();
		//param.put("dirPath", dirPath);
		
		// 파일 저장
		//String itemFilePath = dirPath+ File.separator;
		
		// 파일 저장
		//String itemFilePath = File.separator;
		//FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", itemFilePath);
		//Map<String, Object> fileInfo = fileUtil.uploadFiles();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		

		
		//logger.info("SetUserImage - resultMap : " + resultMap);
		//logger.info("+ End " + className + ".SetUserImage");
		
		//return resultMap;
		return "hi";
	}*/
	
	
}
