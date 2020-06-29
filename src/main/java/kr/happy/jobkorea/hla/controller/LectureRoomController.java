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

import kr.happy.jobkorea.hla.model.LectureRoomModel;
import kr.happy.jobkorea.hla.service.LectureRoomService;

@Controller
@RequestMapping("/hla")
public class LectureRoomController {
	@Autowired
	LectureRoomService lectureRoomService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("lectureRoom.do")
	public String lectureRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("lectureRoom~" + paramMap);

		// 로그인해서 리스트를 먼저 뿌린다.
		model.addAttribute("writer", session.getAttribute("loginId"));
		// 작성 초기 단계에서 쓰려고 미리 뿌린다.
		// System.out.println("writer : " + session.getAttribute("loginId"));

		return "/hla/lectureRoom";
	}

	@RequestMapping("lectureRoomList.do")
	@ResponseBody
	public Map<String, Object> lectureRoomList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("lectureRoomList~" + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		// logger.info(paramMap.get("currentPage").getClass().getName());
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		// logger.info(currentPage.getClass().getName());
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 서비스 호출
		List<LectureRoomModel> lectureRoomList = lectureRoomService.lectureRoomList(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lectureRoomList", lectureRoomList);

		// 목록 숫자 추출하여 보내기
		int totalCnt = lectureRoomService.lectureRoomTotalCnt(paramMap);
		resultMap.put("totalCnt", totalCnt);

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());

		return resultMap;
	}

	@RequestMapping("/lectureRoomSave.do")
	@ResponseBody
	public Map<String, Object> lectureRoomSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("lectureRoomSave~" + paramMap);
		String action = (String) paramMap.get("action");
		logger.info("action~" + action);
		String result = "SUCCESS";
		String resultMsg = null;
				
		if ("I".equals(action)) {
			// 강의실 저장
			try{
				lectureRoomService.lectureRoomInsert(paramMap);
			}catch(Exception e){
				 e.printStackTrace();
			}
			resultMsg = "강의실 저장됐습니다.";
		} else if ("U".equals(action)) {
			// 강의실 수정
			lectureRoomService.lectureRoomUpdate(paramMap);
			resultMsg = "강의실 수정됐습니다.";
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}

	@RequestMapping("lectureRoomDetail.do")
	@ResponseBody
	public Map<String, Object> lectureRoomDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("lectureRoomDetail~" + paramMap);
		String result = "";
		String resultMsg = "";

		// 선택된 게시판 1건 조회
		LectureRoomModel lectureRoomDetail = lectureRoomService.lectureRoomDetail(paramMap);
		// List<CommentsVO> comments = null;

		if (lectureRoomDetail != null) {

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
		resultMap.put("lectureRoomDetail", lectureRoomDetail); // 리턴 값 해쉬에
		// 담기
		resultMap.put("result", result); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", resultMsg); // success 용어 담기

		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + lectureRoomDetail);
		return resultMap;
	}

	@RequestMapping("lectureRoomDelete.do")
	@ResponseBody
	public Map<String, Object> lectureRoomDelete(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("lectureRoomDelete~" + paramMap);

		lectureRoomService.lectureRoomDelete(paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}
}
