package kr.happy.jobkorea.hlt.service;

import java.util.List;
import java.util.Map;

import kr.happy.jobkorea.hlt.model.Plan;
import kr.happy.jobkorea.system.model.NoticeModel;

public interface PlanService {

	public List<Plan> selectPlanList(Map<String, Object> paramMap);

	public int planTotalCnt(Map<String, Object> paramMap);

	public Plan detailPlan(Map<String, Object> paramMap);

	public int insertplan(Map<String, Object> paramMap);

	public int updateplan(Map<String, Object> paramMap);

	public int deleteplan(Map<String, Object> paramMap);



}
