package kr.happy.jobkorea.hlt.controller;


//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//import kr.happy.jobkorea.hlt.service.PlanService;

@Controller
@RequestMapping("/system/")
public class PlanController {
	
	//@Autowired
	//PlanService planService;
	
	@RequestMapping("p_search.do")
	public String searchMenu(){
		return "teacher/Plan";
	}
	

}
