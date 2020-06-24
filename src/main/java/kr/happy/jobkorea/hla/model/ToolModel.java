package kr.happy.jobkorea.hla.model;

import java.sql.Date;

public class ToolModel {
	private int room;
	private String name;
	private int ccount;
	private String etc;
	private String room_size;
	private int seq;
	private String tool_name;
	private String tool_size;
	private int tool_ccount;
	private String tool_etc;
	private Date date;

	public String getRoom_size() {
		return room_size;
	}

	public void setRoom_size(String room_size) {
		this.room_size = room_size;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getRoom() {
		return room;
	}

	public void setRoom(int room) {
		this.room = room;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCcount() {
		return ccount;
	}

	public void setCcount(int ccount) {
		this.ccount = ccount;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTool_name() {
		return tool_name;
	}

	public void setTool_name(String tool_name) {
		this.tool_name = tool_name;
	}

	public String getTool_size() {
		return tool_size;
	}

	public void setTool_size(String tool_size) {
		this.tool_size = tool_size;
	}

	public int getTool_ccount() {
		return tool_ccount;
	}

	public void setTool_ccount(int tool_ccount) {
		this.tool_ccount = tool_ccount;
	}

	public String getTool_etc() {
		return tool_etc;
	}

	public void setTool_etc(String tool_etc) {
		this.tool_etc = tool_etc;
	}
}
