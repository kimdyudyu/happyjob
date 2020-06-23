package kr.happy.jobkorea.hlt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import net.sf.json.JSONArray; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.hlt.model.LectureVO;
import kr.happy.jobkorea.hlt.model.QuestionsVO;
import kr.happy.jobkorea.hlt.service.TestManagementService;

@Controller
@RequestMapping("/hlt/")
public class TestManagementController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	TestManagementService testManagementService;
	@RequestMapping("/testManagement.do")
	public String testManagement(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){
		return "/hlt/testManagement";
	}
	
	@RequestMapping("/getCourseList.do")
	@ResponseBody
	public Map<String,Object> getCourseList(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){

		logger.info("+ Start testManagement");
		logger.info("+ End testManagement");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1) * pageSize;
		
		String loginID = (String)session.getAttribute("loginId");
		loginID = (loginID == null) ?  "1234" : loginID;
		
		paramMap.put("loginID", loginID);
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<LectureVO> list = testManagementService.getCourseList(paramMap);
		
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("list",list);
		
		int totalCount = testManagementService.totalCountCourse();
		
		resultMap.put("totalCountList", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPage", currentPage);
		

		return resultMap;
	}
	
	
	@RequestMapping("/getTestResult.do")
	@ResponseBody
	public Map<String,Object> getTestResult(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){

		logger.info("+ Start getTestResult");
		logger.info("+ End getTestResult");
		
		String loginID = (String)session.getAttribute("loginId");
		
		paramMap.put("loginID", loginID);
		
		List<LectureVO> list = testManagementService.getTestResult(paramMap);
		int totalC = testManagementService.getTotalC(paramMap);
		int totalRe = testManagementService.getTotalRe(paramMap);
		List<QuestionsVO> listDetail = testManagementService.getTestResultDetail(paramMap);
		List<QuestionsVO> listDetailR = testManagementService.getTestResultDetailRe(paramMap);
		
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("list",list);
		resultMap.put("totalC",totalC);
		resultMap.put("totalRe",totalRe);
		resultMap.put("listDetail",listDetail);
		resultMap.put("listDetailR",listDetailR);
		
		return resultMap;
	}
	
	
	@RequestMapping("/saveQuesions.do")
	@ResponseBody
	public Map<String,Object> saveQuesions(Model model,
			@RequestBody String jsonData,
			HttpServletRequest request,
			HttpSession session){

		 List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
		 resultMap= JSONArray.fromObject(jsonData);
		
		 String result;
		try{
			testManagementService.saveQuestions(resultMap);
			result ="success";
		}catch(Exception e){
			e.printStackTrace();
			result ="fail";
		}
		Map<String,Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}

	@RequestMapping("/modifyQuesions.do")
	@ResponseBody
	public Map<String,Object> modifyQuesions(Model model,
			@RequestBody String jsonData,
			HttpServletRequest request,
			HttpSession session){

		 List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
		 resultMap= JSONArray.fromObject(jsonData);
		
		
		 String result;
		try{
			testManagementService.deleteQuestions(resultMap.get(0));
			
			testManagementService.saveQuestions(resultMap);
			result ="modifysuccess";
		}catch(Exception e){
			e.printStackTrace();
			result ="fail";
		}
		Map<String,Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
}
