package kr.happy.jobkorea.jmgr.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.jmgr.model.JmgrUserModel;
import kr.happy.jobkorea.jmgr.service.JmgrUserService;

@Controller
@RequestMapping("/jmgr/")
public class JmgrUserController {
		
		@Autowired
		JmgrUserService jmgrUserService;
		
		@RequestMapping("/adminUser.do")
		public String adminUser(){
			return "/jmgr/userHome";
		}
		
		@RequestMapping("userList.do")
		@ResponseBody
		public Map<String,Object> developerList(
												Model model, 
												@RequestParam Map<String, Object> paramMap, 
												HttpServletRequest request,
												HttpServletResponse response, 
												HttpSession session	){
			

			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;		
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<Map<String,Object>> list = jmgrUserService.getUserList(paramMap);
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			resultMap.put("list", list);
			
			int totalCount = jmgrUserService.totalCountUser(paramMap);
			resultMap.put("totalCountUser", totalCount);
			resultMap.put("pageSize", pageSize);
			resultMap.put("currentPageNoticeList",currentPage);
	
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
			JmgrUserModel  vo = jmgrUserService.selectDeveloperOne(loginID);
			List<String>  list = jmgrUserService.showSkill(loginID);
			
			resultMap.put("detailone", vo);
			resultMap.put("skill", list);
			
			return resultMap;
		}
		

		@RequestMapping("deleteUser.do")
		@ResponseBody
		public Map<String,Object> deleteUSer(
											Model model,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session ){
			
			String loginID = (String)paramMap.get("loginID");
			String msg = "";
			
			try {
					jmgrUserService.deleteUser(loginID);
					msg="삭제 성공";
				
			} catch (Exception e) {
				e.printStackTrace();
				msg="에러 발생, 관리자에게 문의해주십시요.";
			}
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			
			resultMap.put("msg",msg);

			return resultMap;
		}


		@RequestMapping("updateUser.do")
		@ResponseBody
		public Map<String,Object> updateUser(
											Model model,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session ){
			
			String loginID = (String)paramMap.get("loginID");
			String paramstr = (String)paramMap.get("paramstr");
			String msg = "";
			
			if(paramstr.equals("")){
				msg = "최소 1개의 전문기술을 선택해주십시요.";
			}else{
				
				String skillList[] = paramstr.split("/");
				try {	
					jmgrUserService.deleteSkill(loginID);
					jmgrUserService.updateUser(paramMap);
					
					for(int i=0; i<skillList.length; i++){
						String skillarr = skillList[i];
						String skill = skillarr.substring(0, 2);
						String skilldetail = skillarr.substring(2);
	
						jmgrUserService.insertSkill(loginID,skill,skilldetail);
						
					}
					
					msg="수정 성공";
				
			} catch (Exception e) {
				e.printStackTrace();
				msg="에러 발생, 관리자에게 문의해주십시요.";
			}
			}
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			
			resultMap.put("msg",msg);

			return resultMap;
		}		
		
		@RequestMapping("updateComp.do")
		@ResponseBody
		public Map<String,Object> updateComp(
											Model model,
											@RequestParam Map<String,Object> paramMap,
											HttpServletRequest request,
											HttpServletResponse response, 
											HttpSession session ){
			
			String msg = "";
			
			try{
				
				jmgrUserService.updateComp(paramMap);
				msg="수정 성공";
				
			} catch (Exception e) {
				e.printStackTrace();
				msg="에러 발생, 관리자에게 문의해주십시요.";
			}
			
			Map<String,Object> resultMap=new HashMap<String, Object>();
			
			resultMap.put("msg",msg);

			return resultMap;
		}		

}
