package kr.happy.jobkorea.hlt.model;

import java.sql.Date;

public class Plan {
	private String no;
	private String title;
	private String name;
	private String subject;
	private Date startdate;
	private Date enddate;
	private int pcnt;
	private int anumber;
	private String loginID;
	private String email;
	private String room;
	private String goal;
	private String attendanceinfo;
	private String plan;
	private String hp;
	
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public int getPcnt() {
		return pcnt;
	}
	public void setPcnt(int pcnt) {
		this.pcnt = pcnt;
	}
	public int getAnumber() {
		return anumber;
	}
	public void setAnumber(int anumber) {
		this.anumber = anumber;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getGoal() {
		return goal;
	}
	public void setGoal(String goal) {
		this.goal = goal;
	}
	public String getAttendanceinfo() {
		return attendanceinfo;
	}
	public void setAttendanceinfo(String attendanceinfo) {
		this.attendanceinfo = attendanceinfo;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	
	
	@Override
	public String toString() {
		return "Plan [no=" + no + ", title=" + title + ", name=" + name + ", subject=" + subject + ", startdate="
				+ startdate + ", enddate=" + enddate + ", pcnt=" + pcnt + ", anumber=" + anumber + ", loginID="
				+ loginID + ", email=" + email + ", room=" + room + ", goal=" + goal + ", attendanceinfo="
				+ attendanceinfo + ", plan=" + plan + ", hp=" + hp + "]";
	}
	
	
	
	

}