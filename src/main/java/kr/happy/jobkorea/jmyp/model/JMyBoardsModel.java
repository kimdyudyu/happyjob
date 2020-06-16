package kr.happy.jobkorea.jmyp.model;

public class JMyBoardsModel {
	private String 		wno;
	private String 		title;
	private String 		reg_date;
	private String		board_Type;
	private String		selected_count;
	private String		board_code;
	private String		cmnt_level;
	
	
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
	public String getWno() {
		return wno;
	}
	public void setWno(String wno) {
		this.wno = wno;
	}
	public String getBoard_Type() {
		return board_Type;
	}
	public void setBoard_Type(String board_Type) {
		this.board_Type = board_Type;
	}
	public String getSelected_count() {
		return selected_count;
	}
	public void setSelected_count(String selected_count) {
		this.selected_count = selected_count;
	}
	public String getBoard_code() {
		return board_code;
	}
	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}
	public String getCmnt_level() {
		return cmnt_level;
	}
	public void setCmnt_level(String cmnt_level) {
		this.cmnt_level = cmnt_level;
	}
}
