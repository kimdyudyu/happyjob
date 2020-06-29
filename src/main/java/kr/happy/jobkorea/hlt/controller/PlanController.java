package kr.happy.jobkorea.hlt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.log4j.Logger;

import kr.happy.jobkorea.hlt.model.Plan;
import kr.happy.jobkorea.hlt.service.PlanService;
import kr.happy.jobkorea.supportD.model.NoticeDModel;
import kr.happy.jobkorea.system.model.NoticeModel;

//import kr.happy.jobkorea.hlt.service.PlanService;

@Controller
@RequestMapping("/supportD/")
public class PlanController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PlanService planService;
	
	@RequestMapping("lecturePlan.do")
	public String initPlan() {
		
		return "hlt/Plan";
	}
	
	@RequestMapping("planList.do")
	public String planList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".planList");
	    logger.info("   - paramMap : " + paramMap);
		//System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		
		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage -1)*pageSize;
		
		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
	
		// 서비스 호출
		List<Plan> planList = planService.selectPlanList(paramMap);
		model.addAttribute("planList",planList);
		
		// 목록 숫자 추출하여 보내기 
		int totalCnt = planService.planTotalCnt(paramMap);
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageNoticeList",currentPage);
		
		
		//System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " + freeboardlist.size());
		logger.info("+ End " + className + ".planList");
		
		return "hlt/planlist";
	}
	
	
	
	@RequestMapping("planListvue.do")
	@ResponseBody
	public Map<String, Object> noticeListvue(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".planListvue");
		logger.info("   - paramMap : " + paramMap);
		// System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 서비스 호출
		List<Plan> planList = planService.selectPlanList(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("planList", planList);

		// 목록 숫자 추출하여 보내기
		int totalCnt = planService.planTotalCnt(paramMap);
		resultMap.put("totalCnt", totalCnt);

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());
		logger.info("+ End " + className + ".planListvue");

		return resultMap;
	}
	
	
	
	@RequestMapping("detailPlanList.do")
	@ResponseBody
	public Map<String, Object> detailList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		  logger.info("+ Start " + className + ".detailList");
		  logger.info("   - paramMap : " + paramMap);
		  
		String result="";
		
		// 선택된 게시판 1건 조회 
		Plan detailPlan = planService.detailPlan(paramMap);
		//List<CommentsVO> comments = null;
		
		if(detailPlan != null) {
			
			result = "SUCCESS";  // 성공시 찍습니다. 
			
		}else {
			result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", detailPlan); // 리턴 값 해쉬에 담기 
		model.addAttribute("detail", detailPlan);
		//resultMap.put("resultComments", comments);
		resultMap.put("resultMsg", result); // success 용어 담기 
		
		System.out.println("결과 글 찍어봅세 " + result);
		System.out.println("결과 글 찍어봅세 " + detailPlan);
		
		logger.info("resultMap :" + resultMap);
		logger.info("+ End " + className + ".detailList");
		
		return resultMap;
	}
	
	
	/* 공지사항 등록하기 */
	@RequestMapping("planSave.do")
	@ResponseBody
	public Map<String,Object> savaList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("저장키를 먹나요~~~~?? : " + paramMap.toString());
		
		String action = (String)paramMap.get("action"); // 구분하는 키값 
		System.out.println("action 값 찍어보기 : " + action);
		
		//String content = (String)paramMap.get("commentContent");
		//System.out.println("아아앙아아아아아아아악 댃글 컨텐트!! " + content);
		
		// 사용자 정보 설정하기 
		// paramMap.put("fst_rgst_sst_id", session.getAttribute("usrSstId"));
		
		String resultMsg = "";
		//String id = (String) session.getAttribute("loginId"); // 아이디 
		//paramMap.put("writer", id); // session을 통해 아이디 가져옴 
		
		// insert 인지, update 수정인지 확인하기 
		if("I".equals(action)) {
			planService.insertplan(paramMap); // 저장 service
			resultMsg = "SUCCESS";
			
		}else if("U".equals(action)) {
			planService.updateplan(paramMap); // 수정 service
			resultMsg = "UPDATE";
			
		}else if("D".equals(action)) {
			planService.deleteplan(paramMap); // 수정 service
			resultMsg = "DELETE";
			
		}else {
			resultMsg ="FALSE / 등록에 실패했습니다.";
		}
		
		
		// 결과 값 전송
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	
}
