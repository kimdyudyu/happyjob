package kr.happy.jobkorea.ssm.controller;

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

import kr.happy.jobkorea.ssm.service.StuSurveyService;



@Controller
@RequestMapping("/manageZ/")
public class SurveyController {
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		//private final String className = this.getClass().toString();

		@Autowired
		StuSurveyService StuSurveyService;
		
		@RequestMapping("/LecList.do")
		@ResponseBody
		public Map<String,Object> listTaskSend(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("++Start LecList.do ");
			logger.info("++paramMap : "+paramMap);
			
			// 아이디 세션 불러오기
			String loginID = (String)session.getAttribute("loginID");
			paramMap.put("loginID", loginID);
			
			
			// 목록 조회
			List<Map<String,Object>> SurveyList= StuSurveyService.getLecList(paramMap);
			
			Map<String,Object> resultMap = new HashMap<>();
			resultMap.put("SurveyList",SurveyList);
			
			logger.info("++paramMap : "+resultMap);
			logger.info("++End lectureList.do ");
			
			return resultMap;
		}
		
		@RequestMapping("/survey.do")
		public String  surveyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
//
//			logger.info("++Start lectureList.do ");
//			logger.info("++paramMap : "+paramMap);
//			
//			
//			List<Map<String,Object>> list= stuSurvey.getSurveyList(paramMap);
//			
//			Map<String,Object> resultMap = new HashMap<>();
//			
//			resultMap.put("list",list);
//			
//			
//			logger.info("++End lectureList.do ");
			return "ssm/survey/surveyhome";
		}
		
		@RequestMapping("savesurvey.do")
		@ResponseBody
		public Map<String,Object> savesurvey(Model model, 
											@RequestParam Map<String, Object> paramMap, 
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session) throws Exception {

			logger.info("++Start savesurvey.do ");
			logger.info("++paramMap : "+paramMap);
			
			int lec_seq = Integer.parseInt((String)paramMap.get("lec_seq"));
			
			paramMap.put("lec_seq",lec_seq);
			
			Map<String,Object> resultMap = new HashMap<>();
			
			StuSurveyService.savesurvey(paramMap);
			
			
			
			
			
			
			resultMap.put("msg"," 성공");
			
			
			
			
			/*List<Map<String,Object>> list= stuSurvey.getSurveyList(paramMap);
			
			
			
			resultMap.put("list",list);*/
			
			logger.info("++paramMap : "+resultMap);
			logger.info("++End savesurvey.do ");
			return resultMap;
		}
		
		
		
}
