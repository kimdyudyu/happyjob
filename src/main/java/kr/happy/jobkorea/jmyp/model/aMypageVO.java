package kr.happy.jobkorea.jmyp.model;

public class aMypageVO {

	// 프로젝트명, 회사명, 지원일자, 지원취소
	// 프로젝트명, 마감일자, 지원자 수
	// 지원자 목록, 성명, 제목, 희망지역, 등급, 전문기술
	
	
	String loginId;
	String userName;	// 개인 이름
	String skillAdd;
	String position;	
	
	
	
	String projectName;	// 프로젝트 이름
	String projectId;	// 프로젝트 지원 코드
	
	
	
	int SupplyCount; 	// 프로젝트에 지원한 인원
	
	String projectNote;	// 프로젝트 상세정보
	
	String optionOrder;	// 프로젝트 우대사항
	
	String applyDate ;	// 프로젝트 지원날짜
	String receiveDead;	// 프로젝트 데드데이
	
	
	String companyName;		// 기업 명
	String compName;		// 기업명 
	
	String cvCode;		// 지원서 번호
	
	
	

	
	
	public String getCvCode() {
		return cvCode;
	}
	public void setCvCode(String cvCode) {
		this.cvCode = cvCode;
	}
	public int getSupplyCount() {
		return SupplyCount;
	}
	public void setSupplyCount(int supplyCount) {
		SupplyCount = supplyCount;
	}
	public String getOptionOrder() {
		return optionOrder;
	}
	public void setOptionOrder(String optionOrder) {
		this.optionOrder = optionOrder;
	}
	
	
	
	
	
	public String getProjectNote() {
		return projectNote;
	}
	public void setProjectNote(String projectNote) {
		this.projectNote = projectNote;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getReceiveDead() {
		return receiveDead;
	}
	public void setReceiveDead(String receiveDead) {
		this.receiveDead = receiveDead;
	}
	
	
	
	
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getSkillAdd() {
		return skillAdd;
	}
	public void setSkillAdd(String skillAdd) {
		this.skillAdd = skillAdd;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	
	
	

}
