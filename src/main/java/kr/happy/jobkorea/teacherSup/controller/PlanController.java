package kr.happy.jobkorea.teacherSup.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.happy.jobkorea.teacherSup.service.PlanService;

@Controller
@RequestMapping("/system/")
public class PlanController {
	
	@Autowired
	PlanService planService;
	
	@RequestMapping("")
	public String searchMenu(){
		
	}
	

}
