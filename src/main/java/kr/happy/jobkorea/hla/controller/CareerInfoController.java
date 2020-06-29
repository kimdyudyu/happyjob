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

import kr.happy.jobkorea.hla.model.CareerInfoModel;
import kr.happy.jobkorea.hla.service.CareerInfoService;

@Controller
@RequestMapping("/hla")
public class CareerInfoController {
	@Autowired
	CareerInfoService careerInfoService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("/careerInfo.do")
	public String careerInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".careerInfo");
		/* ############## set input data################# */
		paramMap.put("loginId", session.getAttribute("loginId")); // 제목
		paramMap.put("userType", session.getAttribute("userType")); // 오피스 구분 //
																	// 코드
		logger.info("   - paramMap : " + paramMap);

		String returnType = "/hla/careerInfo";

		logger.info("+ end " + className + ".careerInfo");

		return returnType;
	}

	@RequestMapping("careerInfoList.do")
	@ResponseBody
	public Map<String, Object> careerInfoList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".careerInfoList");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		logger.info("pageIndex~"+pageIndex);
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 서비스 호출
		List<CareerInfoModel> careerInfoList = careerInfoService.careerInfoList(paramMap);

		// 목록 숫자 추출하여 보내기
		int totalCnt = careerInfoService.careerInfoListTotalCnt(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("careerInfoList", careerInfoList); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("totalCnt", totalCnt); // success 용어 담기
		
		List<CareerInfoModel> studentList = careerInfoService.studentList();
		resultMap.put("studentList", studentList);
		logger.info(studentList);
		return resultMap;
	}

	@RequestMapping("/careerInfoSave.do")
	@ResponseBody
	public Map<String, Object> careerInfoSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("careerInfoSave map~" + paramMap);
		String action = (String) paramMap.get("action");
		logger.info("action~" + action);
		String result = "SUCCESS";
		String resultMsg = null;
		logger.info(paramMap.get("resign_date"));
		// 사용자 정보 설정
		paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("usrSstId"));

		if ("I".equals(action)) {
			// 취업정보 저장
			careerInfoService.careerInfoInsert(paramMap);
			resultMsg = "취업정보 저장됐습니다.";
		} else if ("U".equals(action)) {
			// 취업정보 수정
			careerInfoService.careerInfoUpdate(paramMap);
			resultMsg = "취업정보 수정됐습니다.";
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}

	@RequestMapping("careerInfoDetail.do")
	@ResponseBody
	public Map<String, Object> careerInfoDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);
		String result = "";
		String resultMsg = "";

		// 선택된 게시판 1건 조회
		CareerInfoModel careerInfoListDetail = careerInfoService.careerInfoListDetail(paramMap);
		// List<CommentsVO> comments = null;

		if (careerInfoListDetail != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "S"; // 성공시 찍습니다.
			resultMsg = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "F"; // null이면 실패입니다.
			resultMsg = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("careerInfoListDetail", careerInfoListDetail); // 리턴 값 해쉬에
																		// 담기
		resultMap.put("result", result); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", resultMsg); // success 용어 담기

		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + careerInfoListDetail);
		return resultMap;
	}

	@RequestMapping("careerInfoDelete.do")
	@ResponseBody
	public Map<String, Object> careerInfoDelete(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("careerInfoDelete~" + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		careerInfoService.careerInfoDelete(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}
}