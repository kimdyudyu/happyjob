package kr.happy.jobkorea.hla.model;

import java.sql.Date;

public class LectureListAdminModel {
	// 강의번호
	private String no;
	// 강의명,과목명
	private String title;
	// 강사명, 학생명
	private String name;
	// 아이디
	private String loginID;
	// 강의실
	private String room;
	// 수강인원
	private int pcnt;
	// 강의목록 비고
	private String etc;
	// 개강일
	private Date startdate;
	// 종강일
	private Date enddate;
	// 휴학여부
	private String restyn;
	// 출석
	private int attend;
	// 수강정보 일련번호
	private int seq;

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getAttend() {
		return attend;
	}

	public void setAttend(int attend) {
		this.attend = attend;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public int getPcnt() {
		return pcnt;
	}

	public void setPcnt(int pcnt) {
		this.pcnt = pcnt;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
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

	public String getRestyn() {
		return restyn;
	}

	public void setRestyn(String restyn) {
		this.restyn = restyn;
	}

}
