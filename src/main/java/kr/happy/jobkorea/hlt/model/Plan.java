package kr.happy.jobkorea.hlt.model;

import java.sql.Date;

public class Plan {
	
	private String title;
	private String name;
	private String subject;
	private Date startdate;
	private Date enddate;
	private int pcnt;
	private int anumber;
	
	
	public Plan() {
		
	}
	
	
	public Plan(String title, String name, String subject, Date startdate, Date enddate, int pcnt, int anumber) {
		super();
		this.title = title;
		this.name = name;
		this.subject = subject;
		this.startdate = startdate;
		this.enddate = enddate;
		this.pcnt = pcnt;
		this.anumber = anumber;
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


	@Override
	public String toString() {
		return "Plan [title=" + title + ", name=" + name + ", subject=" + subject + ", startdate=" + startdate
				+ ", enddate=" + enddate + ", pcnt=" + pcnt + ", anumber=" + anumber + "]";
	}
	
	
	
	
	
	
	

}
