//package kr.happy.jobkorea.jmgr.controller;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.log4j.LogManager;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import kr.happy.jobkorea.jmgr.service.JmgrAdminNoticeService;
//
//@Controller
//@RequestMapping("/jmgr/")
//public class JmgrAdminNoticeController {
//	// Set logger
//			private final Logger logger = LogManager.getLogger(this.getClass());
//
//			// Get class name for logger
//			private final String className = this.getClass().toString();
//			
//			@Autowired
//			JmgrAdminNoticeService jmgrAdminNoticeServiceDao;
//			
//			
//			@RequestMapping("/adminNotice.do")
//			public String adminUser(){
//
//				logger.info("+ Start adminNotice");
//
//				
//				
//				logger.info("+ End adminNotice");
//				return "/jmgr/adminNoticeHome";
//			}
//			
//			@RequestMapping("adminNoticeList.do")
//			@ResponseBody
//			public Map<String,Object> developerList(
//													Model model, 
//													@RequestParam Map<String, Object> paramMap, 
//													HttpServletRequest request,
//													HttpServletResponse response, 
//													HttpSession session	){
//				
//				logger.info("+ Start developerList");
//				logger.info("-- paramMap : "+paramMap);
//	//
//				int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
//				int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
//				int pageIndex = (currentPage-1)*pageSize;		
////				
//				paramMap.put("pageIndex", pageIndex);
//				paramMap.put("pageSize", pageSize);
//				
//				// 개발자목록 조회
//				
//				List<Map<String,Object>> list = jmgrAdminNoticeServiceDao.getUserList(paramMap);
//				
//				Map<String,Object> resultMap=new HashMap<String, Object>();
//				resultMap.put("list", list);
//				
//				//개발자 총수.
//				int totalCount = jmgrAdminNoticeServiceDao.totalCountUser(paramMap);
//				resultMap.put("totalCountUser", totalCount);
//				resultMap.put("pageSize", pageSize);
//				resultMap.put("currentPageNoticeList",currentPage);
////			
////				logger.info("+ resultMap : " +resultMap);
////				logger.info("+ End noticeList");
////				
//				
//				return resultMap;
//			}
//			
//			@RequestMapping("cntUp.do")
//			@ResponseBody
//			public Map<String,Object> gereplyNcntUp(
//												Model model,
//												@RequestParam Map<String,Object> paramMap,
//												HttpServletRequest request,
//												HttpServletResponse response, 
//												HttpSession session ){
//				
//				logger.info("+ Start gereplyNcntUp");
//				logger.info("-- paramMap : "+paramMap);
//				
//				//  카운트 증가하고 카운트 가져오기 .
//				String loginID = (String)paramMap.get("loginID");
//				String name = (String)paramMap.get("name");
//				
//				Map<String,Object> resultMap=new HashMap<String, Object>();
//				
//				resultMap.put("loginID", loginID);
//				resultMap.put("name", name);
//				logger.info("-- resultMap : "+resultMap);
//				logger.info("+ End gereplyNcntUp");
//				
//				return resultMap;
//			}
//			
//			
//			
//			
////			@RequestMapping("updateNotice.do")
////			@ResponseBody
////			public Map<String,Object> updateNotice(
////												Model model,
////												@RequestParam Map<String,Object> paramMap,
////												HttpServletRequest request,
////												HttpServletResponse response, 
////												HttpSession session ){
////				
////				logger.info("+ Start updateNotice");
////				logger.info("-- paramMap : "+paramMap);
////				
////				
////				String action = (String)paramMap.get("action");
////				String msg = "";
////				
////				try {
////					if(action.equals("I")){
////						logger.info("추가 실행.");
////						jmliService.insertNotice(paramMap, request);
////						msg="추가 성공";
////						
////					}else if(action.equals("U")){
////						logger.info("수정 실행.");
////						jmliService.updateNotice(paramMap, request);
////						msg="수정 성공";
////					}else if(action.equals("D")){
////						logger.info("삭제 실행.");
////						jmliService.deleteNotice(paramMap,request);
////						msg="삭제 성공";
////					}else{
////						msg=action+" 이게맞아?";
////					}
////				} catch (Exception e) {
////					e.printStackTrace();
////					msg="에러남..허허허";
////				}
////				
////				
////				logger.info("msg : " + msg);
////				
////				Map<String,Object> resultMap=new HashMap<String, Object>();
////				
////				resultMap.put("msg",msg);
////				
////				
////				
////				logger.info("+ End updateNotice");
////				
////				return resultMap;
////			}
//		
//}
