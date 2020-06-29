package kr.happy.jobkorea.manageC.controller;

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

import kr.happy.jobkorea.manageC.model.examModel;
import kr.happy.jobkorea.manageC.model.examAnswerModel;
import kr.happy.jobkorea.manageC.service.examService;

@Controller
@RequestMapping("/test/")
public class exam_Controller {

	@Autowired
	examService service ; 
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 시험문제 리스트 뿌리기 
	@RequestMapping("examList.do")
	public String examList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".examList");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		logger.info("check loginId 포함된 paramMap: " + paramMap);		
		
		List<examModel> examList = service.examList(paramMap);
		model.addAttribute("examList", examList);
			
		int totalCnt = service.examTotalCnt(paramMap);
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("+ End " + className + ".examList");

		return "exam/testList";
	}
	
	@RequestMapping("testList.do")
	public String testList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String return_result ; 
		logger.info("+ Start " + className + ".testList");
		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("   - paramMap : " + paramMap);
		
		int call_score = service.search_score(paramMap);
		
		if(call_score < 101){
			
			int tscore = service.tscore(paramMap); 
			List<examAnswerModel> tresult = service.tresult(paramMap);
			
			model.addAttribute("tscore", tscore); 
			model.addAttribute("tresult", tresult); 
			
			return_result = "exam/test_second";
		}else{
			return_result = "exam/test_first";
		}
		
		List<examModel> testList = service.testList(paramMap);
		model.addAttribute("testList", testList);
		
		logger.info("+ End " + className + ".testList");
		return return_result ; 
	}
	
	@RequestMapping("calculation.do")
	public String calculation(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".calculationList");
		
		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("   - paramMap : " + paramMap);
		
		List<examModel> answerList = service.answerList(paramMap); // 정답 추출용
		for(int i=0 ; i< answerList.size() ; i++){
			paramMap.put("answer"+i+"", answerList.get(i).getAnswer());
		}
		logger.info("   - paramMap : " + paramMap);
		service.calculate(paramMap); // 점수 계산 및 입력
		
		logger.info("+ End " + className + ".calculationList");
		
		return "exam/test_second" ; 
	}
}
