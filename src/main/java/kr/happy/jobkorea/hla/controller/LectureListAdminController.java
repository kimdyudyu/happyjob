package kr.happy.jobkorea.hla.controller;

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

import kr.happy.jobkorea.hla.dao.LectureListAdminDao;
import kr.happy.jobkorea.hla.model.LectureListAdminModel;
import kr.happy.jobkorea.hla.model.ToolModel;
import kr.happy.jobkorea.hla.service.LectureListAdminService;
import kr.happy.jobkorea.mss.model.AdminLecModel;

@Controller
@RequestMapping("/hla")
public class LectureListAdminController {
	@Autowired
	LectureListAdminService lectureListAdminService;
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();

	@RequestMapping("/lectureListAdmin.do")
	public void lectureListAdmin() throws Exception {

	}

	@RequestMapping("lectureListAdminList.do")
	@ResponseBody
	public  Map<String, Object> lectureListAdminList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("lectureListAdminList~" + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호
		logger.info("pageIndex~"+pageIndex);
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 강의실 목록
		List<LectureListAdminModel> lectureListAdminList = lectureListAdminService.lectureListAdminList(paramMap);
		logger.info("lectureListAdminList~" + lectureListAdminList);
		//model.addAttribute("lectureListAdminList", lectureListAdminList);

		// 강의실 목록 카운트 조회
		int lectureListAdminCount = lectureListAdminService.lectureListAdminCount(paramMap);
		logger.info(lectureListAdminCount);
/*
		model.addAttribute("lectureListAdminCount", lectureListAdminCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod", currentPage);
*/
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lectureListAdminList", lectureListAdminList); // 리턴 값 해쉬에
																		// 담기
		resultMap.put("lectureListAdminCount", lectureListAdminCount); // success
																		// 용어 담기
		//return "/hla/lectureListAdminList";
		return resultMap;
	}

	@RequestMapping("/lectureStudentList.do")
	@ResponseBody
	public Map<String, Object> lectureStudentList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("lectureStudentList~" + paramMap);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<LectureListAdminModel> lectureStudentList = lectureListAdminService.lectureStudentList(paramMap);
		model.addAttribute("userList", lectureStudentList);

		int lectureStudentListCount = lectureListAdminService.lectureStudentListCount(paramMap);
/*
		model.addAttribute("totalCntlist", totalCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("pagesize", pageSize);
		model.addAttribute("lecSeq", paramMap.get("lecSeq"));
		*/
		
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("lectureStudentList", lectureStudentList);
		resultMap.put("lectureStudentListCount", lectureStudentListCount);
		//return "/hla/lectureStudentList";
		return resultMap;
	}

	@RequestMapping("/restyn.do")
	@ResponseBody
	public Map<String, Object> restyn(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("restyn~" + paramMap);
		String action = (String) paramMap.get("action_param");
		String restyn = (String) paramMap.get("restyn");

		String result = "SUCCESS";
		String resultMsg = null;

		if (restyn.equals("y")) {
			resultMsg = "휴학취소 됐습니다.";
			lectureListAdminService.restn(paramMap);
		} else {
			resultMsg = "휴학신청 됐습니다.";
			lectureListAdminService.resty(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String no=(String) paramMap.get("no");
		resultMap.put("no", no);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}

	@RequestMapping("studentInfo.do")
	@ResponseBody
	public Map<String, Object> studentInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("studentInfo~" + paramMap);

		LectureListAdminModel studentInfo = lectureListAdminService.studentInfo(paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("studentInfo", studentInfo);

		return resultMap;
	}

	@RequestMapping("/lectureListVuejs.do")
	public void lectureList() throws Exception {

	}
}