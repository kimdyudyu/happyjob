package kr.happy.jobkorea.hlt.controller;

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

import kr.happy.jobkorea.hlt.model.lectureModel;
import kr.happy.jobkorea.hlt.service.hltListService;
import kr.happy.jobkorea.supportD.model.NoticeDModel;

@Controller
@RequestMapping("/hlt/")
public class hltListController {
	
	// Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
	   
   @Autowired
   hltListService hltListService;
   
   @RequestMapping("hltList.do")
   public String hltList (Model model){
	   
	   return "hlt/hltList";
   }
   
   @RequestMapping("hltClassList.do")
   public String classList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println(" 리스트 호출");
		logger.info("+ Start " + className + ".classList");
		logger.info("   - paramMap : " + paramMap);
		System.out.println(paramMap.get("startdate"));
		// System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		//int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		//int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		//int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		//paramMap.put("pageIndex", pageIndex);
		//paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", session.getAttribute("loginId"));
		System.out.println("잘 찎히니 ? : " + session.getAttribute("loginId"));
		
		// 서비스 호출
		List<lectureModel> classList = hltListService.classList(paramMap);
		model.addAttribute("classList", classList);
		model.addAttribute("totalCnt", classList.size());

		logger.info("+ End " + className + ".classList");

		return "hlt/hltClassList";
	}
   
   @RequestMapping("detailClassList.do")
	@ResponseBody
	public Map<String, Object> detailList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		// System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		logger.info("+ Start " + className + ".detailList");
		logger.info("   - paramMap : " + paramMap);
		String result = "";
		System.out.println(paramMap.get("startdate"));
		// 선택된 게시판 1건 조회
		lectureModel detailClass = hltListService.detailClass(paramMap);
		// List<CommentsVO> comments = null;

		if (detailClass != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", detailClass); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기

		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + detailClass);

		logger.info("+ End " + className + ".detailClass");

		return resultMap;
	}
   
   @RequestMapping("hltPCManage.do")
   public String hltPCManage (Model model){
	   
	   return "hlt/hltPCManage";
   }
   
   @RequestMapping("hltManageList.do")
   @ResponseBody
   public Map<String, Object> hltManageList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start " + className + ".detailList");
	   logger.info("   - paramMap : " + paramMap);
	   String result = "";

	   paramMap.put("loginID", session.getAttribute("loginId"));
	   System.out.println("잘 찎히니 ? : " + session.getAttribute("loginId"));
		
	   List<lectureModel> list = hltListService.hltManageList(paramMap);
	   System.out.println("************** : " + list.size());
	   if (list != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap.put("result", list); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기
		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + list);
		System.out.println(list.size());

	   return resultMap;
   }
   
   @RequestMapping("hltDeleteNo")
   @ResponseBody
   public Map<String, Object> hltDeleteNo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   System.out.println("들어왔니");
	   String result;
	   logger.info(paramMap.get("no"));
	   paramMap.put("loginID", session.getAttribute("loginId"));
	   System.out.println("잘 찎히니 ? : " + session.getAttribute("loginId"));
	   hltListService.hltDeleteNo(paramMap);
	   List<lectureModel> list = hltListService.hltManageList(paramMap);
	   System.out.println(list.size());
	   if (list != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap.put("result", list); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기
		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + list);
		System.out.println(list.size());
		
	   return resultMap;
   }
   
   @RequestMapping("hltModalList")
   @ResponseBody
   public Map<String, Object> hltModalList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   System.out.println("들어왔니");
	   logger.info(paramMap);
	   String result;
	   hltListService.hltModalList(paramMap);
	   List<lectureModel> list = hltListService.hltManageList(paramMap);
	   System.out.println(list.size());
	   if (list != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap.put("result", list); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기
		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + list);
		System.out.println(list.size());
		
	   return resultMap;
   }
   @RequestMapping("evaluationMgt.do")
   public String evaluationMgt (Model model){
	   
	   return "hlt/evaluationMgt";
   }
   
   @RequestMapping("evaluationList.do")
   public String evaluationList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println(" 리스트 호출");
		logger.info("+ Start " + className + ".classList");
		logger.info("   - paramMap : " + paramMap);
		System.out.println(paramMap.get("startdate"));
		// System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		//int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		//int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		//int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		//paramMap.put("pageIndex", pageIndex);
		//paramMap.put("pageSize", pageSize);
		paramMap.put("loginID", session.getAttribute("loginId"));
		System.out.println("잘 찎히니 ? : " + session.getAttribute("loginId"));
		
		// 서비스 호출
		List<lectureModel> evaluationList = hltListService.evaluationList(paramMap);
		model.addAttribute("classList", evaluationList);
		model.addAttribute("totalCnt", evaluationList.size());

		logger.info("+ End " + className + ".classList");

		return "hlt/evaluationSList";
	}
   
    @RequestMapping("DetailSurveyList.do")
	@ResponseBody
	public Map<String, Object> DetailSurveyList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		// System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		logger.info("+ Start " + className + ".detailList");
		logger.info("   - paramMap : " + paramMap);
		String result = "";
		System.out.println(paramMap.get("startdate"));
		// 선택된 게시판 1건 조회
		List<lectureModel> surveyList = hltListService.DetailSurveyList(paramMap);
		// List<CommentsVO> comments = null;

		if (surveyList != null) {

			/*
			 * comments = qnaService.selectComments(paramMap); // 댓글 가지고오기
			 * if(comments != null) { System.out.println("댓글도 소환완료!"); }
			 */
			result = "SUCCESS"; // 성공시 찍습니다.

		} else {
			result = "FAIL / 불러오기에 실패했습니다."; // null이면 실패입니다.
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", surveyList); // 리턴 값 해쉬에 담기
		// resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기

		System.out.println("결과 글 찍어봅세1 " + result);
		System.out.println("결과 글 찍어봅세 2" + surveyList);

		logger.info("+ End " + className + ".surveyList");

		return resultMap;
	}
}
