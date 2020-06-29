package kr.happy.jobkorea.hlt.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.hlt.service.TestManagementService;

@Controller
@RequestMapping("/hlt/")
public class TestListController {
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	TestManagementService testManagementService;
	@RequestMapping("/testList.do")
	public String testManagement(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){
		return "/hlt/testList";
	}
	
	
	@RequestMapping("/getSelectedTestList.do")
	@ResponseBody
	public Map<String,Object> getSelectedTestList(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){
		System.out.println("------------------------------------------------------------------------------------");
		System.out.println("------------------------------------------------------------------------------------");
		System.out.println("------------------------------------------------------------------------------------");
		logger.info("+ Start getSelctedTestList");
		logger.info("-- paramMap : "+paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex",pageIndex);
		paramMap.put("pageSize",pageSize);
		
		Map<String,Object> resultMap = new HashMap<>();
		
		
		List<Map<String,Object>> list = testManagementService.getSelectedTest(paramMap);	
		int totalCount = testManagementService.getTotalCount(paramMap);
		resultMap.put("list",list);
		resultMap.put("currentPage",currentPage);
		resultMap.put("pageSize",pageSize);
		resultMap.put("totalCount",totalCount);
		//resultMap.put("totalCount",totalCount);
		
		/*
		Map<String,Object> parmarr = new HashMap<>();
		ArrayList<String>  targetarr = new ArrayList<String> ();
		int idx = 0;
		for(Map<String,Object> item:list) {
			targetarr.add((String)item.get("no"));
			
			System.out.println("********************** : " + (String)item.get("no"));
			idx++;
		}
		
		parmarr.put("list", targetarr);
		
		
		List<Map<String,Object>> testList = testManagementService.getTestStudentCount(parmarr);
		
		
		List<Map<String,Object>> tookTestList = testManagementService.getTookTestStudentCount(parmarr);
		
		resultMap.put("currentPage",currentPage);
		resultMap.put("pageSize",pageSize);
		resultMap.put("list",list);
		resultMap.put("testList",testList);
		resultMap.put("tookTestList",tookTestList);
		resultMap.put("totalCount",totalCount);
		*/
		
		return resultMap;
	
	}

	
	@RequestMapping("/getUsertInfoC.do")
	@ResponseBody
	public Map<String,Object> getUsertInfoC(Model model,
			@RequestParam Map<String, Object>paramMap,
			HttpServletRequest request,
			HttpSession session){
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage-1)*pageSize;
		
		paramMap.put("pageIndex",pageIndex);
		paramMap.put("pageSize",pageSize);
		

		List<Map<String,Object>> list = testManagementService.getUserInfoD(paramMap);	
		int totalCount = testManagementService.getUserInfoCount(paramMap);
		Map<String,Object> resultMap = new HashMap<>();
		
		resultMap.put("list",list);
		resultMap.put("currentPage",currentPage);
		resultMap.put("pageSize",pageSize);
		resultMap.put("totalCount",totalCount);
		
		return resultMap;
	}
	
	
}
