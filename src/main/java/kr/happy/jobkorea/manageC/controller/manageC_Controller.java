package kr.happy.jobkorea.manageC.controller;

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

import kr.happy.jobkorea.manageC.service.manageC_service;

@Controller
@RequestMapping("/manageC/")
public class manageC_Controller {

	@Autowired
	manageC_service service;

	// Set Logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("examination.do")
	public String examination(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".manageC_시험응시");

		paramMap.put("loginId", session.getAttribute("loginId")); // 로그인 아이디(학생)
		paramMap.put("userType", session.getAttribute("userType")); // 사용자 구분 타입
		paramMap.put("name", session.getAttribute("name")); // 사용자 이름(학생)

		logger.info(" user - paramMap : " + paramMap); // 사용자 값 확인

		logger.info("+ end " + className + ".manageC_시험응시");

		return "exam/exam";
	}

	@RequestMapping("homework.do")
	public String st_hmList() {
		return "/homework/st_hw";
	}
	
	@RequestMapping("st_hwList.do")
	@ResponseBody
	public Map<String, Object> tmList(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		logger.info("lmmList 호출");
		logger.info("param : " + param);

		int currentPage = Integer.parseInt((String) param.get("currentPage"));
		int pageSize = Integer.parseInt((String) param.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		param.put("loginId", session.getAttribute("loginId"));

		param.put("pageIndex", pageIndex);
		param.put("pageSize", pageSize);

		List<Map<String, Object>> list = service.shList(param);
		List<Map<String, Object>> select = service.optionList(param);
		
		logger.info("select : " + select);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", list);
		resultMap.put("select", select);
		logger.info(resultMap);
		
		int totalCount = service.totalCountRoom(param);
		resultMap.put("totalCountList", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageNoticeList", currentPage);

		logger.info("+ resultMap : " + resultMap);
		logger.info("+ End lmmList");

		return resultMap;
	}

	@RequestMapping("IUDLmm.do")
	@ResponseBody
	public Map<String, Object> IUDLmm(HttpServletRequest request, @RequestParam Map<String, Object> paramMap) {

		logger.info("+ Start insert/updateNotice");
		logger.info("-- paramMap : " + paramMap);
		logger.info("-- request : " + request);

		String action = (String) paramMap.get("action");
		String msg = "";

		try {
			if (action.equals("I")) {
				logger.info("추가 실행.");
				service.insertLmm(paramMap, request);
				msg = "과제가 정상적으로 제출되었습니다.";
			} else if (action.equals("U")) {
				logger.info("수정 실행.");
				service.updateLmm(paramMap, request);
				msg = "정상적으로 수정되었습니다.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "Error occur";
		}

		logger.info("msg : " + msg);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", msg);
		logger.info("+ End insert/updateNotice");
		
		return resultMap;
	}
	

	@RequestMapping("qna.do")
	public String QList() {
		return "/qna/qna";
	}
	
	@RequestMapping("QList.do")
	@ResponseBody
	public Map<String, Object> QList(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		logger.info("QList 호출");
		logger.info("param : " + param);

		int currentPage = Integer.parseInt((String) param.get("currentPage"));
		int pageSize = Integer.parseInt((String) param.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		param.put("loginId", session.getAttribute("loginId"));
		param.put("pageIndex", pageIndex);
		param.put("pageSize", pageSize);

		List<Map<String, Object>> list = service.QList(param);
		List<Map<String, Object>> list_comments = service.CList(param);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", list);
		
		logger.info(resultMap);
		
		int totalCount = service.totalQcnt(param);
		resultMap.put("totalCountList", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageNoticeList", currentPage);

		logger.info("+ resultMap : " + resultMap);
		logger.info("+ End QList");

		return resultMap;
	}
	
	@RequestMapping("CList.do")
	@ResponseBody
	public Map<String, Object> CList(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		logger.info("CList 호출");
		logger.info("param : " + param);

		List<Map<String, Object>> list_comments = service.CList(param);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("clist", list_comments);
		
		logger.info("+ resultMap : " + resultMap);
		logger.info("+ End CList");

		return resultMap;
	}
	
	@RequestMapping("comment_write.do")
	public String comment_write(HttpSession session, @RequestParam Map<String, Object> paramMap) {
		logger.info("Comment_write 호출");
		
		paramMap.put("regId",session.getAttribute("loginId"));
		logger.info("paramMap : " + paramMap);
		
		service.comment_write(paramMap);
		
		logger.info("+ End Comment_write");
		
		return "success";
	}
}
