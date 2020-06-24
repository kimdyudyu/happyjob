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

import kr.happy.jobkorea.hla.model.ToolModel;
import kr.happy.jobkorea.hla.service.ToolService;

@Controller
@RequestMapping("/hla")
public class ToolController {
	@Autowired
	ToolService toolService;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("/tool.do")
	public void tool() throws Exception {

	}

	@RequestMapping("toolList.do")
	public String toolList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("toolList~" + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 강의실 목록
		List<ToolModel> toolList = toolService.toolList(paramMap);
		logger.info("toolList~" + toolList);
		model.addAttribute("toolList", toolList);

		// 강의실 목록 카운트 조회
		int toolCount = toolService.toolCount(paramMap);

		model.addAttribute("toolCount", toolCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod", currentPage);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("toolList", toolList); // 리턴 값 해쉬에 담기
		resultMap.put("toolCount", toolCount); // success 용어 담기
		return "/hla/toolList";
	}

	@RequestMapping("listTool.do")
	public String listTool(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("toollist~" + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 장비관리 목록 조회
		List<ToolModel> toolList = toolService.toollist(paramMap);
		model.addAttribute("toolList", toolList);

		// 장비관리 목록 카운트 조회
		int toolCount = toolService.toolcount(paramMap);
		model.addAttribute("toolCount", toolCount);

		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod", currentPage);

		return "hla/listTool";
	}

	@RequestMapping("toolSave.do")
	@ResponseBody
	public Map<String, Object> toolSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveComnDtlCod");
		logger.info("toolSave~" + paramMap);

		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = null;

		// 사용자 정보 설정
		paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));

		if ("I".equals(action)) {
			// 장비 insert
			toolService.toolInsert(paramMap);
			resultMsg = "장비 저장 완료";
		} else if ("U".equals(action)) {
			// 장비 update
			toolService.toolUpdate(paramMap);
			resultMsg = "장비 수정 완료";
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".saveComnDtlCod");

		return resultMap;
	}

	@RequestMapping("toolDetail.do")
	@ResponseBody
	public Map<String, Object> toolDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectComnDtlCod");
		logger.info("toolDetail~" + paramMap);

		// 장비 단건 조회
		ToolModel toolDetail = toolService.toolDetail(paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("toolDetail", toolDetail);

		logger.info("+ End " + className + ".selectComnDtlCod");

		return resultMap;
	}

	@RequestMapping("toolDelete.do")
	@ResponseBody
	public Map<String, Object> toolDelete(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deleteComnDtlCod");
		logger.info("toolDelete~" + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		// 장비 삭제
		toolService.toolDelete(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		logger.info("+ End " + className + ".deleteComnDtlCod");

		return resultMap;
	}
}
