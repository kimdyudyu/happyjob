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

import kr.happy.jobkorea.hla.model.LecListModel;
import kr.happy.jobkorea.hla.service.LecService;

@Controller
@RequestMapping("/hla")
public class LecListController {

	@Autowired
	LecService lecturerService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 강의목록 조회 화면 접속
	@RequestMapping("/lectureList.do")
	public String lectureList(Model model) throws Exception {

		return "hla/haminCns2";
	}

	// 강의 목록 조회 리스트 조회
	@RequestMapping("/lectListAct.do")
	@ResponseBody
	public Map<String, Object> lectListAct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lectListAct");
		logger.info("   - paramMap : " + paramMap);

		// 서비스 호출
		System.out.println("진행확인1 여기는 오냐 ?");
		List<LecListModel> lectList = lecturerService.lectList(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lectList", lectList);
		System.out.println("진행확인2");
		logger.info("+ End " + className + ".lectListAct");

		return resultMap;
	}

	// 강의 수강생 리스트 조회
	@RequestMapping("/lectPeopleInfo.do")
	@ResponseBody
	public Map<String, Object> lectPeopleInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lectPeopleInfo");
		logger.info("   - paramMap : " + paramMap);

		// 서비스 호출
		System.out.println("진행확인1 여기 까지는 오냐");
		List<LecListModel> lectPeopleInfo = lecturerService.lectPeopleInfo(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("lectPeopleInfo", lectPeopleInfo);
		System.out.println("진행확인2");
		logger.info("+ End " + className + ".lectPeopleInfo");

		return resultMap;
	}

	// 학생 상담이력 조회
	@RequestMapping("/studentCnsInfo.do")
	@ResponseBody
	public Map<String, Object> studentCnsInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".studentCnsInfo");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("진행확인1 학생상담이력");
		List<Map<String, Object>> studentCnsInfo = lecturerService.studentCnsInfo(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("studentCnsInfo", studentCnsInfo);

		System.out.println("진행확인2 학생상담이력");
		System.out.println(studentCnsInfo);
		logger.info("+ End " + className + ".studentCnsInfo");

		return resultMap;
	}

	// 학생 상담내용 조회
	@RequestMapping("/cnsDetail.do")
	@ResponseBody
	public Map<String, Object> cnsDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".cnsDetail");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("진행확인1 학생상담내용");
		List<Map<String, Object>> cnsDetail = lecturerService.cnsDetail(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cnsDetail", cnsDetail);

		System.out.println("진행확인2 학생상담내용");
		logger.info(cnsDetail);
		System.out.println(cnsDetail);
		logger.info("+ End " + className + ".cnsDetail");

		return resultMap;
	}

	// 학생 상담내용 수정
	@RequestMapping("/updateCns.do")
	@ResponseBody
	public Map<String, Object> updateCns(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		int updateCns;
		logger.info("+ Start " + className + ".updateCns");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("진행확인1 학생상담업데이트");
		
		   
	 
		updateCns = lecturerService.updateCns(paramMap);
		System.out.println(updateCns);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", "수정 완료");

		System.out.println("진행확인2 학생상담내용업데이트");
	
	   
		logger.info("+ End " + className + ".updateCns");

		return resultMap;
	}

	// 학생 상담내용 수정
	@RequestMapping("/insertCns.do")
	@ResponseBody
	public Map<String, Object> insertCns(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".insertCns");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("진행확인1 상담 신규 등록");
		
		   
	 
		lecturerService.insertCns(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", "등록 완료");

		System.out.println("진행확인2 상담 신규 등록");
	
	   
		logger.info("+ End " + className + ".insertCns");

		return resultMap;
	}

}
