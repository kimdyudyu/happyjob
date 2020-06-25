package kr.happy.jobkorea.hlt.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happy.jobkorea.hlt.service.TeacherTmService;

@Controller
@RequestMapping("/manageD")
public class TeacherTmController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private TeacherTmService teacherTmService;
	
	@RequestMapping("/homeworkMgt.do")
	public String tmList(){
		return "/hlt/teacherTm";
	}
	
	@RequestMapping("/tmList.do")
	@ResponseBody
	public Map<String, Object> tmList(@RequestParam Map<String, Object> param, Model model, HttpSession session){
		logger.info("lmmList 호출");
		logger.info("param : " + param);
		
		int currentPage = Integer.parseInt((String)param.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)param.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;
		
		param.put("pageIndex", pageIndex);
		param.put("pageSize", pageSize);
		
		List<Map<String, Object>> list = teacherTmService.tmList(param);
		
		Map<String, Object> resultMap=new HashMap<String, Object>();
		resultMap.put("list", list);
		
		//공지사항 총수.
		int totalCount = teacherTmService.totalCountRoom(param);
		resultMap.put("totalCountList", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageNoticeList",currentPage);
		
		logger.info("+ resultMap : " +resultMap);
		logger.info("+ End lmmList");
		
		return resultMap;
	}
	
	@RequestMapping("/downloadTmFile.do")
	public void downloadTmFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start Mss downloadQnaFile");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		Map<String,Object> list=teacherTmService.selectTmFile(paramMap);
		
		String filename = (String)list.get("filepath") + File.separator + (String)list.get("filename");
		
		//logger.info(filename);
		byte fileByte[] = FileUtils.readFileToByteArray(new File(filename));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String)list.get("filename"),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End Mss downloadQnaFile");
	}
}
