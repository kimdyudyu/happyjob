package kr.happy.jobkorea.hls.model;

public class ReferenceModel {
	//학습자료
	//제목,작성일,작성자
	
	//팝업
	//제목, 내용, 첨부파일 다운로드
	private String nt_title;
	private String reg_date;
	private String loginID;
	private String nt_note;
	private String filename;
	private String filepath;
	private String filesize;
	
	
	public String getNt_title() {
		return nt_title;
	}
	public void setNt_title(String nt_title) {
		this.nt_title = nt_title;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String red_date) {
		this.reg_date = red_date;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getNt_note() {
		return nt_note;
	}
	public void setNt_note(String nt_note) {
		this.nt_note = nt_note;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
}
