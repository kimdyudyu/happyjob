package kr.happy.jobkorea.hls.controller;


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

import kr.happy.jobkorea.hls.model.CurriculumModel;
import kr.happy.jobkorea.hls.model.ReferenceModel;
import kr.happy.jobkorea.hls.service.CurService;
import kr.happy.jobkorea.hls.service.RefService;


@Controller
@RequestMapping("/hls2")
public class ReferenceController {

	@Autowired
	RefService refService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("/reference.do")
	public String refboard(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		
		logger.info("+ Start " + className + ".refboard");
		/* ############## set input data################# */
		paramMap.put("loginId", session.getAttribute("loginId")); // 제목
		
		logger.info("   - paramMap : " + paramMap);

		String returnType = "/hls/reference";

		logger.info("+ end " + className + ".refboard");

		return returnType;
	}

	/* 공지사항 리스트 뿌리기 */
	@RequestMapping("/refList.do")
	@ResponseBody
	public Map<String, Object> refList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".refList");
		logger.info("   - paramMap : " + paramMap);
		// System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		//paramMap.put("loginId", session.getAttribute("loginId"));

		// 서비스 호출
		List<ReferenceModel> refList = refService.refList(paramMap);

		// 목록 숫자 추출하여 보내기
		int totalCnt = refService.refTotalCnt(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("refList", refList); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("totalCnt", totalCnt); // success 용어 담기

		logger.info("+ End " + className + ".refList");

		return resultMap;
	}

	/* 공지사항 상세 정보 뿌리기 */
	@RequestMapping("/detailRefList.do ")
	@ResponseBody
	public Map<String, Object> detailList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		// System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		logger.info("+ Start " + className + ".detailList");
		logger.info("   - paramMap : " + paramMap);
		String result = "";
		String resultMsg = ""; 
		
		// 선택된 게시판 1건 조회
		ReferenceModel detailRef = refService.detailRef(paramMap);
		// List<CommentsVO> comments = null;

		if (detailRef != null) {

			/*
			 * comments = curService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "S"; // 성공시 찍습니다.
			resultMsg = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "F"; // null이면 실패입니다.
			resultMsg = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}

		
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("detailcur", detailRef); // 리턴 값 해쉬에 담기
		resultMap.put("result", result); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", resultMsg); // success 용어 담기

		System.out.println("result: " + result);
		System.out.println("detailRef: " + detailRef.getNt_title());
		System.out.println("detailRef: " + detailRef.getLoginID());

		logger.info("+ End " + className + ".detailList");

		return resultMap;
	}
	@RequestMapping("/saveComnDtlCodd.do")
	@ResponseBody
	public Map<String, Object> saveComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveComnDtlCod");
		logger.info("   - paramMap : " + paramMap);

		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		paramMap.put("aloginId", session.getAttribute("loginId"));
		
		
		refService.insertRef(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveComnDtlCod");
		
		return resultMap;
	}
	

}