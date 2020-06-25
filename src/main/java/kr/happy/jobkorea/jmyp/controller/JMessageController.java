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

import kr.happy.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.happy.jobkorea.cmnt.model.CmntBbsCmtModel;
import kr.happy.jobkorea.cmnt.model.CmntBbsModel;
import kr.happy.jobkorea.cmnt.service.CmntBbsService;
import kr.happy.jobkorea.common.comnUtils.ComnCodUtil;
import kr.happy.jobkorea.common.comnUtils.MediaUtils;
import kr.happy.jobkorea.msm.model.LectureListModel;
import kr.happy.jobkorea.msm.service.LecturerService;
//import kr.happy.jobkorea.system.model.CmntMgrModel;
import kr.happy.jobkorea.system.model.ComnCodUtilModel;
//import kr.happy.jobkorea.system.service.CmntMgrService;
import kr.happy.jobkorea.jmyp.model.JMessageModel;
import kr.happy.jobkorea.jmyp.service.JMessageService;

@Controller
@RequestMapping("/jmyp/")
public class JMessageController {
	
	@Autowired
	JMessageService jMessageService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("/JMessage.do")
	public String InitMessagePage(Model model) throws Exception {
		logger.info("+ Start " + className + ".InitMessagePage");
		//logger.info("jmjm   - paramMap : ");
		return "jmyp/JMessage";
	}
	
	@RequestMapping("/JMessageList.do")
	@ResponseBody
	public Map<String, Object> SelectMessageList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".SelectMessageList");
		
		logger.info("MessageList - paramMap1 : " + paramMap);
		
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;								// 페이지 시작 row 번호
		//String MsgKinds = (String)paramMap.get("MsgKinds");
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		//paramMap.put("MsgKinds", MsgKinds);
		
		logger.info("MessageList - paramMap2 : " + paramMap);
		// 서비스 호출
		System.out.println("진행확인3");
		//List<Map<String, Object>> messageList;
		List<JMessageModel> SelectMessagelist = jMessageService.messageList(paramMap);
		
		int SelectedCnt = jMessageService.getSelectedCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("SelectMessagelist", SelectMessagelist);
		resultMap.put("SelectedCnt", SelectedCnt);
		System.out.println("진행확인4");
		
		logger.info("MessageList - resultMap : " + resultMap);
		logger.info("+ End " + className + ".JMessageList");

		
		return resultMap;	
	}
	
	@RequestMapping("insertMessage.do")
	@ResponseBody
	public Map<String, Object> insertMessage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".insertMessage");
		logger.info(" insertMessage  - paramMap1 : " + paramMap);

		
		String result = "SUCCESS";
		String resultMsg = "메세지를 보냈습니다.";
		
		// 사용자 정보 설정
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		logger.info(" insertMessage  - paramMap2 : " + paramMap);
		
		/*if ("I".equals(action)) {
			// 상세코드 신규 저장
			//comnCodService.insertComnDtlCod(paramMap);
		} else if("U".equals(action)) {
			// 상세코드 수정 저장
			//comnCodService.updateComnDtlCod(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}*/
		jMessageService.insertMessage(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".insertMessage");
		
		return resultMap;
	}
	
	@RequestMapping("deleteMessage.do")
	@ResponseBody
	public Map<String, Object> deleteMessage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteMessage");
		logger.info(" deleteMessage - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "메세지가 삭제 되었습니다.";
		
		// 상세코드 삭제
		jMessageService.deleteMessage(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteMessage");
		
		return resultMap;
	}
	
	@RequestMapping("/searchID.do")
	@ResponseBody
	public Map<String, Object> SearchID(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".SearchID");
		
		logger.info("SearchID - paramMap1 : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("pageIndex"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;								// 페이지 시작 row 번호
		//String MsgKinds = (String)paramMap.get("MsgKinds");
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		//paramMap.put("MsgKinds", MsgKinds);
		
		logger.info("SearchID - paramMap2 : " + paramMap);
		// 서비스 호출
		List<JMessageModel> SearchIDList = jMessageService.SearchID(paramMap);		
		int SelectedCnt = jMessageService.getSelectedIDCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("SearchIDList", SearchIDList);
		resultMap.put("SelectedCnt", SelectedCnt);
		
		logger.info("SearchID - resultMap : " + resultMap);
		logger.info("+ End " + className + ".SearchID");		
		return resultMap;	
	}	
	
	
}
