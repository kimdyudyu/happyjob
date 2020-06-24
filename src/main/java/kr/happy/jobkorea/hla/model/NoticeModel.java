package kr.happy.jobkorea.hla.model;

import java.sql.Date;

public class NoticeModel {
	// 공지 번호
	private int nt_no;
	// 공지 제목
	private String nt_title;
	// 공지 내용
	private String nt_note;
	// 공지 날짜
	private Date write_date;
	// 아이디
	private String loginID;
	private String user_type;

	public String getNt_note() {
		return nt_note;
	}

	public void setNt_note(String nt_note) {
		this.nt_note = nt_note;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public int getNt_no() {
		return nt_no;
	}

	public void setNt_no(int nt_no) {
		this.nt_no = nt_no;
	}

	public String getNt_title() {
		return nt_title;
	}

	public void setNt_title(String nt_title) {
		this.nt_title = nt_title;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
}
