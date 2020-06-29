package kr.happy.jobkorea.lsm.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.cmnt.model.CmntBbsAtmtFilModel;
import kr.happy.jobkorea.lsm.dao.LSMBoardDao;
import kr.happy.jobkorea.lsm.model.LsmStuCodModel;
import kr.happy.jobkorea.lsm.model.taskFileModel;
import kr.happy.jobkorea.lsm.model.taskInfoModel;
import kr.happy.jobkorea.lsm.service.LSMBoardService;
import kr.happy.jobkorea.ssm.service.StuSurveyService;

@Controller
@RequestMapping("/manageC/")
public class LSMBoardController {

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	   @Autowired
	   LSMBoardService lsmBoardService;
	   @Autowired
		StuSurveyService StuSurveyService;


		// 강의목록 초기화면 
		@RequestMapping("lecture1.do")
		public String lecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lecture1");
			
			paramMap.put("loginId", session.getAttribute("loginId")); // 제목

			
			logger.info(" 보여줘 paramMap : " + paramMap);
		
			
			logger.info("+ End " + className + ".lecture1");
			
			
			return "lsm/lec/LsmLectureList2";
			
		}
	   //강사가 등록한 강의를 select 수강목록/ 진도
	   @RequestMapping("lsmCodList.do")
	   @ResponseBody
	   public Map<String, Object> lsmCodList(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			
		    logger.info("+ Start " + className + ".lsmCodList");
			logger.info("   - paramMap : " + paramMap);
			
			 String loginID = (String)session.getAttribute("loginId"); 
			 paramMap.put("loginID",loginID);

			 // 목록 조회
		   List<Map<String,Object>> lsmCodListModel = lsmBoardService.selectLsmBoardList(paramMap);
		   logger.info("목록" + lsmCodListModel);
		   
		   Map<String, Object> resultMap = new HashMap<>();
		   resultMap.put("lsmCodListModel", lsmCodListModel);
		   System.out.println(resultMap);

		   logger.info("+ End " + className + "lsmCodList");
		   
		   return resultMap;
	   }
	   
//	설문조사 가능목록 도출(진도 100이상인 수강목록)
	   @RequestMapping("LecList.do")
	   @ResponseBody
	   public Map<String,Object> LecList(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("++Start LecList.do ");
			logger.info("++paramMap : "+paramMap);
			System.out.println("옴?");
			// 아이디 세션 불러오기
			String loginID = (String)session.getAttribute("loginId"); 
			paramMap.put("loginID", loginID);
			System.out.println(loginID);
			// 목록 조회
			List<Map<String,Object>> LecListModel = StuSurveyService.getLecList(paramMap);
			//List<Map<String,Object>> LecListModel =  StuSurveyService.getLecList(paramMap);
			Map<String,Object> resultMap = new HashMap<>();
			resultMap.put("LecListModel",LecListModel);
			   System.out.println(resultMap);
			logger.info("++paramMap : "+resultMap);
			logger.info("++End LecList.do ");
			
			return resultMap;
		}
	   
	   //설문조사 모달 띄우기
	   @RequestMapping("surveyModal.do")
	   @ResponseBody
	   public Map<String, Object> getSurveyList(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			
		    logger.info("+ Start " + className + "getSurveyList");
			logger.info("   - paramMap : " + paramMap);
			
		   // 목록 조회
		   Map<String, Object> result = StuSurveyService.getSurveyList(paramMap);
		   
		   Map<String, Object> resultMap = new HashMap<>();
		   resultMap.put("result", result);

		   logger.info("+ End " + className + "getSurveyList");
		   
		   return resultMap;
	   }	   
	   
	   @RequestMapping("lsmModal.do")
	   @ResponseBody
	   public Map<String, Object> lsmModal(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			
		    logger.info("+ Start " + className + ".lsmModal");
			logger.info("   - paramMap : " + paramMap);
			
		   // 목록 조회
		   Map<String, Object> result = lsmBoardService.lsmModal(paramMap);
		   
		   Map<String, Object> resultMap = new HashMap<>();
		   resultMap.put("result", result);

		   logger.info("+ End " + className + "lsmModal");
		   
		   return resultMap;
	   }
	   
		//	설문조사 초기화면
		@RequestMapping("survey.do")
		public String  surveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + "survey");
			
			paramMap.put("loginId", session.getAttribute("loginId")); // 제목

			
			logger.info(" 보여줘 paramMap : " + paramMap);
		
			
			logger.info("+ End " + className + "survey");
			
			
			return "lsm/lec/surveyhome";
		}
		//설문조사 결과 저장해서 보내주기
		@RequestMapping("savesurvey.do")
		@ResponseBody
		public Map<String,Object> savesurvey(Model model, 
			  @RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {

			logger.info("++Start savesurvey.do ");
			logger.info("++paramMap : "+paramMap);
			String loginID = (String)session.getAttribute("loginId"); 
			paramMap.put("loginID", loginID);
//			int lec_seq = Integer.parseInt((String)paramMap.get("lec_seq"));	
//			paramMap.put("lec_seq",lec_seq);
			Map<String,Object> resultMap = new HashMap<>();
			StuSurveyService.savesurvey(paramMap);
			resultMap.put("msg","SUCCESS");
			/*List<Map<String,Object>> list= stuSurvey.getSurveyList(paramMap);
			resultMap.put("list",list);*/
			logger.info("++paramMap : "+resultMap);
			logger.info("++End savesurvey.do ");
			return resultMap;
		}
}
