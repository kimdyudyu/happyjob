package kr.happy.jobkorea.jmli.controller;


import java.io.File;
import java.net.URLEncoder;
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
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.jmli.model.JmliProjectModel;
import kr.happy.jobkorea.jmli.model.JmliProjectSkill;
import kr.happy.jobkorea.jmli.model.JmliUserSkill;
import kr.happy.jobkorea.jmli.model.developerModel;
import kr.happy.jobkorea.jmli.service.JmliService;
import kr.happy.jobkorea.sss.model.NoticeKModel;

@Controller
@RequestMapping("/jmli/")
public class JmliController {
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		JmliService jmliService;
		
		
		@RequestMapping("/adminDeveloper.do")
		public String adminNotice(){

			logger.info("+ Start adminNotice");

				
			logger.info("+ End adminNotice");
			return "/jmli/developerHome";
		}
		@RequestMapping("/mainPage.do")
		public String mainPage(){
			return "/jmli/jmainList";
		}
		
		@RequestMapping("/adminProject.do")
		public String adminProject(){
			return "/jmli/projectHome";
		}
		
		//공지사항 전체목록 조회
		@RequestMapping("noticeList.do")
		@ResponseBody
		public Map<String,Object> noticeList(Model model,
				@RequestParam Map<String, Object>paramMap,
				HttpServletRequest request,
				HttpSession session){
			
			logger.info("+start jnoticeList");
			logger.info("--LELU  paramMap : "+paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage-1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<Map<String,Object>> list = jmliService.getNoticeList(paramMap);
			Map<String,Object> resultMap = new HashMap<>();
			resultMap.put("list", list);
			
			int totalCount = jmliService.totalCountNoticeList();
			resultMap.put("totalCountList",totalCount);
			resultMap.put("pageSize", pageSize);
			resultMap.put("currentPageNoticeList",currentPage);
			
			logger.info(resultMap);
			return resultMap;
		}
	
		@RequestMapping("developerList.do")
		@ResponseBody
		public Map<String,Object> developerList(
												Model model, 
												@RequestParam Map<String, Object> paramMap, 
												HttpServletRequest request,
												HttpServletResponse response, 
												HttpSession session	){
			
			logger.info("+ Start developerList");
			logger.info("-- paramMap : "+paramMap);
//
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;		
//			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 개발자목록 조회
			
			List<Map<String,Object>> list = jmliService.getDeveloperList(paramMap);
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			resultMap.put("list", list);
			
			//개발자 총수.
			int totalCount = jmliService.totalCountDeveloper(paramMap);
			resultMap.put("totalCountDeveloper", totalCount);
			resultMap.put("pageSize", pageSize);
			resultMap.put("currentPageNoticeList",currentPage);
//		
//			logger.info("+ resultMap : " +resultMap);
//			logger.info("+ End noticeList");
//			
			
			return resultMap;
		}
		
		@RequestMapping("selectDeveloperOne.do")
		@ResponseBody
		public Map<String,Object> selectDeveloperOne(
											Model model,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session ){
			
			String loginID = (String)paramMap.get("loginID");
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			developerModel vo = jmliService.selectDeveloperOne(loginID);
			List<String>  list = jmliService.showSkill(loginID);
			resultMap.put("detailone", vo);
			resultMap.put("skill", list);
			
			return resultMap;
		}
		
		
		//프로젝트 전체목록 조회
		@RequestMapping("projectList.do")
		@ResponseBody
		public Map<String,Object> projectList(Model model,
				@RequestParam Map<String, Object>paramMap,
				HttpServletRequest request,
				HttpSession session){
			
			logger.info("+start jnoproject");
			logger.info("--LELU  paramMap : "+paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage-1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<JmliProjectModel> list = jmliService.projectList(paramMap);
			Map<String,Object> resultMap = new HashMap<>();
			resultMap.put("list", list);
			
			int totalCount = jmliService.totalCountProjectList(paramMap);
			
			resultMap.put("totalCountList",totalCount);
			resultMap.put("pageSize", pageSize);
			resultMap.put("currentPageNoticeList",currentPage);
			
			logger.info("projectList alright ? : "+resultMap.get("list"));
			return resultMap;
		}
		
		
		@RequestMapping("selectProjectOne.do")
		@ResponseBody
		public Map<String,Object> selectProjectOne(
											Model model,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session ){
			
			String projectId = (String)paramMap.get("projectId");
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			//상세화면 가져오기 
			JmliProjectModel vo = jmliService.selectProjectOne(projectId);
			//스킬 목록 가져오기
			List<JmliProjectSkill> list = jmliService.selectProjectSkill(projectId);
			
			String userInfo = jmliService.getUserInfo((String)session.getAttribute("loginId"));
			
			resultMap.put("detailone", vo);
			resultMap.put("skill", list);
			resultMap.put("loginId",session.getAttribute("loginId"));
			resultMap.put("userType",userInfo);
			
			logger.info("-- resultMap : "+resultMap);
			
			return resultMap;
		}
		

		@RequestMapping("insertMessage.do")
		@ResponseBody
		public Map<String, Object> insertMessage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".insertMessage");
			logger.info(" insertMessage  - paramMap1 : " + paramMap);
			
			String result = "SUCCESS";
			String resultMsg = "메세지를 보냈습니다.";
			
			paramMap.put("loginId", session.getAttribute("loginId").toString());
			
			jmliService.insertMessage(paramMap);
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
						
			return resultMap;
		}

		
		@RequestMapping("projectUpdate.do")
		@ResponseBody
		public Map<String,Object> projectUpdate(Model model,
				@RequestParam Map<String,Object> paramMap,
				HttpServletRequest request,
				HttpServletResponse response,
				HttpSession session){
			
			logger.info("+start projectUpdate");
			logger.info("--LELU  paramMap : "+paramMap);
			
			try{
				int updateResultP =  jmliService.proectUpdate_project(paramMap);
				System.out.println("updateResultP  : "+updateResultP);
			
				int deleteResultS = jmliService.proectUpdate_deleteSkill(paramMap);
				System.out.println("deleteResultS : "+deleteResultS);
			}catch(Exception e){
				paramMap.put("result","fail");
			}
			paramMap.put("result","success");
			paramMap = jmliService.projectUpdate_data(paramMap);
			return paramMap;
		}

//		@RequestMapping("updateNotice.do")
//		@ResponseBody
//		public Map<String,Object> updateNotice(
//											Model model,
//											@RequestParam Map<String,Object> paramMap,
//											HttpServletRequest request,
//											HttpServletResponse response, 
//											HttpSession session ){
//			
//			logger.info("+ Start updateNotice");
//			logger.info("-- paramMap : "+paramMap);
//			
//			
//			String action = (String)paramMap.get("action");
//			String msg = "";
//			
//			try {
//				if(action.equals("I")){
//					logger.info("추가 실행.");
//					jmliService.insertNotice(paramMap, request);
//					msg="추가 성공";
//					
//				}else if(action.equals("U")){
//					logger.info("수정 실행.");
//					jmliService.updateNotice(paramMap, request);
//					msg="수정 성공";
//				}else if(action.equals("D")){
//					logger.info("삭제 실행.");
//					jmliService.deleteNotice(paramMap,request);
//					msg="삭제 성공";
//				}else{
//					msg=action+" 이게맞아?";
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//				msg="에러남..허허허";
//			}
//			
//			
//			logger.info("msg : " + msg);
//			
//			Map<String,Object> resultMap=new HashMap<String, Object>();
//			
//			resultMap.put("msg",msg);
//			
//			
//			
//			logger.info("+ End updateNotice");
//			
//			return resultMap;
//		}

		@RequestMapping("projectApply.do")
		@ResponseBody
		public Map<String, Object> applyProject(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info(" insertMessage  - paramMap1 : " + paramMap);
			
			String result = (String) paramMap.get("project_name");
			
			String resultMsg = result + " 프로젝트에 지원하였습니다.";
			
			String applierId = session.getAttribute("loginId").toString();
			
			
			paramMap.put("loginId", applierId);

			
			try {
				jmliService.applyProject(paramMap);
			} catch (Exception e) {
				
				resultMsg = "이미 지원한 프로젝트입니다, 지원한 적이 없다면 관리자에게 직접 문의하여주십시요.";
				
			}
			
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("msg", resultMsg);
						
			return resultMap;
		}
		
		@RequestMapping("Registerproject.do")
		@ResponseBody
		public Map<String,Object> Registerproject(Model model,
				@RequestParam Map<String,Object> paramMap,
				HttpServletRequest request,
				HttpServletResponse response,
				HttpSession session){
			
			logger.info("+start Registerproject");
			logger.info("--LELU  paramMap : "+paramMap);
			
			paramMap.put("loginId",session.getAttribute("loginId"));
			
			try{
				int updateResultP =  jmliService.resisterproject(paramMap);
				paramMap = jmliService.projectUpdate_data(paramMap);
				
			}catch(Exception e){
				paramMap.put("result", "fail");
			}
			paramMap.put("result", "success");
			
			
			return paramMap;
		}
		@RequestMapping("projectDelete.do")
		@ResponseBody
		public Map<String,Object> projectDelete(Model model,
				@RequestParam Map<String,Object> paramMap,
				HttpServletRequest request,
				HttpServletResponse response,
				HttpSession session){

			String projectId = (String)paramMap.get("projectId");
			
			try{
				int tb_project = jmliService.deleteTB_Project(projectId);
				int skill = jmliService.deleteTB_ProjectSKILL(projectId);
				int application = jmliService.deleteTB_priApplication(projectId);
			}catch(Exception e){
				paramMap.put("result", "fail");
			}
			paramMap.put("result", "success");
			
			return  paramMap;
		}
	
}
