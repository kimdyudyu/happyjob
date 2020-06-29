package kr.happy.jobkorea.hlteacher.model;

/**
 * @author HappyJob
 *
 */
public class lectureModel {

	private String no;
	private String title;
	private String category;
	private String loginID;
	private String startDate;
	private String endDate;
	private String fileName;
	private int pcnt;
	private String goal;
	private String plan;
	public lectureModel(String no, String title, String category, String loginID, String startDate, String endDate,
			String fileName, int pcnt, String goal, String plan) {
		super();
		this.no = no;
		this.title = title;
		this.category = category;
		this.loginID = loginID;
		this.startDate = startDate;
		this.endDate = endDate;
		this.fileName = fileName;
		this.pcnt = pcnt;
		this.goal = goal;
		this.plan = plan;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getPcnt() {
		return pcnt;
	}
	public void setPcnt(int pcnt) {
		this.pcnt = pcnt;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	
	
}
