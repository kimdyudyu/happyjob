package kr.happy.jobkorea.jmyp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.jmli.model.JmliProjectModel;
import kr.happy.jobkorea.jmli.model.JmliProjectSkill;
import kr.happy.jobkorea.jmli.service.JmliService;
import kr.happy.jobkorea.jmyp.model.UserInfoVO;
import kr.happy.jobkorea.jmyp.model.aMypageVO;
import kr.happy.jobkorea.jmyp.service.MypageAService;

@Controller
@RequestMapping("/jmyp/")
public class aMypageController {
	
	
	@Autowired
	MypageAService mypageAService;
	
	@Autowired
	JmliService jmliService;
	

	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	

	
	
	// D, 개발자
	// C, 기업
	
	
	
	
	
	
	
	
	// 개인
	/////////////
	
	

	
	// mypage
	/////////////////////////////////////////
	
	@RequestMapping("supportStatus.do")
	public String mypage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		return "jmyp/Dmypage";
	}
	
	
	
	
	


	
	// boardD
	///////////////////////////////
	
	
	
	@RequestMapping("mypageA.do")
	@ResponseBody
	public Map<String, Object> mypageA(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".myapgeA.do");
		logger.info("   - paramMap : " + paramMap);

		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<aMypageVO> board = mypageAService.DmypageBoard(paramMap);
		
		
		int totalCnt = mypageAService.DBoardCnt(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		resultMap.put("getBoard", board);
		
		resultMap.put("totalCnt", totalCnt);
		

		logger.info("+ End " + className + ".mypageA.do");
		
		return resultMap;
	}
	
	

	
	
	// search
	///////////////////////////////
	
	
	@RequestMapping("searchD.do")
	@ResponseBody
	public Map<String, Object> searchD(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".searchD.do");
		logger.info("   - paramMap : " + paramMap);

		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<aMypageVO> board = mypageAService.DmypageBoard(paramMap);
		
		
		int totalCnt = mypageAService.DBoardCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("getBoard", board);
		resultMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".searchD.do");
		
		return resultMap;
	}
	
	
	
	
	
	// 프로젝트 상세보기
	
	
	@RequestMapping("projectDetailD.do")
	@ResponseBody
	public Map<String, Object> projectDetailD(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".projectDetailD.do");
		logger.info("   - paramMap : " + paramMap);

		
		// aMypageVO board = mypageAService.projectDetailD(paramMap);
		
		
		String projectId = (String) paramMap.get("projectId");
		
		
		JmliProjectModel vo = jmliService.selectProjectOne(projectId);
		//스킬 목록 가져오기
		List<JmliProjectSkill> list = jmliService.selectProjectSkill(projectId);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// resultMap.put("projectDetail", board);
		
		resultMap.put("detailone", vo);
		resultMap.put("skill", list);
		resultMap.put("loginId",session.getAttribute("loginId"));
		
		
		
		logger.info("+ End " + className + ".projectDetailD.do");
		return resultMap;
	}
	
	
	
	// delete
	@RequestMapping("supplyDeleteD.do")
	@ResponseBody
	public Map<String, Object> supplyDeleteD(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplyDeleteD.do");
		logger.info("   - paramMap : " + paramMap);

		
		
		String projectId = (String) paramMap.get("projectId");
		String loginId = (String) paramMap.get("loginId");
		
		System.out.println(projectId);
		System.out.println(loginId);
		
		
		mypageAService.supplyDeleteD(projectId, loginId);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String reuslt = "삭제되었습니다";
		resultMap.put("supplyDelte", reuslt);
		
		logger.info("+ End " + className + ".supplyDeleteD.do");
		return resultMap;
	}
	
	
	
	
	
	
	
	
	// 기업
	/////////////////////////////////////


	@RequestMapping("supportStatusC.do")
	public String mypageC(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		return "jmyp/Cmypage";
	}
	
	
	
	
	
	// boardC
	///////////////////////////////////////////
	
	
	@RequestMapping("mypageC.do")
	@ResponseBody
	public Map<String, Object> mypageGetC(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".myapgeC.do");
		logger.info("   - paramMap : " + paramMap);

		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		List<aMypageVO> board = mypageAService.CmypageBoard(paramMap);
		
		
		int totalCnt = mypageAService.CBoardCnt(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		resultMap.put("getBoard", board);
		
		resultMap.put("totalCnt", totalCnt);
		
		
		logger.info("+ End " + className + ".mypageC.do");
		
		return resultMap;
	}
	
	
	

	
	// search
	///////////////////////////////
	
	
	@RequestMapping("searchC.do")
	@ResponseBody
	public Map<String, Object> searchC(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".searchC.do");
		logger.info("   - paramMap : " + paramMap);

		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<aMypageVO> board = mypageAService.CmypageBoard(paramMap);
		
		
		int totalCnt = mypageAService.CBoardCnt(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("getBoard", board);
		resultMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".searchC.do");
		
		return resultMap;
	}
	
	
	
	
	
	
	// 프로젝트 지원자 출력
	
	
	@RequestMapping("supplyList.do")
	@ResponseBody
	public Map<String, Object> supllyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplyList.do");
		logger.info("   - paramMap : " + paramMap);

		
		List<aMypageVO> board = mypageAService.supplyList(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("getSupplyList", board);
		
		logger.info("+ End " + className + ".supplyList.do");
		
		return resultMap;
	}
	
	
	
	
	
	// userInfo
	
	
	@RequestMapping("userInfoC.do")
	@ResponseBody
	public Map<String, Object> userInfoC(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".userInfoC.do");
		logger.info("   - paramMap : " + paramMap);

		
		
		String userID = (String) paramMap.get("loginId");
		
		UserInfoVO userInfo = mypageAService.userInfo(userID);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("userInfo", userInfo);
		
		logger.info("+ End " + className + ".userInfoC.do");
		
		return resultMap;
	}
	
 
	
	
	
	
	
	
}
