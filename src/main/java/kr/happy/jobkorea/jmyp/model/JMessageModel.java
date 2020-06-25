package kr.happy.jobkorea.jmyp.model;

public class JMessageModel {
	private String	msg_code;
	private String 	msg_note;
	private String 	msg_date;
	private String	msg_receive;
	private String 	msg_send;
	private	String	receive_name;
	private String 	send_name;
	private String 	msgtype;
	private int		SelectedCnt;
	
	private String 	loginID;
	private	String	name;
	private int		SelectedIDCnt;
	
	
	public String getMsg_code() {
		return msg_code;
	}
	
	public void setMsg_code(String msg_code) {
		this.msg_code = msg_code;
	}
	
	public String getMsg_note() {
		return msg_note;
	}
	
	public void setMsg_note(String msg_note) {
		this.msg_note = msg_note;
	}
	
	public String getMsg_date() {
		return msg_date;
	}
	
	public void setMsg_date(String msg_date) {
		this.msg_date = msg_date;
	}
	
	public String getMsg_receive() {
		return msg_receive;
	}
	
	public void setMsg_receive(String msg_receive) {
		this.msg_receive = msg_receive;
	}
	
	public String getMsg_send() {
		return msg_send;
	}
	
	public void setMsg_send(String msg_send) {
		this.msg_send = msg_send;
	}

	public String getReceive_name() {
		return receive_name;
	}

	public void setReceive_name(String receive_name) {
		this.receive_name = receive_name;
	}

	public String getSend_name() {
		return send_name;
	}

	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	
	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}

	public int getSelectedCnt() {
		return SelectedCnt;
	}

	public void setSelectedCnt(int selectedCnt) {
		SelectedCnt = selectedCnt;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSelectedIDCnt() {
		return SelectedIDCnt;
	}

	public void setSelectedIDCnt(int selectedIDCnt) {
		SelectedIDCnt = selectedIDCnt;
	}



}
