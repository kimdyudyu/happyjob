package kr.happy.jobkorea.jmpm.controller;

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
import kr.happy.jobkorea.jmpm.service.JmpmService;
import kr.happy.jobkorea.sss.model.NoticeKModel;

@Controller
@RequestMapping("/jmpm/")
public class JmpmController {
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	JmpmService jmpmService;
	
	@RequestMapping("projectManage.do")
	public String projectManage(){
		return "/jmpm/projectMangement";
	}
}
