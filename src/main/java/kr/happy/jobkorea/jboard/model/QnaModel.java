package kr.happy.jobkorea.jboard.model;

public class QnaModel {

	// 글번호
	private String wno;
	
	// 재목
	private String title;

	// 등록일자
	private String reg_date;

	// 작성자
	private String loginID;
	
	private String note;
	
	private String cmnt_level;
	
	private String upper_wno;
	
	public String getUpper_wno() {
		return upper_wno;
	}

	public void setUpper_wno(String upper_wno) {
		this.upper_wno = upper_wno;
	}

	public String getCmnt_level() {
		return cmnt_level;
	}

	public void setCmnt_level(String cmnt_level) {
		this.cmnt_level = cmnt_level;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getWno() {
		return wno;
	}

	public void setWno(String wno) {
		this.wno = wno;
	}


	
}
