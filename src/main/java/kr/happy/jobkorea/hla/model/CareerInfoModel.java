package kr.happy.jobkorea.hla.model;

import java.sql.Date;

public class CareerInfoModel {
	// 아이디
	private String loginID;
	// 일련번호
	private int seq;
	// 입사일
	private Date hire_date;
	// 퇴사일
	private Date resign_date;
	// 업체명
	private String cop_name;
	// 이름
	private String name;
	// 재직여부
	private String work_yn;

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public Date getHire_date() {
		return hire_date;
	}

	public void setHire_date(Date hire_date) {
		this.hire_date = hire_date;
	}

	public Date getResign_date() {
		return resign_date;
	}

	public void setResign_date(Date resign_date) {
		this.resign_date = resign_date;
	}

	public String getCop_name() {
		return cop_name;
	}

	public void setCop_name(String cop_name) {
		this.cop_name = cop_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWork_yn() {
		return work_yn;
	}

	public void setWork_yn(String work_yn) {
		this.work_yn = work_yn;
	}

}
