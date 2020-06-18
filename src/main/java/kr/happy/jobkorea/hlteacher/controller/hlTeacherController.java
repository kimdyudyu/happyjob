package kr.happy.jobkorea.hlteacher.controller;

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

import kr.happy.jobkorea.hlteacher.model.lectureModel;
import kr.happy.jobkorea.hlteacher.service.hlTeacherService;
import kr.happy.jobkorea.supportD.model.NoticeDModel;

@Controller
@RequestMapping("/hlteacher/")
public class hlTeacherController {
	
	// Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
	   
   @Autowired
   hlTeacherService hlTeacherService;
   
   @RequestMapping("lecturMgt.do")
   public String classList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println(" 리스트 호출");
		logger.info("+ Start " + className + ".classList");
		logger.info("   - paramMap : " + paramMap);
		// System.out.println("param에서 넘어온 값을 찍어봅시다.: " + paramMap);

		// jsp페이지에서 넘어온 파람 값 정리 (페이징 처리를 위해 필요)
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;

		// 사이즈는 int형으로, index는 2개로 만들어서 -> 다시 파람으로 만들어서 보낸다.
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", session.getAttribute("loginId"));
		System.out.println("잘 찎히니 ? : " + session.getAttribute("loginId"));

		// 서비스 호출
		List<Map<String, Object>> classList = hlTeacherService.classList(paramMap);
		model.addAttribute("noticeList", classList);
		System.out.println("노티스 톡톡 : " + classList);

		// 목록 숫자 추출하여 보내기
		//int totalCnt = classService.noticeTotalCnt(paramMap);
		//model.addAttribute("totalCnt", totalCnt);

		// System.out.println("자 컨트롤러에서 값을 가지고 jsp로 갑니다~ : " +
		// freeboardlist.size());
		logger.info("+ End " + className + ".classList");

		return "hlteacher/lectureMgt";
	}
}
