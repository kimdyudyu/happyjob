package kr.happy.jobkorea.hla.model;

import java.sql.Date;

public class LectureRoomModel {
	// 강의실 번호
	private int room;
	// 강의실명
	private String name;
	// 강의실 자리수
	private int ccount;
	// 강의실 크기
	private String room_size;
	// 비고
	private String etc;

	private Date date;

	public String getRoom_size() {
		return room_size;
	}

	public void setRoom_size(String room_size) {
		this.room_size = room_size;
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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
