package kr.happy.jobkorea.hlt.controller;

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

import kr.happy.jobkorea.hlt.service.hlTeacherLmmService;

@Controller
@RequestMapping("/lmm")
public class hlTeacherLmmController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private hlTeacherLmmService hlteacherLmmService;
	
	@RequestMapping("/lmmBoard.do")
	public String lmmBoard(){
		logger.info("lmmBoard호출");
		return "hlt/teacherLMM";
	}
	
	@RequestMapping("/lmmList.do")
	@ResponseBody
	public Map<String, Object> lmmList(@RequestParam Map<String, Object> param, Model model, HttpSession session){
		logger.info("lmmList 호출");
		logger.info("param : " + param);
		
		int currentPage = Integer.parseInt((String)param.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)param.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;
		
		param.put("pageIndex", pageIndex);
		param.put("pageSize", pageSize);
		
		List<Map<String, Object>> list = hlteacherLmmService.lmmList(param);
		
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("list", list);
		
		//공지사항 총수.
		int totalCount = hlteacherLmmService.totalCountRoom(param);
		resultMap.put("totalCountList", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageNoticeList",currentPage);
		
		logger.info("+ resultMap : " +resultMap);
		logger.info("+ End lmmList");
		
		return resultMap;
	}
	
	@RequestMapping("IUDLmm.do")
	@ResponseBody
	public Map<String,Object> IUDLmm(HttpServletRequest request, @RequestParam Map<String,Object> paramMap){
		
		logger.info("+ Start updateNotice");
		logger.info("-- paramMap : "+paramMap);
		logger.info("-- request : " + request);
		
		
		String action = (String)paramMap.get("action");
		String msg = "";
		
		try {
			if(action.equals("I")){
				logger.info("추가 실행.");
				hlteacherLmmService.insertLmm(paramMap, request);
				msg="추가 성공";
			}else if(action.equals("U")){
				logger.info("수정 실행.");
				hlteacherLmmService.updateLmm(paramMap, request);
				msg="수정 성공";
			}else if(action.equals("D")){
				logger.info("삭제 실행.");
				hlteacherLmmService.deleteLmm(paramMap,request);
				msg="삭제 성공";
			}else{
				msg=action+" 이게맞아?";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg="에러남..허허허";
		}
		
		
		logger.info("msg : " + msg);
		
		Map<String,Object> resultMap=new HashMap<String, Object>();
		
		resultMap.put("msg",msg);

		logger.info("+ End updateNotice");
		
		return resultMap;
	}
}
