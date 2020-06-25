package kr.happy.jobkorea.jmyp.controller;

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

import kr.happy.jobkorea.jmyp.model.JMyBoardsModel;
import kr.happy.jobkorea.jmyp.service.JMyBoardsService;

@Controller
@RequestMapping("/jmyp/")
public class JMyBoardsController {
	@Autowired
	JMyBoardsService jMyBoardsService;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("/JMyBoards.do")
	public String InitMessagePage(Model model) throws Exception {
		logger.info("+ Start " + className + ".InitMyBoards");

		return "jmyp/JMyBoards";
	}
	
	@RequestMapping("/JMyBoardList.do")
	@ResponseBody
	public Map<String, Object> SelectBoards(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".SelectBoards");
		
		logger.info("SelectBoards - paramMap1 : " + paramMap);
		
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;								// 페이지 시작 row 번호
		//String MsgKinds = (String)paramMap.get("MsgKinds");
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		//paramMap.put("MsgKinds", MsgKinds);
		
		logger.info("SelectBoards - paramMap2 : " + paramMap);
		// 서비스 호출
		System.out.println("SelectBoards3");
		//List<Map<String, Object>> messageList;
		List<JMyBoardsModel> SelectBoardlist = jMyBoardsService.SelectBoards(paramMap);
		
		int SelectedCnt = jMyBoardsService.SelectedBoardsCount(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("SelectBoardlist", SelectBoardlist);
		resultMap.put("SelectedCnt", SelectedCnt);
		//System.out.println("진행확인4");
		
		logger.info("SelectBoards - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SelectBoards");

		
		return resultMap;	
	}	
	
	
}
