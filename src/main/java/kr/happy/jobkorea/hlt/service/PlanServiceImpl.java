package kr.happy.jobkorea.hlt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happy.jobkorea.hlt.dao.PlanDao;
import kr.happy.jobkorea.hlt.model.Plan;
import kr.happy.jobkorea.supportD.model.NoticeDModel;
import kr.happy.jobkorea.system.model.NoticeModel;

@Service("PlanService")
public class PlanServiceImpl implements PlanService{
	
	@Autowired
	PlanDao planDao;

	@Override
	public List<Plan> selectPlanList(Map<String, Object> paramMap){
		
		 List<Plan> planList = planDao.selectPlanList(paramMap);
			
			
	   return planList;
	}

	@Override
	public int planTotalCnt(Map<String, Object> paramMap){

		  int totalCnt = planDao.planTotalCnt(paramMap);
			
	      return totalCnt;
	}

	@Override
	public Plan detailPlan(Map<String, Object> paramMap){
		   
			Plan detailPlan = planDao.detailPlan(paramMap);
			
		   return detailPlan;
	}

	@Override
	public int insertplan(Map<String, Object> paramMap) {
	
		int resultCnt = planDao.insertplan(paramMap);
		
		return resultCnt;
		
	}

	@Override
	public int updateplan(Map<String, Object> paramMap) {
		System.out.println(paramMap.get("no"));
		int resultCnt = planDao.updateplan(paramMap);
		
		return resultCnt;
		
	}



	





	

}
